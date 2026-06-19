USE establo;

CREATE OR REPLACE VIEW vista_produccion_vaca AS
SELECT 
    v.id_vaca, v.arete,
    (SELECT COUNT(*) FROM produccion_leche WHERE id_vaca = v.id_vaca) AS numero_registros,
    (SELECT SUM(litros) FROM produccion_leche WHERE id_vaca = v.id_vaca) AS total_litros
FROM VACA v;

CREATE OR REPLACE VIEW vista_produccion_lote AS
SELECT 
    l.id_lote, l.nombre_lote, SUM(p.litros) AS total_producido
FROM LOTE_PRODUCCION l
LEFT JOIN produccion_leche p ON l.id_lote = p.id_lote_prdccion
GROUP BY l.id_lote, l.nombre_lote;

CREATE OR REPLACE VIEW vista_ingresos_ventas AS
SELECT 
    DATE_FORMAT(fcha, '%Y-%m') AS mes, SUM(total_venta) AS ingresos_totales
FROM VENTA_LECHE
GROUP BY DATE_FORMAT(fcha, '%Y-%m');

CREATE OR REPLACE VIEW vista_compras_proveedor AS
SELECT 
    pr.nombre AS proveedor, SUM(c.costo_total) AS total_compras
FROM PROVEEDOR pr
JOIN COMPRA_INSUMO c ON pr.id_proveedor = c.id_proveedor
GROUP BY pr.nombre;

CREATE OR REPLACE VIEW vista_asistencia_empleados AS
SELECT 
    e.id_empleado, e.nombre, e.apellido, SUM(a.presente) AS dias_asistidos
FROM EMPLEADO e
JOIN ASISTENCIA a ON e.id_empleado = a.id_empleado
GROUP BY e.id_empleado, e.nombre, e.apellido;

SELECT * FROM vista_produccion_vaca;
SELECT * FROM vista_produccion_lote;
SELECT * FROM vista_ingresos_ventas;
SELECT * FROM vista_compras_proveedor;
SELECT * FROM vista_asistencia_empleados;
