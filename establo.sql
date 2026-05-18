CREATE DATABASE establo;
USE establo;

CREATE TABLE USUARIO(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
id_empleado INT,
nmbre_usuaio VARCHAR(50) UNIQUE NOT NULL,
password_hash VARCHAR(225),
activo BOOLEAN DEfAULT TRUE,
FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
);

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

CREATE TABLE HISTORIAL_CORRAL(
id_hstrial_crral INT PRIMARY KEY AUTO_INCREMENT,
id_vaca INT,
id_corral INT,
fcha_entrda DATE,
fcha_slida DATE,
motivo VARCHAR(225),
FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca),
FOREIGN KEY (id_corral) REFERENCES CORRAL(id_corral)
);

CREATE TABLE CORRAL (
id_corral INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
capacidad INT,
descripción TEXT
);

CREATE TABLE PRODUCCION_LECHE(
id_prdccion INT PRIMARY KEY AUTO_INCREMENT,
id_vaca INT,
id_lote_prdccion INT,
fcha DATE,
litros DECIMAL(5,2),
grasa_prcntaje DECIMAL (5,2),
solidos_totales_prcntaje DECIMAL (5,2),
turno ENUM ('MAÑANA','TARDE','NOCHE'),
FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca),
FOREIGN KEY (id_lote_prdccion) REFERENCES LOTE_PRODUCCION(id_lote_prdccion)
);

CREATE TABLE VENTA_LECHE(
id_venta INT PRIMARY KEY AUTO_INCREMENT,
id_lote_prdccion INT,
fcha DATE,
litros_vendidos DECIMAL(8,2),
precio_por_litro DECIMAL(6,2),
total_venta DECIMAL(10,2),
comprador VARCHAR(100),
FOREIGN KEY(id_lote_prdccion) REFERENCES LOTE_PRODUCCION(id_lote_prdccion)
);
