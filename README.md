# Walk & Run House — Análisis del valor de clientes VIP

Proyecto de análisis de datos con **SQL** sobre una tienda de calzado ficticia.

El proyecto parte del diseño de una base de datos, continúa con la inserción y limpieza de los datos y termina con un análisis del valor de los clientes, teniendo en cuenta tanto los ingresos generados como el impacto de las devoluciones.

## 1. Pregunta de negocio

Dentro de nuestros mejores clientes (VIP), ¿quién es realmente valioso una vez descontado el impacto de las devoluciones y a quién conviene revisar?

El análisis se centra en comparar los clientes del grupo VIP entre sí para identificar diferencias en el valor que generan y detectar posibles oportunidades de mejora.

## 2. Datos utilizados

Para el análisis se utilizan las siguientes tablas:

* `clientes_limpios`
* `pedidos_limpios`
* `detalle_pedidos_limpios`
* `devoluciones_limpios`
* `productos_limpios`

Se consideran únicamente los pedidos con estado **completado**.

## 3. Separación entre clientes compradores y no compradores

La base de datos contiene **50 clientes registrados**.

Al analizar los pedidos completados, se observa que:

* **48 clientes** han realizado al menos una compra.
* **2 clientes** no tienen compras completadas.

Esta separación permite trabajar con los clientes que realmente han generado ingresos para el negocio.

## 4. Criterio del grupo VIP e identificación de los clientes VIP

Para definir el grupo VIP se utiliza como criterio que pertenezcan al **20 % de los clientes compradores con mayores ingresos**.

El 20 % de los 48 clientes compradores corresponde a **10 clientes**, que forman el grupo VIP.

Este 20 % es un criterio definido para el análisis y no una regla fija del negocio.

Los 10 clientes VIP son:

| Cliente |   Ingresos |
| ------- | ---------: |
| 31      | 1.613,50 € |
| 9       | 1.364,30 € |
| 19      | 1.083,90 € |
| 1       | 1.053,50 € |
| 34      |   934,00 € |
| 13      |   882,90 € |
| 15      |   794,30 € |
| 36      |   783,00 € |
| 41      |   782,70 € |
| 11      |   782,10 € |

## 5. Peso del grupo VIP y no VIP en el negocio

Los 10 clientes VIP generan **10.074,20 €**, que representan aproximadamente el **39,5 % de los ingresos totales**.

Los 38 clientes no VIP generan los **15.440,70 € restantes**, aproximadamente el **60,5 %**.

El ingreso medio también muestra una diferencia importante:

* **Cliente VIP:** aproximadamente 1.007 €.
* **Cliente no VIP:** aproximadamente 406 €.

Por tanto, un cliente VIP genera de media unas **2,5 veces más ingresos** que un cliente no VIP.

El negocio está relativamente repartido y no depende mayoritariamente del grupo VIP, aunque estos clientes tienen un valor individual claramente superior.

## 6. Impacto de las devoluciones en los VIP

Los clientes VIP acumulan un impacto de devoluciones de **1.738,30 €**.

El impacto no está repartido de la misma manera entre todos los clientes.

Destaca especialmente el **cliente 9**, que genera 1.364,30 € de ingresos pero acumula **604,50 € de impacto por devoluciones**.

También presentan un impacto elevado los clientes **13 y 15**, con 294,70 € cada uno.

En cambio, los clientes **31, 34, 36 y 41** no presentan devoluciones.

Esto muestra que pertenecer al grupo VIP por volumen de ingresos no significa necesariamente que todos los clientes tengan el mismo valor una vez consideradas las devoluciones.

## 7. Valor de los clientes después de devoluciones

El resultado permite comparar el valor de los clientes después de considerar el impacto económico de sus devoluciones.

El cliente 9 es el caso más relevante: pasa de ser el **segundo cliente con mayores ingresos** a ocupar una posición mucho más baja cuando se tienen en cuenta sus devoluciones.

Sus ingresos pasan de **1.364,30 € a 759,80 €**.

Esto muestra que analizar únicamente los ingresos puede sobreestimar el valor real de determinados clientes.

## 8. Motivos de devolución

Los principales motivos de devolución entre los clientes VIP son:

* **Producto defectuoso:** 6 devoluciones, con un impacto de 444,40 €.
* **Llegó dañado:** 3 devoluciones, con un impacto de 529,60 €.

Estos dos motivos concentran **974,00 €**, aproximadamente el **56 % del impacto total de las devoluciones de los VIP**.

Aunque "producto defectuoso" presenta más devoluciones, "llegó dañado" genera un mayor impacto económico.

Además, las devoluciones no se concentran en un producto concreto.

Por ello, se propone revisar los procesos de **calidad, preparación y envío** para identificar posibles causas de estos problemas.

## 9. Conclusiones

El análisis muestra que:

* El grupo VIP representa el **20 % de los clientes compradores**, pero genera aproximadamente el **39,5 % de los ingresos**.
* Los clientes VIP generan, de media, unas **2,5 veces más ingresos** que los clientes no VIP.
* El negocio no depende exclusivamente de los clientes VIP, ya que la mayor parte de los ingresos procede del resto de clientes.
* Las devoluciones tienen un impacto relevante dentro del grupo VIP.
* El cliente 9 destaca por su elevado impacto de devoluciones y muestra cómo el ranking de clientes puede cambiar cuando se tiene en cuenta el valor después de devoluciones.
* Los motivos "producto defectuoso" y "llegó dañado" concentran una parte importante del impacto económico de las devoluciones.
* No se observa una concentración clara de las devoluciones en un producto concreto.

## 10. Acciones propuestas

**1. Revisar los procesos de calidad, preparación y envío**

Analizar los casos de productos defectuosos o dañados para identificar posibles causas y reducir el impacto de las devoluciones.

**2. Revisar los clientes VIP con mayor impacto de devoluciones**

Analizar especialmente los clientes 9, 13 y 15 para identificar patrones y entender por qué una parte importante de sus ingresos termina afectada por devoluciones.

**3. Trabajar la fidelización de los clientes próximos al grupo VIP**

Identificar a los clientes que generan ingresos elevados pero todavía no pertenecen al grupo VIP y plantear acciones de fidelización, como ventajas por recurrencia, programas de puntos o promociones personalizadas, con el objetivo de aumentar su valor.

