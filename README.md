# Walk & Run House — Análisis de clientes

Proyecto de análisis de datos con **SQL** sobre una tienda de calzado ficticia.

El proyecto parte del diseño de una base de datos, continúa con la inserción y limpieza de los datos y termina con un análisis del comportamiento de los clientes.

## Objetivo

Analizar el comportamiento de los clientes para conocer:

* qué clientes generan más ingresos;
* qué impacto económico tienen sus devoluciones.

El objetivo es ir más allá de los ingresos y analizar qué clientes pueden requerir un análisis más detallado teniendo en cuenta también sus devoluciones.

## Proceso

El proyecto se divide en cuatro etapas:

1. **Diseño de la base de datos**

   * Creación de las tablas y relaciones.
   * Definición de claves primarias y foráneas.

2. **Inserción de datos**

   * Carga de categorías, clientes, productos, pedidos y devoluciones.
   * Inclusión deliberada de algunas anomalías para trabajar posteriormente la calidad del dato.

3. **Auditoría y limpieza**

   * Corrección de espacios, formatos inconsistentes, emails incorrectos, valores nulos y valores numéricos anómalos.
   * Creación de tablas `_limpios` para conservar los datos originales.

4. **Análisis de clientes**

   * Cálculo de ingresos por cliente.
   * Análisis del impacto económico de las devoluciones.
   * Identificación de clientes que requieren un análisis más detallado.

## Conclusiones

El análisis muestra que **no basta con identificar a los clientes que generan más ingresos**. También es necesario tener en cuenta las devoluciones, ya que pueden tener un impacto económico importante.

En este caso, el **cliente 9 presenta un impacto de devoluciones de 604,50 €**, claramente superior al resto de clientes analizados.

Por tanto, **ingresos y devoluciones deben analizarse conjuntamente** para identificar qué clientes pueden requerir un análisis más detallado.

## Estructura del proyecto

```text
walk-run-house/
│
├── 001_data_base.sql
├── 002_data_insert.sql
├── 003_data_clean.sql
├── 004_analisis_clientes.sql
│
├── EER_diagram.pdf
└── README.md
```
Nota: Las credenciales de conexión a MySQL se almacenan en un archivo .env, que está excluido del repositorio mediante .gitignore.

## Herramientas

* MySQL
* MySQL Workbench
