program E01P4;

type
    alumno = record
        nombreYApellido: string[50];
        dni: integer;
        legajo: string;
        anioIngreso: integer;
    end;

    nodo = record
        cant_datos: integer;
        datos: array [1..M-1] of alumno;
        hijos: array [1..M] of integer;
    end;

    arbolB = file of nodo;