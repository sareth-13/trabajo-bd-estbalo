INSERT INTO ROL (id_rol, nombre_rol)
VALUES
(1, 'Administrador'),
(2, 'Supervisor'),
(3, 'Cajero'),
(4, 'Vendedor'),
(5, 'Almacenero');

INSERT INTO USUARIO_ROL (id_usuario,id_rol)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO USUARIO 
(id_usuario, id_empleado, nmbre_usuario, pasword_hash, activo)
VALUES
(1, 1, 'jperez', 'hash123', 1),
(2, 2, 'mgomez', 'hash456', 1),
(3, 3, 'cramirez', 'hash789', 1),
(4, 4, 'atorres', 'hash321', 1),
(5, 5, 'lfernandez', 'hash654', 0);

INSERT INTO EMPLEADO (id_empleado, nombre, apellido, cargo, fcha_contrato, salario_base, nmero, tlfono, activo)
VALUES
(1, 'Juan', 'Pérez', 'Administrador', '2023-01-15', 2500.00, '101', '987654321', 1),
(2, 'María', 'Gómez', 'Cajera', '2023-03-10', 1800.00, '102', '986123456', 1),
(3, 'Carlos', 'Ramírez', 'Supervisor', '2022-11-05', 3200.00, '103', '985741236', 1),
(4, 'Ana', 'Torres', 'Vendedora', '2024-02-20', 1700.00, '104', '984852963', 1),
(5, 'Luis', 'Fernández', 'Almacenero', '2023-07-12', 1600.00, '105', '983369258', 0);

INSERT INTO ASISTENCIA (id_asistencia,id_e,pleado,fcha,presente)
VALUES
(1, 1, '2026-05-18', 1),
(2, 2, '2026-05-18', 1),
(3, 3, '2026-05-18', 0),
(4, 4, '2026-05-18', 1),
(5, 5, '2026-05-18', 1);

INSERT INTO PAGO_EMPLEADO (id_pago,id_empleado,mes,monto_total,fcha_pago,dias_trabajo,bonos)
VALUES
(1, 1, '2026-04', 2700.00, '2026-05-01', 26, 200.00),
(2, 2, '2026-04', 1900.00, '2026-05-01', 25, 100.00),
(3, 3, '2026-04', 3500.00, '2026-05-01', 27, 300.00),
(4, 4, '2026-04', 1800.00, '2026-05-01', 24, 100.00),
(5, 5, '2026-04', 1600.00, '2026-05-01', 22, 0.00);
