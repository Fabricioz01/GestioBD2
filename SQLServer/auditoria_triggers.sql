
    CREATE TRIGGER audit_sysdiagrams_insert
    ON sysdiagrams
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.name), 'NULL') AS name, ISNULL(CONVERT(varchar(255), i.principal_id), 'NULL') AS principal_id, ISNULL(CONVERT(varchar(255), i.diagram_id), 'NULL') AS diagram_id, ISNULL(CONVERT(varchar(255), i.version), 'NULL') AS version, ISNULL(CONVERT(varchar(255), i.definition), 'NULL') AS definition
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('sysdiagrams', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_sysdiagrams_update
    ON sysdiagrams
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.name), 'NULL') AS name, ISNULL(CONVERT(varchar(255), i.principal_id), 'NULL') AS principal_id, ISNULL(CONVERT(varchar(255), i.diagram_id), 'NULL') AS diagram_id, ISNULL(CONVERT(varchar(255), i.version), 'NULL') AS version, ISNULL(CONVERT(varchar(255), i.definition), 'NULL') AS definition
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('sysdiagrams', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_sysdiagrams_delete
    ON sysdiagrams
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.name), 'NULL') AS name, ISNULL(CONVERT(varchar(255), d.principal_id), 'NULL') AS principal_id, ISNULL(CONVERT(varchar(255), d.diagram_id), 'NULL') AS diagram_id, ISNULL(CONVERT(varchar(255), d.version), 'NULL') AS version, ISNULL(CONVERT(varchar(255), d.definition), 'NULL') AS definition
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('sysdiagrams', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Hoteles_insert
    ON Hoteles
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Ubicacion), 'NULL') AS Ubicacion, ISNULL(CONVERT(varchar(255), i.NumeroHabitaciones), 'NULL') AS NumeroHabitaciones
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Hoteles', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Hoteles_update
    ON Hoteles
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Ubicacion), 'NULL') AS Ubicacion, ISNULL(CONVERT(varchar(255), i.NumeroHabitaciones), 'NULL') AS NumeroHabitaciones
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Hoteles', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Hoteles_delete
    ON Hoteles
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), d.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), d.Ubicacion), 'NULL') AS Ubicacion, ISNULL(CONVERT(varchar(255), d.NumeroHabitaciones), 'NULL') AS NumeroHabitaciones
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Hoteles', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Clientes_insert
    ON Clientes
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Telefono), 'NULL') AS Telefono, ISNULL(CONVERT(varchar(255), i.Email), 'NULL') AS Email
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Clientes', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Clientes_update
    ON Clientes
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Telefono), 'NULL') AS Telefono, ISNULL(CONVERT(varchar(255), i.Email), 'NULL') AS Email
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Clientes', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Clientes_delete
    ON Clientes
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), d.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), d.Telefono), 'NULL') AS Telefono, ISNULL(CONVERT(varchar(255), d.Email), 'NULL') AS Email
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Clientes', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Habitaciones_insert
    ON Habitaciones
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.HabitacionID), 'NULL') AS HabitacionID, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), i.Tipo), 'NULL') AS Tipo, ISNULL(CONVERT(varchar(255), i.PrecioNoche), 'NULL') AS PrecioNoche, ISNULL(CONVERT(varchar(255), i.Disponible), 'NULL') AS Disponible
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Habitaciones', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Habitaciones_update
    ON Habitaciones
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.HabitacionID), 'NULL') AS HabitacionID, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), i.Tipo), 'NULL') AS Tipo, ISNULL(CONVERT(varchar(255), i.PrecioNoche), 'NULL') AS PrecioNoche, ISNULL(CONVERT(varchar(255), i.Disponible), 'NULL') AS Disponible
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Habitaciones', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Habitaciones_delete
    ON Habitaciones
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.HabitacionID), 'NULL') AS HabitacionID, ISNULL(CONVERT(varchar(255), d.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), d.Tipo), 'NULL') AS Tipo, ISNULL(CONVERT(varchar(255), d.PrecioNoche), 'NULL') AS PrecioNoche, ISNULL(CONVERT(varchar(255), d.Disponible), 'NULL') AS Disponible
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Habitaciones', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Eventos_insert
    ON Eventos
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.EventoID), 'NULL') AS EventoID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Fecha), 'NULL') AS Fecha, ISNULL(CONVERT(varchar(255), i.Lugar), 'NULL') AS Lugar, ISNULL(CONVERT(varchar(255), i.Organizador), 'NULL') AS Organizador, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Eventos', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Eventos_update
    ON Eventos
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.EventoID), 'NULL') AS EventoID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Fecha), 'NULL') AS Fecha, ISNULL(CONVERT(varchar(255), i.Lugar), 'NULL') AS Lugar, ISNULL(CONVERT(varchar(255), i.Organizador), 'NULL') AS Organizador, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Eventos', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Eventos_delete
    ON Eventos
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.EventoID), 'NULL') AS EventoID, ISNULL(CONVERT(varchar(255), d.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), d.Fecha), 'NULL') AS Fecha, ISNULL(CONVERT(varchar(255), d.Lugar), 'NULL') AS Lugar, ISNULL(CONVERT(varchar(255), d.Organizador), 'NULL') AS Organizador, ISNULL(CONVERT(varchar(255), d.HotelID), 'NULL') AS HotelID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Eventos', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Reservaciones_insert
    ON Reservaciones
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ReservacionID), 'NULL') AS ReservacionID, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), i.HabitacionID), 'NULL') AS HabitacionID, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), i.FechaEntrada), 'NULL') AS FechaEntrada, ISNULL(CONVERT(varchar(255), i.FechaSalida), 'NULL') AS FechaSalida, ISNULL(CONVERT(varchar(255), i.Estado), 'NULL') AS Estado
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Reservaciones', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Reservaciones_update
    ON Reservaciones
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ReservacionID), 'NULL') AS ReservacionID, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), i.HabitacionID), 'NULL') AS HabitacionID, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), i.FechaEntrada), 'NULL') AS FechaEntrada, ISNULL(CONVERT(varchar(255), i.FechaSalida), 'NULL') AS FechaSalida, ISNULL(CONVERT(varchar(255), i.Estado), 'NULL') AS Estado
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Reservaciones', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Reservaciones_delete
    ON Reservaciones
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.ReservacionID), 'NULL') AS ReservacionID, ISNULL(CONVERT(varchar(255), d.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), d.HabitacionID), 'NULL') AS HabitacionID, ISNULL(CONVERT(varchar(255), d.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), d.FechaEntrada), 'NULL') AS FechaEntrada, ISNULL(CONVERT(varchar(255), d.FechaSalida), 'NULL') AS FechaSalida, ISNULL(CONVERT(varchar(255), d.Estado), 'NULL') AS Estado
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Reservaciones', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_ServiciosAdicionales_insert
    ON ServiciosAdicionales
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ServicioID), 'NULL') AS ServicioID, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Descripcion), 'NULL') AS Descripcion, ISNULL(CONVERT(varchar(255), i.Precio), 'NULL') AS Precio
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ServiciosAdicionales', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_ServiciosAdicionales_update
    ON ServiciosAdicionales
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ServicioID), 'NULL') AS ServicioID, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Descripcion), 'NULL') AS Descripcion, ISNULL(CONVERT(varchar(255), i.Precio), 'NULL') AS Precio
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ServiciosAdicionales', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_ServiciosAdicionales_delete
    ON ServiciosAdicionales
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.ServicioID), 'NULL') AS ServicioID, ISNULL(CONVERT(varchar(255), d.HotelID), 'NULL') AS HotelID, ISNULL(CONVERT(varchar(255), d.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), d.Descripcion), 'NULL') AS Descripcion, ISNULL(CONVERT(varchar(255), d.Precio), 'NULL') AS Precio
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ServiciosAdicionales', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_ReservasDeServicios_insert
    ON ReservasDeServicios
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ReservaID), 'NULL') AS ReservaID, ISNULL(CONVERT(varchar(255), i.ServicioID), 'NULL') AS ServicioID, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), i.FechaReserva), 'NULL') AS FechaReserva, ISNULL(CONVERT(varchar(255), i.Estado), 'NULL') AS Estado
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ReservasDeServicios', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_ReservasDeServicios_update
    ON ReservasDeServicios
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ReservaID), 'NULL') AS ReservaID, ISNULL(CONVERT(varchar(255), i.ServicioID), 'NULL') AS ServicioID, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), i.FechaReserva), 'NULL') AS FechaReserva, ISNULL(CONVERT(varchar(255), i.Estado), 'NULL') AS Estado
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ReservasDeServicios', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_ReservasDeServicios_delete
    ON ReservasDeServicios
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.ReservaID), 'NULL') AS ReservaID, ISNULL(CONVERT(varchar(255), d.ServicioID), 'NULL') AS ServicioID, ISNULL(CONVERT(varchar(255), d.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), d.FechaReserva), 'NULL') AS FechaReserva, ISNULL(CONVERT(varchar(255), d.Estado), 'NULL') AS Estado
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ReservasDeServicios', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Empleados_insert
    ON Empleados
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.EmpleadoID), 'NULL') AS EmpleadoID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Puesto), 'NULL') AS Puesto, ISNULL(CONVERT(varchar(255), i.Telefono), 'NULL') AS Telefono, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Empleados', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Empleados_update
    ON Empleados
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.EmpleadoID), 'NULL') AS EmpleadoID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.Puesto), 'NULL') AS Puesto, ISNULL(CONVERT(varchar(255), i.Telefono), 'NULL') AS Telefono, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Empleados', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Empleados_delete
    ON Empleados
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.EmpleadoID), 'NULL') AS EmpleadoID, ISNULL(CONVERT(varchar(255), d.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), d.Puesto), 'NULL') AS Puesto, ISNULL(CONVERT(varchar(255), d.Telefono), 'NULL') AS Telefono, ISNULL(CONVERT(varchar(255), d.HotelID), 'NULL') AS HotelID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Empleados', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_TurnosDeTrabajo_insert
    ON TurnosDeTrabajo
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.TurnoID), 'NULL') AS TurnoID, ISNULL(CONVERT(varchar(255), i.Fecha), 'NULL') AS Fecha, ISNULL(CONVERT(varchar(255), i.HoraInicio), 'NULL') AS HoraInicio, ISNULL(CONVERT(varchar(255), i.HoraFin), 'NULL') AS HoraFin, ISNULL(CONVERT(varchar(255), i.EmpleadoID), 'NULL') AS EmpleadoID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('TurnosDeTrabajo', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_TurnosDeTrabajo_update
    ON TurnosDeTrabajo
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.TurnoID), 'NULL') AS TurnoID, ISNULL(CONVERT(varchar(255), i.Fecha), 'NULL') AS Fecha, ISNULL(CONVERT(varchar(255), i.HoraInicio), 'NULL') AS HoraInicio, ISNULL(CONVERT(varchar(255), i.HoraFin), 'NULL') AS HoraFin, ISNULL(CONVERT(varchar(255), i.EmpleadoID), 'NULL') AS EmpleadoID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('TurnosDeTrabajo', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_TurnosDeTrabajo_delete
    ON TurnosDeTrabajo
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.TurnoID), 'NULL') AS TurnoID, ISNULL(CONVERT(varchar(255), d.Fecha), 'NULL') AS Fecha, ISNULL(CONVERT(varchar(255), d.HoraInicio), 'NULL') AS HoraInicio, ISNULL(CONVERT(varchar(255), d.HoraFin), 'NULL') AS HoraFin, ISNULL(CONVERT(varchar(255), d.EmpleadoID), 'NULL') AS EmpleadoID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('TurnosDeTrabajo', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_MetodosDePago_insert
    ON MetodosDePago
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.MetodoPagoID), 'NULL') AS MetodoPagoID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('MetodosDePago', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_MetodosDePago_update
    ON MetodosDePago
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.MetodoPagoID), 'NULL') AS MetodoPagoID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('MetodosDePago', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_MetodosDePago_delete
    ON MetodosDePago
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.MetodoPagoID), 'NULL') AS MetodoPagoID, ISNULL(CONVERT(varchar(255), d.Nombre), 'NULL') AS Nombre
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('MetodosDePago', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Pagos_insert
    ON Pagos
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.PagoID), 'NULL') AS PagoID, ISNULL(CONVERT(varchar(255), i.MetodoPago), 'NULL') AS MetodoPago, ISNULL(CONVERT(varchar(255), i.Monto), 'NULL') AS Monto, ISNULL(CONVERT(varchar(255), i.FechaPago), 'NULL') AS FechaPago, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), i.ReservacionID), 'NULL') AS ReservacionID, ISNULL(CONVERT(varchar(255), i.MetodoPagoID), 'NULL') AS MetodoPagoID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Pagos', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Pagos_update
    ON Pagos
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.PagoID), 'NULL') AS PagoID, ISNULL(CONVERT(varchar(255), i.MetodoPago), 'NULL') AS MetodoPago, ISNULL(CONVERT(varchar(255), i.Monto), 'NULL') AS Monto, ISNULL(CONVERT(varchar(255), i.FechaPago), 'NULL') AS FechaPago, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), i.ReservacionID), 'NULL') AS ReservacionID, ISNULL(CONVERT(varchar(255), i.MetodoPagoID), 'NULL') AS MetodoPagoID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Pagos', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Pagos_delete
    ON Pagos
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.PagoID), 'NULL') AS PagoID, ISNULL(CONVERT(varchar(255), d.MetodoPago), 'NULL') AS MetodoPago, ISNULL(CONVERT(varchar(255), d.Monto), 'NULL') AS Monto, ISNULL(CONVERT(varchar(255), d.FechaPago), 'NULL') AS FechaPago, ISNULL(CONVERT(varchar(255), d.ClienteID), 'NULL') AS ClienteID, ISNULL(CONVERT(varchar(255), d.ReservacionID), 'NULL') AS ReservacionID, ISNULL(CONVERT(varchar(255), d.MetodoPagoID), 'NULL') AS MetodoPagoID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Pagos', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Proveedores_insert
    ON Proveedores
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ProveedorID), 'NULL') AS ProveedorID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.TipoProductos), 'NULL') AS TipoProductos, ISNULL(CONVERT(varchar(255), i.Contacto), 'NULL') AS Contacto
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Proveedores', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Proveedores_update
    ON Proveedores
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ProveedorID), 'NULL') AS ProveedorID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.TipoProductos), 'NULL') AS TipoProductos, ISNULL(CONVERT(varchar(255), i.Contacto), 'NULL') AS Contacto
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Proveedores', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Proveedores_delete
    ON Proveedores
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.ProveedorID), 'NULL') AS ProveedorID, ISNULL(CONVERT(varchar(255), d.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), d.TipoProductos), 'NULL') AS TipoProductos, ISNULL(CONVERT(varchar(255), d.Contacto), 'NULL') AS Contacto
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Proveedores', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Compras_insert
    ON Compras
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.CompraID), 'NULL') AS CompraID, ISNULL(CONVERT(varchar(255), i.FechaCompra), 'NULL') AS FechaCompra, ISNULL(CONVERT(varchar(255), i.MontoTotal), 'NULL') AS MontoTotal, ISNULL(CONVERT(varchar(255), i.ProveedorID), 'NULL') AS ProveedorID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Compras', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Compras_update
    ON Compras
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.CompraID), 'NULL') AS CompraID, ISNULL(CONVERT(varchar(255), i.FechaCompra), 'NULL') AS FechaCompra, ISNULL(CONVERT(varchar(255), i.MontoTotal), 'NULL') AS MontoTotal, ISNULL(CONVERT(varchar(255), i.ProveedorID), 'NULL') AS ProveedorID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Compras', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Compras_delete
    ON Compras
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.CompraID), 'NULL') AS CompraID, ISNULL(CONVERT(varchar(255), d.FechaCompra), 'NULL') AS FechaCompra, ISNULL(CONVERT(varchar(255), d.MontoTotal), 'NULL') AS MontoTotal, ISNULL(CONVERT(varchar(255), d.ProveedorID), 'NULL') AS ProveedorID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Compras', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Inventario_insert
    ON Inventario
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.InventarioID), 'NULL') AS InventarioID, ISNULL(CONVERT(varchar(255), i.Producto), 'NULL') AS Producto, ISNULL(CONVERT(varchar(255), i.Cantidad), 'NULL') AS Cantidad, ISNULL(CONVERT(varchar(255), i.NivelMinimo), 'NULL') AS NivelMinimo, ISNULL(CONVERT(varchar(255), i.CompraID), 'NULL') AS CompraID, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Inventario', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Inventario_update
    ON Inventario
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.InventarioID), 'NULL') AS InventarioID, ISNULL(CONVERT(varchar(255), i.Producto), 'NULL') AS Producto, ISNULL(CONVERT(varchar(255), i.Cantidad), 'NULL') AS Cantidad, ISNULL(CONVERT(varchar(255), i.NivelMinimo), 'NULL') AS NivelMinimo, ISNULL(CONVERT(varchar(255), i.CompraID), 'NULL') AS CompraID, ISNULL(CONVERT(varchar(255), i.HotelID), 'NULL') AS HotelID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Inventario', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Inventario_delete
    ON Inventario
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.InventarioID), 'NULL') AS InventarioID, ISNULL(CONVERT(varchar(255), d.Producto), 'NULL') AS Producto, ISNULL(CONVERT(varchar(255), d.Cantidad), 'NULL') AS Cantidad, ISNULL(CONVERT(varchar(255), d.NivelMinimo), 'NULL') AS NivelMinimo, ISNULL(CONVERT(varchar(255), d.CompraID), 'NULL') AS CompraID, ISNULL(CONVERT(varchar(255), d.HotelID), 'NULL') AS HotelID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Inventario', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Mantenimiento_insert
    ON Mantenimiento
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.MantenimientoID), 'NULL') AS MantenimientoID, ISNULL(CONVERT(varchar(255), i.Fecha), 'NULL') AS Fecha, ISNULL(CONVERT(varchar(255), i.Tipo), 'NULL') AS Tipo, ISNULL(CONVERT(varchar(255), i.HabitacionID), 'NULL') AS HabitacionID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Mantenimiento', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Mantenimiento_update
    ON Mantenimiento
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.MantenimientoID), 'NULL') AS MantenimientoID, ISNULL(CONVERT(varchar(255), i.Fecha), 'NULL') AS Fecha, ISNULL(CONVERT(varchar(255), i.Tipo), 'NULL') AS Tipo, ISNULL(CONVERT(varchar(255), i.HabitacionID), 'NULL') AS HabitacionID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Mantenimiento', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Mantenimiento_delete
    ON Mantenimiento
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.MantenimientoID), 'NULL') AS MantenimientoID, ISNULL(CONVERT(varchar(255), d.Fecha), 'NULL') AS Fecha, ISNULL(CONVERT(varchar(255), d.Tipo), 'NULL') AS Tipo, ISNULL(CONVERT(varchar(255), d.HabitacionID), 'NULL') AS HabitacionID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Mantenimiento', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_ReservasDeEventos_insert
    ON ReservasDeEventos
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ReservaID), 'NULL') AS ReservaID, ISNULL(CONVERT(varchar(255), i.EventoID), 'NULL') AS EventoID, ISNULL(CONVERT(varchar(255), i.FechaReserva), 'NULL') AS FechaReserva, ISNULL(CONVERT(varchar(255), i.TipoEvento), 'NULL') AS TipoEvento, ISNULL(CONVERT(varchar(255), i.NumeroAsistentes), 'NULL') AS NumeroAsistentes
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ReservasDeEventos', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_ReservasDeEventos_update
    ON ReservasDeEventos
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ReservaID), 'NULL') AS ReservaID, ISNULL(CONVERT(varchar(255), i.EventoID), 'NULL') AS EventoID, ISNULL(CONVERT(varchar(255), i.FechaReserva), 'NULL') AS FechaReserva, ISNULL(CONVERT(varchar(255), i.TipoEvento), 'NULL') AS TipoEvento, ISNULL(CONVERT(varchar(255), i.NumeroAsistentes), 'NULL') AS NumeroAsistentes
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ReservasDeEventos', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_ReservasDeEventos_delete
    ON ReservasDeEventos
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.ReservaID), 'NULL') AS ReservaID, ISNULL(CONVERT(varchar(255), d.EventoID), 'NULL') AS EventoID, ISNULL(CONVERT(varchar(255), d.FechaReserva), 'NULL') AS FechaReserva, ISNULL(CONVERT(varchar(255), d.TipoEvento), 'NULL') AS TipoEvento, ISNULL(CONVERT(varchar(255), d.NumeroAsistentes), 'NULL') AS NumeroAsistentes
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ReservasDeEventos', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_ServiciosDeLimpieza_insert
    ON ServiciosDeLimpieza
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ServicioID), 'NULL') AS ServicioID, ISNULL(CONVERT(varchar(255), i.FechaLimpieza), 'NULL') AS FechaLimpieza, ISNULL(CONVERT(varchar(255), i.HabitacionesAtendidas), 'NULL') AS HabitacionesAtendidas, ISNULL(CONVERT(varchar(255), i.EmpleadoID), 'NULL') AS EmpleadoID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ServiciosDeLimpieza', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_ServiciosDeLimpieza_update
    ON ServiciosDeLimpieza
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ServicioID), 'NULL') AS ServicioID, ISNULL(CONVERT(varchar(255), i.FechaLimpieza), 'NULL') AS FechaLimpieza, ISNULL(CONVERT(varchar(255), i.HabitacionesAtendidas), 'NULL') AS HabitacionesAtendidas, ISNULL(CONVERT(varchar(255), i.EmpleadoID), 'NULL') AS EmpleadoID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ServiciosDeLimpieza', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_ServiciosDeLimpieza_delete
    ON ServiciosDeLimpieza
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.ServicioID), 'NULL') AS ServicioID, ISNULL(CONVERT(varchar(255), d.FechaLimpieza), 'NULL') AS FechaLimpieza, ISNULL(CONVERT(varchar(255), d.HabitacionesAtendidas), 'NULL') AS HabitacionesAtendidas, ISNULL(CONVERT(varchar(255), d.EmpleadoID), 'NULL') AS EmpleadoID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ServiciosDeLimpieza', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_Reseñas_insert
    ON Reseñas
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ReseñaID), 'NULL') AS ReseñaID, ISNULL(CONVERT(varchar(255), i.ReservacionID), 'NULL') AS ReservacionID, ISNULL(CONVERT(varchar(255), i.Puntuacion), 'NULL') AS Puntuacion, ISNULL(CONVERT(varchar(255), i.Comentario), 'NULL') AS Comentario, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Reseñas', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_Reseñas_update
    ON Reseñas
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ReseñaID), 'NULL') AS ReseñaID, ISNULL(CONVERT(varchar(255), i.ReservacionID), 'NULL') AS ReservacionID, ISNULL(CONVERT(varchar(255), i.Puntuacion), 'NULL') AS Puntuacion, ISNULL(CONVERT(varchar(255), i.Comentario), 'NULL') AS Comentario, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Reseñas', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_Reseñas_delete
    ON Reseñas
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.ReseñaID), 'NULL') AS ReseñaID, ISNULL(CONVERT(varchar(255), d.ReservacionID), 'NULL') AS ReservacionID, ISNULL(CONVERT(varchar(255), d.Puntuacion), 'NULL') AS Puntuacion, ISNULL(CONVERT(varchar(255), d.Comentario), 'NULL') AS Comentario, ISNULL(CONVERT(varchar(255), d.ClienteID), 'NULL') AS ClienteID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('Reseñas', SUSER_SNAME(), 'DELETE', @json);
    END;
    

    CREATE TRIGGER audit_ProgramasDeFidelidad_insert
    ON ProgramasDeFidelidad
    AFTER INSERT
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ProgramaID), 'NULL') AS ProgramaID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.TipoRecompensa), 'NULL') AS TipoRecompensa, ISNULL(CONVERT(varchar(255), i.PuntosAcumulados), 'NULL') AS PuntosAcumulados, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ProgramasDeFidelidad', SUSER_SNAME(), 'INSERT', @json);
    END;

    CREATE TRIGGER audit_ProgramasDeFidelidad_update
    ON ProgramasDeFidelidad
    AFTER UPDATE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), i.ProgramaID), 'NULL') AS ProgramaID, ISNULL(CONVERT(varchar(255), i.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), i.TipoRecompensa), 'NULL') AS TipoRecompensa, ISNULL(CONVERT(varchar(255), i.PuntosAcumulados), 'NULL') AS PuntosAcumulados, ISNULL(CONVERT(varchar(255), i.ClienteID), 'NULL') AS ClienteID
            FROM INSERTED i
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ProgramasDeFidelidad', SUSER_SNAME(), 'UPDATE', @json);
    END;

    CREATE TRIGGER audit_ProgramasDeFidelidad_delete
    ON ProgramasDeFidelidad
    AFTER DELETE
    AS
    BEGIN
        DECLARE @json NVARCHAR(MAX);
        SET @json = (
            SELECT ISNULL(CONVERT(varchar(255), d.ProgramaID), 'NULL') AS ProgramaID, ISNULL(CONVERT(varchar(255), d.Nombre), 'NULL') AS Nombre, ISNULL(CONVERT(varchar(255), d.TipoRecompensa), 'NULL') AS TipoRecompensa, ISNULL(CONVERT(varchar(255), d.PuntosAcumulados), 'NULL') AS PuntosAcumulados, ISNULL(CONVERT(varchar(255), d.ClienteID), 'NULL') AS ClienteID
            FROM DELETED d
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        );
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ProgramasDeFidelidad', SUSER_SNAME(), 'DELETE', @json);
    END;
    
