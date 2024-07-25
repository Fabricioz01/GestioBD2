
    CREATE TRIGGER audit_clientes_insert
    AFTER INSERT ON clientes
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('clientes', USER(), 'INSERT', JSON_OBJECT("ClienteID", NEW.ClienteID, "Nombre", NEW.Nombre, "Telefono", NEW.Telefono, "Email", NEW.Email));
    END;

    CREATE TRIGGER audit_clientes_update
    AFTER UPDATE ON clientes
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('clientes', USER(), 'UPDATE', JSON_OBJECT("ClienteID", NEW.ClienteID, "Nombre", NEW.Nombre, "Telefono", NEW.Telefono, "Email", NEW.Email));
    END;

    CREATE TRIGGER audit_clientes_delete
    AFTER DELETE ON clientes
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('clientes', USER(), 'DELETE', JSON_OBJECT("ClienteID", OLD.ClienteID, "Nombre", OLD.Nombre, "Telefono", OLD.Telefono, "Email", OLD.Email));
    END;
    

    CREATE TRIGGER audit_compras_insert
    AFTER INSERT ON compras
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('compras', USER(), 'INSERT', JSON_OBJECT("CompraID", NEW.CompraID, "FechaCompra", NEW.FechaCompra, "MontoTotal", NEW.MontoTotal, "ProveedorID", NEW.ProveedorID));
    END;

    CREATE TRIGGER audit_compras_update
    AFTER UPDATE ON compras
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('compras', USER(), 'UPDATE', JSON_OBJECT("CompraID", NEW.CompraID, "FechaCompra", NEW.FechaCompra, "MontoTotal", NEW.MontoTotal, "ProveedorID", NEW.ProveedorID));
    END;

    CREATE TRIGGER audit_compras_delete
    AFTER DELETE ON compras
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('compras', USER(), 'DELETE', JSON_OBJECT("CompraID", OLD.CompraID, "FechaCompra", OLD.FechaCompra, "MontoTotal", OLD.MontoTotal, "ProveedorID", OLD.ProveedorID));
    END;
    

    CREATE TRIGGER audit_empleados_insert
    AFTER INSERT ON empleados
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('empleados', USER(), 'INSERT', JSON_OBJECT("EmpleadoID", NEW.EmpleadoID, "Nombre", NEW.Nombre, "Puesto", NEW.Puesto, "Telefono", NEW.Telefono, "HotelID", NEW.HotelID));
    END;

    CREATE TRIGGER audit_empleados_update
    AFTER UPDATE ON empleados
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('empleados', USER(), 'UPDATE', JSON_OBJECT("EmpleadoID", NEW.EmpleadoID, "Nombre", NEW.Nombre, "Puesto", NEW.Puesto, "Telefono", NEW.Telefono, "HotelID", NEW.HotelID));
    END;

    CREATE TRIGGER audit_empleados_delete
    AFTER DELETE ON empleados
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('empleados', USER(), 'DELETE', JSON_OBJECT("EmpleadoID", OLD.EmpleadoID, "Nombre", OLD.Nombre, "Puesto", OLD.Puesto, "Telefono", OLD.Telefono, "HotelID", OLD.HotelID));
    END;
    

    CREATE TRIGGER audit_eventos_insert
    AFTER INSERT ON eventos
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('eventos', USER(), 'INSERT', JSON_OBJECT("EventoID", NEW.EventoID, "Nombre", NEW.Nombre, "Fecha", NEW.Fecha, "Lugar", NEW.Lugar, "Organizador", NEW.Organizador, "HotelID", NEW.HotelID));
    END;

    CREATE TRIGGER audit_eventos_update
    AFTER UPDATE ON eventos
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('eventos', USER(), 'UPDATE', JSON_OBJECT("EventoID", NEW.EventoID, "Nombre", NEW.Nombre, "Fecha", NEW.Fecha, "Lugar", NEW.Lugar, "Organizador", NEW.Organizador, "HotelID", NEW.HotelID));
    END;

    CREATE TRIGGER audit_eventos_delete
    AFTER DELETE ON eventos
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('eventos', USER(), 'DELETE', JSON_OBJECT("EventoID", OLD.EventoID, "Nombre", OLD.Nombre, "Fecha", OLD.Fecha, "Lugar", OLD.Lugar, "Organizador", OLD.Organizador, "HotelID", OLD.HotelID));
    END;
    

    CREATE TRIGGER audit_habitaciones_insert
    AFTER INSERT ON habitaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('habitaciones', USER(), 'INSERT', JSON_OBJECT("HabitacionID", NEW.HabitacionID, "HotelID", NEW.HotelID, "Tipo", NEW.Tipo, "PrecioNoche", NEW.PrecioNoche, "Disponible", NEW.Disponible));
    END;

    CREATE TRIGGER audit_habitaciones_update
    AFTER UPDATE ON habitaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('habitaciones', USER(), 'UPDATE', JSON_OBJECT("HabitacionID", NEW.HabitacionID, "HotelID", NEW.HotelID, "Tipo", NEW.Tipo, "PrecioNoche", NEW.PrecioNoche, "Disponible", NEW.Disponible));
    END;

    CREATE TRIGGER audit_habitaciones_delete
    AFTER DELETE ON habitaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('habitaciones', USER(), 'DELETE', JSON_OBJECT("HabitacionID", OLD.HabitacionID, "HotelID", OLD.HotelID, "Tipo", OLD.Tipo, "PrecioNoche", OLD.PrecioNoche, "Disponible", OLD.Disponible));
    END;
    

    CREATE TRIGGER audit_hoteles_insert
    AFTER INSERT ON hoteles
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('hoteles', USER(), 'INSERT', JSON_OBJECT("HotelID", NEW.HotelID, "Nombre", NEW.Nombre, "Ubicacion", NEW.Ubicacion, "NumeroHabitaciones", NEW.NumeroHabitaciones));
    END;

    CREATE TRIGGER audit_hoteles_update
    AFTER UPDATE ON hoteles
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('hoteles', USER(), 'UPDATE', JSON_OBJECT("HotelID", NEW.HotelID, "Nombre", NEW.Nombre, "Ubicacion", NEW.Ubicacion, "NumeroHabitaciones", NEW.NumeroHabitaciones));
    END;

    CREATE TRIGGER audit_hoteles_delete
    AFTER DELETE ON hoteles
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('hoteles', USER(), 'DELETE', JSON_OBJECT("HotelID", OLD.HotelID, "Nombre", OLD.Nombre, "Ubicacion", OLD.Ubicacion, "NumeroHabitaciones", OLD.NumeroHabitaciones));
    END;
    

    CREATE TRIGGER audit_inventario_insert
    AFTER INSERT ON inventario
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('inventario', USER(), 'INSERT', JSON_OBJECT("InventarioID", NEW.InventarioID, "Producto", NEW.Producto, "Cantidad", NEW.Cantidad, "NivelMinimo", NEW.NivelMinimo, "CompraID", NEW.CompraID));
    END;

    CREATE TRIGGER audit_inventario_update
    AFTER UPDATE ON inventario
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('inventario', USER(), 'UPDATE', JSON_OBJECT("InventarioID", NEW.InventarioID, "Producto", NEW.Producto, "Cantidad", NEW.Cantidad, "NivelMinimo", NEW.NivelMinimo, "CompraID", NEW.CompraID));
    END;

    CREATE TRIGGER audit_inventario_delete
    AFTER DELETE ON inventario
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('inventario', USER(), 'DELETE', JSON_OBJECT("InventarioID", OLD.InventarioID, "Producto", OLD.Producto, "Cantidad", OLD.Cantidad, "NivelMinimo", OLD.NivelMinimo, "CompraID", OLD.CompraID));
    END;
    

    CREATE TRIGGER audit_mantenimiento_insert
    AFTER INSERT ON mantenimiento
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('mantenimiento', USER(), 'INSERT', JSON_OBJECT("MantenimientoID", NEW.MantenimientoID, "Fecha", NEW.Fecha, "Tipo", NEW.Tipo, "HabitacionID", NEW.HabitacionID));
    END;

    CREATE TRIGGER audit_mantenimiento_update
    AFTER UPDATE ON mantenimiento
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('mantenimiento', USER(), 'UPDATE', JSON_OBJECT("MantenimientoID", NEW.MantenimientoID, "Fecha", NEW.Fecha, "Tipo", NEW.Tipo, "HabitacionID", NEW.HabitacionID));
    END;

    CREATE TRIGGER audit_mantenimiento_delete
    AFTER DELETE ON mantenimiento
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('mantenimiento', USER(), 'DELETE', JSON_OBJECT("MantenimientoID", OLD.MantenimientoID, "Fecha", OLD.Fecha, "Tipo", OLD.Tipo, "HabitacionID", OLD.HabitacionID));
    END;
    

    CREATE TRIGGER audit_ofertas_insert
    AFTER INSERT ON ofertas
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ofertas', USER(), 'INSERT', JSON_OBJECT("OfertaID", NEW.OfertaID, "TipoOferta", NEW.TipoOferta, "PorcentajeDescuento", NEW.PorcentajeDescuento, "Condiciones", NEW.Condiciones));
    END;

    CREATE TRIGGER audit_ofertas_update
    AFTER UPDATE ON ofertas
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ofertas', USER(), 'UPDATE', JSON_OBJECT("OfertaID", NEW.OfertaID, "TipoOferta", NEW.TipoOferta, "PorcentajeDescuento", NEW.PorcentajeDescuento, "Condiciones", NEW.Condiciones));
    END;

    CREATE TRIGGER audit_ofertas_delete
    AFTER DELETE ON ofertas
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('ofertas', USER(), 'DELETE', JSON_OBJECT("OfertaID", OLD.OfertaID, "TipoOferta", OLD.TipoOferta, "PorcentajeDescuento", OLD.PorcentajeDescuento, "Condiciones", OLD.Condiciones));
    END;
    

    CREATE TRIGGER audit_pagos_insert
    AFTER INSERT ON pagos
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('pagos', USER(), 'INSERT', JSON_OBJECT("PagoID", NEW.PagoID, "MetodoPago", NEW.MetodoPago, "Monto", NEW.Monto, "FechaPago", NEW.FechaPago, "ClienteID", NEW.ClienteID, "ReservacionID", NEW.ReservacionID));
    END;

    CREATE TRIGGER audit_pagos_update
    AFTER UPDATE ON pagos
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('pagos', USER(), 'UPDATE', JSON_OBJECT("PagoID", NEW.PagoID, "MetodoPago", NEW.MetodoPago, "Monto", NEW.Monto, "FechaPago", NEW.FechaPago, "ClienteID", NEW.ClienteID, "ReservacionID", NEW.ReservacionID));
    END;

    CREATE TRIGGER audit_pagos_delete
    AFTER DELETE ON pagos
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('pagos', USER(), 'DELETE', JSON_OBJECT("PagoID", OLD.PagoID, "MetodoPago", OLD.MetodoPago, "Monto", OLD.Monto, "FechaPago", OLD.FechaPago, "ClienteID", OLD.ClienteID, "ReservacionID", OLD.ReservacionID));
    END;
    

    CREATE TRIGGER audit_programasdefidelidad_insert
    AFTER INSERT ON programasdefidelidad
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('programasdefidelidad', USER(), 'INSERT', JSON_OBJECT("ProgramaID", NEW.ProgramaID, "Nombre", NEW.Nombre, "TipoRecompensa", NEW.TipoRecompensa, "PuntosAcumulados", NEW.PuntosAcumulados, "ClienteID", NEW.ClienteID));
    END;

    CREATE TRIGGER audit_programasdefidelidad_update
    AFTER UPDATE ON programasdefidelidad
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('programasdefidelidad', USER(), 'UPDATE', JSON_OBJECT("ProgramaID", NEW.ProgramaID, "Nombre", NEW.Nombre, "TipoRecompensa", NEW.TipoRecompensa, "PuntosAcumulados", NEW.PuntosAcumulados, "ClienteID", NEW.ClienteID));
    END;

    CREATE TRIGGER audit_programasdefidelidad_delete
    AFTER DELETE ON programasdefidelidad
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('programasdefidelidad', USER(), 'DELETE', JSON_OBJECT("ProgramaID", OLD.ProgramaID, "Nombre", OLD.Nombre, "TipoRecompensa", OLD.TipoRecompensa, "PuntosAcumulados", OLD.PuntosAcumulados, "ClienteID", OLD.ClienteID));
    END;
    

    CREATE TRIGGER audit_proveedores_insert
    AFTER INSERT ON proveedores
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('proveedores', USER(), 'INSERT', JSON_OBJECT("ProveedorID", NEW.ProveedorID, "Nombre", NEW.Nombre, "TipoProductos", NEW.TipoProductos, "Contacto", NEW.Contacto, "HotelID", NEW.HotelID));
    END;

    CREATE TRIGGER audit_proveedores_update
    AFTER UPDATE ON proveedores
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('proveedores', USER(), 'UPDATE', JSON_OBJECT("ProveedorID", NEW.ProveedorID, "Nombre", NEW.Nombre, "TipoProductos", NEW.TipoProductos, "Contacto", NEW.Contacto, "HotelID", NEW.HotelID));
    END;

    CREATE TRIGGER audit_proveedores_delete
    AFTER DELETE ON proveedores
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('proveedores', USER(), 'DELETE', JSON_OBJECT("ProveedorID", OLD.ProveedorID, "Nombre", OLD.Nombre, "TipoProductos", OLD.TipoProductos, "Contacto", OLD.Contacto, "HotelID", OLD.HotelID));
    END;
    

    CREATE TRIGGER audit_reservaciones_insert
    AFTER INSERT ON reservaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reservaciones', USER(), 'INSERT', JSON_OBJECT("ReservacionID", NEW.ReservacionID, "HotelID", NEW.HotelID, "HabitacionID", NEW.HabitacionID, "ClienteID", NEW.ClienteID, "FechaEntrada", NEW.FechaEntrada, "FechaSalida", NEW.FechaSalida, "Estado", NEW.Estado));
    END;

    CREATE TRIGGER audit_reservaciones_update
    AFTER UPDATE ON reservaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reservaciones', USER(), 'UPDATE', JSON_OBJECT("ReservacionID", NEW.ReservacionID, "HotelID", NEW.HotelID, "HabitacionID", NEW.HabitacionID, "ClienteID", NEW.ClienteID, "FechaEntrada", NEW.FechaEntrada, "FechaSalida", NEW.FechaSalida, "Estado", NEW.Estado));
    END;

    CREATE TRIGGER audit_reservaciones_delete
    AFTER DELETE ON reservaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reservaciones', USER(), 'DELETE', JSON_OBJECT("ReservacionID", OLD.ReservacionID, "HotelID", OLD.HotelID, "HabitacionID", OLD.HabitacionID, "ClienteID", OLD.ClienteID, "FechaEntrada", OLD.FechaEntrada, "FechaSalida", OLD.FechaSalida, "Estado", OLD.Estado));
    END;
    

    CREATE TRIGGER audit_reservasdeeventos_insert
    AFTER INSERT ON reservasdeeventos
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reservasdeeventos', USER(), 'INSERT', JSON_OBJECT("ReservaID", NEW.ReservaID, "EventoID", NEW.EventoID, "FechaReserva", NEW.FechaReserva, "TipoEvento", NEW.TipoEvento, "NumeroAsistentes", NEW.NumeroAsistentes));
    END;

    CREATE TRIGGER audit_reservasdeeventos_update
    AFTER UPDATE ON reservasdeeventos
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reservasdeeventos', USER(), 'UPDATE', JSON_OBJECT("ReservaID", NEW.ReservaID, "EventoID", NEW.EventoID, "FechaReserva", NEW.FechaReserva, "TipoEvento", NEW.TipoEvento, "NumeroAsistentes", NEW.NumeroAsistentes));
    END;

    CREATE TRIGGER audit_reservasdeeventos_delete
    AFTER DELETE ON reservasdeeventos
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reservasdeeventos', USER(), 'DELETE', JSON_OBJECT("ReservaID", OLD.ReservaID, "EventoID", OLD.EventoID, "FechaReserva", OLD.FechaReserva, "TipoEvento", OLD.TipoEvento, "NumeroAsistentes", OLD.NumeroAsistentes));
    END;
    

    CREATE TRIGGER audit_reservasdeservicios_insert
    AFTER INSERT ON reservasdeservicios
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reservasdeservicios', USER(), 'INSERT', JSON_OBJECT("ReservaID", NEW.ReservaID, "ServicioID", NEW.ServicioID, "ClienteID", NEW.ClienteID, "FechaReserva", NEW.FechaReserva, "Estado", NEW.Estado));
    END;

    CREATE TRIGGER audit_reservasdeservicios_update
    AFTER UPDATE ON reservasdeservicios
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reservasdeservicios', USER(), 'UPDATE', JSON_OBJECT("ReservaID", NEW.ReservaID, "ServicioID", NEW.ServicioID, "ClienteID", NEW.ClienteID, "FechaReserva", NEW.FechaReserva, "Estado", NEW.Estado));
    END;

    CREATE TRIGGER audit_reservasdeservicios_delete
    AFTER DELETE ON reservasdeservicios
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reservasdeservicios', USER(), 'DELETE', JSON_OBJECT("ReservaID", OLD.ReservaID, "ServicioID", OLD.ServicioID, "ClienteID", OLD.ClienteID, "FechaReserva", OLD.FechaReserva, "Estado", OLD.Estado));
    END;
    

    CREATE TRIGGER audit_reseñas_insert
    AFTER INSERT ON reseñas
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reseñas', USER(), 'INSERT', JSON_OBJECT("ReseñaID", NEW.ReseñaID, "ReservacionID", NEW.ReservacionID, "Puntuacion", NEW.Puntuacion, "Comentario", NEW.Comentario, "ClienteID", NEW.ClienteID));
    END;

    CREATE TRIGGER audit_reseñas_update
    AFTER UPDATE ON reseñas
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reseñas', USER(), 'UPDATE', JSON_OBJECT("ReseñaID", NEW.ReseñaID, "ReservacionID", NEW.ReservacionID, "Puntuacion", NEW.Puntuacion, "Comentario", NEW.Comentario, "ClienteID", NEW.ClienteID));
    END;

    CREATE TRIGGER audit_reseñas_delete
    AFTER DELETE ON reseñas
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('reseñas', USER(), 'DELETE', JSON_OBJECT("ReseñaID", OLD.ReseñaID, "ReservacionID", OLD.ReservacionID, "Puntuacion", OLD.Puntuacion, "Comentario", OLD.Comentario, "ClienteID", OLD.ClienteID));
    END;
    

    CREATE TRIGGER audit_serviciosadicionales_insert
    AFTER INSERT ON serviciosadicionales
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('serviciosadicionales', USER(), 'INSERT', JSON_OBJECT("ServicioID", NEW.ServicioID, "HotelID", NEW.HotelID, "Nombre", NEW.Nombre, "Descripcion", NEW.Descripcion, "Precio", NEW.Precio));
    END;

    CREATE TRIGGER audit_serviciosadicionales_update
    AFTER UPDATE ON serviciosadicionales
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('serviciosadicionales', USER(), 'UPDATE', JSON_OBJECT("ServicioID", NEW.ServicioID, "HotelID", NEW.HotelID, "Nombre", NEW.Nombre, "Descripcion", NEW.Descripcion, "Precio", NEW.Precio));
    END;

    CREATE TRIGGER audit_serviciosadicionales_delete
    AFTER DELETE ON serviciosadicionales
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('serviciosadicionales', USER(), 'DELETE', JSON_OBJECT("ServicioID", OLD.ServicioID, "HotelID", OLD.HotelID, "Nombre", OLD.Nombre, "Descripcion", OLD.Descripcion, "Precio", OLD.Precio));
    END;
    

    CREATE TRIGGER audit_serviciosdelimpieza_insert
    AFTER INSERT ON serviciosdelimpieza
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('serviciosdelimpieza', USER(), 'INSERT', JSON_OBJECT("ServicioID", NEW.ServicioID, "FechaLimpieza", NEW.FechaLimpieza, "HabitacionesAtendidas", NEW.HabitacionesAtendidas, "EmpleadoID", NEW.EmpleadoID));
    END;

    CREATE TRIGGER audit_serviciosdelimpieza_update
    AFTER UPDATE ON serviciosdelimpieza
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('serviciosdelimpieza', USER(), 'UPDATE', JSON_OBJECT("ServicioID", NEW.ServicioID, "FechaLimpieza", NEW.FechaLimpieza, "HabitacionesAtendidas", NEW.HabitacionesAtendidas, "EmpleadoID", NEW.EmpleadoID));
    END;

    CREATE TRIGGER audit_serviciosdelimpieza_delete
    AFTER DELETE ON serviciosdelimpieza
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('serviciosdelimpieza', USER(), 'DELETE', JSON_OBJECT("ServicioID", OLD.ServicioID, "FechaLimpieza", OLD.FechaLimpieza, "HabitacionesAtendidas", OLD.HabitacionesAtendidas, "EmpleadoID", OLD.EmpleadoID));
    END;
    

    CREATE TRIGGER audit_tarifasespeciales_insert
    AFTER INSERT ON tarifasespeciales
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('tarifasespeciales', USER(), 'INSERT', JSON_OBJECT("TarifaID", NEW.TarifaID, "Nombre", NEW.Nombre, "DescuentoAplicado", NEW.DescuentoAplicado, "Condiciones", NEW.Condiciones));
    END;

    CREATE TRIGGER audit_tarifasespeciales_update
    AFTER UPDATE ON tarifasespeciales
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('tarifasespeciales', USER(), 'UPDATE', JSON_OBJECT("TarifaID", NEW.TarifaID, "Nombre", NEW.Nombre, "DescuentoAplicado", NEW.DescuentoAplicado, "Condiciones", NEW.Condiciones));
    END;

    CREATE TRIGGER audit_tarifasespeciales_delete
    AFTER DELETE ON tarifasespeciales
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('tarifasespeciales', USER(), 'DELETE', JSON_OBJECT("TarifaID", OLD.TarifaID, "Nombre", OLD.Nombre, "DescuentoAplicado", OLD.DescuentoAplicado, "Condiciones", OLD.Condiciones));
    END;
    

    CREATE TRIGGER audit_turnosdetrabajo_insert
    AFTER INSERT ON turnosdetrabajo
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('turnosdetrabajo', USER(), 'INSERT', JSON_OBJECT("TurnoID", NEW.TurnoID, "Fecha", NEW.Fecha, "HoraInicio", NEW.HoraInicio, "HoraFin", NEW.HoraFin, "EmpleadoID", NEW.EmpleadoID));
    END;

    CREATE TRIGGER audit_turnosdetrabajo_update
    AFTER UPDATE ON turnosdetrabajo
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('turnosdetrabajo', USER(), 'UPDATE', JSON_OBJECT("TurnoID", NEW.TurnoID, "Fecha", NEW.Fecha, "HoraInicio", NEW.HoraInicio, "HoraFin", NEW.HoraFin, "EmpleadoID", NEW.EmpleadoID));
    END;

    CREATE TRIGGER audit_turnosdetrabajo_delete
    AFTER DELETE ON turnosdetrabajo
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
        VALUES ('turnosdetrabajo', USER(), 'DELETE', JSON_OBJECT("TurnoID", OLD.TurnoID, "Fecha", OLD.Fecha, "HoraInicio", OLD.HoraInicio, "HoraFin", OLD.HoraFin, "EmpleadoID", OLD.EmpleadoID));
    END;
    
