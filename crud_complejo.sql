USE establo;

-- EMPLEADO
INSERT INTO EMPLEADO(nombre, apellido, cargo, fecha_contrato, salario_base)
VALUES ('Juan','Perez','Administrador','2024-01-01',2500);

UPDATE EMPLEADO SET salario_base = 2800 WHERE id_empleado = 1;

DELETE FROM EMPLEADO WHERE id_empleado = 5;

-- CONSULTAS COMPLEJAS
SELECT e.nombre, e.apellido, p.monto_total
FROM EMPLEADO e
JOIN PAGO_EMPLEADO p ON e.id_empleado = p.id_empleado;

SELECT v.arete, SUM(pl.litros) AS total_litros
FROM VACA v
JOIN PRODUCCION_LECHE pl ON v.id_vaca = pl.id_vaca
GROUP BY v.arete;

SELECT c.nombre, SUM(ci.costo_total) AS gasto_total
FROM PROVEEDOR c
JOIN COMPRA_INSUMO ci ON c.id_proveedor = ci.id_proveedor
GROUP BY c.nombre;
