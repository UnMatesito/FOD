# Ejercicio 17

Arbol B+

Orden: 4

Politica de resolución de underflow: Derecha

---

### Arbol Inicial

<p align="center">
    <img src="Arbolinicial.jpg" alt="Arbol Incial"/>
</p>

### Inserción de la clave 120

Para la inserción de la clave debemos leer el nodo 2 y como sabemos que 120 es mayor que 66 nos vamos al nodo 1, avanzo por el nodo 1 y determianmos que debemos insertarlo al final del nodo 1, lo cual causa **Overflow**

Para resolverlo dividimos el nodo 1 y creamos 2 nuevos nodos (2 escrituras) (66,67,[89],120) determinamos que 89 es la clave media, es decir va a ser un nuevo separador y lo insertamos en el nodo 2 debido a que hay espacio y en el nuevo nodo insertamos las claves 89 y 120.

<p align="center">
    <img src="Arbol+120.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L2, L1, E1, E2, E3

### Inserción de la clave 110

Para la inserción de la clave debemos leer el nodo 2 y como sabemos 110 es mas grande que 66 y 89 por lo que me dirijo al nodo 3 donde hay valores mas grandes. Voy leyendo el nodo 2 hasta que encuentro que 110 es mas grande que 120 pero mas pequeño que 89 por lo que lo inserto en el medio.

No ocurre ningun problema de debordamiento de claves.

<p align="center">
    <img src="Arbol+110.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L2, L3, E3

### Inserción de la clave 52

Para la inserción de la clave debemos leer el nodo 2 y como sabemos que 52 es menor que 66 me dirijo al nodo 0 y lo leo. Cunado se va leyendo el nodo 0 se determina que 52 es mas grande que 45, por lo que la clave se inserta al final.

No ocurre ningun problema de debordamiento de claves.

<p align="center">
    <img src="Arbol+52.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L2, L0, E0

### Inserción de la clave 70

Para la inserción de la clave debemos leer el nodo 2 y como sabemos que 70 es mas grande que 66 pero mas pequeño que 89, nos dirijimos al nodo 1. Cuando se va leyendo en nodo 1 se determina que 70 es mas grande que todas las demas claves por lo que se inserta el 70 al final del nodo

No ocurre ningun problema de debordamiento de claves.

<p align="center">
    <img src="Arbol+70.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L2, L1, E1

### Inserción de la clave 15

Para la inserción de la clave debemos leer el nodo 2 y sabemos que 15 es menor que todas las demas claves por lo que me dirijo al nodo 0. Cuando se va leyendo en el nodo 0 se determina que el 15 la clave mas pequeña, por lo que se inserta el 15 al comienzo del nodo 0.

Esta inserción genera **Overflow** por lo que debemos dividir el nodo 0 en 2 creando 2 nuevos nodos (2 Escrituras) al dividir el nodo en 2 (15,23,[45],52) determinamos que 45 es el elemento medio, esto quiere decir que es va a crearse un nuevo separador con dicha clave.

<p align="center">
    <img src="Arbol+15.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L2, L0, E0, E2, E4

### Eliminación de la clave 45

Para la eliminación de la clave primero debemos llegar a la clave en un nodo terminal (los separadores no pueden eliminarse) es decir que leemos el nodo 2 y determinarmos que 45 se debe encontrar en el nodo 4, por lo que me dirijo a ese nodo. Recorriendo el nodo 4 (lectura) encontramos la clave a eliminar y se elimina (Escritura).

No se produce ninun problema de nodos vacios

<p align="center">
    <img src="Arbol-45.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L2, L4, E4

### Eliminación de la clave 52

Para la eliminación de la clave primero debemos llegar a la clave en un nodo terminal (los separadores no pueden eliminarse) es decir que leemos el nodo 2 y determinarmos que 52 se debe encontrar en el nodo 4 (mayor que 45 y menor que 66), por lo que me dirijo a ese nodo. Recorriendo el nodo 4 (lectura) encontramos la clave a eliminar y se elimina (Escritura).

Pero el nodo 4 queda vacio es decir no cumple con la propiedad de minimo de elementos, por lo que se genera **Underflow**, lo primero que debemos considerar es **redistributir las claves**, debemos basarnos en la politica de resolucion de underflows, que en este caso es de Derecha, es decir que nos vamos al nodo adyacente de la derecha (lectura).

La redistribucion de claves genera que se elimine el separador 66 y que 67 sea un nuevo separador, ahora 66 es el nuevo elemento del nodo 4

<p align="center">
    <img src="Arbol-52.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L2, L4, E4, L1, E2, E4
