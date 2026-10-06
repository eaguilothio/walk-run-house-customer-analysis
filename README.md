# Walk & Run House — Análisis del valor de clientes VIP

Proyecto de análisis de datos con **SQL** sobre una tienda de calzado ficticia.

El proyecto parte del diseño de una base de datos, continúa con la inserción y limpieza de los datos y termina con un análisis del valor de los clientes, teniendo en cuenta tanto los **ingresos generados** como el **impacto de las devoluciones**.

## 1. Pregunta de negocio

¿Qué clientes aportan mayor valor al negocio teniendo en cuenta sus ingresos y devoluciones?

Para responder a esta pregunta, el análisis sigue las siguientes cuestiones:

* ¿Quién compra?
* ¿Quién genera más ingresos?
* ¿Se cumple el principio de Pareto?
* ¿Qué peso tienen los clientes VIP?
* ¿Qué pasa con las devoluciones?
* ¿Cuál es el valor real de los clientes VIP?
* ¿Por qué se producen las devoluciones?
* ¿Qué acciones se pueden proponer?

## 2. ¿Quién compra?

La base de datos contiene **50 clientes registrados**.

Al analizar los pedidos completados, se observa que:

* **48 clientes** han realizado al menos una compra.
* **2 clientes** no tienen compras completadas.

Por tanto, el análisis de ingresos se realiza sobre los **48 clientes compradores**, ya que son los que realmente han generado ingresos para el negocio.

## 3. ¿Quién genera más ingresos?

Para identificar a los clientes de mayor valor económico, se calcula el total de ingresos generado por cada cliente y se ordenan de mayor a menor.

Los **10 clientes con mayores ingresos** forman el grupo VIP.

El criterio se basa en el **20 % de los clientes compradores**:

**20 % de 48 = 9,6 → 10 clientes VIP**

Los ingresos de los clientes se calculan a partir de la cantidad vendida y el precio unitario de los productos incluidos en sus pedidos completados.

## 4. ¿Se cumple el principio de Pareto?

El criterio del 20 % está inspirado en el **principio de Pareto (80/20)**, según el cual aproximadamente el 20 % de los clientes puede generar el 80 % de los ingresos.

En este análisis se comprueba si esta relación se cumple en el negocio.

Los **10 clientes VIP**, que representan el **20 % de los clientes compradores**, generan **10.074,20 €**, aproximadamente el **39,5 % de los ingresos totales**.

Por tanto, los datos **no muestran una distribución 80/20**. Los ingresos están más distribuidos entre la clientela y el negocio no depende mayoritariamente de los clientes VIP.

## 5. ¿Qué peso tienen los clientes VIP?

Los 10 clientes VIP generan **10.074,20 €**, que representan aproximadamente el **39,5 % de los ingresos totales**.

Los **38 clientes no VIP** generan los **15.440,70 € restantes**, aproximadamente el **60,5 %**.

Aunque la mayor parte de los ingresos procede de los clientes no VIP, existe una diferencia importante en el ingreso medio:

* **Cliente VIP:** aproximadamente **1.007 €**.
* **Cliente no VIP:** aproximadamente **406 €**.

Un cliente VIP genera de media unas **2,5 veces más ingresos** que un cliente no VIP.

Por tanto, aunque los ingresos están relativamente distribuidos, los clientes VIP tienen un **valor individual claramente superior**.

## 6. ¿Qué pasa con las devoluciones?

Los clientes VIP acumulan un **impacto de devoluciones de 1.738,30 €**.

Este impacto no está repartido de la misma manera entre todos los clientes.

Destaca especialmente el **cliente 9**, que genera **1.364,30 € de ingresos**, pero acumula **604,50 € de impacto por devoluciones**.

En cambio, los clientes **31, 34, 36 y 41** no presentan devoluciones.

Esto muestra que para conocer el valor real de un cliente VIP **no basta con analizar sus ingresos**, sino que también hay que considerar el impacto económico de sus devoluciones.

## 7. ¿Cuál es el valor real de los clientes VIP?

Para obtener una visión más completa del valor de los clientes, se resta a los ingresos el impacto económico de las devoluciones:

**Valor real = ingresos − reembolsos − costes de gestión**

En el conjunto de clientes VIP:

* **Ingresos:** 10.074,20 €
* **Impacto de devoluciones:** 1.738,30 €
* **Valor real:** **8.335,90 €**

El impacto de las devoluciones puede modificar de forma significativa el ranking de los clientes.

Por ejemplo, el **cliente 9** ocupa el segundo puesto por ingresos, pero desciende al séptimo puesto cuando se analiza su valor real después de devoluciones.

Por tanto, analizar únicamente los ingresos puede sobreestimar el valor de determinados clientes.

## 8. ¿Por qué se producen las devoluciones?

Entre los clientes VIP, los principales motivos de devolución son:

* **Producto defectuoso:** 6 devoluciones, con un impacto de **444,40 €**.
* **Llegó dañado:** 3 devoluciones, con un impacto de **529,60 €**.

Estos dos motivos concentran **974,00 €**, aproximadamente el **56 % del impacto total de las devoluciones de los VIP**.

Además, las devoluciones **no se concentran en un producto concreto**.

Por ello, se propone revisar los procesos de **calidad, preparación y envío** para identificar posibles causas de estos problemas.

## 9. Conclusiones

El análisis muestra que:

* El grupo VIP representa el **20 % de los clientes compradores**, pero genera aproximadamente el **39,5 % de los ingresos**.
* Los datos **no muestran una distribución 80/20**, por lo que los ingresos están relativamente distribuidos entre la clientela.
* Los clientes VIP tienen un valor individual superior y generan de media unas **2,5 veces más ingresos** que los clientes no VIP.
* Las devoluciones tienen un impacto relevante dentro del grupo VIP y pueden modificar de forma significativa el ranking de clientes.
* El **cliente 9** destaca por su elevado impacto de devoluciones, que reduce considerablemente su valor real.
* Los motivos **"producto defectuoso"** y **"llegó dañado"** concentran aproximadamente el **56 % del impacto económico** de las devoluciones de los VIP.
* No se observa una **concentración clara de las devoluciones en un producto concreto**.

## 10. Acciones propuestas

**1. Revisar los procesos de preparación y envío**

Analizar los casos de productos defectuosos o dañados para identificar posibles causas y reducir el impacto de las devoluciones.

**2. Hacer seguimiento de los clientes VIP con mayor impacto de devoluciones**

Analizar especialmente los clientes **9, 13 y 15** y realizar un seguimiento posterior a la mejora de los procesos de preparación y envío para comprobar si disminuyen sus devoluciones.

**3. Trabajar la fidelización de los clientes próximos al grupo VIP**

Identificar a los clientes que generan ingresos elevados pero todavía no pertenecen al grupo VIP y plantear acciones de fidelización, como **ventajas por recurrencia, programas de puntos o promociones personalizadas**, con el objetivo de aumentar su valor.

