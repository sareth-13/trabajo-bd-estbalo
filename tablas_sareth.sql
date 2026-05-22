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
