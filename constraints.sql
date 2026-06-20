 USE establo;
 
ALTER TABLE EMPLEADO
    MODIFY nombre         VARCHAR(100) NOT NULL,
    MODIFY apellido       VARCHAR(100) NOT NULL,
    MODIFY fecha_contrato DATE NOT NULL,
    MODIFY salario_base   DECIMAL(10,2) NOT NULL;
 
ALTER TABLE VACA
    MODIFY arete            VARCHAR(50) NOT NULL,
    MODIFY fecha_nacimiento DATE NOT NULL,
    MODIFY estado           VARCHAR(50) NOT NULL;
 
ALTER TABLE CORRAL
    MODIFY capacidad INT NOT NULL;
 
ALTER TABLE LOTE_PRODUCCION
    MODIFY nombre_lote  VARCHAR(100) NOT NULL,
    MODIFY fecha_inicio DATE NOT NULL;
 
ALTER TABLE PRODUCCION_LECHE
    MODIFY fecha  DATE NOT NULL,
    MODIFY litros DECIMAL(5,2) NOT NULL;
 
ALTER TABLE VENTA_LECHE
    MODIFY fecha           DATE NOT NULL,
    MODIFY litros_vendidos DECIMAL(8,2) NOT NULL,
    MODIFY precio_por_litro DECIMAL(6,2) NOT NULL;

ALTER TABLE VACA
    ADD CONSTRAINT uq_vaca_arete UNIQUE (arete);
 
ALTER TABLE ROL
    ADD CONSTRAINT uq_rol_nombre UNIQUE (nombre_rol);
 
ALTER TABLE LOTE_PRODUCCION
    ADD CONSTRAINT uq_lote_nombre UNIQUE (nombre_lote);

 
ALTER TABLE EMPLEADO
    ADD CONSTRAINT ck_empleado_salario CHECK (salario_base > 0);
 
ALTER TABLE VACA
    ADD CONSTRAINT ck_vaca_estado
        CHECK (estado IN ('ACTIVA','SECA','GESTANTE','TERNERA','VENDIDA','MUERTA'));
 
ALTER TABLE CORRAL
    ADD CONSTRAINT ck_corral_capacidad CHECK (capacidad > 0);
 
ALTER TABLE PRODUCCION_LECHE
    ADD CONSTRAINT ck_prod_litros CHECK (litros >= 0),
    ADD CONSTRAINT ck_prod_grasa CHECK (grasa_porcentaje BETWEEN 0 AND 100),
    ADD CONSTRAINT ck_prod_solidos CHECK (solidos_totales_porcentaje BETWEEN 0 AND 100);
 
ALTER TABLE VENTA_LECHE
    ADD CONSTRAINT ck_venta_litros CHECK (litros_vendidos > 0),
    ADD CONSTRAINT ck_venta_precio CHECK (precio_por_litro > 0),
    ADD CONSTRAINT ck_venta_total CHECK (total_venta >= 0);
 
ALTER TABLE INSUMO
    ADD CONSTRAINT ck_insumo_stock CHECK (stock_actual >= 0),
    ADD CONSTRAINT ck_insumo_stock_min CHECK (stock_minimo >= 0),
    ADD CONSTRAINT ck_insumo_precio CHECK (precio_unitario >= 0);
 
ALTER TABLE COMPRA_INSUMO
    ADD CONSTRAINT ck_compra_cantidad CHECK (cantidad > 0),
    ADD CONSTRAINT ck_compra_costo CHECK (costo_total >= 0);
 
ALTER TABLE PAGO_EMPLEADO
    ADD CONSTRAINT ck_pago_monto CHECK (monto_total >= 0),
    ADD CONSTRAINT ck_pago_dias CHECK (dias_trabajados BETWEEN 0 AND 31),
    ADD CONSTRAINT ck_pago_bonos CHECK (bonos >= 0);
 
ALTER TABLE EVENTO_SANITARIO
    ADD CONSTRAINT ck_evento_costo CHECK (costo >= 0);
