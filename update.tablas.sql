USE establo;

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO ROL (id_rol, nombre_rol) VALUES 
(1, 'Administrador'), (2, 'Supervisor'), (3, 'Cajero'), (4, 'Vendedor'), (5, 'Almacenero')
ON DUPLICATE KEY UPDATE nombre_rol = nombre_rol;

-- Solución al error de EMPLEADO usando asignación limpia
INSERT INTO EMPLEADO (id_empleado, nombre, apellido, cargo, fcha_contrato, salario_base, nmero_tlfono, activo) VALUES
(1, 'Juan',   'Pérez',     'Administrador', '2023-01-15', 2500.00, '987654321', 1),
(2, 'María',  'Gómez',     'Cajera',        '2023-03-10', 1800.00, '986123456', 1),
(3, 'Carlos', 'Ramírez',   'Supervisor',    '2022-11-05', 3200.00, '985741236', 1),
(4, 'Ana',    'Torres',    'Vendedora',     '2024-02-20', 1700.00, '984852963', 1),
(5, 'Luis',   'Fernández', 'Almacenero',    '2023-07-12', 1600.00, '983369258', 0)
AS new_data ON DUPLICATE KEY UPDATE 
    nombre = new_data.nombre, 
    apellido = new_data.apellido, 
    cargo = new_data.cargo, 
    fcha_contrato = new_data.fcha_contrato,
    salario_base = new_data.salario_base, 
    nmero_tlfono = new_data.nmero_tlfono,
    activo = new_data.activo;

INSERT INTO CORRAL (id_corral, nombre, capacidad, descripcion) VALUES
(1, 'Corral A', 20, 'Vacas en producción'),
(2, 'Corral B', 15, 'Vacas secas'),
(3, 'Corral C', 10, 'Terneras'),
(4, 'Corral D', 25, 'Vacas gestantes'),
(5, 'Corral E', 12, 'Cuarentena')
AS new_corral ON DUPLICATE KEY UPDATE 
    nombre = new_corral.nombre,
    capacidad = new_corral.capacidad, 
    descripcion = new_corral.descripcion;

INSERT INTO VACA (id_vaca, arete, fecha_nacimiento, estado, fecha_ingreso, id_madre) VALUES
(1, 'A001', '2020-03-10', 'Activa', '2021-01-05', NULL),
(2, 'A002', '2019-07-22', 'Activa', '2020-02-10', NULL),
(3, 'A003', '2021-05-15', 'Gestante', '2022-01-20', 1),
(4, 'A004', '2018-11-30', 'Seca', '2019-06-15', 2),
(5, 'A005', '2022-08-01', 'Ternera', '2022-08-01', 1)
AS new_vaca ON DUPLICATE KEY UPDATE 
    arete = new_vaca.arete, 
    fecha_nacimiento = new_vaca.fecha_nacimiento,
    estado = new_vaca.estado, 
    fecha_ingreso = new_vaca.fecha_ingreso,
    id_madre = new_vaca.id_madre;

INSERT INTO LOTE_PRODUCCION (id_lote, nombre_lote, fecha_inicio, fecha_fin) VALUES
(1, 'Lote Enero 2026', '2026-01-01', '2026-01-31'),
(2, 'Lote Febrero 2026', '2026-02-01', '2026-02-28'),
(3, 'Lote Marzo 2026', '2026-03-01', '2026-03-31'),
(4, 'Lote Abril 2026', '2026-04-01', '2026-04-30'),
(5, 'Lote Mayo 2026', '2026-05-01', '2026-05-31')
AS new_lote ON DUPLICATE KEY UPDATE 
    nombre_lote = new_lote.nombre_lote,
    fecha_inicio = new_lote.fecha_inicio, 
    fecha_fin = new_lote.fecha_fin;

INSERT INTO INSUMO (id_insumo, nombre, unidad_medida, stock_actual, stock_minimo, precio_unitario) VALUES
(1, 'Antibiótico', 'frasco', 50, 10, 25.00),
(2, 'Vitamina ADE', 'litro', 30, 5, 40.00),
(3, 'Desparasitante', 'dosis', 80, 20, 15.00),
(4, 'Vacuna Fiebre', 'dosis', 60, 15, 12.00),
(5, 'Sal mineralizada', 'kg', 200, 50, 3.00)
AS new_insumo ON DUPLICATE KEY UPDATE 
    nombre = new_insumo.nombre,
    unidad_medida = new_insumo.unidad_medida,
    stock_actual = new_insumo.stock_actual, 
    stock_minimo = new_insumo.stock_minimo,
    precio_unitario = new_insumo.precio_unitario;

INSERT INTO PROVEEDOR (id_proveedor, nombre, ruc, telefono, direccion) VALUES
(1, 'Distribuidora Andina', '20123456789', '987654321', 'Av. Perú 123'),
(2, 'Comercial Lima SAC', '20456789123', '986123456', 'Jr. Arequipa 456'),
(3, 'Insumos del Norte', '20567891234', '985741236', 'Calle Los Olivos 789'),
(4, 'Tech Supplies SAC', '20678912345', '984852963', 'Av. Primavera 321'),
(5, 'Global Market', '20789123456', '983369258', 'Jr. Unión 654')
AS new_prov ON DUPLICATE KEY UPDATE 
    nombre = new_prov.nombre,
    ruc = new_prov.ruc,
    telefono = new_prov.telefono, 
    direccion = new_prov.direccion;

INSERT INTO CLIENTE (id_cliente, nombre, ruc, telefono, direccion) VALUES
(1, 'Lácteos del Sur SAC', '20111222333', '987111222', 'Av. Industrial 100'),
(2, 'Quesos Andinos EIRL', '20222333444', '986222333', 'Jr. Comercio 200'),
(3, 'Distribuidora Fresca', '20333444555', '985333444', 'Calle Nueva 300'),
(4, 'Yogurt Express SAC', '20444555666', '984444555', 'Av. Los Pinos 400'),
(5, 'Mercado Central', '20555666777', '983555666', 'Plaza Mayor 500')
AS new_cli ON DUPLICATE KEY UPDATE 
    nombre = new_cli.nombre,
    ruc = new_cli.ruc,
    telefono = new_cli.telefono, 
    direccion = new_cli.direccion;

SET FOREIGN_KEY_CHECKS = 1;
