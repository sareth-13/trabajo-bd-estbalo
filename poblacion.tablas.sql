
USE establo;
INSERT INTO EMPLEADO (id_empleado, nombre, apellido, cargo, fcha_contrato, salario_base, nmero_tlfono, activo)
VALUES
(1, 'Juan',   'Pérez',     'Administrador', '2023-01-15', 2500.00, '987654321', 1),
(2, 'María',  'Gómez',     'Cajera',        '2023-03-10', 1800.00, '986123456', 1),
(3, 'Carlos', 'Ramírez',   'Supervisor',    '2022-11-05', 3200.00, '985741236', 1),
(4, 'Ana',    'Torres',    'Vendedora',     '2024-02-20', 1700.00, '984852963', 1),
(5, 'Luis',   'Fernández', 'Almacenero',    '2023-07-12', 1600.00, '983369258', 0);

INSERT INTO ROL (id_rol, nombre_rol)
VALUES
(1, 'Administrador'),
(2, 'Supervisor'),
(3, 'Cajero'),
(4, 'Vendedor'),
(5, 'Almacenero');

INSERT INTO CORRAL (id_corral, nombre, capacidad, descripcion)
VALUES
(1, 'Corral A', 20, 'Vacas en producción'),
(2, 'Corral B', 15, 'Vacas secas'),
(3, 'Corral C', 10, 'Terneras'),
(4, 'Corral D', 25, 'Vacas gestantes'),
(5, 'Corral E', 12, 'Cuarentena');

INSERT INTO VACA (id_vaca, arete, fecha_nacimiento, estado, fecha_ingreso, fecha_venta_muerte, id_madre)
VALUES
(1, 'A001', '2020-03-10', 'Activa',   '2021-01-05', NULL, NULL),
(2, 'A002', '2019-07-22', 'Activa',   '2020-02-10', NULL, NULL),
(3, 'A003', '2021-05-15', 'Gestante', '2022-01-20', NULL, 1),
(4, 'A004', '2018-11-30', 'Seca',     '2019-06-15', NULL, 2),
(5, 'A005', '2022-08-01', 'Ternera',  '2022-08-01', NULL, 1);

INSERT INTO LOTE_PRODUCCION (id_lote, nombre_lote, fecha_inicio, fecha_fin)
VALUES
(1, 'Lote Enero 2026',   '2026-01-01', '2026-01-31'),
(2, 'Lote Febrero 2026', '2026-02-01', '2026-02-28'),
(3, 'Lote Marzo 2026',   '2026-03-01', '2026-03-31'),
(4, 'Lote Abril 2026',   '2026-04-01', '2026-04-30'),
(5, 'Lote Mayo 2026',    '2026-05-01', '2026-05-31');

INSERT INTO PROVEEDOR (id_proveedor, nombre, ruc, telefono, direccion)
VALUES
(1, 'Distribuidora Andina', '20123456789', '987654321', 'Av. Perú 123'),
(2, 'Comercial Lima SAC',   '20456789123', '986123456', 'Jr. Arequipa 456'),
(3, 'Insumos del Norte',    '20567891234', '985741236', 'Calle Los Olivos 789'),
(4, 'Tech Supplies SAC',    '20678912345', '984852963', 'Av. Primavera 321'),
(5, 'Global Market',        '20789123456', '983369258', 'Jr. Unión 654');

INSERT INTO INSUMO (id_insumo, nombre, unidad_medida, stock_actual, stock_minimo, precio_unitario)
VALUES
(1, 'Antibiótico',      'frasco',  50.00, 10.00, 25.00),
(2, 'Vitamina ADE',     'litro',   30.00,  5.00, 40.00),
(3, 'Desparasitante',   'dosis',   80.00, 20.00, 15.00),
(4, 'Vacuna Fiebre',    'dosis',   60.00, 15.00, 12.00),
(5, 'Sal mineralizada', 'kg',     200.00, 50.00,  3.00);

INSERT INTO CLIENTE (id_cliente, nombre, ruc, telefono, direccion)
VALUES
(1, 'Lácteos del Sur SAC',  '20111222333', '987111222', 'Av. Industrial 100'),
(2, 'Quesos Andinos EIRL',  '20222333444', '986222333', 'Jr. Comercio 200'),
(3, 'Distribuidora Fresca', '20333444555', '985333444', 'Calle Nueva 300'),
(4, 'Yogurt Express SAC',   '20444555666', '984444555', 'Av. Los Pinos 400'),
(5, 'Mercado Central',      '20555666777', '983555666', 'Plaza Mayor 500');



