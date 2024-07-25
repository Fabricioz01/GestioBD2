
    CREATE OR REPLACE TRIGGER audit_clientes_after_insert
    AFTER INSERT ON clientes
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('clientes', USER(), 'INSERT', JSON_OBJECT('new_clienteid', NEW.ClienteID, 'new_nombre', NEW.Nombre, 'new_telefono', NEW.Telefono, 'new_email', NEW.Email));
    END;
    


    CREATE OR REPLACE TRIGGER audit_clientes_after_update
    AFTER UPDATE ON clientes
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('clientes', USER(), 'UPDATE', JSON_OBJECT('old_clienteid', OLD.ClienteID, 'new_clienteid', NEW.ClienteID, 'old_nombre', OLD.Nombre, 'new_nombre', NEW.Nombre, 'old_telefono', OLD.Telefono, 'new_telefono', NEW.Telefono, 'old_email', OLD.Email, 'new_email', NEW.Email));
    END;
    


    CREATE OR REPLACE TRIGGER audit_clientes_after_delete
    AFTER DELETE ON clientes
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('clientes', USER(), 'DELETE', JSON_OBJECT('old_clienteid', OLD.ClienteID, 'old_nombre', OLD.Nombre, 'old_telefono', OLD.Telefono, 'old_email', OLD.Email));
    END;
    


    CREATE OR REPLACE TRIGGER audit_compras_after_insert
    AFTER INSERT ON compras
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('compras', USER(), 'INSERT', JSON_OBJECT('new_compraid', NEW.CompraID, 'new_fechacompra', NEW.FechaCompra, 'new_montototal', NEW.MontoTotal, 'new_proveedorid', NEW.ProveedorID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_compras_after_update
    AFTER UPDATE ON compras
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('compras', USER(), 'UPDATE', JSON_OBJECT('old_compraid', OLD.CompraID, 'new_compraid', NEW.CompraID, 'old_fechacompra', OLD.FechaCompra, 'new_fechacompra', NEW.FechaCompra, 'old_montototal', OLD.MontoTotal, 'new_montototal', NEW.MontoTotal, 'old_proveedorid', OLD.ProveedorID, 'new_proveedorid', NEW.ProveedorID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_compras_after_delete
    AFTER DELETE ON compras
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('compras', USER(), 'DELETE', JSON_OBJECT('old_compraid', OLD.CompraID, 'old_fechacompra', OLD.FechaCompra, 'old_montototal', OLD.MontoTotal, 'old_proveedorid', OLD.ProveedorID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_empleados_after_insert
    AFTER INSERT ON empleados
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('empleados', USER(), 'INSERT', JSON_OBJECT('new_empleadoid', NEW.EmpleadoID, 'new_nombre', NEW.Nombre, 'new_puesto', NEW.Puesto, 'new_telefono', NEW.Telefono, 'new_hotelid', NEW.HotelID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_empleados_after_update
    AFTER UPDATE ON empleados
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('empleados', USER(), 'UPDATE', JSON_OBJECT('old_empleadoid', OLD.EmpleadoID, 'new_empleadoid', NEW.EmpleadoID, 'old_nombre', OLD.Nombre, 'new_nombre', NEW.Nombre, 'old_puesto', OLD.Puesto, 'new_puesto', NEW.Puesto, 'old_telefono', OLD.Telefono, 'new_telefono', NEW.Telefono, 'old_hotelid', OLD.HotelID, 'new_hotelid', NEW.HotelID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_empleados_after_delete
    AFTER DELETE ON empleados
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('empleados', USER(), 'DELETE', JSON_OBJECT('old_empleadoid', OLD.EmpleadoID, 'old_nombre', OLD.Nombre, 'old_puesto', OLD.Puesto, 'old_telefono', OLD.Telefono, 'old_hotelid', OLD.HotelID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_eventos_after_insert
    AFTER INSERT ON eventos
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('eventos', USER(), 'INSERT', JSON_OBJECT('new_eventoid', NEW.EventoID, 'new_nombre', NEW.Nombre, 'new_fecha', NEW.Fecha, 'new_lugar', NEW.Lugar, 'new_organizador', NEW.Organizador, 'new_hotelid', NEW.HotelID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_eventos_after_update
    AFTER UPDATE ON eventos
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('eventos', USER(), 'UPDATE', JSON_OBJECT('old_eventoid', OLD.EventoID, 'new_eventoid', NEW.EventoID, 'old_nombre', OLD.Nombre, 'new_nombre', NEW.Nombre, 'old_fecha', OLD.Fecha, 'new_fecha', NEW.Fecha, 'old_lugar', OLD.Lugar, 'new_lugar', NEW.Lugar, 'old_organizador', OLD.Organizador, 'new_organizador', NEW.Organizador, 'old_hotelid', OLD.HotelID, 'new_hotelid', NEW.HotelID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_eventos_after_delete
    AFTER DELETE ON eventos
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('eventos', USER(), 'DELETE', JSON_OBJECT('old_eventoid', OLD.EventoID, 'old_nombre', OLD.Nombre, 'old_fecha', OLD.Fecha, 'old_lugar', OLD.Lugar, 'old_organizador', OLD.Organizador, 'old_hotelid', OLD.HotelID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_habitaciones_after_insert
    AFTER INSERT ON habitaciones
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('habitaciones', USER(), 'INSERT', JSON_OBJECT('new_habitacionid', NEW.HabitacionID, 'new_hotelid', NEW.HotelID, 'new_tipo', NEW.Tipo, 'new_precionoche', NEW.PrecioNoche, 'new_disponible', NEW.Disponible));
    END;
    


    CREATE OR REPLACE TRIGGER audit_habitaciones_after_update
    AFTER UPDATE ON habitaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('habitaciones', USER(), 'UPDATE', JSON_OBJECT('old_habitacionid', OLD.HabitacionID, 'new_habitacionid', NEW.HabitacionID, 'old_hotelid', OLD.HotelID, 'new_hotelid', NEW.HotelID, 'old_tipo', OLD.Tipo, 'new_tipo', NEW.Tipo, 'old_precionoche', OLD.PrecioNoche, 'new_precionoche', NEW.PrecioNoche, 'old_disponible', OLD.Disponible, 'new_disponible', NEW.Disponible));
    END;
    


    CREATE OR REPLACE TRIGGER audit_habitaciones_after_delete
    AFTER DELETE ON habitaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('habitaciones', USER(), 'DELETE', JSON_OBJECT('old_habitacionid', OLD.HabitacionID, 'old_hotelid', OLD.HotelID, 'old_tipo', OLD.Tipo, 'old_precionoche', OLD.PrecioNoche, 'old_disponible', OLD.Disponible));
    END;
    


    CREATE OR REPLACE TRIGGER audit_hoteles_after_insert
    AFTER INSERT ON hoteles
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('hoteles', USER(), 'INSERT', JSON_OBJECT('new_hotelid', NEW.HotelID, 'new_nombre', NEW.Nombre, 'new_ubicacion', NEW.Ubicacion, 'new_numerohabitaciones', NEW.NumeroHabitaciones));
    END;
    


    CREATE OR REPLACE TRIGGER audit_hoteles_after_update
    AFTER UPDATE ON hoteles
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('hoteles', USER(), 'UPDATE', JSON_OBJECT('old_hotelid', OLD.HotelID, 'new_hotelid', NEW.HotelID, 'old_nombre', OLD.Nombre, 'new_nombre', NEW.Nombre, 'old_ubicacion', OLD.Ubicacion, 'new_ubicacion', NEW.Ubicacion, 'old_numerohabitaciones', OLD.NumeroHabitaciones, 'new_numerohabitaciones', NEW.NumeroHabitaciones));
    END;
    


    CREATE OR REPLACE TRIGGER audit_hoteles_after_delete
    AFTER DELETE ON hoteles
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('hoteles', USER(), 'DELETE', JSON_OBJECT('old_hotelid', OLD.HotelID, 'old_nombre', OLD.Nombre, 'old_ubicacion', OLD.Ubicacion, 'old_numerohabitaciones', OLD.NumeroHabitaciones));
    END;
    


    CREATE OR REPLACE TRIGGER audit_inventario_after_insert
    AFTER INSERT ON inventario
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('inventario', USER(), 'INSERT', JSON_OBJECT('new_inventarioid', NEW.InventarioID, 'new_producto', NEW.Producto, 'new_cantidad', NEW.Cantidad, 'new_nivelminimo', NEW.NivelMinimo, 'new_compraid', NEW.CompraID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_inventario_after_update
    AFTER UPDATE ON inventario
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('inventario', USER(), 'UPDATE', JSON_OBJECT('old_inventarioid', OLD.InventarioID, 'new_inventarioid', NEW.InventarioID, 'old_producto', OLD.Producto, 'new_producto', NEW.Producto, 'old_cantidad', OLD.Cantidad, 'new_cantidad', NEW.Cantidad, 'old_nivelminimo', OLD.NivelMinimo, 'new_nivelminimo', NEW.NivelMinimo, 'old_compraid', OLD.CompraID, 'new_compraid', NEW.CompraID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_inventario_after_delete
    AFTER DELETE ON inventario
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('inventario', USER(), 'DELETE', JSON_OBJECT('old_inventarioid', OLD.InventarioID, 'old_producto', OLD.Producto, 'old_cantidad', OLD.Cantidad, 'old_nivelminimo', OLD.NivelMinimo, 'old_compraid', OLD.CompraID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_mantenimiento_after_insert
    AFTER INSERT ON mantenimiento
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('mantenimiento', USER(), 'INSERT', JSON_OBJECT('new_mantenimientoid', NEW.MantenimientoID, 'new_fecha', NEW.Fecha, 'new_tipo', NEW.Tipo, 'new_habitacionid', NEW.HabitacionID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_mantenimiento_after_update
    AFTER UPDATE ON mantenimiento
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('mantenimiento', USER(), 'UPDATE', JSON_OBJECT('old_mantenimientoid', OLD.MantenimientoID, 'new_mantenimientoid', NEW.MantenimientoID, 'old_fecha', OLD.Fecha, 'new_fecha', NEW.Fecha, 'old_tipo', OLD.Tipo, 'new_tipo', NEW.Tipo, 'old_habitacionid', OLD.HabitacionID, 'new_habitacionid', NEW.HabitacionID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_mantenimiento_after_delete
    AFTER DELETE ON mantenimiento
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('mantenimiento', USER(), 'DELETE', JSON_OBJECT('old_mantenimientoid', OLD.MantenimientoID, 'old_fecha', OLD.Fecha, 'old_tipo', OLD.Tipo, 'old_habitacionid', OLD.HabitacionID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_ofertas_after_insert
    AFTER INSERT ON ofertas
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('ofertas', USER(), 'INSERT', JSON_OBJECT('new_ofertaid', NEW.OfertaID, 'new_tipooferta', NEW.TipoOferta, 'new_porcentajedescuento', NEW.PorcentajeDescuento, 'new_condiciones', NEW.Condiciones));
    END;
    


    CREATE OR REPLACE TRIGGER audit_ofertas_after_update
    AFTER UPDATE ON ofertas
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('ofertas', USER(), 'UPDATE', JSON_OBJECT('old_ofertaid', OLD.OfertaID, 'new_ofertaid', NEW.OfertaID, 'old_tipooferta', OLD.TipoOferta, 'new_tipooferta', NEW.TipoOferta, 'old_porcentajedescuento', OLD.PorcentajeDescuento, 'new_porcentajedescuento', NEW.PorcentajeDescuento, 'old_condiciones', OLD.Condiciones, 'new_condiciones', NEW.Condiciones));
    END;
    


    CREATE OR REPLACE TRIGGER audit_ofertas_after_delete
    AFTER DELETE ON ofertas
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('ofertas', USER(), 'DELETE', JSON_OBJECT('old_ofertaid', OLD.OfertaID, 'old_tipooferta', OLD.TipoOferta, 'old_porcentajedescuento', OLD.PorcentajeDescuento, 'old_condiciones', OLD.Condiciones));
    END;
    


    CREATE OR REPLACE TRIGGER audit_pagos_after_insert
    AFTER INSERT ON pagos
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('pagos', USER(), 'INSERT', JSON_OBJECT('new_pagoid', NEW.PagoID, 'new_metodopago', NEW.MetodoPago, 'new_monto', NEW.Monto, 'new_fechapago', NEW.FechaPago, 'new_clienteid', NEW.ClienteID, 'new_reservacionid', NEW.ReservacionID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_pagos_after_update
    AFTER UPDATE ON pagos
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('pagos', USER(), 'UPDATE', JSON_OBJECT('old_pagoid', OLD.PagoID, 'new_pagoid', NEW.PagoID, 'old_metodopago', OLD.MetodoPago, 'new_metodopago', NEW.MetodoPago, 'old_monto', OLD.Monto, 'new_monto', NEW.Monto, 'old_fechapago', OLD.FechaPago, 'new_fechapago', NEW.FechaPago, 'old_clienteid', OLD.ClienteID, 'new_clienteid', NEW.ClienteID, 'old_reservacionid', OLD.ReservacionID, 'new_reservacionid', NEW.ReservacionID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_pagos_after_delete
    AFTER DELETE ON pagos
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('pagos', USER(), 'DELETE', JSON_OBJECT('old_pagoid', OLD.PagoID, 'old_metodopago', OLD.MetodoPago, 'old_monto', OLD.Monto, 'old_fechapago', OLD.FechaPago, 'old_clienteid', OLD.ClienteID, 'old_reservacionid', OLD.ReservacionID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_programasdefidelidad_after_insert
    AFTER INSERT ON programasdefidelidad
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('programasdefidelidad', USER(), 'INSERT', JSON_OBJECT('new_programaid', NEW.ProgramaID, 'new_nombre', NEW.Nombre, 'new_tiporecompensa', NEW.TipoRecompensa, 'new_puntosacumulados', NEW.PuntosAcumulados, 'new_clienteid', NEW.ClienteID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_programasdefidelidad_after_update
    AFTER UPDATE ON programasdefidelidad
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('programasdefidelidad', USER(), 'UPDATE', JSON_OBJECT('old_programaid', OLD.ProgramaID, 'new_programaid', NEW.ProgramaID, 'old_nombre', OLD.Nombre, 'new_nombre', NEW.Nombre, 'old_tiporecompensa', OLD.TipoRecompensa, 'new_tiporecompensa', NEW.TipoRecompensa, 'old_puntosacumulados', OLD.PuntosAcumulados, 'new_puntosacumulados', NEW.PuntosAcumulados, 'old_clienteid', OLD.ClienteID, 'new_clienteid', NEW.ClienteID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_programasdefidelidad_after_delete
    AFTER DELETE ON programasdefidelidad
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('programasdefidelidad', USER(), 'DELETE', JSON_OBJECT('old_programaid', OLD.ProgramaID, 'old_nombre', OLD.Nombre, 'old_tiporecompensa', OLD.TipoRecompensa, 'old_puntosacumulados', OLD.PuntosAcumulados, 'old_clienteid', OLD.ClienteID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_proveedores_after_insert
    AFTER INSERT ON proveedores
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('proveedores', USER(), 'INSERT', JSON_OBJECT('new_proveedorid', NEW.ProveedorID, 'new_nombre', NEW.Nombre, 'new_tipoproductos', NEW.TipoProductos, 'new_contacto', NEW.Contacto, 'new_hotelid', NEW.HotelID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_proveedores_after_update
    AFTER UPDATE ON proveedores
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('proveedores', USER(), 'UPDATE', JSON_OBJECT('old_proveedorid', OLD.ProveedorID, 'new_proveedorid', NEW.ProveedorID, 'old_nombre', OLD.Nombre, 'new_nombre', NEW.Nombre, 'old_tipoproductos', OLD.TipoProductos, 'new_tipoproductos', NEW.TipoProductos, 'old_contacto', OLD.Contacto, 'new_contacto', NEW.Contacto, 'old_hotelid', OLD.HotelID, 'new_hotelid', NEW.HotelID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_proveedores_after_delete
    AFTER DELETE ON proveedores
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('proveedores', USER(), 'DELETE', JSON_OBJECT('old_proveedorid', OLD.ProveedorID, 'old_nombre', OLD.Nombre, 'old_tipoproductos', OLD.TipoProductos, 'old_contacto', OLD.Contacto, 'old_hotelid', OLD.HotelID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservaciones_after_insert
    AFTER INSERT ON reservaciones
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservaciones', USER(), 'INSERT', JSON_OBJECT('new_reservacionid', NEW.ReservacionID, 'new_hotelid', NEW.HotelID, 'new_habitacionid', NEW.HabitacionID, 'new_clienteid', NEW.ClienteID, 'new_fechaentrada', NEW.FechaEntrada, 'new_fechasalida', NEW.FechaSalida, 'new_estado', NEW.Estado));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservaciones_after_update
    AFTER UPDATE ON reservaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservaciones', USER(), 'UPDATE', JSON_OBJECT('old_reservacionid', OLD.ReservacionID, 'new_reservacionid', NEW.ReservacionID, 'old_hotelid', OLD.HotelID, 'new_hotelid', NEW.HotelID, 'old_habitacionid', OLD.HabitacionID, 'new_habitacionid', NEW.HabitacionID, 'old_clienteid', OLD.ClienteID, 'new_clienteid', NEW.ClienteID, 'old_fechaentrada', OLD.FechaEntrada, 'new_fechaentrada', NEW.FechaEntrada, 'old_fechasalida', OLD.FechaSalida, 'new_fechasalida', NEW.FechaSalida, 'old_estado', OLD.Estado, 'new_estado', NEW.Estado));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservaciones_after_delete
    AFTER DELETE ON reservaciones
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservaciones', USER(), 'DELETE', JSON_OBJECT('old_reservacionid', OLD.ReservacionID, 'old_hotelid', OLD.HotelID, 'old_habitacionid', OLD.HabitacionID, 'old_clienteid', OLD.ClienteID, 'old_fechaentrada', OLD.FechaEntrada, 'old_fechasalida', OLD.FechaSalida, 'old_estado', OLD.Estado));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservasdeeventos_after_insert
    AFTER INSERT ON reservasdeeventos
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservasdeeventos', USER(), 'INSERT', JSON_OBJECT('new_reservaid', NEW.ReservaID, 'new_eventoid', NEW.EventoID, 'new_fechareserva', NEW.FechaReserva, 'new_tipoevento', NEW.TipoEvento, 'new_numeroasistentes', NEW.NumeroAsistentes));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservasdeeventos_after_update
    AFTER UPDATE ON reservasdeeventos
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservasdeeventos', USER(), 'UPDATE', JSON_OBJECT('old_reservaid', OLD.ReservaID, 'new_reservaid', NEW.ReservaID, 'old_eventoid', OLD.EventoID, 'new_eventoid', NEW.EventoID, 'old_fechareserva', OLD.FechaReserva, 'new_fechareserva', NEW.FechaReserva, 'old_tipoevento', OLD.TipoEvento, 'new_tipoevento', NEW.TipoEvento, 'old_numeroasistentes', OLD.NumeroAsistentes, 'new_numeroasistentes', NEW.NumeroAsistentes));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservasdeeventos_after_delete
    AFTER DELETE ON reservasdeeventos
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservasdeeventos', USER(), 'DELETE', JSON_OBJECT('old_reservaid', OLD.ReservaID, 'old_eventoid', OLD.EventoID, 'old_fechareserva', OLD.FechaReserva, 'old_tipoevento', OLD.TipoEvento, 'old_numeroasistentes', OLD.NumeroAsistentes));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservasdeservicios_after_insert
    AFTER INSERT ON reservasdeservicios
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservasdeservicios', USER(), 'INSERT', JSON_OBJECT('new_reservaid', NEW.ReservaID, 'new_servicioid', NEW.ServicioID, 'new_clienteid', NEW.ClienteID, 'new_fechareserva', NEW.FechaReserva, 'new_estado', NEW.Estado));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservasdeservicios_after_update
    AFTER UPDATE ON reservasdeservicios
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservasdeservicios', USER(), 'UPDATE', JSON_OBJECT('old_reservaid', OLD.ReservaID, 'new_reservaid', NEW.ReservaID, 'old_servicioid', OLD.ServicioID, 'new_servicioid', NEW.ServicioID, 'old_clienteid', OLD.ClienteID, 'new_clienteid', NEW.ClienteID, 'old_fechareserva', OLD.FechaReserva, 'new_fechareserva', NEW.FechaReserva, 'old_estado', OLD.Estado, 'new_estado', NEW.Estado));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservasdeservicios_after_delete
    AFTER DELETE ON reservasdeservicios
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservasdeservicios', USER(), 'DELETE', JSON_OBJECT('old_reservaid', OLD.ReservaID, 'old_servicioid', OLD.ServicioID, 'old_clienteid', OLD.ClienteID, 'old_fechareserva', OLD.FechaReserva, 'old_estado', OLD.Estado));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reseñas_after_insert
    AFTER INSERT ON reseñas
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reseñas', USER(), 'INSERT', JSON_OBJECT('new_reseñaid', NEW.ReseñaID, 'new_reservacionid', NEW.ReservacionID, 'new_puntuacion', NEW.Puntuacion, 'new_comentario', NEW.Comentario, 'new_clienteid', NEW.ClienteID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reseñas_after_update
    AFTER UPDATE ON reseñas
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reseñas', USER(), 'UPDATE', JSON_OBJECT('old_reseñaid', OLD.ReseñaID, 'new_reseñaid', NEW.ReseñaID, 'old_reservacionid', OLD.ReservacionID, 'new_reservacionid', NEW.ReservacionID, 'old_puntuacion', OLD.Puntuacion, 'new_puntuacion', NEW.Puntuacion, 'old_comentario', OLD.Comentario, 'new_comentario', NEW.Comentario, 'old_clienteid', OLD.ClienteID, 'new_clienteid', NEW.ClienteID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reseñas_after_delete
    AFTER DELETE ON reseñas
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reseñas', USER(), 'DELETE', JSON_OBJECT('old_reseñaid', OLD.ReseñaID, 'old_reservacionid', OLD.ReservacionID, 'old_puntuacion', OLD.Puntuacion, 'old_comentario', OLD.Comentario, 'old_clienteid', OLD.ClienteID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_serviciosadicionales_after_insert
    AFTER INSERT ON serviciosadicionales
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('serviciosadicionales', USER(), 'INSERT', JSON_OBJECT('new_servicioid', NEW.ServicioID, 'new_hotelid', NEW.HotelID, 'new_nombre', NEW.Nombre, 'new_descripcion', NEW.Descripcion, 'new_precio', NEW.Precio));
    END;
    


    CREATE OR REPLACE TRIGGER audit_serviciosadicionales_after_update
    AFTER UPDATE ON serviciosadicionales
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('serviciosadicionales', USER(), 'UPDATE', JSON_OBJECT('old_servicioid', OLD.ServicioID, 'new_servicioid', NEW.ServicioID, 'old_hotelid', OLD.HotelID, 'new_hotelid', NEW.HotelID, 'old_nombre', OLD.Nombre, 'new_nombre', NEW.Nombre, 'old_descripcion', OLD.Descripcion, 'new_descripcion', NEW.Descripcion, 'old_precio', OLD.Precio, 'new_precio', NEW.Precio));
    END;
    


    CREATE OR REPLACE TRIGGER audit_serviciosadicionales_after_delete
    AFTER DELETE ON serviciosadicionales
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('serviciosadicionales', USER(), 'DELETE', JSON_OBJECT('old_servicioid', OLD.ServicioID, 'old_hotelid', OLD.HotelID, 'old_nombre', OLD.Nombre, 'old_descripcion', OLD.Descripcion, 'old_precio', OLD.Precio));
    END;
    


    CREATE OR REPLACE TRIGGER audit_serviciosdelimpieza_after_insert
    AFTER INSERT ON serviciosdelimpieza
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('serviciosdelimpieza', USER(), 'INSERT', JSON_OBJECT('new_servicioid', NEW.ServicioID, 'new_fechalimpieza', NEW.FechaLimpieza, 'new_habitacionesatendidas', NEW.HabitacionesAtendidas, 'new_empleadoid', NEW.EmpleadoID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_serviciosdelimpieza_after_update
    AFTER UPDATE ON serviciosdelimpieza
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('serviciosdelimpieza', USER(), 'UPDATE', JSON_OBJECT('old_servicioid', OLD.ServicioID, 'new_servicioid', NEW.ServicioID, 'old_fechalimpieza', OLD.FechaLimpieza, 'new_fechalimpieza', NEW.FechaLimpieza, 'old_habitacionesatendidas', OLD.HabitacionesAtendidas, 'new_habitacionesatendidas', NEW.HabitacionesAtendidas, 'old_empleadoid', OLD.EmpleadoID, 'new_empleadoid', NEW.EmpleadoID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_serviciosdelimpieza_after_delete
    AFTER DELETE ON serviciosdelimpieza
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('serviciosdelimpieza', USER(), 'DELETE', JSON_OBJECT('old_servicioid', OLD.ServicioID, 'old_fechalimpieza', OLD.FechaLimpieza, 'old_habitacionesatendidas', OLD.HabitacionesAtendidas, 'old_empleadoid', OLD.EmpleadoID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_tarifasespeciales_after_insert
    AFTER INSERT ON tarifasespeciales
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('tarifasespeciales', USER(), 'INSERT', JSON_OBJECT('new_tarifaid', NEW.TarifaID, 'new_nombre', NEW.Nombre, 'new_descuentoaplicado', NEW.DescuentoAplicado, 'new_condiciones', NEW.Condiciones));
    END;
    


    CREATE OR REPLACE TRIGGER audit_tarifasespeciales_after_update
    AFTER UPDATE ON tarifasespeciales
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('tarifasespeciales', USER(), 'UPDATE', JSON_OBJECT('old_tarifaid', OLD.TarifaID, 'new_tarifaid', NEW.TarifaID, 'old_nombre', OLD.Nombre, 'new_nombre', NEW.Nombre, 'old_descuentoaplicado', OLD.DescuentoAplicado, 'new_descuentoaplicado', NEW.DescuentoAplicado, 'old_condiciones', OLD.Condiciones, 'new_condiciones', NEW.Condiciones));
    END;
    


    CREATE OR REPLACE TRIGGER audit_tarifasespeciales_after_delete
    AFTER DELETE ON tarifasespeciales
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('tarifasespeciales', USER(), 'DELETE', JSON_OBJECT('old_tarifaid', OLD.TarifaID, 'old_nombre', OLD.Nombre, 'old_descuentoaplicado', OLD.DescuentoAplicado, 'old_condiciones', OLD.Condiciones));
    END;
    


    CREATE OR REPLACE TRIGGER audit_turnosdetrabajo_after_insert
    AFTER INSERT ON turnosdetrabajo
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('turnosdetrabajo', USER(), 'INSERT', JSON_OBJECT('new_turnoid', NEW.TurnoID, 'new_fecha', NEW.Fecha, 'new_horainicio', NEW.HoraInicio, 'new_horafin', NEW.HoraFin, 'new_empleadoid', NEW.EmpleadoID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_turnosdetrabajo_after_update
    AFTER UPDATE ON turnosdetrabajo
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('turnosdetrabajo', USER(), 'UPDATE', JSON_OBJECT('old_turnoid', OLD.TurnoID, 'new_turnoid', NEW.TurnoID, 'old_fecha', OLD.Fecha, 'new_fecha', NEW.Fecha, 'old_horainicio', OLD.HoraInicio, 'new_horainicio', NEW.HoraInicio, 'old_horafin', OLD.HoraFin, 'new_horafin', NEW.HoraFin, 'old_empleadoid', OLD.EmpleadoID, 'new_empleadoid', NEW.EmpleadoID));
    END;
    


    CREATE OR REPLACE TRIGGER audit_turnosdetrabajo_after_delete
    AFTER DELETE ON turnosdetrabajo
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('turnosdetrabajo', USER(), 'DELETE', JSON_OBJECT('old_turnoid', OLD.TurnoID, 'old_fecha', OLD.Fecha, 'old_horainicio', OLD.HoraInicio, 'old_horafin', OLD.HoraFin, 'old_empleadoid', OLD.EmpleadoID));
    END;
    

