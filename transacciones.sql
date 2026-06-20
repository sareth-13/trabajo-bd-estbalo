USE establo;
 
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_tx_registrar_venta_leche $$
CREATE PROCEDURE sp_tx_registrar_venta_leche (
    IN  p_id_lote          INT,
    IN  p_id_cliente       INT,
    IN  p_fecha            DATE,
    IN  p_litros_vendidos  DECIMAL(8,2),
    IN  p_precio_por_litro DECIMAL(6,2),
    OUT p_id_venta_generada INT,
    OUT p_mensaje           VARCHAR(255)
)
proc: BEGIN
    DECLARE v_litros_producidos  DECIMAL(10,2);
    DECLARE v_litros_ya_vendidos DECIMAL(10,2);
    DECLARE v_litros_disponibles DECIMAL(10,2);
    DECLARE v_existe_cliente     INT;
 
DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_id_venta_generada = NULL;
        SET p_mensaje = 'ERROR: la transacción fue revertida (ROLLBACK).';
    END;
 
    START TRANSACTION;
 
    SELECT COUNT(*) INTO v_existe_cliente
    FROM CLIENTE WHERE id_cliente = p_id_cliente;
 
    IF v_existe_cliente = 0 THEN
        ROLLBACK;
        SET p_id_venta_generada = NULL;
        SET p_mensaje = 'ERROR: el cliente indicado no existe.';
        LEAVE proc;
    END IF;
 
    -- Bloquea las filas de producción de ese lote para evitar condiciones
    -- de carrera si dos ventas se procesan al mismo tiempo
    SELECT IFNULL(SUM(litros), 0) INTO v_litros_producidos
    FROM PRODUCCION_LECHE WHERE id_lote = p_id_lote
    FOR UPDATE;
 
    SELECT IFNULL(SUM(litros_vendidos), 0) INTO v_litros_ya_vendidos
    FROM VENTA_LECHE WHERE id_lote = p_id_lote
    FOR UPDATE;
 
    SET v_litros_disponibles = v_litros_producidos - v_litros_ya_vendidos;
 
    IF p_litros_vendidos > v_litros_disponibles THEN
        ROLLBACK;
        SET p_id_venta_generada = NULL;
        SET p_mensaje = CONCAT('ERROR: solo hay ', v_litros_disponibles, ' L disponibles en el lote.');
        LEAVE proc;
    END IF;
 
    INSERT INTO VENTA_LECHE (id_lote, id_cliente, fecha, litros_vendidos, precio_por_litro, total_venta)
    VALUES (p_id_lote, p_id_cliente, p_fecha, p_litros_vendidos, p_precio_por_litro,
            ROUND(p_litros_vendidos * p_precio_por_litro, 2));
 
    SET p_id_venta_generada = LAST_INSERT_ID();
 
    COMMIT;
    SET p_mensaje = 'OK: venta registrada correctamente.';
END $$
