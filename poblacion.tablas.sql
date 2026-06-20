USE establo;
SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO ROL (id_rol, nombre_rol) VALUES
(1, 'Administrador'),
(2, 'Supervisor'),
(3, 'Cajero'),
(4, 'Vendedor'),
(5, 'Almacenero');
 
INSERT INTO EMPLEADO (id_empleado, nombre, apellido, cargo, fecha_contrato, salario_base, telefono, activo) VALUES
(1, 'Juan',   'Pérez',     'Administrador', '2023-01-15', 2500.00, '987654321', TRUE),
(2, 'María',  'Gómez',     'Cajera',        '2023-03-10', 1800.00, '986123456', TRUE),
(3, 'Carlos', 'Ramírez',   'Supervisor',    '2022-11-05', 3200.00, '985741236', TRUE),
(4, 'Ana',    'Torres',    'Vendedora',     '2024-02-20', 1700.00, '984852963', TRUE),
(5, 'Luis',   'Fernández', 'Almacenero',    '2023-07-12', 1600.00, '983369258', TRUE),
(6, 'Rosa',   'Vargas',    'Veterinaria',   '2023-09-01', 2800.00, '982147896', TRUE);
 
INSERT INTO CORRAL (id_corral, nombre, capacidad, descripcion) VALUES
(1, 'Corral A', 20, 'Vacas en producción'),
(2, 'Corral B', 15, 'Vacas secas'),
(3, 'Corral C', 10, 'Terneras'),
(4, 'Corral D', 25, 'Vacas gestantes'),
(5, 'Corral E', 12, 'Cuarentena');
 
INSERT INTO LOTE_PRODUCCION (id_lote, nombre_lote, fecha_inicio, fecha_fin) VALUES
(1, 'Lote Enero 2026',   '2026-01-01', '2026-01-31'),
(2, 'Lote Febrero 2026', '2026-02-01', '2026-02-28'),
(3, 'Lote Marzo 2026',   '2026-03-01', '2026-03-31'),
(4, 'Lote Abril 2026',   '2026-04-01', '2026-04-30'),
(5, 'Lote Mayo 2026',    '2026-05-01', '2026-05-31');
 
INSERT INTO CLIENTE (id_cliente, nombre, ruc, telefono, direccion) VALUES
(1, 'Lácteos del Sur SAC',   '20111222333', '987111222', 'Av. Industrial 100'),
(2, 'Quesos Andinos EIRL',   '20222333444', '986222333', 'Jr. Comercio 200'),
(3, 'Distribuidora Fresca',  '20333444555', '985333444', 'Calle Nueva 300'),
(4, 'Yogurt Express SAC',    '20444555666', '984444555', 'Av. Los Pinos 400'),
(5, 'Mercado Central',       '20555666777', '983555666', 'Plaza Mayor 500');
 
INSERT INTO PROVEEDOR (id_proveedor, nombre, ruc, telefono, direccion) VALUES
(1, 'Distribuidora Andina', '20123456789', '987654321', 'Av. Perú 123'),
(2, 'Comercial Lima SAC',   '20456789123', '986123456', 'Jr. Arequipa 456'),
(3, 'Insumos del Norte',    '20567891234', '985741236', 'Calle Los Olivos 789'),
(4, 'Tech Supplies SAC',    '20678912345', '984852963', 'Av. Primavera 321'),
(5, 'Global Market',        '20789123456', '983369258', 'Jr. Unión 654');
 
INSERT INTO INSUMO (id_insumo, nombre, unidad_medida, stock_actual, stock_minimo, precio_unitario) VALUES
(1, 'Antibiótico',       'frasco', 50,  10, 25.00),
(2, 'Vitamina ADE',      'litro',  30,  5,  40.00),
(3, 'Desparasitante',    'dosis',  80,  20, 15.00),
(4, 'Vacuna Fiebre',     'dosis',  60,  15, 12.00),
(5, 'Sal mineralizada',  'kg',     200, 50, 3.00);
 
INSERT INTO USUARIO (id_usuario, id_empleado, nombre_usuario, password_hash, activo) VALUES
(1, 1, 'jperez',   '$2y$10$hashEjemploAdmin000001', TRUE),
(2, 2, 'mgomez',   '$2y$10$hashEjemploCajera000002', TRUE),
(3, 3, 'cramirez', '$2y$10$hashEjemploSuperv000003', TRUE),
(4, 4, 'atorres',  '$2y$10$hashEjemploVended000004', TRUE),
(5, 5, 'lfernandez','$2y$10$hashEjemploAlmac000005', TRUE);
 
INSERT INTO USUARIO_ROL (id_usuario, id_rol) VALUES
(1, 1), 
(2, 3),  
(3, 2),  
(4, 4),  
(5, 5);  
 
