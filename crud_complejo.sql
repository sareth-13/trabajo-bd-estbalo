USE establo;
 
DELIMITER $$
 
CREATE PROCEDURE registrar_produccion_y_actualizar_lote(
    IN p_id_vaca  INT,
    IN p_id_lote  INT,
    IN p_fecha    DATE,
    IN p_litros   DECIMAL(5,2),
    IN p_grasa    DECIMAL(5,2),
    IN p_solidos  DECIMAL(5,2),
    IN p_turno    ENUM('MAÑANA','TARDE','NOCHE')
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM VACA WHERE id_vaca = p_id_vaca AND estado = 'Activa') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La vaca no existe o no está en estado Activa';
    END IF;
 
    IF NOT EXISTS (SELECT 1 FROM LOTE_PRODUCCION WHERE id_lote = p_id_lote) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El lote de producción no existe';
    END IF;
 
    INSERT INTO PRODUCCION_LECHE
        (id_vaca, id_lote_prdccion, fcha, litros, grasa_prcntaje, solidos_totales_prcntaje, turno)
    VALUES
        (p_id_vaca, p_id_lote, p_fecha, p_litros, p_grasa, p_solidos, p_turno);
 
    UPDATE LOTE_PRODUCCION
    SET    fecha_fin = p_fecha
    WHERE  id_lote   = p_id_lote
      AND  (fecha_fin IS NULL OR p_fecha > fecha_fin);
 
    SELECT 'Producción registrada correctamente' AS resultado;
END$$
 
 
CREATE PROCEDURE registrar_evento_sanitario_con_descuento_stock(
    IN p_id_vaca        INT,
    IN p_id_insumo      INT,
    IN p_tipo_evento    VARCHAR(100),
    IN p_descripcion    TEXT,
    IN p_fecha          DATE,
    IN p_costo          DECIMAL(10,2),
    IN p_cantidad_usada DECIMAL(10,2)
)
BEGIN
    DECLARE v_stock_actual DECIMAL(10,2);
    DECLARE v_stock_minimo DECIMAL(10,2);
 
    SELECT stock_actual, stock_minimo
    INTO   v_stock_actual, v_stock_minimo
    FROM   INSUMO
    WHERE  id_insumo = p_id_insumo;
 
    IF v_stock_actual < p_cantidad_usada THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock insuficiente para el insumo seleccionado';
    END IF;
CREATE PROCEDURE registrar_compra_insumo_y_actualizar_stock(
    IN p_id_insumo    INT,
    IN p_id_proveedor INT,
    IN p_fecha_compra DATE,
    IN p_cantidad     DECIMAL(10,2),
    IN p_costo_total  DECIMAL(10,2),
    IN p_factura      VARCHAR(50)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM PROVEEDOR WHERE id_proveedor = p_id_proveedor) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El proveedor no existe';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM INSUMO WHERE id_insumo = p_id_insumo) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El insumo no existe';
    END IF;

    INSERT INTO COMPRA_INSUMO
        (id_insumo, id_proveedor, fecha_compra, cantidad, costo_total, factura_numero)
    VALUES
        (p_id_insumo, p_id_proveedor, p_fecha_compra, p_cantidad, p_costo_total, p_factura);

    UPDATE INSUMO
    SET    stock_actual = stock_actual + p_cantidad
    WHERE  id_insumo    = p_id_insumo;

    SELECT 'Compra registrada y stock actualizado correctamente' AS resultado;
END$$


CREATE PROCEDURE trasladar_vaca_de_corral(
    IN p_id_vaca         INT,
    IN p_id_corral_nuevo INT,
    IN p_fecha           DATE,
    IN p_motivo          VARCHAR(225),
    IN p_nuevo_estado    VARCHAR(50)
)
BEGIN
    DECLARE v_capacidad INT;
    DECLARE v_ocupacion INT;

    SELECT capacidad INTO v_capacidad
    FROM   CORRAL WHERE id_corral = p_id_corral_nuevo;

    SELECT COUNT(*) INTO v_ocupacion
    FROM   HISTORIAL_CORRAL
    WHERE  id_corral  = p_id_corral_nuevo
      AND  fcha_slida IS NULL;

    IF v_ocupacion >= v_capacidad THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El corral destino no tiene capacidad disponible';
    END IF;

    UPDATE HISTORIAL_CORRAL
    SET    fcha_slida = p_fecha
    WHERE  id_vaca    = p_id_vaca
      AND  fcha_slida IS NULL;

    INSERT INTO HISTORIAL_CORRAL
        (id_vaca, id_corral, fcha_entrda, fcha_slida, motivo)
    VALUES
        (p_id_vaca, p_id_corral_nuevo, p_fecha, NULL, p_motivo);

    IF p_nuevo_estado IS NOT NULL THEN
        UPDATE VACA
        SET    estado = p_nuevo_estado
        WHERE  id_vaca = p_id_vaca;
    END IF;

    SELECT 'Traslado registrado correctamente' AS resultado;
END$$

