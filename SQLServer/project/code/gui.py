import tkinter as tk
from tkinter import ttk, messagebox
from PIL import Image, ImageTk
import json
import os
from tkinter import simpledialog
import pyodbc

from audit_triggers import obtener_tablas, generar_disparadores, eliminar_disparadores_funciones
from log_processing import obtener_usuarios, leer_logs_en_rango, validar_fechas, leer_auditoria
from pdf_generator import generar_pdf
import pyodbc
import threading
from time import time
from datetime import datetime
from reportlab.lib.pagesizes import letter, landscape
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Spacer, Table, TableStyle
from reportlab.lib.units import inch
# Archivo de configuración
config_file = 'configSQLServer.json'

def conectar_bd(database):
    try:
        conexion = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=DESKTOP-SSEKAEO\SQLEXPRESS;'
            f'DATABASE={database};'
            'Trusted_Connection=yes;'
        )
        return conexion
    except pyodbc.Error as e:
        print(f"Error de conexión: {e}")
        return None

def verificar_conexion(database):
    conexion = conectar_bd(database)
    if conexion:
        try:
            cursor = conexion.cursor()
            cursor.execute("SELECT @@SERVERNAME, DB_NAME()")
            result = cursor.fetchone()
            print(f"Server: {result[0]}, Database: {result[1]}")
        except pyodbc.Error as e:
            print(f"Error al verificar la conexión: {e}")
        finally:
            cerrar_conexion(None, conexion)
    else:
        print("No se pudo establecer la conexión.")

def obtener_cursor(conexion):
    try:
        return conexion.cursor()
    except pyodbc.Error as e:
        print(f"Error al obtener el cursor: {e}")
        return None

def cerrar_conexion(cursor, conexion):
    try:
        if cursor:
            cursor.close()
        if conexion:
            conexion.close()
    except pyodbc.Error as e:
        print(f"Error al cerrar la conexión: {e}")

# Función para cargar la configuración desde el archivo JSON
def cargar_configuracion():
    if os.path.exists(config_file):
        with open(config_file, 'r') as file:
            config = json.load(file)
            fecha_inicio_entry.insert(0, config.get('default_start_date', ''))
            fecha_fin_entry.insert(0, config.get('default_end_date', ''))
            database_entry.insert(0, config.get('default_database', ''))

# Función para guardar la configuración en el archivo JSON
def guardar_configuracion():
    config = {
        'default_start_date': fecha_inicio_entry.get(),
        'default_end_date': fecha_fin_entry.get(),
        'default_database': database_entry.get(),
    }
    with open(config_file, 'w') as file:
        json.dump(config, file)
    messagebox.showinfo("Configuración Guardada", "La configuración ha sido guardada exitosamente.")

# Función para cargar usuarios en el ComboBox
def cargar_usuarios():
    conexion = conectar_bd(database_entry.get())
    if conexion is None:
        messagebox.showerror("Error de Conexión", "No se pudo conectar a la base de datos. Verifique sus credenciales.")
        return
    
    cursor = obtener_cursor(conexion)
    if cursor:
        usuarios = obtener_usuarios(cursor)
        if usuarios:
            usuario_combobox['values'] = usuarios
            messagebox.showinfo("Usuarios Cargados", "Usuarios cargados exitosamente.")
        else:
            messagebox.showwarning("Sin Usuarios", "No se encontraron usuarios en la base de datos.")
    else:
        messagebox.showerror("Error", "Error al obtener el cursor de la base de datos.")
    
    cerrar_conexion(cursor, conexion)

# Función para generar los disparadores de auditoría
def generar_disparadores_bd():
    conexion = conectar_bd(database_entry.get())
    if conexion is None:
        messagebox.showerror("Error de Conexión", "No se pudo conectar a la base de datos. Verifique sus credenciales.")
        return
    
    cursor = obtener_cursor(conexion)
    if cursor:
        tablas = obtener_tablas(cursor)
        generar_disparadores(cursor, tablas)
        messagebox.showinfo("Disparadores Generados", "Los disparadores de auditoría se generaron exitosamente.")
    else:
        messagebox.showerror("Error", "Error al obtener el cursor de la base de datos.")
    
    cerrar_conexion(cursor, conexion)

# Función para eliminar los disparadores y funciones de auditoría
def eliminar_disparadores_bd():
    nombre_objeto = simpledialog.askstring("Eliminar Disparadores", "Ingrese el nombre del objeto (tabla o función) para eliminar:")
    if nombre_objeto:
        conexion = conectar_bd(database_entry.get())
        if conexion is None:
            messagebox.showerror("Error de Conexión", "No se pudo conectar a la base de datos. Verifique sus credenciales.")
            return
        
        cursor = obtener_cursor(conexion)
        if cursor:
            eliminar_disparadores_funciones(cursor, nombre_objeto)
            messagebox.showinfo("Objetos Eliminados", f"Los objetos relacionados con '{nombre_objeto}' fueron eliminados exitosamente.")
        else:
            messagebox.showerror("Error", "Error al obtener el cursor de la base de datos.")
        
        cerrar_conexion(cursor, conexion)

