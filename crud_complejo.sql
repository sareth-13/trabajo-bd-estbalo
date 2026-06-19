USE establo;

-- ============================================================================
-- 1. [CREATE] - INSERCIÓN COMPLEJA CON TRANSACCIÓN (Venta y Registro)
-- ============================================================================
START TRANSACTION;

-- Definir los datos de la venta en variables
SET @cliente_id = 1;
SET @fecha_venta = '2026-06-19';
SET @total_dinero = 1500.00;

-- Insertar la venta principal
INSERT INTO VENTA_LECHE (id_cliente, fcha, total_venta) 
VALUES (@cliente_id, @fecha_venta, @total_dinero);

-- Guardar el ID generado automáticamente de esa venta para auditoría posterior
SET @ultimo_id_venta = LAST_INSERT_ID();

COMMIT;


-- ============================================================================
-- 2. [READ] - LECTURA COMPLEJA (Consulta con JOINs, Filtros y Agrupaciones)
-- ============================================================================
SET @cliente_buscado = 1;

SELECT 
    v.id_venta,
    c.nombre AS nombre_cliente,
    c.ruc,
    v.fcha AS fecha_operacion,
    v.total_venta AS monto_total
FROM VENTA_LECHE v
INNER JOIN CLIENTE c ON v.id_cliente = c.id_cliente
WHERE v.id_cliente = @cliente_buscado
ORDER BY v.fcha DESC;


-- ============================================================================
-- 3. [UPDATE] - ACTUALIZACIÓN COMPLEJA (Modificación condicional)
-- ============================================================================
-- Si el cliente cambia de dirección, actualizamos su ubicación y recalculamos 
-- el total de una venta específica si se le aplicó un recargo por delivery.
SET @cliente_a_actualizar = 1;
SET @nueva_direccion = 'Av. Industrial 500, Arequipa';

UPDATE CLIENTE 
SET direccion = @nueva_direccion 
WHERE id_cliente = @cliente_a_actualizar;

UPDATE VENTA_LECHE 
SET total_venta = total_venta * 1.05 
WHERE id_cliente = @cliente_a_actualizar AND fcha = '2026-06-19';


-- ============================================================================
-- 4. [DELETE] - BORRADO COMPLEJO (Limpieza en cascada manual)
-- ============================================================================
-- Para borrar un cliente de forma segura sin romper las llaves foráneas:
START TRANSACTION;

SET @cliente_a_eliminar = 5;

-- Primero borramos el historial de sus ventas para evitar errores de restricción
DELETE FROM VENTA_LECHE 
WHERE id_cliente = @cliente_a_eliminar;

-- Ahora borramos definitivamente al cliente
DELETE FROM CLIENTE 
WHERE id_cliente = @cliente_a_eliminar;

COMMIT;
