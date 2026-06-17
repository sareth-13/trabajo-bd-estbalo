
-- ============================================================================
-- REPORTE: PRODUCCIÓN DE LECHE POR VACA (CORREGIDO Y SEGURO)
-- ============================================================================
USE establo;

SELECT 
    v.id_vaca,
    v.arete,
    (SELECT COUNT(*) FROM produccion_leche WHERE id_vaca = v.id_vaca) AS numero_registros,
    (SELECT SUM(litros) FROM produccion_leche WHERE id_vaca = v.id_vaca) AS total_litros
FROM vaca v
ORDER BY total_litros DESC 
LIMIT 0, 25;
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
-- REPORTE: INGRESOS POR VENTAS (OPTIMIZADO)
-- ============================================================================
SELECT 
    DATE_FORMAT(fcha, '%Y-%m') AS mes, 
    SUM(total_venta) AS ingresos_totales
FROM VENTA_LECHE
GROUP BY DATE_FORMAT(fcha, '%Y-%m') -- Agrupación explícita por la función de fecha
ORDER BY DATE_FORMAT(fcha, '%Y-%m') ASC; -- Ordenamiento cronológico estricto

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
GROUP BY e.id_empleado, e.nombre, e.apellido;
