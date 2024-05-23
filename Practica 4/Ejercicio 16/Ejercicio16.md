# Ejercicio 16

Arbol B+

Orden: 4

Politica de resolución de underflow: Derecha

---

### Arbol Incial

<p align="center">
    <img src="Arbolinicial.jpg" alt="Arbol Inicial">
</p>

### Inserción de la clave 80

Para la inserción de la clave 80, se debe realizar una lectura en el nodo 4 (raiz) donde buscamos si 80 es mayor a 340, como no lo es nos vamos al nodo 0 donde vamos recorriendo el nodo hasta que encontramos el 77 que es el ultimo elemento por lo cual escribimos el 80 al final del nodo 0. La insercion de la clave 80 causa **Overflow**, por lo que debemos dividir el nodo en 2 (11,50,[77],80) que hace que se creen 2 nodos (2 escrituras). Con los 2 nodos creados se inserta el 77 y 80 en el nuevo nodo (nodo 5) y el 77 (elemento medio, nuevo separador) como hay lugar arriba lo insertamos en el nodo 4 lo cual causa nuevamente **Overflow**

Para solucionar esto debemos divir en 2 el nodo 4 (77,340,[400],500) se crean 2 nuevos nodos (2 escrituras). Con los 2 nuevos nodos creados se inserta el 400 (elemento medio) en el nodo 7 y la clave 500 en el nodo 6 (Al ser una redistribucion de spearadosres, se comporta como un arbol B). 

<p align="center">
    <img src="Arbol+80.jpg" alt="Arbol Inicial">
</p>

#### Escrituras y Lecturas

L4, L0, E4, E5, E6, E7

### Eliminación de la clave 400

Para la eliminación de la clave 400, debemos empezar por la raiz localizando donde se encuentra la clave 400 en un nodo terminal. Por lo tanto leemos el nodo 4, luego el nodo 6 y por ultimo el nodo 2 pero como no se encuentra en el nodo decimos que **no se puede eliminar la clave 400** (no se pueden eliminar separadores, solo claves)

<p align="center">
    <img src="Arbol+80.jpg" alt="Arbol Inicial">
</p>

#### Escrituras y Lecturas

L4, L6, L2

### Escrituras y Lecutras Totales

L4, L0 | L4, L6, L2

E4, E5, E6, E7