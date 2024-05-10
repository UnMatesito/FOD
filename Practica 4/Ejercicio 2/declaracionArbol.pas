program arbolBconIndices;
const
    M = //Orden

type
    alumno = record
        nombreYApellido: string[50];
        dni: integer;
        legajo: string;
        anioIngreso: integer;
    end;

    nodos = record
        cant_datos : integer;
        datos: array[1..M-1] of integer; //Elegimos el DNI
        enlace: array[1..M-1] of integer;
        hijos: array[1..M] of integer;
    end;

    archivo_alumnos = file of alumno;

    arbol = file of nodos;

// Modulos y cuerpo del programa