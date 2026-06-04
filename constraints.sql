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

ALTER TABLE EVENTO_SANITARIO
    MODIFY tipo_evento VARCHAR(100) NOT NULL,
    ADD CONSTRAINT chk_costo_evento CHECK (costo >= 0);

ALTER TABLE USUARIO
    DROP FOREIGN KEY usuario_ibfk_1,
    ADD CONSTRAINT fk_usuario_empleado
        FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id_empleado)
        ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE USUARIO_ROL
    DROP FOREIGN KEY usuario_rol_ibfk_1,
    ADD CONSTRAINT fk_usuariorol_usuario
        FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
        ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE USUARIO_ROL
    DROP FOREIGN KEY usuario_rol_ibfk_2,
    ADD CONSTRAINT fk_usuariorol_rol
        FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
        ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE HISTORIAL_CORRAL
    DROP FOREIGN KEY historial_corral_ibfk_1,
    ADD CONSTRAINT fk_historial_vaca
        FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca)
        ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE HISTORIAL_CORRAL
    DROP FOREIGN KEY historial_corral_ibfk_2,
    ADD CONSTRAINT fk_historial_corral
        FOREIGN KEY (id_corral) REFERENCES CORRAL(id_corral)
        ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PRODUCCION_LECHE
    DROP FOREIGN KEY produccion_leche_ibfk_1,
    ADD CONSTRAINT fk_produccion_vaca
        FOREIGN KEY (id_vaca) REFERENCES VACA(id_vaca)
        ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PRODUCCION_LECHE
    DROP FOREIGN KEY produccion_leche_ibfk_2,
    ADD CONSTRAINT fk_produccion_lote
        FOREIGN KEY (id_lote_prdccion) REFERENCES LOTE_PRODUCCION(id_lote)
        ON DELETE CASCADE ON UPDATE CASCADE;

CREATE PROCEDURE registrar_venta_leche_en_cascada(
    IN p_id_lote          INT,
    IN p_fecha            DATE,
    IN p_litros_vendidos  DECIMAL(8,2),
    IN p_precio_por_litro DECIMAL(6,2),
    IN p_nombre_cliente   VARCHAR(150)
)
BEGIN
    DECLARE v_total DECIMAL(10,2);

    IF NOT EXISTS (
        SELECT 1 FROM LOTE_PRODUCCION
        WHERE id_lote = p_id_lote AND fecha_fin IS NOT NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El lote no existe o aún está abierto';
    END IF;

    SET v_total = p_litros_vendidos * p_precio_por_litro;

    INSERT INTO VENTA_LECHE
        (id_lote_prdccion, fcha, litros_vendidos, precio_por_litro, total_venta, comprador)
    VALUES
        (p_id_lote, p_fecha, p_litros_vendidos, p_precio_por_litro, v_total, p_nombre_cliente);

    SELECT CONCAT('Venta registrada. Total: S/ ', v_total) AS resultado;
END$$

DELIMITER ; 
