USE establo;
 
DELIMITER $$

DROP PROCEDURE IF EXISTS sp_alta_empleado_completo $$
CREATE PROCEDURE sp_alta_empleado_completo (
    IN p_nombre          VARCHAR(100),
    IN p_apellido        VARCHAR(100),
    IN p_cargo           VARCHAR(100),
    IN p_fecha_contrato  DATE,
    IN p_salario_base    DECIMAL(10,2),
    IN p_telefono        VARCHAR(20),
    IN p_nombre_usuario  VARCHAR(50),
    IN p_password_hash   VARCHAR(225),
    IN p_id_rol          INT
)
BEGIN
    DECLARE v_id_empleado INT;
    DECLARE v_id_usuario  INT;
 
    INSERT INTO EMPLEADO (nombre, apellido, cargo, fecha_contrato, salario_base, telefono, activo)
    VALUES (p_nombre, p_apellido, p_cargo, p_fecha_contrato, p_salario_base, p_telefono, TRUE);
 
    SET v_id_empleado = LAST_INSERT_ID();
 
    INSERT INTO USUARIO (id_empleado, nombre_usuario, password_hash, activo)
    VALUES (v_id_empleado, p_nombre_usuario, p_password_hash, TRUE);
 
    SET v_id_usuario = LAST_INSERT_ID();
 
    INSERT INTO USUARIO_ROL (id_usuario, id_rol)
    VALUES (v_id_usuario, p_id_rol);
 
    SELECT v_id_empleado AS id_empleado, v_id_usuario AS id_usuario;
END $$

DROP PROCEDURE IF EXISTS sp_trasladar_vaca $$
CREATE PROCEDURE sp_trasladar_vaca (
    IN p_id_vaca         INT,
    IN p_id_corral_nuevo INT,
    IN p_motivo          VARCHAR(225)
)
BEGIN
    UPDATE HISTORIAL_CORRAL
       SET fecha_salida = CURDATE()
     WHERE id_vaca = p_id_vaca
       AND fecha_salida IS NULL;
 
    INSERT INTO HISTORIAL_CORRAL (id_vaca, id_corral, fecha_entrada, motivo)
    VALUES (p_id_vaca, p_id_corral_nuevo, CURDATE(), p_motivo);
 
    UPDATE VACA
       SET estado = 'ACTIVA'
     WHERE id_vaca = p_id_vaca;
END $$

DROP PROCEDURE IF EXISTS sp_registrar_compra_insumo $$
CREATE PROCEDURE sp_registrar_compra_insumo (
    IN p_id_insumo      INT,
    IN p_id_proveedor   INT,
    IN p_fecha_compra   DATE,
    IN p_cantidad       DECIMAL(10,2),
    IN p_costo_total    DECIMAL(10,2),
    IN p_factura_numero VARCHAR(50)
)
BEGIN
    DECLARE v_existe_proveedor INT;
 
    SELECT COUNT(*) INTO v_existe_proveedor
    FROM PROVEEDOR WHERE id_proveedor = p_id_proveedor;
 
    IF v_existe_proveedor = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El proveedor indicado no existe.';
    END IF;
 
    INSERT INTO COMPRA_INSUMO (id_insumo, id_proveedor, fecha_compra, cantidad, costo_total, factura_numero)
    VALUES (p_id_insumo, p_id_proveedor, p_fecha_compra, p_cantidad, p_costo_total, p_factura_numero);
 
    UPDATE INSUMO
       SET stock_actual = stock_actual + p_cantidad,
           precio_unitario = ROUND(p_costo_total / p_cantidad, 2)
     WHERE id_insumo = p_id_insumo;
END $$

DROP PROCEDURE IF EXISTS sp_registrar_evento_sanitario $$
CREATE PROCEDURE sp_registrar_evento_sanitario (
    IN p_id_vaca        INT,
    IN p_id_veterinario INT,
    IN p_id_insumo      INT,
    IN p_cantidad_usada DECIMAL(10,2),
    IN p_costo          DECIMAL(10,2),
    IN p_tipo_evento    VARCHAR(100),
    IN p_descripcion    TEXT,
    IN p_fecha          DATE
)
BEGIN
    DECLARE v_stock_disponible DECIMAL(10,2);
 
    SELECT stock_actual INTO v_stock_disponible
    FROM INSUMO WHERE id_insumo = p_id_insumo
    FOR UPDATE;
 
    IF v_stock_disponible < p_cantidad_usada THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock insuficiente del insumo para este evento sanitario.';
    END IF;
 
    INSERT INTO EVENTO_SANITARIO (id_vaca, id_veterinario, id_insumo, costo, tipo_evento, descripcion, fecha)
    VALUES (p_id_vaca, p_id_veterinario, p_id_insumo, p_costo, p_tipo_evento, p_descripcion, p_fecha);
 
    UPDATE INSUMO
       SET stock_actual = stock_actual - p_cantidad_usada
     WHERE id_insumo = p_id_insumo;
END $$
 
 
DROP PROCEDURE IF EXISTS sp_dar_baja_vaca $$
CREATE PROCEDURE sp_dar_baja_vaca (
    IN p_id_vaca      INT,
    IN p_nuevo_estado VARCHAR(50),  -- 'VENDIDA' o 'MUERTA'
    IN p_fecha_baja   DATE
)
BEGIN
    IF p_nuevo_estado NOT IN ('VENDIDA','MUERTA') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Estado de baja inválido. Use VENDIDA o MUERTA.';
    END IF;
 
    UPDATE VACA
       SET estado = p_nuevo_estado,
           fecha_venta_muerte = p_fecha_baja
     WHERE id_vaca = p_id_vaca;
 
    UPDATE HISTORIAL_CORRAL
       SET fecha_salida = p_fecha_baja,
           motivo = CONCAT('Baja de la vaca: ', p_nuevo_estado)
     WHERE id_vaca = p_id_vaca
       AND fecha_salida IS NULL;
END $$

