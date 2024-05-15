# Ejercicio 8

### Arbol inicial

<p align="center">
    <img src="Arbol Incial.jpg" alt="Arbol Inicial"/>
</p>

### Inserción de la clave 5

Se inserta la clave 5 en el nodo 0, lo cual causa **Overflow**, para solucionar esto, se divide el nodo 0 en 2 y se selecciona como elemento medio el 32, el cual se inserta en el nodo 2 (existe un nodo padre) y se crea un nuevo nodo con la clave faltante (5,22,[32],50).

<p align="center">
    <img src="Arbol5.jpg" alt="Arbol con la clave 5 insertada"/>
</p>

#### Escrituras y Lecturas

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 0
- Creacion del nodo 3
- Escritura del 32 en el nodo 2 (raiz)
- Escritura del 5 en el nodo 0

### Inserción de la clave 9

Se inserta la clave 9 en el nodo 0, no causa ningun problema su inserción.

<p align="center">
    <img src="Arbol9.jpg" alt="Arbol con la clave 9 insertada"/>
</p>

#### Escrituras y Lecturas

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 0
- Escritura en el nodo 0

### Inserción de la clave 80

Se inserta la clave 80 en el nodo 1, lo cual causa **Overflow**, para solucionarlo, se divide el nodo 1 en 2 y se selecciona como medio la clave 80, el cual se inserta en el nodo 2 (existe un nodo padre) y se crea un nuevo nodo con la claves faltantes (77,79,[80],92).

<p align="center">
    <img src="Arbol80.jpg" alt="Arbol con la clave 80 insertada"/>
</p>

#### Escrituras y Lecturas

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 1
- Creacion del nodo 4
- Escritura del 80 en el nodo 2 (raiz)

### Inserción de la clave 51

Se inserta la clave 51 en el nodo 3, lo cual no causa ningun problema.

<p align="center">
    <img src="Arbol51.jpg" alt="Arbol con la clave 51 insertada"/>
</p>

#### Escrituras y Lecturas

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 3
- Escritura del 51 en el nodo 3

### Eliminación de la clave 50

Se elimina la clave 50 del nodo 3 y 51 pasa a ser el primera clave del nodo 3, lo cual no causa ningun problema.

<p align="center">
    <img src="Arbol50.jpg" alt="Arbol con la clave 50 eliminada"/>
</p>

#### Escrituras y Lecturas

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 3
- Escritura del 51 en la primera posicion del nodo 3

### Eliminación de la clave 92

Se elimina la clave 92 del nodo 1, lo cual causa **Underflow**, es decir hay que redistribuir o fusionar, se sabe que la politica de redistribución es derecha por lo que se busca si el nodo 1 tiene un hermano adyacente derecho, como no lo tiene se pregunta si se puede fusionar con el nodo adyacente derecho, el cual no posee. 

En este caso se genera un **Caso Especial** por lo que se debe redistribuir con el nodo adyacente que poseea que el nodo 4. Cuando ocurre esta redistribución la clave 80 pasa a ser parte del nodo raiz y se envia la clave 80 al nodo 1.

<p align="center">
    <img src="Arbol92.jpg" alt="Arbol con la clave 92 eliminada"/>
</p>

#### Escrituras y Lecturas

- Lectura en el nodo 2 (raiz)
- Lectura en el nodo 1
- Eliminación de la clave 92
- Lectura en el nodo 2 (80)
- Lectura en el nodo 4 (79)
- Escritura en la clave 79 el nodo 2 (raiz)
- Escritura de la clave 80 en el nodo 1