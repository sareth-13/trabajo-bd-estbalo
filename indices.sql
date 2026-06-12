USE establo;
EXPLAIN SELECT * FROM PRODUCCION_LECHE WHERE id_vaca = 1;
EXPLAIN SELECT * FROM PRODUCCION_LECHE WHERE fcha BETWEEN '2024-01-01' AND '2024-12-31';
EXPLAIN SELECT * FROM EVENTO_SANITARIO WHERE id_vaca = 1;
EXPLAIN SELECT * FROM COMPRA_INSUMO WHERE id_proveedor = 1;
EXPLAIN SELECT * FROM HISTORIAL_CORRAL WHERE id_vaca = 1 AND fcha_slida IS NULL;

-- 1. Consultas de producción filtradas por vaca (JOIN frecuente)
CREATE INDEX idx_produccion_vaca
    ON PRODUCCION_LECHE (id_vaca);

-- 2. Reportes por rango de fechas de producción
CREATE INDEX idx_produccion_fecha
    ON PRODUCCION_LECHE (fcha);

-- 3. Índice compuesto: reporte mensual por vaca (GROUP BY vaca + mes)
CREATE INDEX idx_produccion_vaca_fecha
    ON PRODUCCION_LECHE (id_vaca, fcha);

-- 4. Eventos sanitarios consultados por vaca
CREATE INDEX idx_evento_vaca
    ON EVENTO_SANITARIO (id_vaca);

-- 5. Compras agrupadas por proveedor (reporte de gasto)
CREATE INDEX idx_compra_proveedor
    ON COMPRA_INSUMO (id_proveedor);

-- 6. Traslados activos: buscar el corral actual de una vaca
CREATE INDEX idx_historial_vaca_salida
    ON HISTORIAL_CORRAL (id_vaca, fcha_slida);
