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
    tipo_evento,
    COUNT(id_evento)      AS num_eventos,
    SUM(costo)             AS costo_total,
    ROUND(AVG(costo), 2)   AS costo_promedio
FROM EVENTO_SANITARIO
GROUP BY tipo_evento
HAVING SUM(costo) > 200
ORDER BY costo_total DESC;
