USE establo;

-- ============================================================================
-- SOLUCIÓN DEFINITIVA DE CONSTRAINTS (Integridad Referencial Real)
-- ============================================================================

-- 1. Tabla ASISTENCIA: Si el empleado se borra, no permitas dejar la asistencia huérfana.
ALTER TABLE ASISTENCIA DROP FOREIGN KEY IF EXISTS fk_asistencia_empleado;
ALTER TABLE ASISTENCIA DROP FOREIGN KEY IF EXISTS asistencia_ibfk_1;
ALTER TABLE ASISTENCIA ADD CONSTRAINT fk_asistencia_empleado 
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado) 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- 2. Tabla VACA (Autorreferencial): Si la madre muere o se borra, el hijo se queda con madre NULL.
ALTER TABLE VACA DROP FOREIGN KEY IF EXISTS fk_vaca_madre;
ALTER TABLE VACA DROP FOREIGN KEY IF EXISTS vaca_ibfk_1;
ALTER TABLE VACA ADD CONSTRAINT fk_vaca_madre 
    FOREIGN KEY (id_madre) REFERENCES VACA(id_vaca) 
    ON DELETE SET NULL ON UPDATE CASCADE;

-- 3. Tabla PRODUCCION_LECHE: Bloquea el borrado de una vaca si ya tiene registros de producción.
ALTER TABLE produccion_leche DROP FOREIGN KEY IF EXISTS fk_produccion_vaca;
ALTER TABLE produccion_leche DROP FOREIGN KEY IF EXISTS produccion_leche_ibfk_1;
ALTER TABLE produccion_leche ADD CONSTRAINT fk_produccion_vaca 
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca) 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- 4. Tabla COMPRA_INSUMO: No permitas borrar un proveedor si hay facturas/compras asociadas.
ALTER TABLE COMPRA_INSUMO DROP FOREIGN KEY IF EXISTS fk_compra_proveedor;
ALTER TABLE COMPRA_INSUMO DROP FOREIGN KEY IF EXISTS compra_insumo_ibfk_1;
ALTER TABLE COMPRA_INSUMO ADD CONSTRAINT fk_compra_proveedor 
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor) 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- 5. Tabla VENTA_LECHE: No permitas borrar un cliente si tiene deudas o historial de ventas.
ALTER TABLE VENTA_LECHE DROP FOREIGN KEY IF EXISTS fk_venta_cliente;
ALTER TABLE VENTA_LECHE DROP FOREIGN KEY IF EXISTS venta_leche_ibfk_1;
ALTER TABLE VENTA_LECHE ADD CONSTRAINT fk_venta_cliente 
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente) 
    ON DELETE RESTRICT ON UPDATE CASCADE;

-- 6. Tabla HISTORIAL_CORRAL: Si la vaca se borra, su historial de movimientos se limpia automáticamente.
ALTER TABLE HISTORIAL_CORRAL DROP FOREIGN KEY IF EXISTS fk_historial_vaca;
ALTER TABLE HISTORIAL_CORRAL DROP FOREIGN KEY IF EXISTS historial_corral_ibfk_1;
ALTER TABLE HISTORIAL_CORRAL ADD CONSTRAINT fk_historial_vaca 
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca) 
    ON DELETE CASCADE ON UPDATE CASCADE;

-- 7. Tabla EVENTO_SANITARIO: Si la vaca se elimina, su historial médico se borra en cascada.
ALTER TABLE EVENTO_SANITARIO DROP FOREIGN KEY IF EXISTS fk_evento_vaca;
ALTER TABLE EVENTO_SANITARIO DROP FOREIGN KEY IF EXISTS evento_sanitario_ibfk_1;
ALTER TABLE EVENTO_SANITARIO ADD CONSTRAINT fk_evento_vaca 
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca) 
    ON DELETE CASCADE ON UPDATE CASCADE;
