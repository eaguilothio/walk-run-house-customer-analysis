-- ============================================================
-- WALK & RUN HOUSE
-- ANÁLISIS DEL VALOR DE CLIENTES VIP
-- ============================================================

USE walk_run_house;


-- ============================================================
-- ÍNDICE
-- ============================================================
--
-- 1. Pregunta de negocio
-- 2. Datos utilizados
-- 3. ¿Quién compra?
-- 4. ¿Quiénes son nuestros clientes VIP?
-- 5. ¿Se cumple el principio de Pareto?
-- 6. ¿Qué diferencia existe entre los clientes VIP y los no VIP?
-- 7. ¿Qué diferencia existe dentro del grupo VIP?
-- 8. ¿Cuál es el valor real de los clientes VIP?
-- 9. ¿Por qué se producen las devoluciones?
-- 10. Conclusiones
-- 11. Acciones propuestas
--
-- ============================================================


-- ============================================================
-- 1. PREGUNTA DE NEGOCIO
-- ============================================================

-- ¿Qué clientes aportan mayor valor al negocio teniendo en cuenta
-- sus ingresos y devoluciones?


-- ============================================================
-- 2. DATOS UTILIZADOS
-- ============================================================

-- Se utilizan las tablas limpias creadas en 003:
--
-- - clientes_limpios
-- - pedidos_limpios
-- - detalle_pedidos_limpios
-- - devoluciones_limpios
-- - productos_limpios
--
-- Solo se consideran pedidos con estado "completado".


-- ============================================================
-- 3. ¿QUIÉN COMPRA?
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
-- Los otros 2 clientes no han realizado compras completadas,
-- por lo que no aportan ingresos y quedan fuera del análisis.


-- ============================================================
-- 4. ¿QUIÉNES SON NUESTROS CLIENTES VIP?
-- ============================================================

-- Para identificar a los clientes de mayor valor económico,
-- se utiliza como referencia el principio de Pareto (80/20).
--
-- Este principio plantea que, en determinados contextos,
-- aproximadamente el 20 % de los clientes puede concentrar
-- el 80 % de los ingresos.
--
-- En este análisis, el 20 % se utiliza como criterio para
-- definir el grupo VIP, pero el 80 % no se da por supuesto.
-- Posteriormente se comprueba qué porcentaje de los ingresos
-- genera realmente este grupo.
--
-- La base de clientes compradores está formada por 48 clientes:
--
-- 20 % de 48 = 9,6 → 10 clientes VIP.
--
-- Por tanto, los clientes se ordenan de mayor a menor según
-- los ingresos generados y los 10 primeros forman el grupo VIP.
--
-- Se calcula sobre los clientes compradores y no sobre el total
-- de clientes registrados, ya que un cliente sin compras no puede
-- entrar en un ranking de ingresos.


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
-- 5. ¿SE CUMPLE EL PRINCIPIO DE PARETO?
-- ============================================================


-- 5.1. ¿Cuánto ingresan todos los clientes?

SELECT
    SUM(d.cantidad * d.precio_unitario) AS ingresos_totales
FROM pedidos_limpios p
JOIN detalle_pedidos_limpios d
    ON d.id_pedido = p.id_pedido
WHERE p.estado = 'completado';

-- Resultado: 25.514,90 €


-- 5.2. ¿Qué parte de los ingresos totales representan los VIP?

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
--
-- Porcentaje:
-- 10.074,20 / 25.514,90 * 100 = 39,48 %


-- QUÉ SIGNIFICA
--
-- El 20 % de los compradores genera aproximadamente el 39,5 %
-- de los ingresos.
--
-- Por tanto, los datos no muestran una distribución 80/20:
-- el 20 % de los clientes no concentra el 80 % de los ingresos.
--
-- Los ingresos están más distribuidos entre la clientela
-- y el negocio no depende mayoritariamente de los clientes VIP.


-- ============================================================
-- 6. ¿QUÉ DIFERENCIA EXISTE ENTRE LOS CLIENTES VIP
--    Y LOS NO VIP?
-- ============================================================

-- Los 10 clientes VIP generan 10.074,20 €,
-- aproximadamente el 39,5 % de los ingresos totales.
--
-- Los 38 clientes no VIP generan 15.440,70 €,
-- aproximadamente el 60,5 % restante.


-- Ingreso medio por cliente:
--
-- Cliente VIP: aproximadamente 1.007 €.
-- Cliente no VIP: aproximadamente 406 €.
--
-- El ingreso medio de un VIP es aproximadamente 2,5 veces
-- superior al de un cliente no VIP.
--
-- 1.007 € ÷ 406 € = 2,48 ≈ 2,5 veces.


-- QUÉ SIGNIFICA
--
-- Aunque la mayor parte de los ingresos procede de los clientes
-- no VIP, existe una diferencia importante en el ingreso medio.
--
-- Un cliente VIP genera de media unas 2,5 veces más ingresos
-- que un cliente no VIP.
--
-- Por tanto, aunque los ingresos están relativamente distribuidos,
-- los clientes VIP tienen un valor individual claramente superior.


-- ============================================================
-- 7. ¿QUÉ DIFERENCIA EXISTE DENTRO DEL GRUPO VIP?
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


-- QUÉ SIGNIFICA
--
-- Dentro del grupo VIP existen diferencias importantes
-- en el impacto económico de las devoluciones.
--
-- El cliente 9 destaca especialmente, con un impacto
-- de 604,50 €.
--
-- En cambio, los clientes 31, 34, 36 y 41 no presentan
-- devoluciones.
--
-- Por tanto, no todos los clientes VIP aportan el mismo valor
-- una vez considerado el impacto de las devoluciones.