# Función para generar el reporte en PDF
def generar_reporte():
    fecha_inicio = fecha_inicio_entry.get()
    fecha_fin = fecha_fin_entry.get()
    usuario = usuario_combobox.get()
    
    if validar_fechas(fecha_inicio, fecha_fin):
        logs = leer_logs_en_rango(fecha_inicio, fecha_fin, usuario)
        auditoria = leer_auditoria(fecha_inicio, fecha_fin, usuario)
        if logs or auditoria:
            generar_pdf(logs, auditoria, usuario, fecha_inicio, fecha_fin)
            messagebox.showinfo("Reporte Generado", "El reporte en PDF se generó exitosamente.")
        else:
            messagebox.showwarning("Sin Logs", "No se encontraron logs en el rango de fechas especificado.")
    else:
        messagebox.showerror("Error de Fechas", "La fecha de inicio no puede ser posterior a la fecha de fin.")

#GENERAR HILOS
def generar_hilos():
    def ejecutar_consulta(cursor, lock, query, results, index):
        try:
            start_time = time()
            with lock:
                cursor.execute(query)
                result = cursor.fetchall()
                headers = [desc[0] for desc in cursor.description]
            end_time = time()
            execution_time = end_time - start_time
            results[index] = (headers, result, execution_time)
        except Exception as e:
            results[index] = ([], str(e), 0)

    print("Ejecutando consultas y generando reporte...")

    # Consultas complejas
    queries = [
        "SELECT Hoteles.Nombre, Hoteles.Ubicacion, Hoteles.NumeroHabitaciones FROM Hoteles",
        "SELECT Clientes.Nombre, Clientes.Telefono, Clientes.Email FROM Clientes",
        "SELECT Habitaciones.HabitacionID, Hoteles.Nombre AS Hotel, Habitaciones.Tipo, Habitaciones.PrecioNoche, Habitaciones.Disponible FROM Habitaciones INNER JOIN Hoteles ON Habitaciones.HotelID = Hoteles.HotelID",
        "SELECT Eventos.Nombre, Eventos.Fecha, Eventos.Lugar, Eventos.Organizador, Hoteles.Nombre AS Hotel FROM Eventos INNER JOIN Hoteles ON Eventos.HotelID = Hoteles.HotelID",
        "SELECT Reservaciones.ReservacionID, Hoteles.Nombre AS Hotel, Clientes.Nombre AS Cliente, Habitaciones.Tipo, Reservaciones.FechaEntrada, Reservaciones.FechaSalida, Reservaciones.Estado FROM Reservaciones INNER JOIN Hoteles ON Reservaciones.HotelID = Hoteles.HotelID INNER JOIN Habitaciones ON Reservaciones.HabitacionID = Habitaciones.HabitacionID INNER JOIN Clientes ON Reservaciones.ClienteID = Clientes.ClienteID",
    ]

    try:
        # Establecer conexión a la base de datos
        conn = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=DESKTOP-SSEKAEO\SQLEXPRESS;'
            'DATABASE=bd_proyecto;'
            'Trusted_Connection=yes;'
        )
        cursor = conn.cursor()

        threads = []
        results = [None] * len(queries)
        lock = threading.Lock()

        for i, query in enumerate(queries):
            thread = threading.Thread(target=ejecutar_consulta, args=(cursor, lock, query, results, i))
            threads.append(thread)
            thread.start()

        for thread in threads:
            thread.join()

        fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
        output_path = f"Resultados_Consultas_{fecha_hora}.pdf"

        doc = SimpleDocTemplate(output_path, pagesize=letter)
        story = []

        for i, (query, (headers, result, exec_time)) in enumerate(zip(queries, results)):
            story.append(Table([[f"Consulta {i + 1}", query]], colWidths=[2.5 * inch, 4.5 * inch]))
            story.append(Table([["Tiempo de ejecución:", f"{exec_time} segundos"]], colWidths=[2.5 * inch, 4.5 * inch]))
            story.append(Table([["Resultados:"]], colWidths=[7 * inch]))

            if isinstance(result, list) and result:
                data = [headers] + result
            else:
                data = [["Sin resultados"]]

            t = Table(data)
            t.setStyle(TableStyle([
                ('BACKGROUND', (0, 0), (-1, 0), colors.gray),
                ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
                ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
                ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
                ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
                ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
                ('GRID', (0, 0), (-1, -1), 1, colors.black),
                ('BOX', (0, 0), (-1, -1), 2, colors.black),
            ]))

            story.append(t)
            story.append(Spacer(1, 12))

        doc.build(story)
        print(f"Informe generado en: {output_path}")
        messagebox.showinfo("Éxito", "Los hilos se generaron correctamente.")
    except Exception as e:
        messagebox.showerror("Error", f"Se produjo un error al los hilos: {e}")
    finally:
        cursor.close()
        conn.close()

root = tk.Tk()
root.title("Generador de Informes")

generate_button = tk.Button(root, text="Generar Informe", command=generar_reporte)
generate_button.pack(pady=20)

root.mainloop()


# ---------------------------------------------
# Funciones para cambiar el color del botón al pasar el cursor
def on_enter(e):
    e.widget['background'] = '#73877B'

