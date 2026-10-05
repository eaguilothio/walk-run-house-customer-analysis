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
-- 31, 9 (1364,30 €), 19, 1, 34, 13


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
-- 5. ANÁLISIS DEL CLIENTE CON MAYOR IMPACTO DE DEVOLUCIONES
-- ============================================================

-- ¿Qué cliente presenta el mayor impacto económico por devoluciones?
--
-- El cliente con ID 9 presenta un impacto de devoluciones
-- claramente superior al resto, con 604,50 €.
--
-- Aunque genera 1.364,30 € en ingresos, las devoluciones
-- representan 604,50 €, por lo que los ingresos después
-- de devoluciones se reducen a 759,80 €.
--
-- Las devoluciones representan el 44,3 % de los ingresos
-- generados por este cliente.
--
-- Dado que se encuentra entre los clientes que más ingresos
-- generan, conviene analizar los motivos de sus devoluciones
-- para comprobar si se trata de un comportamiento específico
-- del cliente o si los mismos problemas se repiten
-- y puede afectar de forma relevante al negocio.

SELECT 
    p.id_pedido,
    p.fecha_pedido,
    pr.nombre AS producto,
    cat.nombre_categoria,
    dp.cantidad AS cantidad_comprada,
    dp.precio_unitario,
    dev.cantidad_devuelta,
    dev.reembolso,
    dev.coste_gestion,
    dev.motivo
FROM pedidos_limpios p
JOIN detalle_pedidos_limpios dp ON dp.id_pedido = p.id_pedido
JOIN productos_limpios pr ON pr.id_producto = dp.id_producto
JOIN categorias_limpios cat ON cat.id_categoria = pr.id_categoria
LEFT JOIN devoluciones_limpios dev ON dev.id_detalle_pedido = dp.id_detalle_pedido
WHERE p.id_cliente = 9
ORDER BY p.fecha_pedido ASC; -- Entre las causas el cliente menciona que: Llegó dañado y no era lo esperado.
                                -- Como siguiente paso, sería interesante revisar otras opiniones para comprobar:
                                -- posibles problemas en el estado del producto;
                                -- diferencias entre la información mostrada en la web y las expectativas del cliente.

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

-- 3. CLIENTES DE MAYOR INGRESO
-- Esto es especialmente importante en los clientes que más
-- ingresos generan, ya que un volumen alto de devoluciones
-- puede reducir de forma importante sus ingresos finales.
--
-- En estos casos, es interesante analizar los motivos de las
-- devoluciones para determinar si se trata de un comportamiento
-- específico del cliente o si puede reflejar un problema
-- que también afecta al conjunto del negocio.

-- ============================================================
-- FIN
-- ============================================================
