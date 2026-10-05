-- ============================================================
-- WALK & RUN HOUSE
-- AUDITORÍA Y LIMPIEZA DE DATOS
-- ============================================================


-- ============================================================
-- 1. OBJETIVO
-- ============================================================
--
-- Auditar las tablas insertadas en el archivo 002, detectar las
-- anomalías de calidad del dato y corregirlas.
--
-- La limpieza NO se hace sobre las tablas originales, sino sobre
-- una copia (tablas _limpios). Así los datos de partida se
-- conservan y siempre se puede comparar el antes y el después.
--
-- Las anomalías están concentradas en dos tablas:
--
-- | Tabla     | Tipo de problema     | Columnas                    |
-- |-----------|----------------------|-----------------------------|
-- | clientes  | categóricas y fechas | nombre, municipio, email,   |
-- |           |                      | provincia, fecha_nacimiento |
-- | productos | numéricas            | precio, coste               |
--
-- El resto de tablas (categorias, pedidos, detalle_pedidos y
-- devoluciones) se revisan igualmente, pero no contienen
-- anomalías.
--
--
-- ============================================================
-- 2. MÉTODO
-- ============================================================
--
-- Cada tabla se trata con la misma secuencia:
--
--   1. INSPECCIÓN GENERAL
--      → se revisan todos los registros con SELECT * para
--        conocer los valores existentes.
--
--   2. DETECCIÓN DE POSIBLES ANOMALÍAS
--      → una consulta por problema, que devuelve las filas
--        afectadas. Se indica el resultado esperado y la
--        decisión que se toma.
--
--   3. TABLA LIMPIA
--      → CREATE TABLE ... LIKE
--        crea una copia de la estructura de la tabla.
--
--      → INSERT INTO ... SELECT *
--        copia todos los datos de la tabla original.
--
--      → UPDATE
--        indica la tabla que se quiere modificar.
--
--       → SET    
--         indica la columna que se quiere modificar
--         y el nuevo valor.
--       
--       → WHERE  
--        indica las filas que se quieren modificar.
--
--      → VALIDACIÓN
--        se repite la consulta de detección sobre la tabla
--        limpia y debe devolver 0 filas.
--
--
-- ============================================================
-- 3. PATRONES APLICADOS
-- ============================================================
--
-- DE TEXTO
--
-- TRIM(texto)
--   → elimina los espacios del principio y del final.
--
-- LOWER(texto)
--   → convierte el texto a minúsculas.
--
-- UPPER(texto)
--   → convierte el texto a mayúsculas.
--
-- BINARY texto
--   → permite hacer una comparación exacta, distinguiendo
--     entre mayúsculas y minúsculas.
--
-- LIKE
--   → busca textos que cumplen un patrón.
--
--
-- DE FECHAS
--
-- IS NULL
--   → comprueba si un campo no tiene ningún valor.
--
-- Comparación con una fecha límite (< '1920-01-01')
--   → detecta fechas centinela, es decir, valores por defecto
--     que no representan una fecha real.
--
--
-- NUMÉRICAS
--
-- ABS(número)
--   → devuelve el valor absoluto de un número.
--     Se utiliza para eliminar un signo negativo incorrecto.
--
-- ============================================================

USE walk_run_house;

-- Workbench bloquea los UPDATE sin una condición sobre la PK.
SET SQL_SAFE_UPDATES = 0;

-- Se eliminan las tablas limpias en orden inverso a sus dependencias,
-- de modo que el script se pueda ejecutar varias veces.
DROP TABLE IF EXISTS devoluciones_limpios;
DROP TABLE IF EXISTS detalle_pedidos_limpios;
DROP TABLE IF EXISTS pedidos_limpios;
DROP TABLE IF EXISTS productos_limpios;
DROP TABLE IF EXISTS clientes_limpios;
DROP TABLE IF EXISTS categorias_limpios;


-- ============================================================
-- 1. CATEGORIAS
-- ============================================================

-- 1.1. Inspección general
-- Se revisan los registros para comprobar los valores existentes.

SELECT * FROM categorias;


-- 1.2. Detección de posibles anomalías
-- Se comprueba si existen espacios sobrantes o categorías vacías.

SELECT *
FROM categorias
WHERE nombre_categoria <> TRIM(nombre_categoria)
   OR TRIM(nombre_categoria) = '';

-- Esperado: 0 filas.
-- No se detectan anomalías.


-- 1.3. Tabla limpia: copia de la tabla original.

DROP TABLE IF EXISTS categorias_limpios;

CREATE TABLE categorias_limpios LIKE categorias;

INSERT INTO categorias_limpios
SELECT * FROM categorias;


-- No es necesario realizar UPDATE porque no existen anomalías.


-- ============================================================
-- 2. CLIENTES
-- ============================================================

