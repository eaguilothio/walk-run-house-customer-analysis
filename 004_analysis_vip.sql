-- ============================================================
-- WALK & RUN HOUSE
-- ANÁLISIS DE CLIENTES VIP
-- ============================================================

USE walk_run_house;


-- ============================================================
-- 1. PREGUNTA DE NEGOCIO
-- ============================================================

-- Dentro de nuestros mejores clientes (VIP), ¿quién es realmente
-- valioso una vez descontadas las devoluciones y a quién
-- conviene revisar?
--
-- No se compara VIP contra no VIP: se compara el grupo VIP
-- entre sí.


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
-- 3. DEFINICIÓN DE CLIENTE VIP
-- ============================================================

-- 3.1. ¿Cuántos clientes registrados tenemos?

SELECT COUNT(DISTINCT id_cliente) AS total_clientes
FROM clientes_limpios;

-- Resultado: 50


-- 3.2. ¿Cuántos clientes han comprado?

SELECT COUNT(DISTINCT id_cliente) AS clientes_compradores
FROM pedidos_limpios
WHERE estado = 'completado';

-- Resultado: 48
--
-- Los otros 2 no han comprado, no aportan ingresos
-- y quedan fuera del análisis.


-- 3.3. CRITERIO VIP
--
-- Se usa el 20 % por convención, siguiendo el principio de Pareto
-- (80/20): en muchos negocios, aproximadamente el 20 % de los
-- clientes genera el 80 % de los ingresos.
--
-- VIP = el 20 % de los clientes compradores con más ingresos.
-- 20 % de 48 = 9,6 → 10 clientes VIP.
--
-- Se calcula sobre compradores y no sobre registrados, porque
-- un cliente sin compras no puede entrar en el ranking.
--
-- El 20 % es un criterio de analista, no una regla
-- fija. Más adelante se comprueba con los datos qué porcentaje
-- de ingresos representa realmente este grupo.


-- ============================================================
-- 4. LOS 10 CLIENTES VIP
-- ============================================================

-- ¿Qué 10 clientes generan más ingresos?

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
LIMIT 10;

-- IDs de los 10 VIP:
--
-- 31 (1.613,50)
-- 9  (1.364,30)
-- 19 (1.083,90)
-- 1  (1.053,50)
-- 34 (934,00)
-- 13 (882,90)
-- 15 (794,30)
-- 36 (783,00)
-- 41 (782,70)
-- 11 (782,10)


-- ============================================================
-- 5. PESO DEL GRUPO VIP EN EL NEGOCIO
-- ============================================================

-- ¿Cuánto ingresan los clientes al negocio?

SELECT
    SUM(d.cantidad * d.precio_unitario) AS ingresos_totales
FROM pedidos_limpios p
JOIN detalle_pedidos_limpios d
    ON d.id_pedido = p.id_pedido
WHERE p.estado = 'completado';

-- Resultado: 25.514,90 €


-- ¿Qué parte de los ingresos totales representan los VIP?

SELECT
    SUM(d.cantidad * d.precio_unitario) AS ingresos_vip
FROM pedidos_limpios p
JOIN detalle_pedidos_limpios d
    ON d.id_pedido = p.id_pedido
WHERE p.estado = 'completado'
  AND p.id_cliente IN (31, 9, 19, 1, 34, 13, 15, 36, 41, 11);

-- Resultado: 10.074,20 €


-- Ingresos totales: 25.514,90 €
-- Ingresos de los 10 VIP: 10.074,20 €
-- Porcentaje = 10.074,20 / 25.514,90 * 100 = 39,48 %


-- QUÉ SIGNIFICA
--
-- El 20 % de los compradores genera el 39,5 % de los ingresos,
-- muy lejos del 80 % de Pareto.
--
-- Se usa el 20 % como criterio para definir el grupo VIP,
-- pero los datos muestran que aquí no se cumple el principio
-- 80/20.
--
-- El negocio está relativamente repartido y no depende de
-- unos pocos clientes.
--
-- LOS VIP SIGUEN SIENDO CLIENTES DE MAYOR VALOR
--
-- Cada VIP genera de media unos 1.007 €.
--
-- Los no VIP generan 15.440,70 € entre 38 clientes,
-- unos 406 € por cliente.
--
-- El ingreso medio de un VIP es aproximadamente 2,5 veces
-- superior al de un cliente no VIP ( 1.007 € ÷ 406 € = 2,48 ≈ 2,5 veces).


-- ============================================================
-- 6. DEVOLUCIONES DE LOS VIP
-- ============================================================

-- ¿Qué impacto económico tienen las devoluciones de los VIP?

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
  AND p.id_cliente IN (31, 9, 19, 1, 34, 13, 15, 36, 41, 11)
GROUP BY p.id_cliente, c.nombre
ORDER BY impacto_devoluciones DESC;

-- Impacto por cliente:
--
-- 9  (604,50)
-- 13 (294,70)
-- 15 (294,70)
-- 19 (254,80)
-- 1  (189,70)
-- 11 (99,90)
--
-- Los VIP que no aparecen aquí no tienen devoluciones:
-- 31, 34, 36 y 41.


-- ============================================================
-- 7. VALOR DESPUÉS DE DEVOLUCIONES
-- ============================================================

