# Walk & Run House — Análisis del valor de clientes

Proyecto de análisis de datos con **SQL** sobre una tienda de calzado ficticia.

## Objetivo

Analizar el valor de los clientes para identificar:

* qué clientes generan más ingresos;
* qué peso tienen los clientes VIP en el negocio;
* qué impacto tienen sus devoluciones;
* qué clientes siguen generando más ingresos después de considerar las devoluciones;
* cuáles son los principales motivos de devolución.

## Proceso

El proyecto se divide en cuatro etapas:

### 1. Diseño de la base de datos

* Creación de las tablas y relaciones.

### 2. Inserción de datos

* Carga de datos.
* Inclusión deliberada de algunas anomalías para trabajar posteriormente la calidad del dato.

### 3. Auditoría y limpieza

* Corrección de anomalías.
* Creación de tablas `_limpios` para conservar los datos originales.

### 4. Análisis de clientes

* Definición de un grupo VIP formado por el 20 % de los clientes compradores con mayores ingresos.
* Comparación de los ingresos de los clientes antes y después de considerar las devoluciones.
* Análisis de los principales motivos de devolución y de su distribución por producto.

## Principales resultados

Los **10 clientes VIP**, que representan el 20 % de los clientes compradores, generan **10.074,20 €**, el **39,5 % de los ingresos totales**.

Aunque los VIP no concentran la mayor parte de los ingresos, su ingreso medio es de aproximadamente **1.007 € por cliente**, frente a unos **406 € por cliente no VIP**. Un cliente VIP genera, por tanto, aproximadamente **2,5 veces más ingresos** que un cliente no VIP.

Sin embargo, las devoluciones tienen un impacto relevante. En el grupo VIP representan **1.738,30 €**, reduciendo los ingresos del grupo de **10.074,20 € a 8.335,90 €** después de considerar las devoluciones.

El **cliente 9** es el caso más destacado: genera **1.364,30 € en ingresos**, pero acumula **604,50 € de impacto por devoluciones**. Como consecuencia, sus ingresos ajustados se reducen a **759,80 €** y pasa del segundo puesto por ingresos al séptimo después de considerar las devoluciones.

Los principales motivos de devolución son **"producto defectuoso"** y **"llegó dañado"**, que conjuntamente representan **974 €**, aproximadamente el **56 % del impacto total de las devoluciones de los VIP**.

El análisis por producto no muestra una concentración relevante: ningún producto acumula un volumen elevado de devoluciones. Por tanto, los datos apuntan más a revisar las **causas y los procesos de preparación y envío** que a un problema específico de un producto.

## Acciones propuestas

A partir de los resultados, se plantean tres líneas de actuación:

* **Revisar los procesos de preparación y envío**, especialmente ante devoluciones por producto defectuoso o por productos que llegan dañados.

* **Analizar las devoluciones de los clientes VIP con mayor impacto**, especialmente los clientes 9, 13 y 15, para comprobar si las mejoras en preparación y envío reducen su impacto de devoluciones.

* **Fidelizar a los clientes situados justo por debajo del grupo VIP** mediante puntos, ventajas para clientes recurrentes u otros incentivos, con el objetivo de aumentar su valor y acercarlos al grupo VIP.

## Estructura del proyecto

```text
walk-run-house/
│
├── 001_data_base.sql
├── 002_data_insert.sql
├── 003_data_clean.sql
├── 004_analysis_vip.sql
│
├── diagramaEER.pdf
└── README.md
```

**Nota:** Las credenciales de conexión a MySQL se almacenan en un archivo `.env`, que está excluido del repositorio mediante `.gitignore`.

## Herramientas

* MySQL
* MySQL Workbench
