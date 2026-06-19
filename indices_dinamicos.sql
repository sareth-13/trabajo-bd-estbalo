USE establo;

SET @fecha_inicio = '2026-01-01';
SET @fecha_fin    = '2026-03-31';
SET @empleado_buscado = 3;

SELECT 
    DATE_FORMAT(fcha, '%Y-%m') AS mes,
    SUM(total_venta) AS ingresos_totales
FROM VENTA_LECHE
WHERE fcha BETWEEN @fecha_inicio AND @fecha_fin
GROUP BY DATE_FORMAT(fcha, '%Y-%m')
ORDER BY mes ASC;

SELECT 
    id_empleado,
    nombre,
    apellido,
    dias_asistidos 
FROM vista_asistencia_empleados 
WHERE id_empleado = @empleado_buscado;
