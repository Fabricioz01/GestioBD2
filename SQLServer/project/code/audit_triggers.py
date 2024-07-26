import pyodbc

def obtener_tablas(cursor):
    cursor.execute("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'")
    return cursor.fetchall()

def obtener_columnas(cursor, tabla):
    cursor.execute(f"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='{tabla}'")
    return [columna[0] for columna in cursor.fetchall()]

def crear_funcion_trigger(tabla, columnas):
    columnas_json_insert = ', '.join([f"ISNULL(CONVERT(varchar(255), i.{col}), 'NULL') AS {col}" for col in columnas])
    columnas_json_update = ', '.join([f"ISNULL(CONVERT(varchar(255), i.{col}), 'NULL') AS {col}" for col in columnas])
    columnas_json_delete = ', '.join([f"ISNULL(CONVERT(varchar(255), d.{col}), 'NULL') AS {col}" for col in columnas])
    
    return f"""
    CREATE TRIGGER audit_{tabla}_insert
    ON {tabla}
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT {columnas_json_insert}
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_{tabla}_update
    ON {tabla}
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT {columnas_json_update}
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_{tabla}_delete
    ON {tabla}
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT {columnas_json_delete}
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('{tabla}', SUSER_SNAME(), 'DELETE', @json);
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
                    print(f"Creating triggers for table: {tabla[0]}")
                    statements = funcion_sql.split('END;')
                    for statement in statements:
                        if statement.strip():
                            print(f"Executing SQL: {statement.strip() + ' END;'}")
                            cursor.execute(statement.strip() + ' END;')
                    cursor.commit()
                    print(f"Triggers for table {tabla[0]} created successfully.")
                except pyodbc.Error as e:
                    print(f"Error al crear el trigger para la tabla {tabla[0]}: {e}")
                    cursor.rollback()
    print("\nDisparadores de auditoría creados exitosamente y guardados en 'auditoria_triggers.sql'.")

def eliminar_disparadores_funciones(cursor, tabla):
    try:
        cursor.execute(f"DROP TRIGGER IF EXISTS audit_{tabla}_insert;")
        cursor.execute(f"DROP TRIGGER IF EXISTS audit_{tabla}_update;")
        cursor.execute(f"DROP TRIGGER IF EXISTS audit_{tabla}_delete;")
        cursor.commit()
        print(f"Triggers de auditoría para la tabla '{tabla}' eliminados correctamente.")
    except pyodbc.Error as e:
        print(f"Error al eliminar: {e}")
        cursor.rollback()

def obtener_triggers(cursor):
    cursor.execute("SELECT name FROM sys.triggers")
    return cursor.fetchall()

def obtener_funciones(cursor):
    cursor.execute("SELECT name FROM sys.procedures")
    return cursor.fetchall()
