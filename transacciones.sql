USE establo;
DELIMITER $$
CREATE PROCEDURE trasladar_vaca_transaccion(
    IN p_id_vaca         INT,
    IN p_id_corral_nuevo INT,
    IN p_fecha           DATE,
    IN p_motivo          VARCHAR(225),
    IN p_nuevo_estado    VARCHAR(50)
)
BEGIN
    DECLARE v_capacidad INT;
    DECLARE v_ocupacion INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error en el traslado: transacción revertida';
    END;
    START TRANSACTION;
        SELECT capacidad INTO v_capacidad
        FROM   CORRAL WHERE id_corral = p_id_corral_nuevo FOR SHARE;
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

    COMMIT;

    SELECT 'Traslado completado exitosamente' AS resultado;
END$$

CREATE PROCEDURE venta_leche_transaccion(
    IN p_id_lote          INT,
    IN p_fecha            DATE,
    IN p_litros_vendidos  DECIMAL(8,2),
    IN p_precio_por_litro DECIMAL(6,2),
    IN p_comprador        VARCHAR(100)
)
BEGIN
    DECLARE v_total DECIMAL(10,2);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error en la venta: transacción revertida';
    END;

    START TRANSACTION;

        IF NOT EXISTS (
            SELECT 1 FROM LOTE_PRODUCCION
            WHERE  id_lote  = p_id_lote
              AND  fecha_fin IS NOT NULL
        ) THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'El lote no existe o aún está abierto';
        END IF;

        SET v_total = p_litros_vendidos * p_precio_por_litro;

        INSERT INTO VENTA_LECHE
            (id_lote_prdccion, fcha, litros_vendidos,
             precio_por_litro, total_venta, comprador)
        VALUES
            (p_id_lote, p_fecha, p_litros_vendidos,
             p_precio_por_litro, v_total, p_comprador);

    COMMIT;

    SELECT CONCAT('Venta registrada. Total: S/ ', v_total) AS resultado;
END$$

DELIMITER ;
