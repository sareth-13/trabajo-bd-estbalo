CREATE DATABASE IF NOT EXISTS establo;
USE establo;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS ROL (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS EMPLEADO (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    fcha_contrato DATE NOT NULL,
    salario_base DECIMAL(10,2) NOT NULL,
    nmero_tlfono VARCHAR(20),
    activo TINYINT(1) DEFAULT 1
);

CREATE TABLE IF NOT EXISTS ASISTENCIA (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha DATE NOT NULL,
    presente TINYINT(1) NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

CREATE TABLE IF NOT EXISTS CORRAL (
    id_corral INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL,
    descripcion TEXT
);

CREATE TABLE IF NOT EXISTS VACA (
    id_vaca INT AUTO_INCREMENT PRIMARY KEY,
    arete VARCHAR(20) UNIQUE NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    id_madre INT,
    FOREIGN KEY (id_madre) REFERENCES VACA(id_vaca)
);

CREATE TABLE IF NOT EXISTS produccion_leche (
    id_prdccion INT AUTO_INCREMENT PRIMARY KEY,
    id_vaca INT,
    id_lote_prdccion INT,
    fcha DATE NOT NULL,
    litros DECIMAL(5,2) NOT NULL,
    grasa_prcntaje DECIMAL(4,2),
    solidos_totales_prcntaje DECIMAL(4,2),
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca)
);

CREATE TABLE IF NOT EXISTS LOTE_PRODUCCION (
    id_lote INT AUTO_INCREMENT PRIMARY KEY,
    nombre_lote VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS INSUMO (
    id_insumo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    unidad_medida VARCHAR(20) NOT NULL,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS PROVEEDOR (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    ruc VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT
);

CREATE TABLE IF NOT EXISTS COMPRA_INSUMO (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    fcha DATE NOT NULL,
    costo_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);

CREATE TABLE IF NOT EXISTS CLIENTE (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    ruc VARCHAR(20) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT
);

CREATE TABLE IF NOT EXISTS VENTA_LECHE (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fcha DATE NOT NULL,
    total_venta DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE IF NOT EXISTS HISTORIAL_CORRAL (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_vaca INT,
    id_corral INT,
    fecha_cambio DATE NOT NULL,
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca),
    FOREIGN KEY (id_corral) REFERENCES CORRAL(id_corral)
);

CREATE TABLE IF NOT EXISTS EVENTO_SANITARIO (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_vaca INT,
    detalle TEXT,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca)
);

INSERT INTO ROL (id_rol, nombre_rol) VALUES 
(1, 'Administrador'), (2, 'Supervisor'), (3, 'Cajero'), (4, 'Vendedor'), (5, 'Almacenero')
ON DUPLICATE KEY UPDATE nombre_rol = VALUES(nombre_rol);

INSERT INTO EMPLEADO (id_empleado, nombre, apellido, cargo, fcha_contrato, salario_base, nmero_tlfono, activo) VALUES
(1, 'Juan',   'Pérez',     'Administrador', '2023-01-15', 2500.00, '987654321', 1),
(2, 'María',  'Gómez',     'Cajera',        '2023-03-10', 1800.00, '986123456', 1),
(3, 'Carlos', 'Ramírez',   'Supervisor',    '2022-11-05', 3200.00, '985741236', 1),
(4, 'Ana',    'Torres',    'Vendedora',     '2024-02-20', 1700.00, '984852963', 1),
(5, 'Luis',   'Fernández', 'Almacenero',    '2023-07-12', 1600.00, '983369258', 0)
ON DUPLICATE KEY UPDATE nombre = VALUES(nombre), apellido = VALUES(apellido), cargo = VALUES(cargo), salario_base = VALUES(salario_base), activo = VALUES(activo);

INSERT INTO CORRAL (id_corral, nombre, capacidad, descripcion) VALUES
(1, 'Corral A', 20, 'Vacas en producción'),
(2, 'Corral B', 15, 'Vacas secas'),
(3, 'Corral C', 10, 'Terneras'),
(4, 'Corral D', 25, 'Vacas gestantes'),
(5, 'Corral E', 12, 'Cuarentena')
ON DUPLICATE KEY UPDATE capacidad = VALUES(capacidad), descripcion = VALUES(descripcion);

INSERT INTO VACA (id_vaca, arete, fecha_nacimiento, estado, fecha_ingreso, id_madre) VALUES
(1, 'A001', '2020-03-10', 'Activa', '2021-01-05', NULL),
(2, 'A002', '2019-07-22', 'Activa', '2020-02-10', NULL),
(3, 'A003', '2021-05-15', 'Gestante', '2022-01-20', 1),
(4, 'A004', '2018-11-30', 'Seca', '2019-06-15', 2),
(5, 'A005', '2022-08-01', 'Ternera', '2022-08-01', 1)
ON DUPLICATE KEY UPDATE arete = VALUES(arete), estado = VALUES(estado), id_madre = VALUES(id_madre);

INSERT INTO LOTE_PRODUCCION (id_lote, nombre_lote, fecha_inicio, fecha_fin) VALUES
(1, 'Lote Enero 2026', '2026-01-01', '2026-01-31'),
(2, 'Lote Febrero 2026', '2026-02-01', '2026-02-28'),
(3, 'Lote Marzo 2026', '2026-03-01', '2026-03-31'),
(4, 'Lote Abril 2026', '2026-04-01', '2026-04-30'),
(5, 'Lote Mayo 2026', '2026-05-01', '2026-05-31')
ON DUPLICATE KEY UPDATE fecha_inicio = VALUES(fecha_inicio), fecha_fin = VALUES(fecha_fin);

INSERT INTO INSUMO (id_insumo, nombre, unidad_medida, stock_actual, stock_minimo, precio_unitario) VALUES
(1, 'Antibiótico', 'frasco', 50, 10, 25.00),
(2, 'Vitamina ADE', 'litro', 30, 5, 40.00),
(3, 'Desparasitante', 'dosis', 80, 20, 15.00),
(4, 'Vacuna Fiebre', 'dosis', 60, 15, 12.00),
(5, 'Sal mineralizada', 'kg', 200, 50, 3.00)
ON DUPLICATE KEY UPDATE stock_actual = VALUES(stock_actual), precio_unitario = VALUES(precio_unitario);

INSERT INTO PROVEEDOR (id_proveedor, nombre, ruc, telefono, direccion) VALUES
(1, 'Distribuidora Andina', '20123456789', '987654321', 'Av. Perú 123'),
(2, 'Comercial Lima SAC', '20456789123', '986123456', 'Jr. Arequipa 456'),
(3, 'Insumos del Norte', '20567891234', '985741236', 'Calle Los Olivos 789'),
(4, 'Tech Supplies SAC', '20678912345', '984852963', 'Av. Primavera 321'),
(5, 'Global Market', '20789123456', '983369258', 'Jr. Unión 654')
ON DUPLICATE KEY UPDATE telefono = VALUES(telefono), direccion = VALUES(direccion);

INSERT INTO CLIENTE (id_cliente, nombre, ruc, telefono, direccion) VALUES
(1, 'Lácteos del Sur SAC', '20111222333', '987111222', 'Av. Industrial 100'),
(2, 'Quesos Andinos EIRL', '20222333444', '986222333', 'Jr. Comercio 200'),
(3, 'Distribuidora Fresca', '20333444555', '985333444', 'Calle Nueva 300'),
(4, 'Yogurt Express SAC', '20444555666', '984444555', 'Av. Los Pinos 400'),
(5, 'Mercado Central', '20555666777', '983555666', 'Plaza Mayor 500')
ON DUPLICATE KEY UPDATE telefono = VALUES(telefono), direccion = VALUES(direccion);

SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE produccion_leche ADD INDEX IF NOT EXISTS idx_prod_vaca (id_vaca);
ALTER TABLE produccion_leche ADD INDEX IF NOT EXISTS idx_prod_lote (id_lote_prdccion);
ALTER TABLE VENTA_LECHE ADD INDEX IF NOT EXISTS idx_ventas_fecha (fcha);
ALTER TABLE COMPRA_INSUMO ADD INDEX IF NOT EXISTS idx_compras_fecha (fcha);
ALTER TABLE ASISTENCIA ADD INDEX IF NOT EXISTS idx_asistencia_emp (id_empleado);

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
