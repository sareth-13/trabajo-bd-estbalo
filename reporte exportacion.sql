USE establo;

SELECT 
    v.id_venta AS 'CODIGO VENTA',
    DATE_FORMAT(v.fcha, '%d/%m/%Y') AS 'FECHA EMISION',
    c.nombre AS 'CLIENTE',
    c.ruc AS 'RUC CLIENTE',
    c.telefono AS 'TELEFONO',
    v.total_venta AS 'MONTO TOTAL (PEN)'
FROM VENTA_LECHE v
INNER JOIN CLIENTE c ON v.id_cliente = c.id_cliente
ORDER BY v.fcha DESC;