INSERT INTO USUARIO (id_usuario, id_empleado, nmbre_usuaio, password_hash, activo)
VALUES
(1, 1, 'jperez',     'hash123', 1),
(2, 2, 'mgomez',     'hash456', 1),
(3, 3, 'cramirez',   'hash789', 1),
(4, 4, 'atorres',    'hash321', 1),
(5, 5, 'lfernandez', 'hash654', 0);

INSERT INTO USUARIO_ROL (id_usuario, id_rol)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO HISTORIAL_CORRAL (id_hstrial_crral, id_vaca, id_corral, fcha_entrda, fcha_slida, motivo)
VALUES
(1, 1, 1, '2021-01-05', NULL,         'Ingreso inicial'),
(2, 2, 1, '2020-02-10', '2021-06-01', 'Producción'),
(3, 3, 4, '2022-01-20', NULL,         'Gestación'),
(4, 4, 2, '2019-06-15', NULL,         'Vaca seca'),
(5, 5, 3, '2022-08-01', NULL,         'Ternera recién nacida');

INSERT INTO PRODUCCION_LECHE (id_prdccion, id_vaca, id_lote_prdccion, fcha, litros, grasa_prcntaje, solidos_totales_prcntaje, turno)
VALUES
(1, 1, 1, '2026-01-05', 12.50, 3.80, 12.50, 'MAÑANA'),
(2, 2, 1, '2026-01-05', 10.00, 3.60, 12.00, 'TARDE'),
(3, 1, 2, '2026-02-10', 11.00, 3.90, 12.80, 'MAÑANA'),
(4, 2, 2, '2026-02-10',  9.50, 3.70, 12.20, 'TARDE'),
(5, 1, 3, '2026-03-15', 13.00, 4.00, 13.00, 'MAÑANA');

INSERT INTO VENTA_LECHE (id_venta, id_lote_prdccion, fcha, litros_vendidos, precio_por_litro, total_venta, comprador)
VALUES
(1, 1, '2026-02-01', 500.00, 1.80,  900.00, 'Lácteos del Sur SAC'),
(2, 2, '2026-03-01', 480.00, 1.85,  888.00, 'Quesos Andinos EIRL'),
(3, 3, '2026-04-01', 520.00, 1.80,  936.00, 'Distribuidora Fresca'),
(4, 4, '2026-05-01', 510.00, 1.90,  969.00, 'Yogurt Express SAC'),
(5, 5, '2026-06-01', 490.00, 1.85,  906.50, 'Mercado Central');

INSERT INTO COMPRA_INSUMO (id_compra, id_insumo, id_proveedor, fecha_compra, cantidad, costo_total, factura_numero)
VALUES
(1, 1, 1, '2026-05-01', 50, 500.00,  'FAC-1001'),
(2, 2, 2, '2026-05-03', 30, 750.00,  'FAC-1002'),
(3, 3, 3, '2026-05-05', 20, 400.00,  'FAC-1003'),
(4, 4, 4, '2026-05-07', 15, 900.00,  'FAC-1004'),
(5, 5, 5, '2026-05-10', 40, 1200.00, 'FAC-1005');

INSERT INTO PAGO_EMPLEADO (id_pago, id_empleado, mes, monto_total, fecha_pago, dias_trabajados, bonos)
VALUES
(1, 1, '2026-04', 2700.00, '2026-05-01', 26, 200.00),
(2, 2, '2026-04', 1900.00, '2026-05-01', 25, 100.00),
(3, 3, '2026-04', 3500.00, '2026-05-01', 27, 300.00),
(4, 4, '2026-04', 1800.00, '2026-05-01', 24, 100.00),
(5, 5, '2026-04', 1600.00, '2026-05-01', 22,   0.00);

INSERT INTO EVENTO_SANITARIO (id_evento, id_vaca, id_veterinario, id_insumo, costo, tipo_evento, descripcion, fecha)
VALUES
(1, 1, NULL, 1, 50.00, 'Tratamiento',     'Aplicación de antibiótico', '2026-03-10'),
(2, 2, NULL, 3, 30.00, 'Desparasitación', 'Desparasitación rutinaria', '2026-03-12'),
(3, 3, NULL, 4, 25.00, 'Vacunación',      'Vacuna fiebre aftosa',      '2026-04-01'),
(4, 4, NULL, 2, 40.00, 'Vitaminas',       'Suplemento vitamínico',     '2026-04-15'),
(5, 5, NULL, 3, 15.00, 'Desparasitación', 'Primera desparasitación',   '2026-04-20');

INSERT INTO ASISTENCIA (id_asistencia, id_empleado, fecha, presente)
VALUES
(1, 1, '2026-05-18', 1),
(2, 2, '2026-05-18', 1),
(3, 3, '2026-05-18', 0),
(4, 4, '2026-05-18', 1),
(5, 5, '2026-05-18', 1);
