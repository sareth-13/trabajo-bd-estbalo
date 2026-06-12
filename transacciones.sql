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