-- ¿Qué clientes VIP siguen siendo más valiosos después
-- de tener en cuenta sus devoluciones?
--
-- Se comparan los ingresos generados con el impacto económico
-- de las devoluciones.
--
-- A nivel global: 
-- Ingresos VIP: 10.074,20 €
-- Impacto de devoluciones: 1.738,30 €
-- Valor real: 8.335,90 €
--
-- A nivel de cliente:
--
-- Cliente 31: 1.613,50 - 0       = 1.613,50 €
-- Cliente 34:   934,00 - 0       =   934,00 €
-- Cliente 1 : 1.053,50 - 189,70  =   863,80 €
-- Cliente 19: 1.083,90 - 254,80  =   829,10 €
-- Cliente 36:   783,00 - 0       =   783,00 €
-- Cliente 41:   782,70 - 0       =   782,70 €
-- Cliente 9 : 1.364,30 - 604,50  =   759,80 €
-- Cliente 11:   782,10 - 99,90   =   682,20 €
-- Cliente 13:   882,90 - 294,70  =   588,20 €
-- Cliente 15:   794,30 - 294,70  =   499,60 €
--
-- El cliente 9 es especialmente relevante:
-- ocupa el segundo puesto por ingresos, pero baja al séptimo
-- puesto después de tener en cuenta las devoluciones.
--
-- Los clientes 9, 13 y 15 son los que presentan un mayor
-- porcentaje de ingresos afectados por devoluciones.


-- ============================================================
-- 8. MOTIVOS DE DEVOLUCIÓN
-- ============================================================

-- ¿Qué motivos de devolución se repiten entre los VIP?

SELECT
    dv.motivo,
    COUNT(*) AS devoluciones,
    SUM(dv.reembolso + dv.coste_gestion) AS impacto_devoluciones
FROM devoluciones_limpios dv
JOIN detalle_pedidos_limpios d
    ON d.id_detalle_pedido = dv.id_detalle_pedido
JOIN pedidos_limpios p
    ON p.id_pedido = d.id_pedido
WHERE p.estado = 'completado'
  AND p.id_cliente IN (31, 9, 19, 1, 34, 13, 15, 36, 41, 11)
GROUP BY dv.motivo
ORDER BY devoluciones DESC;


-- QUÉ SIGNIFICA
--
-- "Producto defectuoso" es el motivo más frecuente,
-- con 6 devoluciones y un impacto de 444,40 €.
--
-- Sin embargo, "llegó dañado" genera un impacto económico
-- mayor: 529,60 € en solo 3 devoluciones.
--
-- Ambos motivos concentran 974,00 €, aproximadamente el 56 %
-- del impacto total de las devoluciones de los VIP.
--
-- Por tanto, no solo importa cuántas devoluciones se producen,
-- sino también su impacto económico.


-- ¿Qué productos y motivos de devolución se repiten entre los VIP?

SELECT
    dv.motivo,
    pdt.nombre AS producto,
    COUNT(*) AS devoluciones,
    SUM(dv.reembolso + dv.coste_gestion) AS impacto_devoluciones
FROM devoluciones_limpios dv
JOIN detalle_pedidos_limpios d
    ON d.id_detalle_pedido = dv.id_detalle_pedido
JOIN pedidos_limpios p
    ON p.id_pedido = d.id_pedido
JOIN productos_limpios pdt
    ON pdt.id_producto = d.id_producto
WHERE p.estado = 'completado'
  AND p.id_cliente IN (31, 9, 19, 1, 34, 13, 15, 36, 41, 11)
GROUP BY dv.motivo, pdt.nombre
ORDER BY impacto_devoluciones DESC;

-- Las devoluciones no se concentran en productos concretos,
-- ya que ningún producto acumula un volumen elevado de devoluciones ( entre 1 y 2 devoluciones).

-- QUÉ SIGNIFICA
-- El análisis apunta a revisar los procesos de preparación y envío,
-- ya que las devoluciones no se concentran en productos concretos.

-- ============================================================
-- 9. CONCLUSIONES
-- ============================================================

-- 1. PESO DEL GRUPO VIP
--
-- Los 10 clientes VIP (20 % de los compradores) generan
-- 10.074,20 €, el 39,5 % de los ingresos totales.
--
-- El negocio no depende de unos pocos clientes, ya que los VIP
-- no concentran la mayor parte de los ingresos.
--
-- Sin embargo, cada VIP genera de media unos 1.007 €,
-- frente a unos 406 € por cliente no VIP.
--
-- Por tanto, los VIP siguen siendo clientes de mayor valor,
-- aunque las ventas estén relativamente repartidas.


-- 2. VALOR DESPUÉS DE DEVOLUCIONES
--
-- Las devoluciones tienen un impacto total de 1.738,30 €
-- sobre los VIP, reduciendo el valor del grupo de
-- 10.074,20 € a 8.335,90 €.
--
-- El cliente 9 destaca especialmente: aunque ocupa el segundo
-- puesto por ingresos, las devoluciones reducen su valor ajustado
-- hasta 759,80 €.
--
-- Los clientes 9, 13 y 15 presentan el mayor porcentaje
-- de ingresos afectados por devoluciones.


-- 3. MOTIVOS DE DEVOLUCIÓN
--
-- Los motivos "producto defectuoso" y "llegó dañado"
-- concentran 974,00 €, aproximadamente el 56 % del impacto
-- total de las devoluciones de los VIP.
--
-- El análisis apunta a revisar los procesos de preparación y envío,
-- ya que las devoluciones no se concentran en productos concretos.


-- ACCIONES
--
-- 1. Localizar problemas en preparación o envío de los pedidos.
--
-- 2. Analizar las devoluciones de los clientes VIP con mayor impacto,
-- especialmente los clientes 9, 13 y 15, para comprobar si las
-- mejoras en preparación y envío reducen su impacto de devoluciones.
--
-- 3. Potenciar la compra de los clientes situados justo
-- por debajo del grupo VIP mediante acciones de fidelización,
-- como puntos, descuentos o ventajas para clientes recurrentes,
-- con el objetivo de aumentar su valor y acercarlos al grupo VIP.


-- ============================================================
-- FIN
-- ============================================================