def on_leave(e):
    e.widget['background'] = '#839788'

# Crear la ventana principal de la interfaz gráfica
ventana = tk.Tk()
ventana.title("Gestión de Auditoría y Reportes")
ventana.geometry("700x400")
ventana.configure(background='#E5D1D0')  # Fondo color pastel claro

# Crear el frame principal
frame_principal = tk.Frame(ventana, bg='#E5D1D0')
frame_principal.pack(padx=20, pady=20, fill='both', expand=True)

# Ruta del logo (usa raw string para evitar problemas con caracteres de escape)
logo_path = r"C:\Users\PC GAMER\Desktop\sqlserver\project\code\logo.png"

# Verificar si el archivo existe
if os.path.exists(logo_path):
    logo = Image.open(logo_path)  # Cargar el logo
    logo = logo.resize((80, 80), Image.LANCZOS)
    ventana.logo_img = ImageTk.PhotoImage(logo)  # Guardar la referencia en el objeto ventana
    logo_label = tk.Label(frame_principal, image=ventana.logo_img, bg='#E5D1D0')
    logo_label.grid(row=0, column=0, columnspan=3, pady=(0, 20))
else:
    print(f"Error: No se encuentra el archivo de logo en {logo_path}")

# Crear y ubicar los widgets en el frame principal con colores
style = ttk.Style()
style.configure("TLabel", background='#E5D1D0', font=('Helvetica', 12), foreground='black')  # Fondo color pastel y texto negro
style.configure("TEntry", font=('Helvetica', 12))
style.configure("TCombobox", font=('Helvetica', 12))

ttk.Label(frame_principal, text="Fecha de Inicio (YYYY-MM-DD HH:MM:SS):").grid(row=1, column=0, padx=5, pady=5, sticky=tk.W)
fecha_inicio_entry = ttk.Entry(frame_principal, width=25)
fecha_inicio_entry.grid(row=1, column=1, padx=5, pady=5, sticky=(tk.W, tk.E), columnspan=2)

ttk.Label(frame_principal, text="Fecha de Fin (YYYY-MM-DD HH:MM:SS):").grid(row=2, column=0, padx=5, pady=5, sticky=tk.W)
fecha_fin_entry = ttk.Entry(frame_principal, width=25)
fecha_fin_entry.grid(row=2, column=1, padx=5, pady=5, sticky=(tk.W, tk.E), columnspan=2)

ttk.Label(frame_principal, text="Usuario:").grid(row=3, column=0, padx=5, pady=5, sticky=tk.W)
usuario_combobox = ttk.Combobox(frame_principal, state="readonly")
usuario_combobox.grid(row=3, column=1, padx=5, pady=5, sticky=(tk.W, tk.E), columnspan=1)
cargar_usuarios_btn = tk.Button(frame_principal, text="Cargar Usuarios", command=cargar_usuarios, bg='#839788', fg='white')
cargar_usuarios_btn.grid(row=3, column=2, padx=5, pady=5, sticky=tk.W)

ttk.Label(frame_principal, text="Database:").grid(row=4, column=0, padx=5, pady=5, sticky=tk.W)
database_entry = ttk.Entry(frame_principal, width=50)
database_entry.grid(row=4, column=1, padx=5, pady=5, sticky=(tk.W, tk.E), columnspan=2)

# Frame para los botones de acciones
frame_botones = tk.Frame(frame_principal, bg='#E5D1D0')
frame_botones.grid(row=5, column=0, columnspan=3, pady=20)

guardar_configuracion_btn = tk.Button(frame_botones, text="Guardar Configuración", command=guardar_configuracion, bg='#839788', fg='white')
guardar_configuracion_btn.grid(row=0, column=0, padx=10, pady=5)
generar_disparadores_btn = tk.Button(frame_botones, text="Generar Disparadores", command=generar_disparadores_bd, bg='#839788', fg='white')
generar_disparadores_btn.grid(row=0, column=1, padx=10, pady=5)
eliminar_disparadores_btn = tk.Button(frame_botones, text="Eliminar Disparadores", command=eliminar_disparadores_bd, bg='#839788', fg='white')
eliminar_disparadores_btn.grid(row=0, column=2, padx=10, pady=5)
generar_reporte_btn = tk.Button(frame_botones, text="Generar Reporte", command=generar_reporte, bg='#839788', fg='white')
generar_reporte_btn.grid(row=0, column=3, padx=10, pady=5)
generar_hilos_btn = tk.Button(frame_botones, text="Generar Hilos", command=generar_hilos, bg='#839788', fg='white')
generar_hilos_btn.grid(row=0, column=4, padx=10, pady=5)

# Asociar eventos de entrada y salida del cursor para cambiar color de botones
for btn in [cargar_usuarios_btn, guardar_configuracion_btn, generar_disparadores_btn, eliminar_disparadores_btn, generar_reporte_btn, generar_hilos_btn]:
    btn.bind("<Enter>", on_enter)
    btn.bind("<Leave>", on_leave)

# Cargar configuración al iniciar
cargar_configuracion()

# Iniciar el bucle principal de la interfaz gráfica
ventana.mainloop()
