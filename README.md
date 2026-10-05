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

El análisis muestra que **no basta con identificar a los clientes que generan más ingresos**. También es importante analizar sus devoluciones, ya que pueden reducir de forma significativa los ingresos generados.

En este caso, el **cliente 9 presenta 604,50 € en devoluciones**, una cantidad claramente superior a la del resto de clientes analizados. Aunque genera **1.364,30 € en ingresos**, las devoluciones reducen esta cantidad a **759,80 €**.

Por tanto, **ingresos y devoluciones deben analizarse conjuntamente**, especialmente en los clientes que generan más ingresos, para detectar aquellos cuyo resultado puede verse afectado de forma importante por las devoluciones.


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
