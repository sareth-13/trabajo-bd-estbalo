USE establo;

CREATE INDEX idx_empleado_nombre
ON EMPLEADO(nombre);

CREATE INDEX idx_empleado_apellido
ON EMPLEADO(apellido);

CREATE INDEX idx_vaca_estado
ON VACA(estado);

CREATE INDEX idx_vaca_fecha_ingreso
ON VACA(fecha_ingreso);

CREATE INDEX idx_corral_capacidad
ON CORRAL(capacidad);

CREATE INDEX idx_produccion_vaca
ON PRODUCCION_LECHE(id_vaca);

CREATE INDEX idx_produccion_lote
ON PRODUCCION_LECHE(id_lote_prdccion);

CREATE INDEX idx_produccion_fecha
ON PRODUCCION_LECHE(fcha);

CREATE INDEX idx_venta_lote
ON VENTA_LECHE(id_lote_prdccion);

CREATE INDEX idx_insumo_nombre
ON INSUMO(nombre);

CREATE INDEX idx_compra_proveedor
ON COMPRA_INSUMO(id_proveedor);

CREATE INDEX idx_compra_insumo
ON COMPRA_INSUMO(id_insumo);

CREATE INDEX idx_pago_empleado
ON PAGO_EMPLEADO(id_empleado);

CREATE INDEX idx_evento_vaca
ON EVENTO_SANITARIO(id_vaca);

CREATE INDEX idx_historial_vaca
ON HISTORIAL_CORRAL(id_vaca);

CREATE INDEX idx_historial_corral
ON HISTORIAL_CORRAL(id_corral);
