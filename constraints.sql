USE establo;

ALTER TABLE EMPLEADO
ADD CONSTRAINT chk_salario CHECK (salario_base > 0);

ALTER TABLE VACA
ADD CONSTRAINT chk_estado CHECK (estado IN ('Activa','Gestante','Seca','Ternera','Vendida','Muerta'));

ALTER TABLE CORRAL
ADD CONSTRAINT chk_capacidad CHECK (capacidad > 0);

ALTER TABLE PRODUCCION_LECHE
ADD CONSTRAINT chk_litros CHECK (litros > 0);

ALTER TABLE VENTA_LECHE
ADD CONSTRAINT chk_litros_venta CHECK (litros_vendidos > 0),
ADD CONSTRAINT chk_precio CHECK (precio_por_litro > 0);

ALTER TABLE INSUMO
ADD CONSTRAINT chk_stock CHECK (stock_actual >= 0 AND stock_minimo >= 0);

ALTER TABLE COMPRA_INSUMO
ADD CONSTRAINT chk_compra CHECK (cantidad > 0 AND costo_total > 0);

ALTER TABLE PAGO_EMPLEADO
ADD CONSTRAINT chk_bonos CHECK (bonos >= 0);
