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