-- 2.1. Inspección general
-- Se revisan los registros para identificar posibles
-- inconsistencias en los datos.

SELECT * FROM clientes;


-- ------------------------------------------------------------
-- 2.2. nombre: espacios sobrantes
-- ------------------------------------------------------------

-- Se comprueba si existen espacios al principio o al final
-- del nombre.

SELECT id_cliente, nombre
FROM clientes
WHERE nombre <> TRIM(nombre);

-- Esperado: ids 3, 9 y 17.
-- Decisión: eliminar los espacios sobrantes con TRIM().


-- ------------------------------------------------------------
-- 2.3. municipio: mayúsculas y minúsculas inconsistentes
-- ------------------------------------------------------------

-- Se comprueba si existen municipios escritos completamente
-- en mayúsculas o en minúsculas.

SELECT id_cliente, municipio
FROM clientes
WHERE BINARY municipio = UPPER(municipio)
   OR BINARY municipio = LOWER(municipio);

-- Esperado: ids 5, 12 y 34.
-- Decisión: unificar el nombre de los municipios.


-- ------------------------------------------------------------
-- 2.4. email: formato incorrecto
-- ------------------------------------------------------------

-- Se comprueba si existen emails que no contienen un formato
-- mínimo válido.

SELECT id_cliente, email
FROM clientes
WHERE email NOT LIKE '%@%.%'
   OR email LIKE '%@%@%';

-- Esperado: ids 10, 19 y 26.
-- Decisión: poner el email a NULL porque no se puede
-- reconstruir correctamente.


-- ------------------------------------------------------------
-- 2.5. provincia: valores NULL
-- ------------------------------------------------------------

-- Se comprueba si existen provincias sin informar.

SELECT id_cliente, municipio, provincia
FROM clientes
WHERE provincia IS NULL;

-- Esperado: ids 29, 30 y 31.
-- Decisión: completar la provincia a partir del municipio
-- cuando el municipio permite identificarla.


-- ------------------------------------------------------------
-- 2.6. fecha_nacimiento: fecha centinela
-- ------------------------------------------------------------

-- Se comprueba si existen fechas de nacimiento que no
-- corresponden a una fecha real. 1900-01-01 es un valor
-- por defecto, no la fecha de nacimiento de una persona.

SELECT id_cliente, nombre, fecha_nacimiento
FROM clientes
WHERE fecha_nacimiento < '1920-01-01';

-- Esperado: id 14 (1900-01-01).
-- Decisión: poner la fecha a NULL porque no se puede
-- conocer la fecha de nacimiento correcta. Dejar 1900
-- distorsionaría cualquier análisis de edad.


-- ------------------------------------------------------------
-- 2.7. Tabla limpia
-- ------------------------------------------------------------

DROP TABLE IF EXISTS clientes_limpios;

CREATE TABLE clientes_limpios LIKE clientes;

INSERT INTO clientes_limpios
SELECT * FROM clientes;


-- ------------------------------------------------------------
-- 2.8. Corrección del nombre
-- ------------------------------------------------------------

-- Se eliminan los espacios sobrantes.

UPDATE clientes_limpios
SET nombre = TRIM(nombre)
WHERE nombre <> TRIM(nombre);


-- ------------------------------------------------------------
-- 2.9. Corrección del municipio
-- ------------------------------------------------------------

-- Se unifica el formato de los municipios.
-- El mismo municipio se escribe siempre de la misma forma.

UPDATE clientes_limpios
SET municipio = 'Barcelona'
WHERE LOWER(municipio) = 'barcelona';

UPDATE clientes_limpios
SET municipio = 'Sabadell'
WHERE LOWER(municipio) = 'sabadell';

UPDATE clientes_limpios
SET municipio = 'Girona'
WHERE LOWER(municipio) = 'girona';


-- ------------------------------------------------------------
-- 2.10. Corrección del email
-- ------------------------------------------------------------

-- Como los emails incorrectos no se pueden reconstruir,
-- se eliminan poniendo el valor a NULL.

UPDATE clientes_limpios
SET email = NULL
WHERE email NOT LIKE '%@%.%'
   OR email LIKE '%@%@%';


-- ------------------------------------------------------------
-- 2.11. Corrección de la provincia
-- ------------------------------------------------------------

-- Se completa la provincia cuando se puede deducir
-- correctamente a partir del municipio.

UPDATE clientes_limpios
SET provincia = 'Barcelona'
WHERE provincia IS NULL
  AND municipio IN ('Barcelona', 'Terrassa', 'Mataró');


-- ------------------------------------------------------------
-- 2.12. Corrección de fecha_nacimiento
-- ------------------------------------------------------------

-- La fecha centinela no se puede reconstruir,
-- se sustituye por NULL.

