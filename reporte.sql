USE establo;

SELECT
    v.id_vaca,
    v.arete,
    DATE_FORMAT(p.fecha, '%Y-%m')     AS mes,
    COUNT(p.id_produccion)            AS cantidad_ordeños,
    SUM(p.litros)                     AS total_litros,
    ROUND(AVG(p.grasa_porcentaje), 2) AS grasa_promedio
FROM PRODUCCION_LECHE p
JOIN VACA v ON v.id_vaca = p.id_vaca
GROUP BY v.id_vaca, v.arete, DATE_FORMAT(p.fecha, '%Y-%m')
HAVING SUM(p.litros) > 300
ORDER BY mes DESC, total_litros DESC;
 

SELECT
    c.id_cliente,
    c.nombre                    AS cliente,
    DATE_FORMAT(vl.fecha, '%Y-%m') AS mes,
    COUNT(vl.id_venta)          AS num_ventas,
    SUM(vl.litros_vendidos)     AS litros_totales,
    SUM(vl.total_venta)         AS monto_total
FROM VENTA_LECHE vl
JOIN CLIENTE c ON c.id_cliente = vl.id_cliente
GROUP BY c.id_cliente, c.nombre, DATE_FORMAT(vl.fecha, '%Y-%m')
HAVING SUM(vl.total_venta) > 1000
ORDER BY mes DESC, monto_total DESC;

SELECT
    pr.id_proveedor,
    pr.nombre               AS proveedor,
    COUNT(c.id_compra)      AS num_compras,
    SUM(c.cantidad)         AS cantidad_total,
    SUM(c.costo_total)      AS gasto_total
FROM COMPRA_INSUMO c
JOIN PROVEEDOR pr ON pr.id_proveedor = c.id_proveedor
GROUP BY pr.id_proveedor, pr.nombre
HAVING SUM(c.costo_total) > 500
ORDER BY gasto_total DESC;

SELECT
    es.tipo_evento,
    v.arete,
    COUNT(es.id_evento)    AS num_eventos,
    SUM(es.costo)          AS costo_total,
    ROUND(AVG(costo), 2)   AS costo_promedio
FROM EVENTO_SANITARIO es
JOIN VACA v ON v.id_vaca = es.id_vaca
JOIN INSUMO i ON i.id_insumo = es.id_insumo
GROUP BY es.tipo_evento, v.arete
HAVING SUM(es.costo) > 200
ORDER BY costo_total DESC;

SELECT
    e.id_empleado,
    CONCAT(e.nombre, ' ', e.apellido)   AS empleado,
    DATE_FORMAT(a.fecha, '%Y-%m')       AS mes,
    SUM(CASE WHEN a.presente = FALSE THEN 1 ELSE 0 END) AS faltas,
    SUM(CASE WHEN a.presente = TRUE  THEN 1 ELSE 0 END) AS dias_presentes
FROM ASISTENCIA a
JOIN EMPLEADO e ON e.id_empleado = a.id_empleado
GROUP BY e.id_empleado, empleado, DATE_FORMAT(a.fecha, '%Y-%m')
HAVING SUM(CASE WHEN a.presente = FALSE THEN 1 ELSE 0 END) > 2
ORDER BY mes DESC, faltas DESC;

SELECT
    co.id_corral,
    co.nombre                  AS corral,
    COUNT(DISTINCT v.id_vaca)  AS num_vacas,
    ROUND(AVG(p.litros), 2)    AS promedio_litros_por_ordeño
FROM HISTORIAL_CORRAL hc
JOIN CORRAL co ON co.id_corral = hc.id_corral
JOIN VACA v ON v.id_vaca = hc.id_vaca
JOIN PRODUCCION_LECHE p
     ON p.id_vaca = v.id_vaca
    AND p.fecha BETWEEN hc.fecha_entrada AND IFNULL(hc.fecha_salida, CURDATE())
GROUP BY co.id_corral, co.nombre
HAVING AVG(p.litros) > 15
ORDER BY promedio_litros_por_ordeño DESC;
