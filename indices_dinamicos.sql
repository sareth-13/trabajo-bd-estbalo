USE establo;

-- =========================
-- ÍNDICE DINÁMICO: PRODUCCIÓN POR VACA
-- (se usa cuando hay consultas por vaca)
-- =========================
CREATE INDEX idx_dyn_produccion_vaca
ON PRODUCCION_LECHE(id_vaca);

-- =========================
-- ÍNDICE DINÁMICO: FILTRO POR FECHA
-- (reportes mensuales)
-- =========================
CREATE INDEX idx_dyn_produccion_fecha
ON PRODUCCION_LECHE(fcha);

-- =========================
-- ÍNDICE DINÁMICO: VENTAS
-- =========================
CREATE INDEX idx_dyn_venta_lote
ON VENTA_LECHE(id_lote_prdccion);

-- =========================
-- CUANDO YA NO SE USAN (EJEMPLO)
-- =========================
-- DROP INDEX idx_dyn_produccion_fecha ON PRODUCCION_LECHE;
