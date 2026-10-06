# Walk & Run House — Análisis del valor de clientes VIP

Proyecto de análisis de datos con **SQL** sobre una tienda de calzado ficticia.

El objetivo es identificar **1) si los ingresos están concentrados en un pequeño grupo de clientes y 2) qué clientes tienen mayor valor para el negocio**. Para ello, además de analizar los ingresos, se tiene en cuenta el impacto económico de las devoluciones.

## Pregunta de negocio

**¿Qué clientes aportan mayor valor al negocio teniendo en cuenta sus ingresos y devoluciones?**

Para responder a esta pregunta, el análisis sigue estas cuestiones:

* ¿Quién compra?
* ¿Quiénes son nuestros clientes VIP?
* ¿Se cumple el principio de Pareto?
* ¿Qué diferencia existe entre los clientes VIP y los no VIP?
* ¿Qué diferencia existe dentro del grupo VIP?
* ¿Por qué se producen las devoluciones?
* ¿Qué acciones se pueden proponer?

---

## ¿Quién compra?

La base de datos contiene **50 clientes registrados**.

Al analizar los pedidos completados, se observa que:

* **48 clientes** han realizado al menos una compra.
* **2 clientes** no tienen compras completadas.

Por tanto, el análisis de ingresos se realiza sobre los **48 clientes compradores**, ya que son los que realmente han generado ingresos para el negocio.

---

## ¿Quiénes son nuestros clientes VIP?

Para identificar a los clientes de mayor valor económico, se utiliza como referencia el **principio de Pareto (80/20)**.

Este principio plantea que, en determinados contextos, aproximadamente el **20 % de los clientes puede concentrar el 80 % de los ingresos**.

En este análisis, el **20 % se utiliza como criterio para definir el grupo VIP**, pero el 80 % no se da por supuesto: posteriormente se comprueba qué porcentaje de los ingresos genera realmente este grupo.

La base de clientes compradores está formada por **48 clientes**:

**20 % de 48 = 9,6 → 10 clientes VIP**

Por tanto, los clientes se ordenan de mayor a menor según los ingresos generados y los **10 primeros forman el grupo VIP**.

---

## ¿Se cumple el principio de Pareto?

Los **10 clientes VIP**, que representan el **20 % de los clientes compradores**, generan **10.074,20 €**, aproximadamente el **39,5 % de los ingresos totales**.

Los **38 clientes no VIP** generan los **15.440,70 € restantes**, aproximadamente el **60,5 %**.

Por tanto, los datos **no muestran una distribución 80/20**. El 20 % de los clientes no concentra el 80 % de los ingresos, sino aproximadamente el 39,5 %.

Esto indica que los ingresos están **más distribuidos entre la clientela** y que el negocio no depende mayoritariamente de los clientes VIP.

---

## ¿Qué diferencia existe entre los clientes VIP y los no VIP?

Aunque la mayor parte de los ingresos procede de los clientes no VIP, existe una diferencia importante en el ingreso medio por cliente:

* **Cliente VIP:** aproximadamente **1.007 €**.
* **Cliente no VIP:** aproximadamente **406 €**.

Un cliente VIP genera de media unas **2,5 veces más ingresos** que un cliente no VIP.

Por tanto, aunque los ingresos totales están relativamente distribuidos, los clientes VIP tienen un **valor individual claramente superior**.

---

## ¿Qué diferencia existe dentro del grupo VIP?

Los clientes VIP no tienen todos el mismo comportamiento.

Al analizar sus devoluciones, se observa que acumulan un **impacto económico de 1.738,30 €**, pero este impacto está concentrado principalmente en algunos clientes.

Destaca especialmente el **cliente 9**, que genera **1.364,30 € de ingresos**, pero acumula **604,50 € de impacto por devoluciones**.

En cambio, los clientes **31, 34, 36 y 41** no presentan devoluciones.

Por tanto, incluso dentro del grupo VIP existen diferencias importantes en el valor que aporta cada cliente al negocio.

---

## ¿Por qué se producen las devoluciones?

Entre los clientes VIP, los principales motivos de devolución son:

* **Producto defectuoso:** 6 devoluciones, con un impacto de **444,40 €**.
* **Llegó dañado:** 3 devoluciones, con un impacto de **529,60 €**.

Estos dos motivos concentran **974,00 €**, aproximadamente el **56 % del impacto total de las devoluciones de los VIP**.

Además, las devoluciones **no se concentran en un producto concreto**.

Por ello, se propone revisar los procesos de **calidad, preparación y envío** para identificar posibles causas de estos problemas y reducir el impacto de las devoluciones.

---

## Conclusiones

El análisis muestra que:

* El grupo VIP representa el **20 % de los clientes compradores**, pero genera aproximadamente el **39,5 % de los ingresos**.
* Los datos **no muestran una distribución 80/20**. Los ingresos están relativamente distribuidos entre la clientela.
* Los clientes VIP tienen un **valor individual superior** y generan de media unas **2,5 veces más ingresos** que los clientes no VIP.
* Dentro del grupo VIP existen diferencias importantes en el impacto de las devoluciones.
* Los motivos **"producto defectuoso"** y **"llegó dañado"** concentran aproximadamente el **56 % del impacto económico** de las devoluciones de los VIP.
* No se observa una **concentración clara de las devoluciones en un producto concreto**.

---

## Acciones propuestas

**1. Revisar los procesos de preparación y envío**

Analizar los casos de productos defectuosos o dañados para identificar posibles causas y reducir el impacto de las devoluciones.

**2. Hacer seguimiento del cliente VIP con mayor impacto de devoluciones**

Analizar especialmente el cliente 9, que presenta el mayor impacto de devoluciones, y realizar un seguimiento posterior a la mejora de los procesos de preparación y envío para comprobar si disminuyen sus devoluciones.

**3. Trabajar la fidelización de los clientes próximos al grupo VIP**

Identificar a los clientes que generan ingresos elevados pero todavía no pertenecen al grupo VIP y plantear acciones de fidelización, como **ventajas por recurrencia, programas de puntos o promociones personalizadas**, con el objetivo de aumentar su valor.

