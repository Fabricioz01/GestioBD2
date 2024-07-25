import tkinter as tk
from tkinter import ttk, filedialog, messagebox
import json
import os
from tkinter import simpledialog
from mysql.connector import connect, Error

from audit_triggers import obtener_tablas, generar_disparadores, eliminar_disparadores_funciones
from log_processing import obtener_usuarios, leer_logs_en_rango, validar_fechas
from pdf_generator import generar_pdf

# Archivo de configuración
config_file = 'mysql.json'

def conectar_bd(database, user, password):
    try:
        conexion = connect(
            host="localhost",
            user=user,
            password=password,
            database=database,
            port="3306",
            charset='utf8mb4',
            collation='utf8mb4_unicode_ci'
        )
        return conexion
    except Error as e:
        error_msg = str(e)
        if "Unknown collation: 'utf8mb4_0900_ai_ci'" in error_msg:
            print("Error de conexión: La collation 'utf8mb4_0900_ai_ci' no es soportada por su versión de MySQL.")
            print("Por favor, cambie la collation de su base de datos a 'utf8mb4_unicode_ci'.")
        else:
            print(f"Error de conexión: {e}")
        return None

def verificar_conexion(database, user, password):
    conexion = conectar_bd(database, user, password)
    if conexion:
        try:
            cursor = conexion.cursor()
            cursor.execute("SELECT @@character_set_database, @@collation_database")
            result = cursor.fetchone()
            print(f"Character set: {result[0]}, Collation: {result[1]}")
        except Error as e:
            print(f"Error al verificar la conexión: {e}")
        finally:
            cerrar_conexion(None, conexion)
    else:
        print("No se pudo establecer la conexión.")

def obtener_cursor(conexion):
    try:
        return conexion.cursor()
    except Error as e:
        print(f"Error al obtener el cursor: {e}")
        return None

def cerrar_conexion(cursor, conexion):
    try:
        if cursor:
            cursor.close()
        if conexion:
            conexion.close()
    except Error as e:
        print(f"Error al cerrar la conexión: {e}")

# Función para cargar la configuración desde el archivo JSON
def cargar_configuracion():
    if os.path.exists(config_file):
        with open(config_file, 'r') as file:
            config = json.load(file)
            log_directory_entry.insert(0, config.get('log_directory', ''))
            fecha_inicio_entry.insert(0, config.get('default_start_date', ''))
            fecha_fin_entry.insert(0, config.get('default_end_date', ''))
            user_entry.insert(0, config.get('default_usuario', ''))
            database_entry.insert(0, config.get('default_database', ''))
            password_entry.insert(0, config.get('default_password', ''))

# Función para guardar la configuración en el archivo JSON
def guardar_configuracion():
    config = {
        'log_directory': log_directory_entry.get(),
        'default_start_date': fecha_inicio_entry.get(),
        'default_end_date': fecha_fin_entry.get(),
        'default_usuario': user_entry.get(),
        'default_database': database_entry.get(),
        'default_password': password_entry.get(),
    }
    with open(config_file, 'w') as file:
        json.dump(config, file)
    messagebox.showinfo("Configuración Guardada", "La configuración ha sido guardada exitosamente.")

# Función para cargar usuarios en el ComboBox
def cargar_usuarios():
    conexion = conectar_bd(database_entry.get(), user_entry.get(), password_entry.get())
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

# Función para seleccionar el directorio de logs
def cargar_logs():
    log_directory = filedialog.askdirectory()
    log_directory_entry.delete(0, tk.END)
    log_directory_entry.insert(0, log_directory)

# Función para generar los disparadores de auditoría
def generar_disparadores_bd():
    conexion = conectar_bd(database_entry.get(), user_entry.get(), password_entry.get())
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
        conexion = conectar_bd(database_entry.get(), user_entry.get(), password_entry.get())
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
    log_directory = log_directory_entry.get()
    fecha_inicio = fecha_inicio_entry.get()
    fecha_fin = fecha_fin_entry.get()
    usuario = usuario_combobox.get()
    
    if validar_fechas(fecha_inicio, fecha_fin):
        logs = leer_logs_en_rango(log_directory, fecha_inicio, fecha_fin, usuario)
        if logs:
            generar_pdf(logs, usuario, fecha_inicio, fecha_fin)
            messagebox.showinfo("Reporte Generado", "El reporte en PDF se generó exitosamente.")
        else:
            messagebox.showwarning("Sin Logs", "No se encontraron logs en el rango de fechas especificado.")
    else:
        messagebox.showerror("Error de Fechas", "La fecha de inicio no puede ser posterior a la fecha de fin.")

