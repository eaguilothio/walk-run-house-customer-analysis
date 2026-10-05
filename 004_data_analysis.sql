-- ============================================================
-- WALK & RUN HOUSE
-- ANÁLISIS DE CLIENTES
-- ============================================================

USE walk_run_house;


-- ============================================================
-- 1. PREGUNTA DE NEGOCIO
-- ============================================================

-- ¿Qué clientes generan mayores ingresos y
-- cuáles realizan más devoluciones?
--
-- El objetivo es conocer mejor el comportamiento de los clientes
-- y detectar casos que puedan requerir un análisis posterior.


-- ============================================================
-- 2. DATOS UTILIZADOS
-- ============================================================

-- Se utilizan las tablas limpias creadas en 003:
--
-- - clientes_limpios
-- - pedidos_limpios
-- - detalle_pedidos_limpios
-- - devoluciones_limpios
--
-- Solo se consideran pedidos con estado "completado".


-- ============================================================
-- 3. INGRESOS POR CLIENTE
-- ============================================================

-- ¿Qué clientes generan más ingresos?

SELECT
    p.id_cliente,
    c.nombre,
    SUM(d.cantidad * d.precio_unitario) AS ingresos
FROM pedidos_limpios p
JOIN clientes_limpios c
    ON c.id_cliente = p.id_cliente
JOIN detalle_pedidos_limpios d
    ON d.id_pedido = p.id_pedido
WHERE p.estado = 'completado'
GROUP BY p.id_cliente, c.nombre
ORDER BY ingresos DESC
LIMIT 6;

-- Se seleccionan los 6 clientes con mayores ingresos para
-- analizar con más detalle el impacto de sus devoluciones.
--
-- 31, 9, 19, 1, 34, 13


-- ============================================================
-- 4. IMPACTO DE LAS DEVOLUCIONES
-- ============================================================

-- ¿Qué impacto económico tienen las devoluciones de los
-- 6 clientes con mayores ingresos?

SELECT
    p.id_cliente,
    c.nombre,
    COUNT(*) AS devoluciones,
    SUM(dv.reembolso) AS reembolso_total,
    SUM(dv.coste_gestion) AS coste_gestion_total,
    SUM(dv.reembolso + dv.coste_gestion) AS impacto_devoluciones
FROM devoluciones_limpios dv
JOIN detalle_pedidos_limpios d
    ON d.id_detalle_pedido = dv.id_detalle_pedido
JOIN pedidos_limpios p
    ON p.id_pedido = d.id_pedido
JOIN clientes_limpios c
    ON c.id_cliente = p.id_cliente
WHERE p.estado = 'completado'
  AND p.id_cliente IN (31, 9, 19, 1, 34, 13)
GROUP BY p.id_cliente, c.nombre
ORDER BY impacto_devoluciones DESC;

-- El cliente con ID 9 concentra el mayor impacto por devoluciones,
-- con 604,50 €, más del doble que los siguientes clientes
-- (294,70 €, 254,80 € y 189,70 €).


-- ============================================================
-- 5. ANÁLISIS DEL CLIENTE QUE MÁS DEVUELVE
-- ============================================================

-- El cliente con ID 9 tiene un impacto de devoluciones
-- claramente superior al resto, con 604,50 €.
--
-- Esto indica que, aunque pueda ser un cliente que genere
-- muchos ingresos, las devoluciones están reduciendo de forma
-- importante el valor que aporta.
--
-- Conviene revisar el comportamiento de este cliente y las
-- causas de sus devoluciones, especialmente si también se
-- encuentra entre los clientes que más ingresos generan.


-- ============================================================
-- 6. IDEA PRINCIPAL DEL PROYECTO
-- ============================================================

-- 1. INGRESOS
-- No basta con identificar a los clientes que más compran.
-- También es importante analizar cuánto valor generan realmente.

-- 2. DEVOLUCIONES
-- Las devoluciones pueden reducir de forma importante el valor
-- generado por un cliente. Por eso, ingresos y devoluciones
-- deben analizarse conjuntamente para identificar a los clientes
-- de mayor valor.


-- ============================================================
-- FIN
-- ============================================================
