%Constantes
include "globals.mzn";

%Dimensiones del Kakuro
int: sizefila;
int: sizecolumna;
set of int: filas = 1..sizefila;
set of int: columnas = 1..sizecolumna;

%Creacion de un tablero con un margen extra para realizar comparaciones
set of int: filasE = 0..sizefila+1;
set of int: columnasE = 0..sizecolumna+1;

%Creacion de matrices en capas, sirve para evaluar los margenes del tablero
array[filas,columnas] of int: margen;
array[filas,columnas] of int: derecha;
array[filas,columnas] of int: abajo;

%Variables
%Tablero donde iran los resultados del problema
array[filasE,columnasE] of var 0..9: kakuro;

%Restricciones
%Llos limites del tablero deben ser 0
constraint forall(i in filasE)(kakuro [i,0] = 0);
constraint forall(j in columnasE)(kakuro [0,j] = 0);
constraint forall(i in filasE)(kakuro[i,sizecolumna+1] = 0);
constraint forall(j in columnasE)(kakuro[sizefila+1,j] = 0);

%Los margenes propuestos por el kakuro debe ser 0
constraint forall(i in filas, j in columnas)(if margen [i,j] = 1 then kakuro [i,j] = 0 else kakuro[i,j] != 0 endif);

%Los numeros diferentes de cero, entre dos ceros, deben ser diferentes entre si
constraint forall(i,k in filasE, j in columnasE where count(kakuro[1..k,j],0) <= 2) (if kakuro[i,j]=0 /\ kakuro[k,j]=0 then alldifferent_except_0(kakuro[i..k,j]) endif);

constraint forall(i in filasE,j,k in columnasE where count(kakuro[i,j..k],0) <=2) (if kakuro[i,j]=0 /\ kakuro[i,k]=0 then alldifferent_except_0(kakuro[i,j..k]) endif);

%La suma de los numeros de una fila o columna debe ser igual a la propuesta por el kakuro
constraint forall(i in filas, j in columnas, k in columnasE where count(kakuro[i,j..k],0) <= 2) (if derecha[i,j] != 0 /\ j<k /\ kakuro[i,k]=0 then derecha[i,j] = sum(kakuro[i,j..k]) endif);

constraint forall(i in filas, j in columnas, k in filasE where count(kakuro[i..k,j],0) <= 2) (if abajo[i,j] != 0 /\ i<k /\ kakuro[k,j]=0 then abajo[i,j] = sum(kakuro[i..k,j]) endif);

%Impresion del tablero resuelto.
output[show([kakuro[i,j] | j in columnas]) ++ "\n" | i in filas];
solve::int_search(kakuro,first_fail,indomain_median) satisfy;

