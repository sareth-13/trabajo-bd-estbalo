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
