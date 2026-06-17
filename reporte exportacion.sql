USE establo;

SELECT 
    v.arete,
    SUM(pl.litros) AS total_litros,
    AVG(pl.grasa_porcentaje) AS grasa_promedio
FROM VACA v
JOIN PRODUCCION_LECHE pl ON v.id_vaca = pl.id_vaca
GROUP BY v.arete;

SELECT 
    DATE_FORMAT(fecha,'%Y-%m') AS mes,
    SUM(total_venta) AS ingresos
FROM VENTA_LECHE
GROUP BY mes;
