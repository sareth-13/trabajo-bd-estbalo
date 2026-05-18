CREATE DATABASE establo;
USE establo;

-- PARTE 1: Sareth 

CREATE TABLE EMPLEADO(
id_empleado INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100),
apellido VARCHAR(100), 
cargo VARCHAR(100),
fcha_contrato DATE,
salario_base DECIMAL(10,2),
nmero_tlfono VARCHAR(20),
activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE USUARIO(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
id_empleado INT,
nmbre_usuaio VARCHAR(50) UNIQUE NOT NULL,
password_hash VARCHAR(225),
activo BOOLEAN DEFAULT TRUE,
FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

CREATE TABLE CORRAL (
id_corral INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
capacidad INT,
descripción TEXT
);

CREATE TABLE HISTORIAL_CORRAL(
id_hstrial_crral INT PRIMARY KEY AUTO_INCREMENT,
id_vaca INT,
id_corral INT,
fcha_entrda DATE,
fcha_slida DATE,
motivo VARCHAR(225),
-- NOTA: Joaquín debe descomentar la línea de abajo al crear VACA:
-- FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca),
FOREIGN KEY (id_corral) REFERENCES CORRAL(id_corral)
);

CREATE TABLE PRODUCCION_LECHE(
id_prdccion INT PRIMARY KEY AUTO_INCREMENT,
id_vaca INT,
id_lote_prdccion INT,
fcha DATE,
litros DECIMAL(5,2),
grasa_prcntaje DECIMAL (5,2),
solidos_totales_prcntaje DECIMAL (5,2),
turno ENUM ('MAÑANA','TARDE','NOCHE')
-- NOTA: Joaquín debe descomentar las líneas de abajo al crear VACA y LOTE_PRODUCCION:
-- FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca),
-- FOREIGN KEY (id_lote_prdccion) REFERENCES LOTE_PRODUCCION(id_lote_prdccion)
);

CREATE TABLE VENTA_LECHE(
id_venta INT PRIMARY KEY AUTO_INCREMENT,
id_lote_prdccion INT,
fcha DATE,
litros_vendidos DECIMAL(8,2),
precio_por_litro DECIMAL(6,2),
total_venta DECIMAL(10,2),
comprador VARCHAR(100)
-- NOTA: Joaquín debe descomentar la línea de abajo al crear LOTE_PRODUCCION:
-- FOREIGN KEY(id_lote_prdccion) REFERENCES LOTE_PRODUCCION(id_lote_prdccion)
);

-- PARTE 2: Luis (PAGOS, INSUMOS, CLIENTES, ETC.)

CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    ruc VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    direccion VARCHAR(255)
);

CREATE TABLE INSUMO (
    id_insumo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    unidad_medida VARCHAR(20),
    stock_actual DECIMAL(10,2) DEFAULT 0.00,
    stock_minimo DECIMAL(10,2) DEFAULT 0.00,
    precio_unitario DECIMAL(10,2)
);

CREATE TABLE COMPRA_INSUMO (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_insumo INT,
    id_proveedor INT, 
    fecha_compra DATE NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    costo_total DECIMAL(10,2) NOT NULL,
    factura_numero VARCHAR(50),
    FOREIGN KEY (id_insumo) REFERENCES INSUMO(id_insumo)
    -- NOTA: Joaquín debe descomentar la línea de abajo al crear PROVEEDOR:
    -- FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);

CREATE TABLE PAGO_EMPLEADO (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado INT,
    mes VARCHAR(20) NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    fecha_pago DATE NOT NULL,
    dias_trabajados INT,
    bonos DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

CREATE TABLE USUARIO_ROL (
    id_usuario INT,
    id_rol INT, 
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
    -- NOTA: Joaquín debe descomentar la línea de abajo al crear ROL:
    -- FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
);

CREATE TABLE EVENTO_SANITARIO (
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    id_vaca INT, 
    id_veterinario INT, 
    id_insumo INT, 
    costo DECIMAL(10,2),
    tipo_evento VARCHAR(100),
    descripcion TEXT,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_insumo) REFERENCES INSUMO(id_insumo)
    -- NOTA: Joaquín debe descomentar la línea de abajo al crear VACA:
    -- FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca)
);
