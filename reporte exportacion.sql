USE establo;
 
SELECT
    v.id_vaca,
    v.arete                                          AS codigo_vaca,
    DATE_FORMAT(p.fcha, '%Y-%m')                     AS mes,
    COUNT(p.id_prdccion)                             AS registros_ordeño,
    ROUND(SUM(p.litros), 2)                          AS total_litros,
    ROUND(AVG(p.litros), 2)                          AS promedio_litros_por_ordeño,
    ROUND(AVG(p.grasa_prcntaje), 2)                  AS promedio_grasa_pct
FROM PRODUCCION_LECHE p
JOIN VACA v ON v.id_vaca = p.id_vaca
GROUP BY v.id_vaca, v.arete, DATE_FORMAT(p.fcha, '%Y-%m')
HAVING SUM(p.litros) > 20
ORDER BY mes DESC, total_litros DESC;
 
 
SELECT
    l.id_lote,
    l.nombre_lote,
    l.fecha_inicio,
    l.fecha_fin,
    COUNT(vl.id_venta)                               AS numero_ventas,
    ROUND(SUM(vl.litros_vendidos), 2)                AS total_litros_vendidos,
    ROUND(AVG(vl.precio_por_litro), 2)               AS precio_promedio_litro,
    ROUND(SUM(vl.total_venta), 2)                    AS ingreso_total
FROM VENTA_LECHE vl
JOIN LOTE_PRODUCCION l ON l.id_lote = vl.id_lote_prdccion
GROUP BY l.id_lote, l.nombre_lote, l.fecha_inicio, l.fecha_fin
HAVING SUM(vl.total_venta) > 800
ORDER BY ingreso_total DESC;

SELECT
    p.id_proveedor,
    p.nombre                                         AS proveedor,
    p.ruc,
    COUNT(ci.id_compra)                              AS numero_compras,
    ROUND(SUM(ci.costo_total), 2)                    AS gasto_total,
    ROUND(AVG(ci.costo_total), 2)                    AS gasto_promedio_por_compra,
    MIN(ci.fecha_compra)                             AS primera_compra,
    MAX(ci.fecha_compra)                             AS ultima_compra
FROM COMPRA_INSUMO ci
JOIN PROVEEDOR p ON p.id_proveedor = ci.id_proveedor
GROUP BY p.id_proveedor, p.nombre, p.ruc
HAVING SUM(ci.costo_total) > 500
ORDER BY gasto_total DESC;


SELECT
    v.id_vaca,
    v.arete                                          AS codigo_vaca,
    v.estado,
    COUNT(es.id_evento)                              AS total_eventos,
    ROUND(SUM(es.costo), 2)                          AS costo_sanitario_total,
    ROUND(AVG(es.costo), 2)                          AS costo_promedio_por_evento,
    GROUP_CONCAT(DISTINCT es.tipo_evento ORDER BY es.tipo_evento SEPARATOR ', ')
                                                     AS tipos_evento
FROM EVENTO_SANITARIO es
JOIN VACA v ON v.id_vaca = es.id_vaca
GROUP BY v.id_vaca, v.arete, v.estado
HAVING COUNT(es.id_evento) > 1
ORDER BY costo_sanitario_total DESC;
