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
