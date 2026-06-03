USE establo;
 
ALTER TABLE EMPLEADO
    MODIFY nombre        VARCHAR(100) NOT NULL,
    MODIFY apellido      VARCHAR(100) NOT NULL,
    MODIFY cargo         VARCHAR(100) NOT NULL,
    MODIFY fcha_contrato DATE         NOT NULL,
    MODIFY salario_base  DECIMAL(10,2) NOT NULL,
    ADD CONSTRAINT chk_salario_empleado CHECK (salario_base > 0);
 
ALTER TABLE VACA
    MODIFY arete         VARCHAR(50) NOT NULL,
    MODIFY fecha_ingreso DATE        NOT NULL,
    ADD CONSTRAINT chk_estado_vaca
        CHECK (estado IN ('Activa','Gestante','Seca','Ternera','Vendida','Muerta'));
 
ALTER TABLE CORRAL
    MODIFY nombre    VARCHAR(50) NOT NULL,
    ADD CONSTRAINT chk_capacidad_corral CHECK (capacidad > 0);
 
ALTER TABLE PRODUCCION_LECHE
    MODIFY fcha   DATE         NOT NULL,
    MODIFY litros DECIMAL(5,2) NOT NULL,
    ADD CONSTRAINT chk_litros_positivos CHECK (litros > 0),
    ADD CONSTRAINT chk_grasa_rango      CHECK (grasa_prcntaje BETWEEN 0 AND 100),
    ADD CONSTRAINT chk_solidos_rango    CHECK (solidos_totales_prcntaje BETWEEN 0 AND 100);
 
ALTER TABLE VENTA_LECHE
    MODIFY fcha             DATE         NOT NULL,
    MODIFY litros_vendidos  DECIMAL(8,2) NOT NULL,
    MODIFY precio_por_litro DECIMAL(6,2) NOT NULL,
    ADD CONSTRAINT chk_litros_venta CHECK (litros_vendidos  > 0),
    ADD CONSTRAINT chk_precio_litro CHECK (precio_por_litro > 0),
    ADD CONSTRAINT chk_total_venta  CHECK (total_venta      > 0);
 
ALTER TABLE INSUMO
    MODIFY nombre        VARCHAR(100) NOT NULL,
    MODIFY unidad_medida VARCHAR(20)  NOT NULL,
    ADD CONSTRAINT chk_stock_actual  CHECK (stock_actual    >= 0),
    ADD CONSTRAINT chk_stock_minimo  CHECK (stock_minimo    >= 0),
    ADD CONSTRAINT chk_precio_insumo CHECK (precio_unitario >  0);
 
ALTER TABLE COMPRA_INSUMO
    ADD CONSTRAINT chk_cantidad_compra CHECK (cantidad    > 0),
    ADD CONSTRAINT chk_costo_compra    CHECK (costo_total > 0);
 
ALTER TABLE PAGO_EMPLEADO
    MODIFY mes         VARCHAR(20)   NOT NULL,
    MODIFY monto_total DECIMAL(10,2) NOT NULL,
    MODIFY fecha_pago  DATE          NOT NULL,
    ADD CONSTRAINT chk_dias_trabajados CHECK (dias_trabajados BETWEEN 0 AND 31),
    ADD CONSTRAINT chk_monto_pago      CHECK (monto_total > 0),
    ADD CONSTRAINT chk_bonos           CHECK (bonos >= 0);
