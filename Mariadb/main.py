import mysql.connector
import os
import re
from datetime import datetime
from reportlab.lib.pagesizes import letter, landscape
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
import chardet

def mostrar_menu():
    print("\nMenu de Opciones:")
    print("1. Generacion de Disparadores de Auditoria")
    print("2. Logs")
    print("3. Salir")   

def obtener_columnas_tabla(cursor, tabla):
    cursor.execute(f"SHOW COLUMNS FROM {tabla}")
    columnas = cursor.fetchall()
    nombres_columnas = [columna[0] for columna in columnas]
    return nombres_columnas

def crear_funcion_trigger(cursor, tabla):
    columnas = obtener_columnas_tabla(cursor, tabla)

    insert_values = ", ".join([f"'new_{columna.lower()}', NEW.{columna}" for columna in columnas])
    update_values = ", ".join([f"'old_{columna.lower()}', OLD.{columna}, 'new_{columna.lower()}', NEW.{columna}" for columna in columnas])
    delete_values = ", ".join([f"'old_{columna.lower()}', OLD.{columna}" for columna in columnas])

    funcion_insert_sql = f"""
    CREATE OR REPLACE TRIGGER audit_{tabla}_after_insert
    AFTER INSERT ON {tabla}
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('{tabla}', USER(), 'INSERT', JSON_OBJECT({insert_values}));
    END;
    """

    funcion_update_sql = f"""
    CREATE OR REPLACE TRIGGER audit_{tabla}_after_update
    AFTER UPDATE ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('{tabla}', USER(), 'UPDATE', JSON_OBJECT({update_values}));
    END;
    """

    funcion_delete_sql = f"""
    CREATE OR REPLACE TRIGGER audit_{tabla}_after_delete
    AFTER DELETE ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('{tabla}', USER(), 'DELETE', JSON_OBJECT({delete_values}));
    END;
    """

    try:
        cursor.execute(funcion_insert_sql)
    except mysql.connector.Error as err:
        print(f"Error al ejecutar el disparador INSERT para {tabla}: {err}")

    try:
        cursor.execute(funcion_update_sql)
    except mysql.connector.Error as err:
        print(f"Error al ejecutar el disparador UPDATE para {tabla}: {err}")

    try:
        cursor.execute(funcion_delete_sql)
    except mysql.connector.Error as err:
        print(f"Error al ejecutar el disparador DELETE para {tabla}: {err}")

    return funcion_insert_sql, funcion_update_sql, funcion_delete_sql

def opcion1(cursor):
    print("Ejecutando Opción 1...")
    
    cursor.execute("SHOW TABLES")
    tablas = cursor.fetchall()
    
    print("\nTablas disponibles en la base de datos:")
    for idx, tabla in enumerate(tablas):
        print(f"{idx + 1}. {tabla[0]}")
    
    seleccion = input("\nSeleccione las tablas para auditar (separadas por coma, o 'all' para todas): ")
    
    if seleccion.lower() == 'all':
        tablas_seleccionadas = [tabla[0] for tabla in tablas]
    else:
        try:
            indices = map(int, seleccion.split(','))
            tablas_seleccionadas = [tablas[idx - 1][0] for idx in indices]
        except ValueError:
            print("Selección inválida. Por favor, use números separados por comas.")
            return

    with open("auditoria_triggers.sql", "w", encoding="utf-8") as sql_file:
        for tabla in tablas_seleccionadas:
            if tabla.lower() != 'auditoria':
                funciones_sql = crear_funcion_trigger(cursor, tabla)
                for funcion_sql in funciones_sql:
                    sql_file.write(funcion_sql)
                    sql_file.write("\n\n")  # Separador entre funciones

    print("\nDisparadores de auditoría creados exitosamente y guardados en 'auditoria_triggers.sql'.")

def generar_pdf(logs, usuario, fecha_inicio, fecha_fin):
    pdf_filename = f'reporte_logs_{usuario}{fecha_inicio.replace(":", "-").replace(" ", "")}a{fecha_fin.replace(":", "-").replace(" ", "_")}.pdf'
    doc = SimpleDocTemplate(pdf_filename, pagesize=landscape(letter))
    styles = getSampleStyleSheet()
    custom_style = ParagraphStyle(
        name='CustomStyle',
        fontSize=9,
        leading=10,
        spaceAfter=4,
        wordWrap='CJK'
    )
    date_time_style = ParagraphStyle(
        name='DateTimeStyle',
        fontSize=9,
        leading=10,
        spaceAfter=4,
        wordWrap='CJK',
        alignment=1
    )
    elements = []

    title = f"Reporte: Logs de MariaDB\nUsuario: {usuario}\nDesde: {fecha_inicio}\nHasta: {fecha_fin}"
    elements.append(Paragraph(title, styles['Title']))
    elements.append(Spacer(1, 12))

    col_widths = [100, 500]
    data = [["Fecha y Hora", "Log Entry"]]
    
    for log in logs:
        data.append([
            Paragraph(log['fecha_hora'], date_time_style),
            Paragraph(log['linea'], custom_style)
        ])

    table = Table(data, colWidths=col_widths)
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.green),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 10),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 10),
        ('BACKGROUND', (0, 1), (-1, -1), colors.skyblue),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.cyan),
        ('FONTSIZE', (0, 1), (-1, -1), 9),
    ]))

    elements.append(table)
    doc.build(elements)
    print(f"PDF generado exitosamente en '{pdf_filename}'")