UPDATE clientes_limpios
SET fecha_nacimiento = NULL
WHERE fecha_nacimiento < '1920-01-01';


-- ------------------------------------------------------------
-- 2.13. Validación
-- ------------------------------------------------------------

-- Se comprueba que los problemas corregibles hayan
-- desaparecido.

SELECT *
FROM clientes_limpios
WHERE nombre <> TRIM(nombre)
   OR BINARY municipio = UPPER(municipio)
   OR BINARY municipio = LOWER(municipio)
   OR email NOT LIKE '%@%.%'
   OR email LIKE '%@%@%'
   OR provincia IS NULL
   OR fecha_nacimiento < '1920-01-01';

-- Esperado: 0 filas.


-- Se comprueba aparte que los datos no reconstruibles
-- quedan como NULL.

SELECT id_cliente, nombre, email, fecha_nacimiento
FROM clientes_limpios
WHERE id_cliente IN (10, 14, 19, 26);

-- Esperado: ids 10, 19 y 26 con email NULL;
--           id 14 con fecha_nacimiento NULL.


-- ============================================================
-- 3. PRODUCTOS
-- ============================================================

-- 3.1. Inspección general
-- Se revisan los productos para identificar posibles
-- valores numéricos incorrectos.

SELECT * FROM productos;


-- ------------------------------------------------------------
-- 3.2. precio: valor incorrecto
-- ------------------------------------------------------------

-- Se busca el precio anormalmente alto que corresponde
-- a un error de escritura.

SELECT id_producto, nombre, precio
FROM productos
WHERE precio > 1000;

-- Esperado: id 12 con precio 1490.00.
-- Decisión: corregir el precio a 14.90.


-- ------------------------------------------------------------
-- 3.3. coste: valor negativo
-- ------------------------------------------------------------

-- Se comprueba si existen costes negativos.

SELECT id_producto, nombre, coste
FROM productos
WHERE coste < 0;

-- Esperado: id 16 con coste -9.00.
-- Decisión: corregir el signo utilizando ABS().


-- ------------------------------------------------------------
-- 3.4. Tabla limpia
-- ------------------------------------------------------------

DROP TABLE IF EXISTS productos_limpios;

CREATE TABLE productos_limpios LIKE productos;

INSERT INTO productos_limpios
SELECT * FROM productos;


-- ------------------------------------------------------------
-- 3.5. Corrección del precio
-- ------------------------------------------------------------

-- El precio incorrecto 1490.00 se corrige a 14.90.

UPDATE productos_limpios
SET precio = 14.90
WHERE id_producto = 12;


-- ------------------------------------------------------------
-- 3.6. Corrección del coste
-- ------------------------------------------------------------

-- Se elimina el signo negativo del coste.

UPDATE productos_limpios
SET coste = ABS(coste)
WHERE coste < 0;


-- ------------------------------------------------------------
-- 3.7. Validación
-- ------------------------------------------------------------

SELECT *
FROM productos_limpios
WHERE precio > 1000
   OR coste < 0;

-- Esperado: 0 filas.


-- ============================================================
-- 4. PEDIDOS
-- ============================================================

-- 4.1. Inspección general

SELECT * FROM pedidos;


-- ------------------------------------------------------------
-- 4.2. Detección de posibles anomalías
-- ------------------------------------------------------------

-- Se comprueba si existen pedidos con una fecha futura.

SELECT *
FROM pedidos
WHERE fecha_pedido > CURRENT_DATE;

-- Esperado: 0 filas.
-- No se detectan anomalías.


-- ------------------------------------------------------------
-- 4.3. Tabla limpia
-- ------------------------------------------------------------

DROP TABLE IF EXISTS pedidos_limpios;

CREATE TABLE pedidos_limpios LIKE pedidos;

INSERT INTO pedidos_limpios
SELECT * FROM pedidos;


-- No es necesario realizar UPDATE porque no existen
-- anomalías detectadas.


-- ============================================================
-- 5. DETALLE_PEDIDOS
-- ============================================================

-- 5.1. Inspección general

SELECT * FROM detalle_pedidos;


-- ------------------------------------------------------------
-- 5.2. Detección de posibles anomalías
-- ------------------------------------------------------------

-- Se comprueba que la cantidad y el precio sean positivos.

SELECT *
FROM detalle_pedidos
WHERE cantidad <= 0
   OR precio_unitario <= 0;

-- Esperado: 0 filas.
-- No se detectan anomalías.


-- ------------------------------------------------------------
-- 5.3. Tabla limpia
-- ------------------------------------------------------------

DROP TABLE IF EXISTS detalle_pedidos_limpios;

CREATE TABLE detalle_pedidos_limpios LIKE detalle_pedidos;

INSERT INTO detalle_pedidos_limpios
SELECT * FROM detalle_pedidos;


