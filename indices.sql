USE establo;

-- 1. Forzar a MySQL a ignorar las restricciones temporalmente
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Borrar los índices viejos usando la sintaxis independiente correcta
DROP INDEX IF EXISTS idx_prod_vaca ON produccion_leche;
DROP INDEX IF EXISTS idx_prod_lote ON produccion_leche;
DROP INDEX IF EXISTS idx_ventas_fecha ON VENTA_LECHE;
DROP INDEX IF EXISTS idx_compras_fecha ON COMPRA_INSUMO;
DROP INDEX IF EXISTS idx_asistencia_emp ON ASISTENCIA;

-- 3. Crear los índices nuevos limpiamente
ALTER TABLE produccion_leche ADD INDEX idx_prod_vaca (id_vaca);
ALTER TABLE produccion_leche ADD INDEX idx_prod_lote (id_lote_prdccion);
ALTER TABLE VENTA_LECHE ADD INDEX idx_ventas_fecha (fcha);
ALTER TABLE COMPRA_INSUMO ADD INDEX idx_compras_fecha (fcha);
ALTER TABLE ASISTENCIA ADD INDEX idx_asistencia_emp (id_empleado);

-- 4. Reactivar el control de llaves foráneas
SET FOREIGN_KEY_CHECKS = 1;
