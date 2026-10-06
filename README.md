# Walk & Run House — Análisis del valor de clientes VIP

Proyecto de análisis de datos con **SQL** sobre una tienda de calzado ficticia.

El proyecto parte del diseño de una base de datos, continúa con la inserción y limpieza de los datos y termina con un análisis del valor de los clientes, teniendo en cuenta tanto los ingresos generados como el impacto de las devoluciones.

## 1. Pregunta de negocio

¿Qué clientes aportan mayor valor al negocio teniendo en cuenta sus ingresos y devoluciones?

## 2. Separación entre clientes compradores y no compradores

La base de datos contiene **50 clientes registrados**.

Al analizar los pedidos completados, se observa que:

* **48 clientes** han realizado al menos una compra.
* **2 clientes** no tienen compras completadas.

Esta separación permite trabajar con los clientes que realmente han generado ingresos para el negocio.

## 4. Criterio del grupo VIP e identificación de los clientes VIP

Para definir el grupo VIP se utiliza como criterio el 20 % de los clientes compradores con mayores ingresos, tomando como referencia el principio de Pareto (80/20), según el cual aproximadamente el 20 % de los clientes puede generar el 80 % de los ingresos.

Si se cumple esta relación, significa que los ingresos están concentrados en los clientes de mayor valor. Si no se cumple, significa que los ingresos están más distribuidos entre la clientela.

El 20 % de los 48 clientes compradores corresponde a 10 clientes, que forman el grupo VIP. Por ello, se ordenan los clientes por ingresos de mayor a menor y se seleccionan los 10 primeros.

## 5. Peso del grupo VIP y no VIP en el negocio

Los 10 clientes VIP generan **10.074,20 €**, que representan aproximadamente el **39,5 % de los ingresos totales**.

Los 38 clientes no VIP generan los **15.440,70 € restantes**, aproximadamente el **60,5 %**.

No se cumple el principio de Pareto, los ingresos están más distribuidos entre la clientela.

No obstante, el ingreso medio muestra una diferencia importante:

* **Cliente VIP:** aproximadamente 1.007 €.
* **Cliente no VIP:** aproximadamente 406 €.

Un cliente VIP genera de media unas **2,5 veces más ingresos** que un cliente no VIP.

Por lo tanto, aunque el negocio está relativamente repartido y no dependa mayoritariamente del grupo VIP, estos clientes tienen un valor individual claramente superior.

## 6. Impacto de las devoluciones en los VIP

Los clientes VIP acumulan un impacto de devoluciones de **1.738,30 €**.

El impacto no está repartido de la misma manera entre todos los clientes.

Destaca especialmente el **cliente 9**, que genera 1.364,30 € de ingresos pero acumula **604,50 € de impacto por devoluciones**.

En cambio, los clientes **31, 34, 36 y 41** no presentan devoluciones.

Esto muestra que para conocer el valor real de un cliente VIP no basta con analizar sus ingresos, sino que también hay que considerar el impacto de sus devoluciones.

## 7. Motivos de devolución

Los principales motivos de devolución entre los clientes VIP son:

* **Producto defectuoso:** 6 devoluciones, con un impacto de 444,40 €.
* **Llegó dañado:** 3 devoluciones, con un impacto de 529,60 €.

Estos dos motivos concentran **974,00 €**, aproximadamente el **56 % del impacto total de las devoluciones de los VIP**.

Además, las devoluciones no se concentran en un producto concreto.

Por ello, se propone revisar los procesos de **calidad, preparación y envío** para identificar posibles causas de estos problemas.

## 8. Conclusiones

El análisis muestra que:

* El grupo VIP representa el **20 % de los clientes compradores**, pero genera aproximadamente el **39,5 % de los ingresos**.
* Los datos **no muestran una distribución 80/20**. El negocio no depende exclusivamente de los clientes VIP, ya que la mayor parte de los ingresos procede del resto de clientes.
* Los clientes VIP tienen un valor superior, generando de media unas **2,5 veces más ingresos** que los clientes no VIP.
* Las devoluciones tienen un impacto relevante dentro del grupo VIP. El ranking de clientes puede cambiar cuando se tiene en cuenta el **valor real después de devoluciones**.
* Los motivos **"producto defectuoso"** y **"llegó dañado"** concentran una parte importante del impacto económico de las devoluciones. Sin embargo, **no se observa una concentración clara de las devoluciones en un producto concreto**.


## 10. Acciones propuestas

**1. Revisar los procesos de calidad, preparación y envío**

Analizar los casos de productos defectuosos o dañados para identificar posibles causas y reducir el impacto de las devoluciones.

**2. Revisar los clientes VIP con mayor impacto de devoluciones**

Analizar especialmente los clientes 9, 13 y 15 para identificar patrones y entender por qué una parte importante de sus ingresos termina afectada por devoluciones.

**3. Trabajar la fidelización de los clientes próximos al grupo VIP**

Identificar a los clientes que generan ingresos elevados pero todavía no pertenecen al grupo VIP y plantear acciones de fidelización, como ventajas por recurrencia, programas de puntos o promociones personalizadas, con el objetivo de aumentar su valor.