-- ============================================================
-- 8. ¿CUÁL ES EL VALOR REAL DE LOS CLIENTES VIP?
-- ============================================================

-- Se compara el ingreso generado por cada cliente con el impacto
-- económico de sus devoluciones.
--
-- Valor real = ingresos - reembolso - costes de gestión


-- A nivel global:
--
-- Ingresos VIP:             10.074,20 €
-- Impacto de devoluciones:   1.738,30 €
-- Valor real:                8.335,90 €


-- Valor real a nivel de cliente:
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


-- QUÉ SIGNIFICA
--
-- El cliente 9 es especialmente relevante:
-- ocupa el segundo puesto por ingresos, pero baja al séptimo
-- puesto después de tener en cuenta las devoluciones.
--
-- Sus ingresos pasan de 1.364,30 € a 759,80 € de valor real.
--
-- Los clientes 9, 13 y 15 presentan el mayor porcentaje
-- de ingresos afectados por devoluciones.
--
-- Esto muestra que para conocer el valor real de un cliente
-- no basta con analizar sus ingresos, sino que también hay que
-- considerar el impacto económico de sus devoluciones.


-- ============================================================
-- 9. ¿POR QUÉ SE PRODUCEN LAS DEVOLUCIONES?
-- ============================================================


-- 9.1. ¿Qué motivos de devolución se repiten entre los VIP?

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


-- 9.2. ¿Qué productos y motivos de devolución se repiten
--      entre los VIP?

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


-- QUÉ SIGNIFICA
--
-- Las devoluciones no se concentran en un producto concreto,
-- ya que ningún producto acumula un volumen elevado de devoluciones
-- (entre 1 y 2 devoluciones).
--
-- Además, "producto defectuoso" y "llegó dañado" concentran
-- una parte importante del impacto económico.
--
-- Por ello, se propone revisar los procesos de calidad,
-- preparación y envío para identificar posibles causas.


-- ============================================================
-- 10. CONCLUSIONES
-- ============================================================


-- 1. ¿QUIÉNES SON NUESTROS CLIENTES VIP?
--
-- Los 10 clientes VIP representan el 20 % de los clientes
-- compradores y generan 10.074,20 € de ingresos.


-- 2. ¿SE CUMPLE EL PRINCIPIO DE PARETO?
--
-- El grupo VIP genera aproximadamente el 39,5 % de los ingresos.
--
-- Los datos no muestran una distribución 80/20:
-- el 20 % de los clientes no concentra el 80 % de los ingresos.
--
-- Los ingresos están más distribuidos entre la clientela.


-- 3. ¿QUÉ DIFERENCIA EXISTE ENTRE LOS CLIENTES VIP
--    Y LOS NO VIP?
--
-- Los clientes VIP generan de media unos 1.007 €,
-- frente a unos 406 € por cliente no VIP.
--
-- Un cliente VIP genera aproximadamente 2,5 veces más ingresos
-- que un cliente no VIP.


-- 4. ¿QUÉ DIFERENCIA EXISTE DENTRO DEL GRUPO VIP?
--
-- El impacto de las devoluciones no está repartido de la misma
-- manera entre todos los clientes VIP.
--
-- Destaca especialmente el cliente 9, que presenta
-- 604,50 € de impacto por devoluciones.
--
-- En cambio, los clientes 31, 34, 36 y 41 no presentan devoluciones.


-- 5. ¿CUÁL ES EL VALOR REAL DE LOS CLIENTES VIP?
--
-- Los VIP generan 10.074,20 € de ingresos y acumulan
-- 1.738,30 € de impacto por devoluciones.
--
-- Por tanto, el valor real del grupo VIP se reduce
-- a 8.335,90 € después de considerar las devoluciones.
--
-- El cliente 9 es especialmente relevante:
-- aunque ocupa el segundo puesto por ingresos, las devoluciones
-- reducen su valor real hasta 759,80 €.
--
-- Por tanto, analizar únicamente los ingresos puede sobreestimar
-- el valor de determinados clientes.


-- 6. ¿POR QUÉ SE PRODUCEN LAS DEVOLUCIONES?
--
-- Los motivos "producto defectuoso" y "llegó dañado"
-- concentran 974,00 €, aproximadamente el 56 % del impacto
-- total de las devoluciones de los VIP.
--
-- Las devoluciones no se concentran en un producto concreto.
--
-- Por ello, conviene revisar los procesos de calidad,
-- preparación y envío.


-- ============================================================
-- 11. ACCIONES PROPUESTAS
-- ============================================================


-- 1. Revisar los procesos de preparación y envío
-- para identificar posibles causas de productos defectuosos
-- o dañados y reducir el impacto de las devoluciones.


-- 2. Hacer seguimiento del cliente VIP con mayor impacto
-- de devoluciones.
--
-- Analizar especialmente el cliente 9, que presenta
-- el mayor impacto de devoluciones, y realizar un seguimiento
-- posterior a la mejora de los procesos de preparación y envío
-- para comprobar si disminuyen sus devoluciones.


-- 3. Trabajar la fidelización de los clientes próximos
-- al grupo VIP.
--
-- Identificar a los clientes que generan ingresos elevados
-- pero todavía no pertenecen al grupo VIP y plantear acciones
-- de fidelización, como ventajas por recurrencia, programas
-- de puntos o promociones personalizadas, con el objetivo
-- de aumentar su valor.


-- ============================================================
-- FIN
-- ============================================================
