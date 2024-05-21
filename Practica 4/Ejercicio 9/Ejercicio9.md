# Ejercicio 9

### Arbol Inicial

<p align="center">
    <img src="ArbolInicial.jpg" alt="Arbol Inicial"/>
</p>

### Inserción de la clave 15

Al realizar la inserción de la clave 15 ocurre **Overflow** por lo que se debe dividir el nodo 0 (raiz) y crear 2 nuevos nodos, es decir se aumenta la altura. Al realizar la division nos quedamos que 78 como elemento medio y los demas se distribuyen a los demas nodos (15,34,56,[78],100, 176). La raiz pasa a ser el nodo 2

<p align="center">
    <img src="Arbol15.jpg" alt="Arbol con la clave 15 insertada"/>
</p>

#### Lecturas y Escrituras

- Lectura en el nodo 0 (raiz)
- Escritura de la clave en el nodo 0
- Se produce Overflow, se divide y acomodan los nodos

### Inserción de la clave 71

Se inserta la clave 71 en el nodo 0, lo cual no causa problemas.

<p align="center">
    <img src="Arbol71.jpg" alt="Arbol con la clave 15 insertada"/>
</p>

#### Lecturas y Escrituras

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 0
- Escritura de la clave 71 en el nodo 0

### Inserción de la clave 3

Se inserta la clave 3 en el nodo 0, lo cual no causa problemas.

<p align="center">
    <img src="Arbol3.jpg" alt="Arbol con la clave 15 insertada"/>
</p>

#### Lecturas y Escrituras

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 0
- Escritura de la clave 3 en el nodo 0

### Inserción de la clave 48

Se inserta la clave 48 en el nodo 0, lo cual causa **Overflow** por lo que se debe dividir el nodo 0 y crear 2 nuevos nodos. Al realizar la division nos quedamos que 48 es la mitad, es decir va a ser una nueva clave de la raiz y la parte mas derecha va a ser las claves que compongan el nodo 3. (3,15,34,[48],56,71)

<p align="center">
    <img src="Arbol48.jpg" alt="Arbol con la clave 15 insertada"/>
</p>

#### Lecturas y Escrituras

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 0
- Escritura de la clave 48 en el nodo 0
- Division y reacomodamiento de claves
  
### Eliminación de la clave 56

Se elimina la clave 56 del nodo 3, lo cual no causa problemas.

<p align="center">
    <img src="Arbol56.jpg" alt="Arbol con la clave 15 insertada"/>
</p>

#### Lecturas y Escrituras

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 3
- Eliminacion de la clave 56 del nodo 3 (Escritura)

### Eliminación de la clave 71

Se elimina la clave 71 del nodo 3, lo cual causa **Underflow** para solucionar esto se debe pénsar en la politica de resolucion de underflow, que en este caso es derecha o izquierda, por lo tanto primero se pregunta si el nodo 3 tiene un adyacente derecho, el cual es el nodo 1 por lo que se redistribuyen las claves para resolver el underflow.

<p align="center">
    <img src="Arbol-71.jpg" alt="Arbol con la clave 15 insertada"/>
</p>

#### Lecturas y Escrituras

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 3
- Eliminación de la clave 71 del nodo 3 (Escritura)
- Redistribucion por Underflow
- Lectura en el nodo 3
- Lectura en el nodo 2
- Escritura de la clave 100 en el nodo 2 (raiz)
- Escritura de la clave 78 en el nodo 3