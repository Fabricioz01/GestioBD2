import pyodbc
from datetime import datetime

def conectar_bd():
    try:
        conexion = pyodbc.connect(
            'DRIVER={ODBC Driver 17 for SQL Server};'
            'SERVER=DESKTOP-SSEKAEO\SQLEXPRESS;'
            'DATABASE=bd_proyecto;'
            'Trusted_Connection=yes;'
        )
        return conexion
    except pyodbc.Error as e:
        print(f"Error de conexión: {e}")
        return None

def obtener_usuarios(cursor):
    cursor.execute("SELECT DISTINCT USUARIO_DB FROM AUDITORIA;")
    return [usuario[0] for usuario in cursor.fetchall()]

def leer_logs_en_rango(fecha_inicio, fecha_fin, usuario):
    logs_combinados = []
    try:
        fecha_inicio = datetime.strptime(fecha_inicio, "%Y-%m-%d %H:%M:%S")
        fecha_fin = datetime.strptime(fecha_fin, "%Y-%m-%d %H:%M:%S")
    except ValueError:
        print("Formato de fecha y hora incorrecto.")
        return []

    conexion = conectar_bd()
    if not conexion:
        return []

    cursor = conexion.cursor()
    query = f"""
    SELECT event_time, action_id, succeeded, session_id, server_principal_name, database_name, schema_name, object_name, statement
    FROM sys.fn_get_audit_file('C:\\AuditLogs\\*', NULL, NULL)
    WHERE event_time >= ? AND event_time <= ?
      AND server_principal_name = ?
    """

    cursor.execute(query, fecha_inicio, fecha_fin, usuario)
    for row in cursor.fetchall():
        log_entry = {
            'fecha_hora': row[0].strftime("%Y-%m-%d %H:%M:%S"),
            'linea': f"Acción: {row[1]}, Resultado: {row[2]}, Sesión: {row[3]}, Usuario: {row[4]}, Base de Datos: {row[5]}, Esquema: {row[6]}, Objeto: {row[7]}, Sentencia: {row[8]}"
        }
        logs_combinados.append(log_entry)

    conexion.close()
    return logs_combinados

def leer_auditoria(fecha_inicio, fecha_fin, usuario):
    auditoria_datos = []
    try:
        fecha_inicio_dt = datetime.strptime(fecha_inicio, "%Y-%m-%d %H:%M:%S")
        fecha_fin_dt = datetime.strptime(fecha_fin, "%Y-%m-%d %H:%M:%S")
    except ValueError:
        print("Formato de fecha y hora incorrecto.")
        return []

    conexion = conectar_bd()
    if not conexion:
        return []

    cursor = conexion.cursor()
    query = f"""
    SELECT fecha_hora, nombre_tabla, accion, descripcion_cambios
    FROM AUDITORIA
    WHERE fecha_hora >= ? AND fecha_hora <= ?
      AND USUARIO_DB = ?
    """

    cursor.execute(query, fecha_inicio_dt, fecha_fin_dt, usuario)
    for row in cursor.fetchall():
        auditoria_entry = {
            'fecha_hora': row[0].strftime("%Y-%m-%d %H:%M:%S"),
            'nombre_tabla': row[1],
            'accion': row[2],
            'descripcion_cambios': row[3]
        }
        auditoria_datos.append(auditoria_entry)

    conexion.close()
    return auditoria_datos

def validar_fechas(fecha_inicio, fecha_fin):
    try:
        datetime.strptime(fecha_inicio, "%Y-%m-%d %H:%M:%S")
        datetime.strptime(fecha_fin, "%Y-%m-%d %H:%M:%S")
        return True
    except ValueError:
        print("Formato de fecha y hora incorrecto. Por favor, use el formato 'YYYY-MM-DD HH:MM:SS'.")
        return False
