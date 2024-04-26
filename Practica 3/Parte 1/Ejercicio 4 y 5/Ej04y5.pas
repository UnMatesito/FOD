program E04P3;
const
    valorAlto = 9999;

type
    reg_flor = record
        nombre: string[45];
        codigo: integer;
    end;

    tArchFlores = file of reg_flor;

procedure cargarFlor(var flor: reg_flor);
begin
    with flor do
        begin
            writeln('Ingrese el nombre de la Flor');
            readln(nombre);
            if (nombre <> 'ZZZ') then
                begin
                    writeln('Ingrese el codigo de la flor');
                    readln(codigo);
                end;
            writeln();
        end;
end;

procedure crearArchivoFlores(var archivo: tArchFlores);
var
    flor: reg_flor;
begin
    Rewrite(archivo);
    flor.codigo := 0;
    write(archivo, flor);
    cargarFlor(flor);
    while (flor.nombre <> 'ZZZ') do
        begin
            write(archivo, flor);
            cargarFlor(flor);
        end;
    close(archivo);
end;

procedure leer(var archivo: tArchFlores; var dato: reg_flor);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.codigo := valorAlto;    
end;

//Ejercicio 4
procedure agregarFlor(var a: tArchFlores; nombre: string; codigo: integer);
var
    flor, aux: reg_flor;
begin
    reset(a);
    leer(a, flor);
    if (flor.codigo < 0) then
        begin
            seek(a, abs(flor.codigo)); //Consigo de la cabecera la posicion de la cabecera
            read(a, aux); //Me guardo esa posicion en aux
            seek(a, filepos(a)-1);
            flor.nombre := nombre;
            flor.codigo := codigo;
            write(a, flor); //Inserto en esa posicion los datos de la alta
            seek(a, 0); //vuelvo a la cabecera
            write(a, aux); //Inserto la nuevo poscion de la cabecera
        end
    else
        begin
            seek(a, FileSize(a)); //Agrego los datos al final del archivo
            flor.nombre := nombre;
            flor.codigo := codigo;
            write(a, flor);
        end;
    close(a);
end;

//Ejercicio 5
procedure eliminarFlor(var a: tArchFlores; flor: reg_flor);
var
    vflor, aux: reg_flor;
begin
    reset(a);
    leer(a, aux); //me guardo el valor de la cabecera en aux
    leer(a, vflor);
    while (vflor.codigo <> valorAlto) do
        begin
            if (vflor.codigo = flor.codigo) and (vflor.nombre = flor.nombre) then
                begin
                    vflor.codigo := aux.codigo;
                    seek(a, filepos(a)-1);
                    aux.codigo := filepos(a) * -1;
                    write(a, vflor);
                    seek(a, 0);
                    write(a, aux);
                end
            else
                leer(a, vflor);
        end;
    close(a);
end;

procedure listarArchivo(var archivo: tArchFlores);
var
    flor: reg_flor;
begin
    reset(archivo);
    while (not eof(archivo)) do
        read(archivo, flor);
        if (flor.codigo > 0) then
            writeln('Nombre: ', flor.nombre);
            writeln('Codigo: ', flor.codigo);
            writeln();
    close(archivo);
end;

var
    archivo: tArchFlores;
    flor: reg_flor;
    nombre: string;
    codigo: integer;
begin
    Assign(archivo, 'Archivo_Flores');
    crearArchivoFlores(archivo);
    writeln('Eliminacion de una flor');
    writeln();
    writeln('Ingrese el nombre de la flor a eliminar');
    readln(flor.nombre);
    writeln('Ingrese el codigo de la flor a eliminar');
    readln(flor.codigo);
    eliminarFlor(archivo, flor);
    listarArchivo(archivo);
    writeln('Dar de alta una flor');
    writeln();
    writeln('Ingrese un nuevo nombre');
    readln(nombre);
    writeln('Ingrese un nuevo codigo');
    readln(codigo);
    agregarFlor(archivo, nombre, codigo);
    listarArchivo(archivo);
end.