INSERT INTO PAGO_EMPLEADO (id_pago, id_empleado, mes, monto_total, fecha_pago, dias_trabajados, bonos) VALUES
(1, 1, '2026-05', 2500.00, '2026-05-30', 30, 0.00),
(2, 2, '2026-05', 1750.00, '2026-05-30', 29, 50.00),
(3, 3, '2026-05', 3200.00, '2026-05-30', 30, 100.00),
(4, 4, '2026-05', 1650.00, '2026-05-30', 28, 0.00),
(5, 5, '2026-05', 1600.00, '2026-05-30', 30, 0.00);
 
INSERT INTO ASISTENCIA (id_empleado, fecha, presente) VALUES
(1, '2026-06-01', TRUE), (1, '2026-06-02', TRUE), (1, '2026-06-03', TRUE),
(2, '2026-06-01', TRUE), (2, '2026-06-02', FALSE), (2, '2026-06-03', TRUE),
(3, '2026-06-01', TRUE), (3, '2026-06-02', TRUE), (3, '2026-06-03', FALSE),
(4, '2026-06-01', FALSE), (4, '2026-06-02', FALSE), (4, '2026-06-03', FALSE),
(5, '2026-06-01', TRUE), (5, '2026-06-02', TRUE), (5, '2026-06-03', TRUE);

INSERT INTO VACA (id_vaca, arete, fecha_nacimiento, estado, fecha_ingreso, fecha_venta_muerte, id_madre) VALUES
(1, 'A001', '2020-03-10', 'ACTIVA',   '2021-01-05', NULL, NULL),
(2, 'A002', '2019-07-22', 'ACTIVA',   '2020-02-10', NULL, NULL),
(3, 'A003', '2021-05-15', 'GESTANTE', '2022-01-20', NULL, 1),
(4, 'A004', '2018-11-30', 'SECA',     '2019-06-15', NULL, 2),
(5, 'A005', '2024-08-01', 'TERNERA',  '2024-08-01', NULL, 1);
 
INSERT INTO HISTORIAL_CORRAL (id_vaca, id_corral, fecha_entrada, fecha_salida, motivo) VALUES
(1, 1, '2026-01-05', NULL, 'Ingreso a producción'),
(2, 1, '2026-01-10', NULL, 'Ingreso a producción'),
(3, 4, '2026-02-01', NULL, 'Traslado por gestación'),
(4, 2, '2026-01-15', NULL, 'Periodo de secado'),
(5, 3, '2024-08-01', NULL, 'Corral de terneras');
 

INSERT INTO PRODUCCION_LECHE (id_vaca, id_lote, fecha, litros, grasa_porcentaje, solidos_totales_porcentaje, turno) VALUES
(1, 5, '2026-05-02', 18.50, 3.80, 12.50, 'MAÑANA'),
(1, 5, '2026-05-02', 14.20, 3.75, 12.30, 'TARDE'),
(1, 5, '2026-05-03', 18.90, 3.82, 12.60, 'MAÑANA'),
(2, 5, '2026-05-02', 20.10, 4.00, 13.00, 'MAÑANA'),
(2, 5, '2026-05-02', 15.80, 3.90, 12.80, 'TARDE'),
(2, 5, '2026-05-03', 19.60, 3.95, 12.90, 'MAÑANA'),
(1, 4, '2026-04-15', 17.30, 3.70, 12.20, 'MAÑANA'),
(2, 4, '2026-04-15', 19.00, 3.85, 12.70, 'MAÑANA');
 
INSERT INTO VENTA_LECHE (id_lote, id_cliente, fecha, litros_vendidos, precio_por_litro, total_venta) VALUES
(5, 1, '2026-05-05', 150.00, 3.50, 525.00),
(5, 2, '2026-05-06', 100.00, 3.60, 360.00),
(4, 3, '2026-04-20', 200.00, 3.40, 680.00),
(4, 1, '2026-04-22', 120.00, 3.50, 420.00);

INSERT INTO COMPRA_INSUMO (id_insumo, id_proveedor, fecha_compra, cantidad, costo_total, factura_numero) VALUES
(1, 1, '2026-05-01', 20.00, 500.00, 'F001-2026'),
(2, 2, '2026-05-03', 10.00, 400.00, 'F002-2026'),
(3, 3, '2026-05-05', 30.00, 450.00, 'F003-2026'),
(4, 1, '2026-05-07', 25.00, 300.00, 'F004-2026'),
(5, 4, '2026-05-10', 100.00, 300.00, 'F005-2026');
 
INSERT INTO EVENTO_SANITARIO (id_vaca, id_veterinario, id_insumo, costo, tipo_evento, descripcion, fecha) VALUES
(1, 6, 4, 80.00, 'Vacunación', 'Vacuna contra fiebre aftosa', '2026-05-12'),
(2, 6, 3, 45.00, 'Desparasitación', 'Aplicación de desparasitante oral', '2026-05-12'),
(3, 6, 2, 120.00, 'Control prenatal', 'Suplemento vitamínico por gestación', '2026-05-14'),
(4, 6, 1, 90.00, 'Tratamiento', 'Antibiótico por mastitis leve', '2026-05-15');
 
SET FOREIGN_KEY_CHECKS = 1;
