-- UPDATE 1: Sareth - Aumento de salario a supervisores
UPDATE EMPLEADO
SET salario_base = salario_base * 1.10
WHERE cargo = 'Supervisor';

-- UPDATE 2: Luis - Actualizar stock de insumo
UPDATE INSUMO
SET stock_actual = stock_actual + 50
WHERE id_insumo = 1;

-- UPDATE 3: Joaquín - Cambiar estado de una vaca
UPDATE VACA
SET estado = 'Vendida'
WHERE id_vaca = 4;
