USE establo;

-- ============================================================================
-- REPORTE: PRODUCCIÓN DE LECHE POR VACA (CORREGIDO)
-- ============================================================================

SELECT 
    v.id_vaca,
    v.arete,
    COUNT(p.id_vaca) AS numero_registros, -- Corregido para evitar el error #1054
    SUM(p.litros) AS total_litros,
    AVG(p.grasa_prcntaje) AS promedio_grasa,
    AVG(p.solidos_totales_prcntaje) AS promedio_solidos
FROM VACA v
LEFT JOIN PRODUCCION_LECHE p ON v.id_vaca = p.id_vaca
GROUP BY v.id_vaca, v.arete
ORDER BY total_litros DESC;

-- ============================================================================
-- REPORTE: PRODUCCIÓN POR LOTE
-- ============================================================================

SELECT 
    l.id_lote,
    l.nombre_lote,
    SUM(p.litros) AS total_producido
FROM LOTE_PRODUCCION l
LEFT JOIN PRODUCCION_LECHE p ON l.id_lote = p.id_lote_prdccion
GROUP BY l.id_lote, l.nombre_lote;

-- ============================================================================
-- REPORTE: INGRESOS POR VENTAS
-- ============================================================================

SELECT 
    DATE_FORMAT(fcha, '%Y-%m') AS mes,
    SUM(total_venta) AS ingresos_totales
FROM VENTA_LECHE
GROUP BY DATE_FORMAT(fcha, '%Y-%m')
ORDER BY mes;

-- ============================================================================
-- REPORTE: COMPRAS POR PROVEEDOR
-- ============================================================================

SELECT 
    pr.nombre AS proveedor,
    SUM(c.costo_total) AS total_compras
FROM PROVEEDOR pr
JOIN COMPRA_INSUMO c ON pr.id_proveedor = c.id_proveedor
GROUP BY pr.nombre
ORDER BY total_compras DESC;

-- ============================================================================
-- REPORTE: ASISTENCIA EMPLEADOS
-- ============================================================================

SELECT 
    e.nombre,
    e.apellido,
    SUM(a.presente) AS dias_asistidos
FROM EMPLEADO e
JOIN ASISTENCIA a ON e.id_empleado = a.id_empleado
GROUP BY e.id_empleado, e.nombre, e.apellido; -- Añadidos al GROUP BY por estándar SQL
