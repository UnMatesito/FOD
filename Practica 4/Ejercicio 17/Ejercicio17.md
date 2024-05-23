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

Para la inserción de la clave debemos leer el nodo 2 y como sabemos que 70 es mas grande que 66 pero mas pequeño que 89, nos dirigimos al nodo 1. Cuando se va leyendo en nodo 1 se determina que 70 es mas grande que todas las demas claves por lo que se inserta el 70 al final del nodo

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

No se produce ningun problema de nodos vacios.

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

### Inserción de la clave 22

Para la inserción de la clave primero debemos leer el nodo 2 (raiz) donde determinamos que 22 es menor a 45, es decir que nos dirigimos al nodo 0. Cuando realizamos la lectura en el nodo 0 llegamos a que 22 es mayor a 15 y menor que 23, es decir insertamos la clave en el medio.

No ocurre ningun problema de debordamiento de claves.

<p align="center">
    <img src="Arbol+22.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L2, L0, E0

### Inserción de la clave 19

Para la inserción de la clave, primero debemos leer el nodo 2 (raiz) donde determinamos que 10 es menor que 45, es decir que nos dirigimos al nodo 0. Cuando realizamos la lectura en el nodo 0 llegamos a que 19 es mayor que 15 y menor a 22, es decir que lo insertamos en el medio.

Al realizar la inserción de la clave 19 ocurre **Overflow** en el nodo 0 por lo que debemos dividir el nodo 0 en 2 (2 escrituras) y con los 2 nuevos nodos (15,19,[22],23) se determina que la clave 22 es un nuevo separador y en el nodo 5 se inserta el 22 y 23.

Cuando se inserta el nuevo separador vuelve a ocurrir **Overflow** en el nodo 2, por lo tanto debemos divir las claves en 2 y crear 2 nuevos nodos (2 escrituras) al dividir las claves (22,45,[67],89), el separador 67 se promociona en el nuevo nodo (nodo 7) y las demas claves se distribuyen en los demas nodos (lo taratamos como un arbol B). Ahora la raiz pasa a ser el nodo 7.

<p align="center">
    <img src="Arbol+19.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L2, L0, E0, E5, E2, E6, E7

### Eliminación de la clave 66

Para la eliminación de la clave primero debemos llegar a los nodos terminales para realizar la eliminacion, por lo tanto leemos el nodo 7 (raiz) y sabemos que 66 es menor que 67 por lo que nos dirigimos al nodo 2, cuando leemos al nodo 2 determinamos que la clave 66 es mas grande que las demas claves, por lo tanto nos dirigimos al nodo 4. Cuando leemos el nodo 4 encoentramos la clave 66 y eliminamos dicho elemento (escritura).

La eliminacion de la clave 66 produce **Underflow** por lo que debo redistribuir primero con el hermano adyacente derecho (politica de derecha) como no puedo intento fusionar con el hermano adyacente derecho, lo cual tampoco puedo (no existe un hermano adyacente). Se produce un **Caso Especial**, es decir debo fijarme si puedo redistribuir con el hermano adyacente de cualquier lado (izquiero o derecho) sino fusiono. como el nodo 4 posee de adyacente el nodo 5 redistribuyo con el nodo 5.

Elimino el separador 45 y promociono el 23 tanto como separador (para el nodo 2) como clave para el nodo 4.

<p align="center">
    <img src="Arbol-66.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L7, L2, L4, L5, E2, E4

### Eliminación de la clave 22 

Para la eliminación de la clave primero debemos llegar a los nodos terminales para realizar la eliminacion, por lo tanto leemos el nodo 7 (raiz) y sabemos que 22 es menor que 67 por lo que nos dirigimos al nodo 2, cuando leemos al nodo 2 determinamos que la clave 22 es igual a 22 pero menor que 23, por lo tanto nos dirigimos al nodo 5. Cuando leemos el nodo 5 encoentramos la clave 22 y eliminamos dicho elemento (escritura).

La eliminación de la clave 22 produce **Underflow** por lo que primero pregunto si puedo redistribuir con el hermano adyacente derecho, como no puedo, fusiono el nodo 5 con el 4 quedandome el nodo 4 con la clave 23. El separador 23 se elimina debio a que no es mas necesario.

<p align="center">
    <img src="Arbol-22.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L7, L2, L5, E4

### Eliminacion de la clave 19

Para la eliminación de la clave primero debemos llegar a los nodos terminales para realizar la eliminacion, por lo tanto leemos el nodo 7 (raiz) y sabemos que 19 es menor que 67 por lo que nos dirigimos al nodo 2, cuando leemos al nodo 2 determinamos que la clave 19 es menor que 22, por lo tanto nos dirigimos al nodo 0. Cuando leemos el nodo 0 encoentramos la clave 19 y eliminamos dicho elemento (escritura).

No se produce ningun problema de nodos vacios.

<p align="center">
    <img src="Arbol-19.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L7, L2, L5, E4

### Eliminacion de la clave 23

Ocurre **Underflow** no puedo realizar la redistribucion, intento fusionar con el hermano adyacente derecho, no puedo tampoco, ocurre un **Caso Especial**, intento redistribuir (no es posible), fusiono con el nodo 0

<p align="center">
    <img src="Arbol-23.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L7, L2, L4, E4

### Eliminacion de la clave 89

No se produce ningun problema de nodos vacios.

<p align="center">
    <img src="Arbol-89.jpg" alt="Arbol Incial"/>
</p>

#### Lecturas y Escrituras

L7, L6, L3, E3