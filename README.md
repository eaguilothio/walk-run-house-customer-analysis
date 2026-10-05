# Walk & Run House — Análisis de clientes

Proyecto de análisis de datos con **SQL** sobre una tienda de calzado ficticia.

El proyecto parte del diseño de una base de datos, continúa con la inserción y limpieza de los datos y termina con un análisis del comportamiento de los clientes.

## Objetivo

Analizar si los clientes que más ingresos generan son necesariamente los que más valor aportan. 

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

## Conclusiones

El análisis muestra que **no basta con identificar a los clientes que generan más ingresos**, sino que también es necesario considerar el impacto de sus devoluciones.

El **cliente 9** genera **1.364,30 € en ingresos**, pero acumula **604,50 € en devoluciones**, por lo que los ingresos después de devoluciones se reducen a **759,80 €**.

Este resultado muestra que un cliente con un volumen elevado de ingresos **no necesariamente genera el mismo valor una vez consideradas sus devoluciones**.

Además, es necesario analizar los **motivos de devolución**. En el caso del cliente 9 aparecen **“Llegó dañado”** y **“No era lo esperado”**. Analizar estos motivos permitiría comprobar si se trata de un comportamiento específico de este cliente o si los mismos problemas se repiten en otros clientes.

Como siguiente paso, en otro análisis sería especialmente relevante revisar los motivos de devolución de los clientes que generan más ingresos, ya que sus devoluciones tienen un mayor impacto económico, y comprobar si los problemas detectados se repiten en otros clientes o productos.

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