-- No es necesario realizar UPDATE porque no existen
-- anomalías detectadas.


-- ============================================================
-- 6. DEVOLUCIONES
-- ============================================================

-- 6.1. Inspección general

SELECT * FROM devoluciones;


-- ------------------------------------------------------------
-- 6.2. Detección de posibles anomalías
-- ------------------------------------------------------------

-- Se comprueba que las devoluciones sean coherentes con la
-- línea de pedido a la que pertenecen: la fecha no puede ser
-- anterior al pedido, no se puede devolver más de lo comprado
-- y el reembolso debe ser cantidad devuelta x precio unitario.

SELECT dv.*
FROM devoluciones dv
JOIN detalle_pedidos d ON d.id_detalle_pedido = dv.id_detalle_pedido
JOIN pedidos p ON p.id_pedido = d.id_pedido
WHERE dv.fecha_devolucion < p.fecha_pedido
   OR dv.cantidad_devuelta <= 0
   OR dv.cantidad_devuelta > d.cantidad
   OR dv.reembolso <> dv.cantidad_devuelta * d.precio_unitario;

-- Esperado: 0 filas.
-- No se detectan anomalías.

-- Se comprueba que no se devuelva más de lo comprado
-- sumando todas las devoluciones de una misma línea.

SELECT d.id_detalle_pedido, d.cantidad, SUM(dv.cantidad_devuelta) AS devuelto
FROM devoluciones dv
JOIN detalle_pedidos d ON d.id_detalle_pedido = dv.id_detalle_pedido
GROUP BY d.id_detalle_pedido, d.cantidad
HAVING SUM(dv.cantidad_devuelta) > d.cantidad;

-- Esperado: 0 filas.
-- No se detectan anomalías.


-- ------------------------------------------------------------
-- 6.3. Tabla limpia
-- ------------------------------------------------------------

DROP TABLE IF EXISTS devoluciones_limpios;

CREATE TABLE devoluciones_limpios LIKE devoluciones;

INSERT INTO devoluciones_limpios
SELECT * FROM devoluciones;


-- No es necesario realizar UPDATE porque no existen
-- anomalías detectadas.


-- ============================================================
-- 7. CLAVES FORÁNEAS DE LAS TABLAS LIMPIAS
-- ============================================================

-- CREATE TABLE ... LIKE copia la estructura y los índices,
-- pero no las claves foráneas.
--
-- Por eso se añaden las FK al final, cuando todas las tablas
-- _limpios ya existen.
--
-- Las claves apuntan a las tablas _limpios y no a las originales.


-- ------------------------------------------------------------
-- 7.1. Productos → Categorías
-- ------------------------------------------------------------

ALTER TABLE productos_limpios
ADD CONSTRAINT fk_prod_limpios_categoria
FOREIGN KEY (id_categoria)
REFERENCES categorias_limpios(id_categoria);


-- ------------------------------------------------------------
-- 7.2. Pedidos → Clientes
-- ------------------------------------------------------------

ALTER TABLE pedidos_limpios
ADD CONSTRAINT fk_ped_limpios_cliente
FOREIGN KEY (id_cliente)
REFERENCES clientes_limpios(id_cliente);


-- ------------------------------------------------------------
-- 7.3. Detalle de pedidos → Pedidos
-- ------------------------------------------------------------

ALTER TABLE detalle_pedidos_limpios
ADD CONSTRAINT fk_det_limpios_pedido
FOREIGN KEY (id_pedido)
REFERENCES pedidos_limpios(id_pedido);


-- ------------------------------------------------------------
-- 7.4. Detalle de pedidos → Productos
-- ------------------------------------------------------------

ALTER TABLE detalle_pedidos_limpios
ADD CONSTRAINT fk_det_limpios_producto
FOREIGN KEY (id_producto)
REFERENCES productos_limpios(id_producto);


-- ------------------------------------------------------------
-- 7.5. Devoluciones → Detalle de pedidos
-- ------------------------------------------------------------

ALTER TABLE devoluciones_limpios
ADD CONSTRAINT fk_dev_limpios_detalle
FOREIGN KEY (id_detalle_pedido)
REFERENCES detalle_pedidos_limpios(id_detalle_pedido);


-- ============================================================
-- 8. COMPROBACIÓN FINAL
-- ============================================================

-- Se comprueba que las tablas limpias existen y contienen
-- los datos después de las correcciones.

SELECT * FROM categorias_limpios;

SELECT * FROM clientes_limpios;

SELECT * FROM productos_limpios;

SELECT * FROM pedidos_limpios;

SELECT * FROM detalle_pedidos_limpios;

SELECT * FROM devoluciones_limpios;


-- Se vuelve a activar la protección de Workbench.

SET SQL_SAFE_UPDATES = 1;


-- ============================================================
-- FIN
-- ============================================================