# Crear la ventana principal de la interfaz gráfica
ventana = tk.Tk()
ventana.title("Gestión de Auditoría y Reportes")

# Crear un estilo personalizado para ttk
style = ttk.Style()

# Colores pasteles cálidos
style.configure('TFrame', background='#FAD7A0')  # Fondo de los frames
style.configure('TLabel', background='#FAD7A0', foreground='#6E2C00', font=('Arial', 10, 'bold'))  # Etiquetas
style.configure('TButton', background='#F5CBA7', foreground='#6E2C00', font=('Arial', 10, 'bold'))  # Botones
style.configure('TEntry', fieldbackground='#FDEBD0', foreground='#6E2C00')  # Entradas de texto
style.configure('TCombobox', fieldbackground='#FDEBD0', foreground='#6E2C00')  # Combobox

# Crear el frame principal
frame_principal = ttk.Frame(ventana, padding="10")
frame_principal.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

# Configurar la cuadrícula
ventana.columnconfigure(0, weight=1)
ventana.rowconfigure(0, weight=1)

# Crear y ubicar los widgets en el frame principal
ttk.Label(frame_principal, text="Directorio de Logs:").grid(row=0, column=0, sticky=tk.W, pady=5)
log_directory_entry = ttk.Entry(frame_principal, width=50)
log_directory_entry.grid(row=0, column=1, sticky=(tk.W, tk.E), pady=5)
ttk.Button(frame_principal, text="Cargar", command=cargar_logs).grid(row=0, column=2, sticky=tk.W, pady=5)

ttk.Label(frame_principal, text="Fecha de Inicio (YYYY-MM-DD):").grid(row=1, column=0, sticky=tk.W, pady=5)
fecha_inicio_entry = ttk.Entry(frame_principal, width=20)
fecha_inicio_entry.grid(row=1, column=1, sticky=(tk.W, tk.E), pady=5)

ttk.Label(frame_principal, text="Fecha de Fin (YYYY-MM-DD):").grid(row=2, column=0, sticky=tk.W, pady=5)
fecha_fin_entry = ttk.Entry(frame_principal, width=20)
fecha_fin_entry.grid(row=2, column=1, sticky=(tk.W, tk.E), pady=5)

ttk.Label(frame_principal, text="Usuario:").grid(row=3, column=0, sticky=tk.W, pady=5)
usuario_combobox = ttk.Combobox(frame_principal, state="readonly")
usuario_combobox.grid(row=3, column=1, sticky=(tk.W, tk.E), pady=5)
ttk.Button(frame_principal, text="Cargar Usuarios", command=cargar_usuarios).grid(row=3, column=2, sticky=tk.W, pady=5)

ttk.Label(frame_principal, text="Database:").grid(row=4, column=0, sticky=tk.W, pady=5)
database_entry = ttk.Entry(frame_principal, width=50)
database_entry.grid(row=4, column=1, sticky=(tk.W, tk.E), pady=5)

ttk.Label(frame_principal, text="Usuario BD:").grid(row=5, column=0, sticky=tk.W, pady=5)
user_entry = ttk.Entry(frame_principal, width=50)
user_entry.grid(row=5, column=1, sticky=(tk.W, tk.E), pady=5)

ttk.Label(frame_principal, text="Contraseña BD:").grid(row=6, column=0, sticky=tk.W, pady=5)
password_entry = ttk.Entry(frame_principal, width=50, show='*')
password_entry.grid(row=6, column=1, sticky=(tk.W, tk.E), pady=5)

ttk.Button(frame_principal, text="Guardar Configuración", command=guardar_configuracion).grid(row=7, column=1, sticky=tk.E, pady=10)
ttk.Button(frame_principal, text="Generar Disparadores", command=generar_disparadores_bd).grid(row=8, column=0, sticky=tk.W, pady=5)
ttk.Button(frame_principal, text="Eliminar Disparadores", command=eliminar_disparadores_bd).grid(row=8, column=1, sticky=tk.W, pady=5)
ttk.Button(frame_principal, text="Generar Reporte", command=generar_reporte).grid(row=8, column=2, sticky=tk.E, pady=5)

# Cargar configuración al iniciar
cargar_configuracion()

# Iniciar el bucle principal de la interfaz gráfica
ventana.mainloop()
