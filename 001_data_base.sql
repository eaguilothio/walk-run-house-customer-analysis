-- ============================================================
-- WALK & RUN HOUSE
-- DISEÑO DE UNA BASE DE DATOS
-- ============================================================


-- ============================================================
-- 1. OBJETIVO
-- ============================================================
--
-- CRITERIO DE DISEÑO: 
--
-- Esta base define ESTRUCTURA y TIPOS, no calidad.
-- Por eso no incluye restricciones CHECK sobre los valores
-- (precios, costes, cantidades, importes).
--
-- La calidad del dato se exige en el archivo 003.
--
-- Esto permite que 002 inserte anomalías deliberadas para
-- aprender a auditarlas y limpiarlas.
--
-- ============================================================
-- 2. MÉTODO DE DISEÑO
-- ============================================================

-- 2.1. ENTIDADES Y ATRIBUTOS
--
-- ENTIDAD
-- Existe por sí misma, tiene identidad propia y puede
-- describirse mediante varias características.
--
-- Ejemplos:
--   Cliente, Producto, Categoría.
--
-- ATRIBUTO
-- Es una característica de una entidad y no existe por sí solo.
--
-- Ejemplos:
--   Email → describe al cliente.
--   Precio → describe al producto.


-- 2.2. DIMENSIONES Y HECHOS
--
-- DIMENSIONES
-- Describen entidades y permiten responder:
-- ¿QUIÉN? ¿QUÉ? ¿DÓNDE?
--
--   clientes
--   productos
--   categorias
--
-- HECHOS
-- Registran acontecimientos y permiten responder:
-- ¿QUÉ PASÓ? ¿CUÁNTO?
--
--   pedidos
--   devoluciones
--
-- Los hechos suelen contener métricas y aumentan a medida que
-- se producen nuevas operaciones.


-- 2.3. RELACIONES
--
-- Lo habitual es una relación 1:N:
--   Dimensión 1 → N Hechos
--
-- En una relación N:M se crea una tabla intermedia.
--
-- La PK identifica cada fila.
-- La FK se coloca en el lado "muchos" de una relación 1:N.


-- | Tabla             | PK                  | FK                         |
-- | ----------------- | ------------------- | -------------------------- |
-- | `categorias`      | `id_categoria`      | —                          |
-- | `clientes`        | `id_cliente`        | —                          |
-- | `productos`       | `id_producto`       | `id_categoria`             |
-- | `pedidos`         | `id_pedido`         | `id_cliente`               |
-- | `detalle_pedidos` | `id_detalle_pedido` | `id_pedido`, `id_producto` |
-- | `devoluciones`    | `id_devolucion`     | `id_detalle_pedido`        |


-- 2.4. ORDEN DE CREACIÓN
--
-- Las tablas deben crearse respetando sus dependencias:
--
--   categorias
--   clientes
--   productos
--   pedidos
--   detalle_pedidos
--   devoluciones
--
-- Primero se crean las tablas independientes y después las
-- que contienen FK hacia ellas.


-- 2.5. REPRESENTACIÓN DE LAS FILAS
--
-- DIMENSIONES
--   categorias       → una categoría
--   clientes         → un cliente
--   productos        → un producto
--
-- HECHOS
--   pedidos          → un pedido
--   devoluciones     → una devolución (total o parcial) de una línea
--
-- TABLA INTERMEDIA 
--   detalle_pedidos  → un producto dentro de un pedido


-- 2.6. DECISIONES DE DISEÑO
--
-- CLIENTES
--   clientes guarda municipio y provincia (todas de Cataluña:
--   Barcelona, Girona, Tarragona y Lleida). No hay columna de
--   comunidad autónoma porque es siempre la misma.
--
--  PEDIDOS
--   Todos los pedidos son de 2024 y están representados los
--   12 meses. Los pedidos pendientes están en noviembre y
--   diciembre.
--   Solo existen tres estados: completado, cancelado, pendiente.
--   Un pedido "devuelto" es un pedido COMPLETADO: la venta se
--   produjo y después el producto volvió a la empresa.
--   La devolución no se guarda en el estado, sino en la tabla
--   devoluciones.
--
-- IMPORTES DE DEVOLUCIÓN
--  Las devoluciones se atribuyen al año del pedido. Todas
--  son de 2024.
--   reembolso     = dinero devuelto al cliente (importe total).
--   coste_gestion = coste de gestionar la devolución (importe
--                   fijo de 5 euros, devolución a cargo de la
--                   empresa).

-- ============================================================
-- 3. DIAGRAMA EER
-- ============================================================
--
-- El diagrama EER que resume visualmente las tablas, columnas
-- y relaciones está disponible en EER_diagram.pdf.
--
-- Ha sido generado mediante Database Reverse Engineer
-- (MySQL Workbench) a partir de este script.
--
--

-- ============================================================
-- 4. CONSTRUCCIÓN
-- ============================================================

CREATE DATABASE IF NOT EXISTS walk_run_house;
USE walk_run_house;


-- ------------------------------------------------------------
-- 4.1. categorias
-- ------------------------------------------------------------

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL UNIQUE
);


-- ------------------------------------------------------------
-- 4.2. clientes
-- ------------------------------------------------------------

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    municipio VARCHAR(50),
    provincia VARCHAR(50),
    fecha_nacimiento DATE,
    canal_captacion ENUM(
        'redes_sociales',
        'web',
        'tienda_fisica',
        'referido',
        'marketplace'
    ),
    fecha_registro DATE NOT NULL
);


-- ------------------------------------------------------------
-- 4.3. productos
-- ------------------------------------------------------------

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    coste DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,

    FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);


-- ------------------------------------------------------------
-- 4.4. pedidos
-- ------------------------------------------------------------

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    estado ENUM(
        'completado',
        'cancelado',
        'pendiente'
    ) NOT NULL,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);


-- ------------------------------------------------------------
-- 4.5. detalle_pedidos
-- ------------------------------------------------------------

CREATE TABLE detalle_pedidos (
    id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido),

    FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);


-- ------------------------------------------------------------
-- 4.6. devoluciones
-- ------------------------------------------------------------

CREATE TABLE devoluciones (
    id_devolucion INT AUTO_INCREMENT PRIMARY KEY,
    id_detalle_pedido INT NOT NULL,
    fecha_devolucion DATE NOT NULL,
    cantidad_devuelta INT NOT NULL,
    reembolso DECIMAL(10,2) NOT NULL,
    coste_gestion DECIMAL(10,2) NOT NULL DEFAULT 5,
    motivo VARCHAR(100),

    FOREIGN KEY (id_detalle_pedido)
        REFERENCES detalle_pedidos(id_detalle_pedido)
);


-- ============================================================
-- FIN
-- ============================================================