def obtener_usuarios(cursor):
    cursor.execute("SELECT user FROM mysql.user WHERE host='localhost';")
    return [usuario[0] for usuario in cursor.fetchall()]

def leer_logs_en_rango(log_directory, fecha_inicio, fecha_fin, usuario):
    logs_combinados = []
    try:
        fecha_inicio = datetime.strptime(fecha_inicio, "%Y-%m-%d %H:%M:%S")
        fecha_fin = datetime.strptime(fecha_fin, "%Y-%m-%d %H:%M:%S")
    except ValueError:
        print("Formato de fecha y hora incorrecto.")
        return []

    log_files = sorted(os.listdir(log_directory))
    for log_file in log_files:
        if not log_file.endswith('.log'):
            continue

        log_path = os.path.join(log_directory, log_file)
        if os.path.getsize(log_path) > 0:
            with open(log_path, 'rb') as file:
                raw_data = file.read()
                result = chardet.detect(raw_data)
                encoding = result['encoding']
                try:
                    decoded_data = raw_data.decode(encoding)
                except UnicodeDecodeError:
                    decoded_data = raw_data.decode('utf-8', errors='replace')

                for line in decoded_data.splitlines():
                    match = re.match(
                        r"(?P<fecha_hora>\d{2}\d{2}\d{2}\s+\d{2}:\d{2}:\d{2})\s+\d+\s+\w+\s+\w+",
                        line
                    )
                    if match:
                        log_fecha = datetime.strptime(match.group("fecha_hora"), "%y%m%d %H:%M:%S")
                        if fecha_inicio <= log_fecha <= fecha_fin:
                            log_entry = {
                                'fecha_hora': log_fecha.strftime("%Y-%m-%d %H:%M:%S"),
                                'linea': line
                            }
                            logs_combinados.append(log_entry)
    return logs_combinados

def validar_fechas(fecha_inicio, fecha_fin):
    try:
        datetime.strptime(fecha_inicio, "%Y-%m-%d %H:%M:%S")
        datetime.strptime(fecha_fin, "%Y-%m-%d %H:%M:%S")
        return True
    except ValueError:
        print("Formato de fecha y hora incorrecto. Por favor, use el formato 'YYYY-MM-DD HH:MM:SS'.")
        return False

def opcion2(cursor):
    print("Ejecutando Opción 2...")

    usuarios = obtener_usuarios(cursor)
    print("\nUsuarios disponibles:")
    for idx, usuario in enumerate(usuarios):
        print(f"{idx + 1}. {usuario}")

    seleccion_usuario = input("\nSeleccione un usuario (número): ")
    try:
        usuario = usuarios[int(seleccion_usuario) - 1]
    except (IndexError, ValueError):
        print("Selección de usuario inválida.")
        return

    while True:
        fecha_inicio = input("Ingrese la fecha y hora de inicio (YYYY-MM-DD HH:MM:SS): ")
        fecha_fin = input("Ingrese la fecha y hora de fin (YYYY-MM-DD HH:MM:SS): ")
        if validar_fechas(fecha_inicio, fecha_fin):
            break

    log_directory = r"C:\Program Files\MariaDB 11.4\data\logs"  # Ajustar la ruta al directorio de logs de MariaDB
    logs = leer_logs_en_rango(log_directory, fecha_inicio, fecha_fin, usuario)
    
    if not logs:
        print("No se encontraron registros para los criterios especificados.")
    else:
        print("\nContenido de los logs seleccionados:\n")
        for log in logs:
            print(f"{log['fecha_hora']} - {log['linea']}")

        generar_pdf(logs, usuario, fecha_inicio, fecha_fin)

def validar_fechas(fecha_inicio, fecha_fin):
    try:
        datetime.strptime(fecha_inicio, "%Y-%m-%d %H:%M:%S")
        datetime.strptime(fecha_fin, "%Y-%m-%d %H:%M:%S")
        return True
    except ValueError:
        print("Formato de fecha y hora incorrecto. Por favor, intente nuevamente.")
        return False

def main():
    database = "hotel"
    try:
        conexion = mysql.connector.connect(
            host="localhost",
            port=3306,
            database=database,
            user="root",
            password="123"
        )
        conexion.autocommit = True
        cursor = conexion.cursor()
        
        while True:
            mostrar_menu()
            opcion = input("Selecciona una opción: ")
            if opcion == '1':
                opcion1(cursor)
            elif opcion == '2':
                opcion2(cursor)
            elif opcion == '3':
                print("Saliendo del programa...")
                break
            else:
                print("Opción no válida. Por favor, intenta de nuevo.")
    except mysql.connector.Error as e:
        print(f"Error en la conexión a la base de datos: {e}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conexion' in locals() and conexion.is_connected():
            conexion.close()

if __name__ == '__main__':
    main()
