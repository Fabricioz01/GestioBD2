import mysql.connector

def obtener_tablas(cursor):
    cursor.execute("SHOW TABLES")
    return cursor.fetchall()

#def crear_funcion_trigger(tabla):
    return f"""
    CREATE TRIGGER audit_{tabla}_insert
    AFTER INSERT ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', USER(), 'INSERT', JSON_OBJECT('NEW', NEW.*));
    END;

    CREATE TRIGGER audit_{tabla}_update
    AFTER UPDATE ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', USER(), 'UPDATE', JSON_OBJECT('NEW', NEW.*));
    END;

    CREATE TRIGGER audit_{tabla}_delete
    AFTER DELETE ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', USER(), 'DELETE', JSON_OBJECT('OLD', OLD.*));
    END;
    """

def obtener_tablas(cursor):
    cursor.execute("SHOW TABLES")
    return cursor.fetchall()

def obtener_columnas(cursor, tabla):
    cursor.execute(f"SHOW COLUMNS FROM {tabla}")
    return [columna[0] for columna in cursor.fetchall()]

def crear_funcion_trigger(tabla, columnas):
    columnas_json_insert = ', '.join([f'"{col}", NEW.{col}' for col in columnas])
    columnas_json_update = ', '.join([f'"{col}", NEW.{col}' for col in columnas])
    columnas_json_delete = ', '.join([f'"{col}", OLD.{col}' for col in columnas])
    
    return f"""
    CREATE TRIGGER audit_{tabla}_insert
    AFTER INSERT ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', USER(), 'INSERT', JSON_OBJECT({columnas_json_insert}));
    END;

    CREATE TRIGGER audit_{tabla}_update
    AFTER UPDATE ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', USER(), 'UPDATE', JSON_OBJECT({columnas_json_update}));
    END;

    CREATE TRIGGER audit_{tabla}_delete
    AFTER DELETE ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', USER(), 'DELETE', JSON_OBJECT({columnas_json_delete}));
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
                except mysql.connector.Error as e:
                    print(f"Error al crear el trigger para la tabla {tabla[0]}: {e}")
    print("\nDisparadores de auditoría creados exitosamente y guardados en 'auditoria_triggers.sql'.")

def crear_trigger(tabla):
    return crear_funcion_trigger(tabla)

#def generar_disparadores(cursor, tablas):
    with open("auditoria_triggers.sql", "w", encoding="utf-8") as sql_file:
        for tabla in tablas:
            if tabla[0].lower() != 'auditoria':
                funcion_sql = crear_funcion_trigger(tabla[0])
                sql_file.write(funcion_sql + "\n")
                try:
                    for statement in funcion_sql.split(';'):
                        if statement.strip():
                            cursor.execute(statement.strip() + ';')
                except mysql.connector.Error as e:
                    print(f"Error al crear el trigger para la tabla {tabla[0]}: {e}")
    print("\nDisparadores de auditoría creados exitosamente y guardados en 'auditoria_triggers.sql'.")


def eliminar_disparadores_funciones(cursor, tabla):
    try:
        cursor.execute(f"DROP TRIGGER IF EXISTS audit_{tabla}_insert;")
        cursor.execute(f"DROP TRIGGER IF EXISTS audit_{tabla}_update;")
        cursor.execute(f"DROP TRIGGER IF EXISTS audit_{tabla}_delete;")
        print(f"Triggers de auditoría para la tabla '{tabla}' eliminados correctamente.")
    except mysql.connector.Error as e:
        print(f"Error al eliminar: {e}")

def obtener_triggers(cursor):
    cursor.execute("SHOW TRIGGERS")
    return cursor.fetchall()

def obtener_funciones(cursor):
    cursor.execute("SHOW PROCEDURE STATUS WHERE Db = DATABASE()")
    return cursor.fetchall()
