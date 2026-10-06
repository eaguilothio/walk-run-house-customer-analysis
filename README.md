# Walk & Run House — Análisis del valor de clientes

Proyecto de análisis de datos con **SQL** sobre una tienda de calzado ficticia.

El proyecto analiza el valor de los clientes a partir de los **ingresos generados y el impacto económico de sus devoluciones**, con especial atención al grupo de clientes VIP.

## Objetivo

Determinar qué clientes generan mayor valor para el negocio y comprobar si los clientes que más ingresos generan siguen siendo los más valiosos después de considerar sus devoluciones.

Para ello, el análisis busca responder a las siguientes preguntas:

* ¿Qué clientes generan más ingresos?
* ¿Qué peso tienen los clientes VIP sobre los ingresos totales?
* ¿Qué impacto tienen las devoluciones sobre el valor de los clientes?
* ¿Qué clientes siguen siendo más valiosos después de considerar las devoluciones?
* ¿Cuáles son los principales motivos de devolución?
* ¿Las devoluciones se concentran en determinados productos?

## Proceso

El proyecto se divide en cuatro etapas:

### 1. Diseño de la base de datos

* Creación de las tablas.
* Definición de las relaciones entre clientes, pedidos, productos y devoluciones.

### 2. Inserción de datos

* Carga de los datos en la base de datos.
* Inclusión deliberada de algunas anomalías para trabajar posteriormente la calidad del dato.

### 3. Auditoría y limpieza

* Identificación y corrección de anomalías.
* Creación de tablas `_limpios` para conservar los datos originales y trabajar sobre una versión depurada.

### 4. Análisis de clientes

* Identificación de clientes compradores.
* Definición del grupo VIP formado por el 20 % de los clientes compradores con mayores ingresos.
* Análisis del peso de los clientes VIP sobre los ingresos totales.
* Comparación de los ingresos medios entre clientes VIP y no VIP.
* Análisis del impacto económico de las devoluciones.
* Comparación del valor de los clientes antes y después de considerar las devoluciones.
* Análisis de los principales motivos de devolución.
* Análisis de la distribución de las devoluciones por producto.

## Principales resultados

### Clientes y grupo VIP

La base de datos cuenta con **50 clientes registrados**, de los cuales **48 han realizado al menos una compra**.

A partir de estos 48 clientes compradores, se define el grupo VIP como el **20 % con mayores ingresos**, formado por **10 clientes**.

Estos 10 clientes generan **10.074,20 €**, el **39,5 % de los ingresos totales**.

Esto muestra una cierta concentración de los ingresos: el 20 % de los clientes genera aproximadamente el 40 % de las ventas, aunque no se trata de una distribución 80/20.

Además, el ingreso medio de un cliente VIP es de aproximadamente **1.007 €**, frente a unos **406 € por cliente no VIP**. Por tanto, un cliente VIP genera, de media, aproximadamente **2,5 veces más ingresos** que un cliente no VIP.

### Impacto de las devoluciones

Los ingresos generados no reflejan por sí solos el valor de los clientes. Al considerar las devoluciones, el grupo VIP acumula un impacto de **1.738,30 €**, reduciendo sus ingresos de **10.074,20 € a 8.335,90 €**.

Esto muestra que las devoluciones pueden modificar de forma significativa el valor generado por determinados clientes.

### Cliente con mayor impacto

El **cliente 9** es el caso más destacado. Genera **1.364,30 € en ingresos**, pero acumula **604,50 € de impacto por devoluciones**.

Como consecuencia, sus ingresos ajustados se reducen a **759,80 €** y pasa del **segundo puesto por ingresos al séptimo** después de considerar las devoluciones.

Este caso muestra que un cliente que inicialmente se encuentra entre los que más ingresos generan no necesariamente mantiene la misma posición cuando se considera el impacto de sus devoluciones.

### Motivos de devolución

Los principales motivos de devolución son **“producto defectuoso”** y **“llegó dañado”**.

En conjunto, representan **974 €**, aproximadamente el **56 % del impacto total de las devoluciones de los clientes VIP**.

### Distribución por producto

El análisis de las devoluciones por producto no muestra una concentración relevante: **ningún producto acumula un volumen elevado de devoluciones**.

Por tanto, los datos apuntan más a revisar las **causas de las devoluciones y los procesos de preparación y envío** que a un problema concentrado en un producto concreto.

## Acciones propuestas

A partir de los resultados, se plantean tres líneas de actuación:

* **Revisar los procesos de calidad, preparación y envío**, especialmente en los casos de producto defectuoso o producto que llega dañado.
* **Analizar los clientes VIP con mayor impacto de devoluciones**, como los clientes 9, 13 y 15, para identificar patrones y posibles causas.
* **Fidelizar a los clientes situados justo por debajo del grupo VIP** mediante puntos, descuentos u otras ventajas para clientes recurrentes, con el objetivo de aumentar su valor y acercarlos al grupo VIP.

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

* **MySQL**
* **MySQL Workbench**
