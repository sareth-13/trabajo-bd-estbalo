USE establo;

-- ============================================================================
-- CRUD EMPLEADO (SEGURO)
-- ============================================================================

-- 1. Insertar empleado
INSERT INTO EMPLEADO (nombre, apellido, cargo, fcha_contrato, salario_base, nmero_tlfono, activo)
VALUES ('Juan', 'Pérez', 'Administrador', '2023-01-15', 2500.00, '987654321', 1);

-- 2. Verificar inserción
SELECT * FROM EMPLEADO;

-- 3. Actualizar último empleado insertado (más seguro que id fijo)
UPDATE EMPLEADO
SET salario_base = 2800.00
ORDER BY id_empleado DESC
LIMIT 1;

-- 4. DELETE SEGURO EMPLEADO
SET @emp_id = (SELECT MAX(id_empleado) FROM EMPLEADO);

DELETE FROM ASISTENCIA WHERE id_empleado = @emp_id;
DELETE FROM PAGO_EMPLEADO WHERE id_empleado = @emp_id;
DELETE FROM USUARIO WHERE id_empleado = @emp_id;
DELETE FROM EMPLEADO WHERE id_empleado = @emp_id;


-- ============================================================================
-- CRUD VACA (SEGURO Y CORREGIDO)
-- ============================================================================

-- 1. Insertar vaca
INSERT INTO VACA (arete, fecha_nacimiento, estado, fecha_ingreso)
VALUES ('A001', '2020-03-10', 'Activa', '2021-01-05');

-- 2. Verificar inserción
SELECT * FROM VACA;

-- 3. Definir ID de la vaca que se quiere borrar (Ejemplo con ID: 1)
-- Nota: Cambia el '1' por el ID de la vaca que realmente desees eliminar.
SET @vaca_id_a_borrar = 1; 

-- 4. CORRECCIÓN DEL ERROR #1451: Romper relación de maternidad (Hijos de esta vaca)
-- Esto evita el fallo de restricción de clave foránea autorreferencial
UPDATE VACA
SET id_madre = NULL
WHERE id_madre = @vaca_id_a_borrar;

-- 5. Borrar dependencias en otras tablas
DELETE FROM PRODUCCION_LECHE WHERE id_vaca = @vaca_id_a_borrar;
DELETE FROM HISTORIAL_CORRAL WHERE id_vaca = @vaca_id_a_borrar;
DELETE FROM EVENTO_SANITARIO WHERE id_vaca = @vaca_id_a_borrar;

-- 6. Finalmente, borrar la vaca de forma segura
DELETE FROM VACA WHERE id_vaca = @vaca_id_a_borrar;


-- ============================================================================
-- CONSULTAS COMPLEJAS
-- ============================================================================

-- Producción por vaca
SELECT 
    v.id_vaca,
    v.arete,
    SUM(p.litros) AS total_litros
FROM VACA v
JOIN PRODUCCION_LECHE p ON v.id_vaca = p.id_vaca
GROUP BY v.id_vaca, v.arete;

-- Ventas por lote
SELECT 
    l.id_lote,
    SUM(vl.total_venta) AS ingresos_totales
FROM LOTE_PRODUCCION l
JOIN VENTA_LECHE vl ON l.id_lote = vl.id_lote_prdccion
GROUP BY l.id_lote;

-- Compras por proveedor
SELECT 
    pr.nombre,
    SUM(c.costo_total) AS total_gastado
FROM PROVEEDOR pr
JOIN COMPRA_INSUMO c ON pr.id_proveedor = c.id_proveedor
GROUP BY pr.nombre;

-- Empleados con pagos
SELECT 
    e.nombre,
    e.apellido,
    p.monto_total,
    p.mes
FROM EMPLEADO e
JOIN PAGO_EMPLEADO p ON e.id_empleado = p.id_empleado;
