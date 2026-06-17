CREATE DATABASE IF NOT EXISTS establo;
USE establo;

-- =========================
-- TABLAS PRINCIPALES
-- =========================

CREATE TABLE EMPLEADO(
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    fecha_contrato DATE NOT NULL,
    salario_base DECIMAL(10,2) NOT NULL CHECK (salario_base > 0),
    numero_telefono VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE USUARIO(
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado INT,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(225),
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

CREATE TABLE ROL(
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(100) NOT NULL
);

CREATE TABLE USUARIO_ROL(
    id_usuario INT,
    id_rol INT,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
);

CREATE TABLE VACA(
    id_vaca INT PRIMARY KEY AUTO_INCREMENT,
    arete VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE,
    estado VARCHAR(50),
    fecha_ingreso DATE NOT NULL,
    fecha_venta_muerte DATE,
    id_madre INT,
    FOREIGN KEY (id_madre) REFERENCES VACA(id_vaca) ON DELETE SET NULL
);

CREATE TABLE CORRAL(
    id_corral INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL CHECK (capacidad > 0),
    descripcion TEXT
);

CREATE TABLE HISTORIAL_CORRAL(
    id_historial_corral INT PRIMARY KEY AUTO_INCREMENT,
    id_vaca INT,
    id_corral INT,
    fecha_entrada DATE,
    fecha_salida DATE,
    motivo VARCHAR(225),
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca),
    FOREIGN KEY (id_corral) REFERENCES CORRAL(id_corral)
);

CREATE TABLE LOTE_PRODUCCION(
    id_lote INT PRIMARY KEY AUTO_INCREMENT,
    nombre_lote VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE PRODUCCION_LECHE(
    id_produccion INT PRIMARY KEY AUTO_INCREMENT,
    id_vaca INT,
    id_lote INT,
    fecha DATE NOT NULL,
    litros DECIMAL(5,2) NOT NULL CHECK (litros > 0),
    grasa_porcentaje DECIMAL(5,2),
    solidos_totales_porcentaje DECIMAL(5,2),
    turno ENUM('MAÑANA','TARDE','NOCHE'),
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca),
    FOREIGN KEY (id_lote) REFERENCES LOTE_PRODUCCION(id_lote)
);

CREATE TABLE VENTA_LECHE(
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_lote INT,
    fecha DATE,
    litros_vendidos DECIMAL(8,2) CHECK (litros_vendidos > 0),
    precio_por_litro DECIMAL(6,2) CHECK (precio_por_litro > 0),
    total_venta DECIMAL(10,2),
    comprador VARCHAR(100),
    FOREIGN KEY (id_lote) REFERENCES LOTE_PRODUCCION(id_lote)
);

CREATE TABLE CLIENTE(
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    ruc VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    direccion VARCHAR(255)
);

CREATE TABLE PROVEEDOR(
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150) NOT NULL,
    ruc VARCHAR(20) UNIQUE,
    telefono VARCHAR(20),
    direccion VARCHAR(255)
);

CREATE TABLE INSUMO(
    id_insumo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    unidad_medida VARCHAR(20),
    stock_actual DECIMAL(10,2) DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo DECIMAL(10,2) DEFAULT 0 CHECK (stock_minimo >= 0),
    precio_unitario DECIMAL(10,2) CHECK (precio_unitario > 0)
);

CREATE TABLE COMPRA_INSUMO(
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_insumo INT,
    id_proveedor INT,
    fecha_compra DATE NOT NULL,
    cantidad DECIMAL(10,2) CHECK (cantidad > 0),
    costo_total DECIMAL(10,2) CHECK (costo_total > 0),
    factura_numero VARCHAR(50),
    FOREIGN KEY (id_insumo) REFERENCES INSUMO(id_insumo),
    FOREIGN KEY (id_proveedor) REFERENCES PROVEEDOR(id_proveedor)
);

CREATE TABLE PAGO_EMPLEADO(
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado INT,
    mes VARCHAR(20),
    monto_total DECIMAL(10,2),
    fecha_pago DATE,
    dias_trabajados INT,
    bonos DECIMAL(10,2),
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

CREATE TABLE EVENTO_SANITARIO(
    id_evento INT PRIMARY KEY AUTO_INCREMENT,
    id_vaca INT,
    id_veterinario INT,
    id_insumo INT,
    costo DECIMAL(10,2),
    tipo_evento VARCHAR(100),
    descripcion TEXT,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca),
    FOREIGN KEY (id_insumo) REFERENCES INSUMO(id_insumo)
);

CREATE TABLE ASISTENCIA(
    id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado INT,
    fecha DATE NOT NULL,
    presente BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);
