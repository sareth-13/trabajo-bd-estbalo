USE establo;

ALTER TABLE produccion_leche DROP INDEX idx_prod_vaca;
ALTER TABLE produccion_leche DROP INDEX idx_prod_lote;
ALTER TABLE VENTA_LECHE DROP INDEX idx_ventas_fecha;
ALTER TABLE COMPRA_INSUMO DROP INDEX idx_compras_fecha;
ALTER TABLE ASISTENCIA DROP INDEX idx_asistencia_emp;

ALTER TABLE produccion_leche ADD INDEX idx_prod_vaca (id_vaca);
ALTER TABLE produccion_leche ADD INDEX idx_prod_lote (id_lote_prdccion);
ALTER TABLE VENTA_LECHE ADD INDEX idx_ventas_fecha (fcha);
ALTER TABLE COMPRA_INSUMO ADD INDEX idx_compras_fecha (fcha);
ALTER TABLE ASISTENCIA ADD INDEX idx_asistencia_emp (id_empleado);
