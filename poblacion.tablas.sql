USE establo;

-- ============================================================================
-- 1. INSERCIÓN / ACTUALIZACIÓN DE CATÁLOGOS (SEGURO CONTRA ERRORES #1451 Y #1062)
-- ============================================================================

-- ROLES
INSERT INTO ROL (nombre_rol)
VALUES 
('Administrador'),
('Supervisor'),
('Cajero'),
('Vendedor'),
('Almacenero')
ON DUPLICATE KEY UPDATE nombre_rol = VALUES(nombre_rol);

-- EMPLEADOS (Corregido con ON DUPLICATE KEY UPDATE para no romper llaves foráneas)
INSERT INTO EMPLEADO (id_empleado, nombre, apellido, cargo, fcha_contrato, salario_base, nmero_tlfono, activo)
VALUES
(1, 'Juan',   'Pérez',     'Administrador', '2023-01-15', 2500.00, '987654321', 1),
(2, 'María',  'Gómez',     'Cajera',        '2023-03-10', 1800.00, '986123456', 1),
(3, 'Carlos', 'Ramírez',   'Supervisor',    '2022-11-05', 3200.00, '985741236', 1),
(4, 'Ana',    'Torres',    'Vendedora',     '2024-02-20', 1700.00, '984852963', 1),
(5, 'Luis',   'Fernández', 'Almacenero',    '2023-07-12', 1600.00, '983369258', 0)
ON DUPLICATE KEY UPDATE 
    nombre = VALUES(nombre),
    apellido = VALUES(apellido),
    cargo = VALUES(cargo),
    fcha_contrato = VALUES(fcha_contrato),
    salario_base = VALUES(salario_base),
    nmero_tlfono = VALUES(nmero_tlfono),
    activo = VALUES(activo);

-- CORRALES
INSERT INTO CORRAL (nombre, capacidad, descripcion)
VALUES
('Corral A', 20, 'Vacas en producción'),
('Corral B', 15, 'Vacas secas'),
('Corral C', 10, 'Terneras'),
('Corral D', 25, 'Vacas gestantes'),
('Corral E', 12, 'Cuarentena')
ON DUPLICATE KEY UPDATE capacidad = VALUES(capacidad), descripcion = VALUES(descripcion);

-- VACAS
INSERT INTO VACA (id_vaca, arete, fecha_nacimiento, estado, fecha_ingreso, id_madre)
VALUES
(1, 'A001', '2020-03-10', 'Activa', '2021-01-05', NULL),
(2, 'A002', '2019-07-22', 'Activa', '2020-02-10', NULL),
(3, 'A003', '2021-05-15', 'Gestante', '2022-01-20', 1),
(4, 'A004', '2018-11-30', 'Seca', '2019-06-15', 2),
(5, 'A005', '2022-08-01', 'Ternera', '2022-08-01', 1)
ON DUPLICATE KEY UPDATE 
    arete = VALUES(arete), 
    estado = VALUES(estado), 
    id_madre = VALUES(id_madre);

-- LOTES PRODUCCIÓN
INSERT INTO LOTE_PRODUCCION (nombre_lote, fecha_inicio, fecha_fin)
VALUES
('Lote Enero 2026', '2026-01-01', '2026-01-31'),
('Lote Febrero 2026', '2026-02-01', '2026-02-28'),
('Lote Marzo 2026', '2026-03-01', '2026-03-31'),
('Lote Abril 2026', '2026-04-01', '2026-04-30'),
('Lote Mayo 2026', '2026-05-01', '2026-05-31')
ON DUPLICATE KEY UPDATE fecha_inicio = VALUES(fecha_inicio), fecha_fin = VALUES(fecha_fin);

-- INSUMOS
INSERT INTO INSUMO (nombre, unidad_medida, stock_actual, stock_minimo, precio_unitario)
VALUES
('Antibiótico', 'frasco', 50, 10, 25.00),
('Vitamina ADE', 'litro', 30, 5, 40.00),
('Desparasitante', 'dosis', 80, 20, 15.00),
('Vacuna Fiebre', 'dosis', 60, 15, 12.00),
('Sal mineralizada', 'kg', 200, 50, 3.00)
ON DUPLICATE KEY UPDATE stock_actual = VALUES(stock_actual), precio_unitario = VALUES(precio_unitario);

-- PROVEEDORES
INSERT INTO PROVEEDOR (nombre, ruc, telefono, direccion)
VALUES
('Distribuidora Andina', '20123456789', '987654321', 'Av. Perú 123'),
('Comercial Lima SAC', '20456789123', '986123456', 'Jr. Arequipa 456'),
('Insumos del Norte', '20567891234', '985741236', 'Calle Los Olivos 789'),
('Tech Supplies SAC', '20678912345', '984852963', 'Av. Primavera 321'),
('Global Market', '20789123456', '983369258', 'Jr. Unión 654')
ON DUPLICATE KEY UPDATE telefono = VALUES(telefono), direccion = VALUES(direccion);

-- CLIENTES
INSERT INTO CLIENTE (nombre, ruc, telefono, direccion)
VALUES
('Lácteos del Sur SAC', '20111222333', '987111222', 'Av. Industrial 100'),
('Quesos Andinos EIRL', '20222333444', '986222333', 'Jr. Comercio 200'),
('Distribuidora Fresca', '20333444555', '985333444', 'Calle Nueva 300'),
('Yogurt Express SAC', '20444555666', '984444555', 'Av. Los Pinos 400'),
('Mercado Central', '20555666777', '983555666', 'Plaza Mayor 500')
ON DUPLICATE KEY UPDATE telefono = VALUES(telefono), direccion = VALUES(direccion);


-- ============================================================================
-- 2. PROCESO DE ELIMINACIÓN SEGURO (EJEMPLO VACA ID: 1)
-- ============================================================================
SET @vaca_id_a_borrar = 1; 

-- Romper relación de maternidad para evitar error #1451 autorreferencial
UPDATE VACA SET id_madre = NULL WHERE id_madre = @vaca_id_a_borrar;

-- Borrar dependencias en minúsculas y mayúsculas según tu esquema
DELETE FROM produccion_leche WHERE id_vaca = @vaca_id_a_borrar;
DELETE FROM HISTORIAL_CORRAL WHERE id_vaca = @vaca_id_a_borrar;
DELETE FROM EVENTO_SANITARIO WHERE id_vaca = @vaca_id_a_borrar;

-- Borrado definitivo de la vaca
DELETE FROM VACA WHERE id_vaca = @vaca_id_a_borrar;


-- ============================================================================
-- 3. REPORTES Y CONSULTAS (OPTIMIZADAS CONTRA COLUMNAS DESCONOCIDAS #1054)
-- ============================================================================

-- REPORTE: PRODUCCIÓN DE LECHE POR VACA
SELECT 
    v.id_vaca,
    v.arete,
    (SELECT COUNT(*) FROM produccion_leche WHERE id_vaca = v.id_vaca) AS numero_registros,
    (SELECT SUM(litros) FROM produccion_leche WHERE id_vaca = v.id_vaca) AS total_litros
FROM VACA v
ORDER BY total_litros DESC 
LIMIT 0, 25;

-- REPORTE: PRODUCCIÓN POR LOTE
SELECT 
    l.id_lote,
    l.nombre_lote,
    SUM(p.litros) AS total_producido
FROM LOTE_PRODUCCION l
LEFT JOIN produccion_leche p ON l.id_lote = p.id_lote_prdccion
GROUP BY l.id_lote, l.nombre_lote;

-- REPORTE: INGRESOS POR VENTAS
SELECT 
    DATE_FORMAT(fcha, '%Y-%m') AS mes,
    SUM(total_venta) AS ingresos_totales
FROM VENTA_LECHE
GROUP BY DATE_FORMAT(fcha, '%Y-%m')
ORDER BY DATE_FORMAT(fcha, '%Y-%m') ASC;

-- REPORTE: COMPRAS POR PROVEEDOR
SELECT 
    pr.nombre AS proveedor,
    SUM(c.costo_total) AS total_compras
FROM PROVEEDOR pr
JOIN COMPRA_INSUMO c ON pr.id_proveedor = c.id_proveedor
GROUP BY pr.nombre
ORDER BY total_compras DESC;

-- REPORTE: ASISTENCIA EMPLEADOS
SELECT 
    e.nombre,
    e.apellido,
    SUM(a.presente) AS dias_asistidos
FROM EMPLEADO e
JOIN ASISTENCIA a ON e.id_empleado = a.id_empleado
GROUP BY e.id_empleado, e.nombre, e.apellido;
