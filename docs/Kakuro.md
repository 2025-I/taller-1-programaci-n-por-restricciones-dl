# Kakuro

El Kakuro es un juego tipo crucigrama derivado del Sudoku, aunque menos conocido. Este tipo de crucigramas no tiene claves verbales sino numéricas, y como en ellos, cada respuesta sirve de ayuda para resolver las otras que se cruzan. Por este motivo, el nombre original del juego era rompecabezas de sumas cruzadas. El objetivo del Kakuro es rellenar las casillas con números del 1 al 9 de forma qué en ninguna serie de números, en horizontal o vertical, se repitan y que su suma dé como resultado el número que se indica.


## Descripción Detallada
El problema de kakuro se modela como un Problema de Satisfacción por Restricciones (CSP) en Minizinc, este modelo cuenta con variables, las cuales representan las celdas del tablero y las restricciones tales como los números de celdas y columnas sean diferentes entre sí, al encontrarse vertical u horizontalmente, además de que el resultado de la suma coincida con la pista dada.


### Variables y Dominios
- Kakuro[i,j]: Representa el número en la celda (i, j) del tablero. Su dominio es {0, 1..9}, donde 0 indica una celda negra (celda vacía).
- margen[i, j]: Matriz binaria que indica si una celda es una casilla negra.
- derecha[i, j]: Matriz que almacena la suma esperada de manera horizontal.
- abajo[i, j]: Matriz que almacena la suma esperada de manera vertical.


### Restricciones
- Las celdas negras (margen[i, j] = 1) deben contener 0.
- Los números en una misma secuencia horizontal o vertical no pueden repetirse.
- Las secuencias de números deben sumar el valor especificado en las pistas.
- Los bordes del tablero extendido están definidos con ceros para facilitar el manejo de restricciones.

## Kakuro solucionado


### Tablero 1
![Imagen de la solucion](/docs/Imagenes/T1.png)


### Tablero 2
![Imagen de la solucion](/docs/Imagenes/T2.png)


### Tablero 3
![Imagen de la solucion](/docs/Imagenes/T3.png)


## Código utilizado
![Imagen del código](/docs/Imagenes/kakuro.png)


## Resultados obtenidos con las diferentes estrategias de distribución.

Se realizaron pruebas con tres estrategias diferentes.

1. first_fail + **indomain_median**: Prioriza las variables con menor dominio y selecciona valores medianos.

1. smallest + **indomain_min**: Prioriza variables con menor valor posible.
1. largest + **indomain_max**: Prioriza variables con mayor valor posible.


 ### Tiempos de Ejecución después de 3 pruebas para cada uno

|Estrategia | Tablero 1 | Tablero 2 | Tablero 3 |
| :-------: | :------: | :----: | :-----: |
|first_fail| 944.3 msec |  499 msec |  507.6 msec |
|smallest| 968.3 msec |  486 msec |  473.3 msec |
|largest | 920.3 msec |  492.6 msec | 470.6 msec |

Aunque las tres estrategias funcionan de manera diferente, sus tiempos de ejecución son relativamente similares.


## Árboles 


### first_fail


- Tablero 1

![Imagen del árbol](/docs/Imagenes/FP1.png)


- Tablero 2

![Imagen del árbol](/docs/Imagenes/FP2.png)


- Tablero 3

![Imagen del árbol](/docs/Imagenes/FP3.png)


### smallest  


- Tablero 1

![Imagen del árbol](/docs/Imagenes/SP1.png)


- Tablero 2

![Imagen del árbol](/docs/Imagenes/SP2.png)


- Tablero 3

![Imagen del árbol](/docs/Imagenes/SP3.png)


### largest  


- Tablero 1

![Imagen del árbol](/docs/Imagenes/LP1.png)


- Tablero 2

![Imagen del árbol](/docs/Imagenes/LP2.png)


- Tablero 3

![Imagen del árbol](/docs/Imagenes/LP3.png)  


## Análisis Comparativo de las Estrategias


### Ventajas y Desventajas


|Estrategia| Ventajas| Desventajas|
| :-----:| :----: | :----: |
| first_fail + indomain_median | Rápida, balanceada | Puede no ser óptima en tableros grandes |
| smallest + indomain_min | Garantiza valores bajos al inicio | Más lenta en problemas grandes |
| largest + indomain_max | Explora soluciones de mayor valor | Tiempo de ejecución más alto |


## Conclusión


Aunque las tres estrategias trabajan de manera diferente, sus tiempos de ejecución pueden ser relativamente similares en algunos casos. Para este modelado, la estrategia first_fail es una buena opción ya que esta ofrece una solución adecuada en un tiempo aceptable, pero debemos reconocer que en ciertos tableros largest tuvo una mejor respuesta, esto indica que la elección de la estrategia puede depender del tamaño y la estructura del tablero.
