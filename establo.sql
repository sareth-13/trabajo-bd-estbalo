
CREATE TABLE EMPLEADO (
    id_empleado    INT PRIMARY KEY AUTO_INCREMENT,
    nombre         VARCHAR(100),
    apellido       VARCHAR(100),
    cargo          VARCHAR(100),
    fecha_contrato DATE,
    salario_base   DECIMAL(10,2),
    telefono       VARCHAR(20),
    activo         BOOLEAN DEFAULT TRUE
);
 
CREATE TABLE USUARIO (
    id_usuario     INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado    INT,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    password_hash  VARCHAR(225),
    activo         BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_usuario_empleado
        FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);
 
CREATE TABLE ROL (
    id_rol     INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(100) NOT NULL
);
 
CREATE TABLE USUARIO_ROL (
    id_usuario INT,
    id_rol     INT,
    PRIMARY KEY (id_usuario, id_rol),
    CONSTRAINT fk_usuariorol_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    CONSTRAINT fk_usuariorol_rol
        FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
);
 
CREATE TABLE ASISTENCIA (
    id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado   INT,
    fecha         DATE NOT NULL,
    presente      BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_asistencia_empleado
        FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);
 
CREATE TABLE PAGO_EMPLEADO (
    id_pago         INT PRIMARY KEY AUTO_INCREMENT,
    id_empleado     INT,
    mes             VARCHAR(20) NOT NULL,
    monto_total     DECIMAL(10,2) NOT NULL,
    fecha_pago      DATE NOT NULL,
    dias_trabajados INT,
    bonos           DECIMAL(10,2) DEFAULT 0.00,
    CONSTRAINT fk_pago_empleado
        FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);
CREATE TABLE CORRAL (
    id_corral   INT PRIMARY KEY AUTO_INCREMENT,
    nombre      VARCHAR(50) NOT NULL,
    capacidad   INT,
    descripcion TEXT
);
 
CREATE TABLE VACA (
    id_vaca           INT PRIMARY KEY AUTO_INCREMENT,
    arete             VARCHAR(50),
    fecha_nacimiento  DATE,
    estado            VARCHAR(50),
    fecha_ingreso     DATE,
    fecha_venta_muerte DATE,
    id_madre          INT,
    CONSTRAINT fk_vaca_madre
        FOREIGN KEY (id_madre) REFERENCES VACA(id_vaca)
);
 
CREATE TABLE HISTORIAL_CORRAL (
    id_historial INT PRIMARY KEY AUTO_INCREMENT,
    id_vaca      INT,
    id_corral    INT,
    fecha_entrada DATE,
    fecha_salida  DATE,
    motivo       VARCHAR(225),
    CONSTRAINT fk_historial_vaca
        FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca),
    CONSTRAINT fk_historial_corral
        FOREIGN KEY (id_corral) REFERENCES CORRAL(id_corral)
);
