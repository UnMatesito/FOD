writeln('Dar de alta una flor');
    writeln();
    writeln('Ingrese un nuevo nombre');
    readln(nombre);
    writeln('Ingrese un nuevo codigo');
    readln(codigo);
    agregarFlor(archivo, nombre, codigo);
    listarArchivo(archivo);