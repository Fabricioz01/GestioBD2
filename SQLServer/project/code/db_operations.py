import pyodbc

from segundoParcialTutoria.sqlserver.project.code.audit_triggers import obtener_columnas # type: ignore

def obtener_tablas(cursor):
    cursor.execute("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'")
    return cursor.fetchall()

def crear_funcion_trigger(tabla, columnas):
    columnas_json_insert = ', '.join([f"'{col}', CONVERT(varchar(255), INSERTED.{col})" for col in columnas])
    columnas_json_update = ', '.join([f"'{col}', CONVERT(varchar(255), INSERTED.{col})" for col in columnas])
    columnas_json_delete = ', '.join([f"'{col}', CONVERT(varchar(255), DELETED.{col})" for col in columnas])
    
    return f"""
    CREATE TRIGGER audit_{tabla}_insert
    ON {tabla}
    AFTER INSERT
    AS
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', SUSER_SNAME(), 'INSERT', '{{ {columnas_json_insert} }}');
    END;

    CREATE TRIGGER audit_{tabla}_update
    ON {tabla}
    AFTER UPDATE
    AS
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', SUSER_SNAME(), 'UPDATE', '{{ {columnas_json_update} }}');
    END;

    CREATE TRIGGER audit_{tabla}_delete
    ON {tabla}
    AFTER DELETE
    AS
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', SUSER_SNAME(), 'DELETE', '{{ {columnas_json_delete} }}');
    END;
    """

def generar_disparadores(cursor, tablas):
    with open("auditoria_triggers.sql", "w", encoding="utf-8") as sql_file:
        for tabla in tablas:
            if tabla[0].lower() != 'auditoria':
                columnas = obtener_columnas(cursor, tabla[0])
                funcion_sql = crear_funcion_trigger(tabla[0], columnas)
                sql_file.write(funcion_sql + "\n")
                try:
                    statements = funcion_sql.split('END;')
                    for statement in statements:
                        if statement.strip():
                            cursor.execute(statement.strip() + ' END;')
                except pyodbc.Error as e:
                    print(f"Error al crear el trigger para la tabla {tabla[0]}: {e}")
    print("\nDisparadores de auditoría creados exitosamente y guardados en 'auditoria_triggers.sql'.")

def eliminar_disparadores_funciones(cursor, tabla):
    try:
        cursor.execute(f"DROP TRIGGER IF EXISTS audit_{tabla}_insert;")
        cursor.execute(f"DROP TRIGGER IF EXISTS audit_{tabla}_update;")
        cursor.execute(f"DROP TRIGGER IF EXISTS audit_{tabla}_delete;")
        print(f"Triggers de auditoría para la tabla '{tabla}' eliminados correctamente.")
    except pyodbc.Error as e:
        print(f"Error al eliminar: {e}")

def obtener_triggers(cursor):
    cursor.execute("SELECT name FROM sys.triggers")
    return cursor.fetchall()

def obtener_funciones(cursor):
    cursor.execute("SELECT name FROM sys.procedures")
    return cursor.fetchall()
