USE establo;

-- =========================
-- VIEW 1: Producción por vaca
-- =========================
CREATE VIEW vw_produccion_vaca AS
SELECT 
    v.id_vaca,
    v.arete,
    p.fcha,
    p.litros,
    p.grasa_prcntaje,
    p.solidos_totales_prcntaje
FROM VACA v
JOIN PRODUCCION_LECHE p ON v.id_vaca = p.id_vaca;

-- =========================
-- VIEW 2: Ventas completas
-- =========================
CREATE VIEW vw_ventas AS
SELECT 
    v.id_venta,
    v.fcha,
    v.litros_vendidos,
    v.precio_por_litro,
    v.total_venta,
    l.nombre_lote
FROM VENTA_LECHE v
JOIN LOTE_PRODUCCION l ON v.id_lote_prdccion = l.id_lote;

-- =========================
-- VIEW 3: Empleados y pagos
-- =========================
CREATE VIEW vw_empleados_pagos AS
SELECT 
    e.id_empleado,
    e.nombre,
    e.apellido,
    p.mes,
    p.monto_total,
    p.bonos
FROM EMPLEADO e
JOIN PAGO_EMPLEADO p ON e.id_empleado = p.id_empleado;

-- =========================
-- VIEW 4: Inventario de insumos
-- =========================
CREATE VIEW vw_insumos AS
SELECT 
    id_insumo,
    nombre,
    stock_actual,
    stock_minimo,
    precio_unitario
FROM INSUMO;
