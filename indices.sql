USE establo;

-- PRODUCCIÓN
CREATE INDEX idx_prod_vaca ON PRODUCCION_LECHE(id_vaca);
CREATE INDEX idx_prod_fecha ON PRODUCCION_LECHE(fecha);
CREATE INDEX idx_prod_vaca_fecha ON PRODUCCION_LECHE(id_vaca, fecha);

-- EVENTOS
CREATE INDEX idx_evento_vaca ON EVENTO_SANITARIO(id_vaca);

-- COMPRAS
CREATE INDEX idx_compra_proveedor ON COMPRA_INSUMO(id_proveedor);

-- HISTORIAL
CREATE INDEX idx_historial_vaca ON HISTORIAL_CORRAL(id_vaca);

-- ÍNDICES DINÁMICOS (OPCIONAL)
CREATE INDEX idx_dinamico_litros ON PRODUCCION_LECHE(litros);
