USE establo;

-- =========================
-- EMPLEADO
-- =========================
ALTER TABLE EMPLEADO
    MODIFY nombre VARCHAR(100) NOT NULL,
    MODIFY apellido VARCHAR(100) NOT NULL,
    MODIFY cargo VARCHAR(100) NOT NULL,
    MODIFY fcha_contrato DATE NOT NULL,
    MODIFY salario_base DECIMAL(10,2) NOT NULL,
    MODIFY nmero_tlfono VARCHAR(20),
    MODIFY activo BOOLEAN DEFAULT TRUE;

-- =========================
-- VACA
-- =========================
ALTER TABLE VACA
    MODIFY arete VARCHAR(50) NOT NULL,
    MODIFY fecha_nacimiento DATE,
    MODIFY estado VARCHAR(50),
    MODIFY fecha_ingreso DATE NOT NULL,
    MODIFY fecha_venta_muerte DATE,
    MODIFY id_madre INT;

-- =========================
-- CORRAL
-- =========================
ALTER TABLE CORRAL
    MODIFY nombre VARCHAR(50) NOT NULL,
    MODIFY capacidad INT,
    MODIFY descripcion TEXT;

-- =========================
-- LOTE PRODUCCIÓN
-- =========================
ALTER TABLE LOTE_PRODUCCION
    MODIFY nombre_lote VARCHAR(100),
    MODIFY fecha_inicio DATE,
    MODIFY fecha_fin DATE;

-- =========================
-- INSUMO
-- =========================
ALTER TABLE INSUMO
    MODIFY nombre VARCHAR(100) NOT NULL,
    MODIFY unidad_medida VARCHAR(20),
    MODIFY stock_actual DECIMAL(10,2) DEFAULT 0,
    MODIFY stock_minimo DECIMAL(10,2) DEFAULT 0,
    MODIFY precio_unitario DECIMAL(10,2);

-- =========================
-- CLIENTE
-- =========================
ALTER TABLE CLIENTE
    MODIFY nombre VARCHAR(150) NOT NULL,
    MODIFY ruc VARCHAR(20),
    MODIFY telefono VARCHAR(20),
    MODIFY direccion VARCHAR(255);

-- =========================
-- PROVEEDOR
-- =========================
ALTER TABLE PROVEEDOR
    MODIFY nombre VARCHAR(150) NOT NULL,
    MODIFY ruc VARCHAR(20),
    MODIFY telefono VARCHAR(20),
    MODIFY direccion VARCHAR(255);

-- =========================
-- EVENTO SANITARIO
-- =========================
ALTER TABLE EVENTO_SANITARIO
    MODIFY costo DECIMAL(10,2),
    MODIFY tipo_evento VARCHAR(100),
    MODIFY descripcion TEXT,
    MODIFY fecha DATE NOT NULL;

-- =========================
-- PAGO EMPLEADO
-- =========================
ALTER TABLE PAGO_EMPLEADO
    MODIFY mes VARCHAR(20) NOT NULL,
    MODIFY monto_total DECIMAL(10,2) NOT NULL,
    MODIFY fecha_pago DATE NOT NULL,
    MODIFY dias_trabajados INT,
    MODIFY bonos DECIMAL(10,2);
