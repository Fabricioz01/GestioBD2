import os
import re
from datetime import datetime
import chardet

def obtener_usuarios(cursor):
    cursor.execute("SELECT user FROM mysql.user;")
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
                        r"(?P<fecha_hora>\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z)",
                        line
                    )
                    if match:
                        log_fecha = datetime.strptime(match.group("fecha_hora"), "%Y-%m-%dT%H:%M:%S.%fZ")
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
