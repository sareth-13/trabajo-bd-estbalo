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
       SET estado = 'Activa'
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
    IF p_nuevo_estado NOT IN ('Vendida','Muerta') THEN
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

DROP PROCEDURE IF EXISTS sp_procesar_pago_empleado $$
CREATE PROCEDURE sp_procesar_pago_empleado (
    IN p_id_empleado INT,
    IN p_mes         VARCHAR(20),   
    IN p_fecha_pago  DATE,
    IN p_bonos       DECIMAL(10,2)
)
BEGIN
    DECLARE v_salario_base    DECIMAL(10,2);
    DECLARE v_dias_trabajados INT;
    DECLARE v_monto_total     DECIMAL(10,2);
 
    SELECT salario_base INTO v_salario_base
    FROM EMPLEADO WHERE id_empleado = p_id_empleado;
 
    SELECT COUNT(*) INTO v_dias_trabajados
    FROM ASISTENCIA
    WHERE id_empleado = p_id_empleado
      AND presente = TRUE
      AND DATE_FORMAT(fecha, '%Y-%m') = p_mes;
 
    SET v_monto_total = ROUND((v_salario_base / 30) * v_dias_trabajados + p_bonos, 2);
 
    INSERT INTO PAGO_EMPLEADO (id_empleado, mes, monto_total, fecha_pago, dias_trabajados, bonos)
    VALUES (p_id_empleado, p_mes, v_monto_total, p_fecha_pago, v_dias_trabajados, p_bonos);
 
    SELECT v_dias_trabajados AS dias_trabajados, v_monto_total AS monto_total;
END $$

DROP PROCEDURE IF EXISTS sp_registrar_venta_leche $$
CREATE PROCEDURE sp_registrar_venta_leche (
    IN p_id_lote          INT,
    IN p_id_cliente       INT,
    IN p_fecha            DATE,
    IN p_litros_vendidos  DECIMAL(8,2),
    IN p_precio_por_litro DECIMAL(6,2)
)
BEGIN
    DECLARE v_litros_producidos DECIMAL(10,2);
    DECLARE v_litros_ya_vendidos DECIMAL(10,2);
    DECLARE v_litros_disponibles DECIMAL(10,2);
 
    SELECT IFNULL(SUM(litros), 0) INTO v_litros_producidos
    FROM PRODUCCION_LECHE WHERE id_lote = p_id_lote;
 
    SELECT IFNULL(SUM(litros_vendidos), 0) INTO v_litros_ya_vendidos
    FROM VENTA_LECHE WHERE id_lote = p_id_lote;
 
    SET v_litros_disponibles = v_litros_producidos - v_litros_ya_vendidos;
 
    IF p_litros_vendidos > v_litros_disponibles THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No hay suficiente leche disponible en ese lote.';
    END IF;
 
    INSERT INTO VENTA_LECHE (id_lote, id_cliente, fecha, litros_vendidos, precio_por_litro, total_venta)
    VALUES (p_id_lote, p_id_cliente, p_fecha, p_litros_vendidos, p_precio_por_litro,
            ROUND(p_litros_vendidos * p_precio_por_litro, 2));
END $$
 
DELIMITER ;
