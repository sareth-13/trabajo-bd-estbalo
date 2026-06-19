USE establo;

-- 1. Eliminar llaves foráneas temporalmente para liberar los índices
ALTER TABLE ASISTENCIA DROP FOREIGN KEY fk_asistencia_empleado;
ALTER TABLE produccion_leche DROP FOREIGN KEY fk_produccion_vaca;

-- 2. Ahora sí, borrar los índices viejos sin errores
ALTER TABLE produccion_leche DROP INDEX IF EXISTS idx_prod_vaca;
ALTER TABLE produccion_leche DROP INDEX IF EXISTS idx_prod_lote;
ALTER TABLE VENTA_LECHE DROP INDEX IF EXISTS idx_ventas_fecha;
ALTER TABLE COMPRA_INSUMO DROP INDEX IF EXISTS idx_compras_fecha;
ALTER TABLE ASISTENCIA DROP INDEX IF EXISTS idx_asistencia_emp;

-- 3. Crear los índices nuevos
ALTER TABLE produccion_leche ADD INDEX idx_prod_vaca (id_vaca);
ALTER TABLE produccion_leche ADD INDEX idx_prod_lote (id_lote_prdccion);
ALTER TABLE VENTA_LECHE ADD INDEX idx_ventas_fecha (fcha);
ALTER TABLE COMPRA_INSUMO ADD INDEX idx_compras_fecha (fcha);
ALTER TABLE ASISTENCIA ADD INDEX idx_asistencia_emp (id_empleado);

-- 4. Reconstruir las llaves foráneas
ALTER TABLE ASISTENCIA ADD CONSTRAINT fk_asistencia_empleado 
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado) 
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE produccion_leche ADD CONSTRAINT fk_produccion_vaca 
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca) 
    ON DELETE RESTRICT ON UPDATE CASCADE;
