program E08P3;
const
    valorAlto = 'ZZZ';

type
    distribucion = record
        nombre: string;
        anioLanzamiento: integer;
        versionKernel: string;
        cantDesarroladores: integer;
        descripcion: string;
    end;

    archivo_Distribuciones = file of distribucion;

procedure cargarDisrtibucion(var d: distribucion);
begin
    with d do
        begin
            writeln('Ingrese el nombre de la distribucion');
            readln(nombre);
            if (nombre <> valorAlto) then
                begin
                    writeln('Ingrese el año de lanzamiento de la distribucion');
                    readln(anioLanzamiento);
                    writeln('Ingrese la version del kernel');
                    readln(versionKernel);
                    writeln('Ingrese la cantidad de desarroladores que trabajaron en la distribucion');
                    readln(cantDesarroladores);
                    writeln('Ingrese la descripcion de la distribucion');
                    readln(descripcion);
                end;
            writeln();
        end;
end;

procedure crearArchivo(var archivo: archivo_Distribuciones);
var
    d: distribucion;
begin
    rewrite(archivo);
    d.cantDesarroladores := 0;
    write(archivo, d);
    cargarDisrtibucion(d);
    while (d.nombre <> valorAlto) do
        begin
            write(archivo, d);
            cargarDisrtibucion(d);
        end;
    close(archivo);
end;

procedure leer(var archivo: archivo_Distribuciones; var datos: distribucion);
begin
    if (not eof(archivo)) then
        read(archivo, datos)
    else
        datos.nombre := valorAlto;
end;

function existeDistribucion(var archivo: archivo_Distribuciones; nombre: string): boolean;
var
    d: distribucion;
    existe: boolean;
begin
    existe := false;
    reset(archivo);
    leer(archivo, d);
    while (d.nombre <> valorAlto) do
        begin
            if(d.nombre = nombre) then
                existe := true;
            leer(archivo, d);
        end;
    close(archivo);
    existeDistribucion := existe;
end;

procedure AltaDistribucion(var archivo: archivo_Distribuciones; nueDis: distribucion);
var
    d, aux: distribucion;
begin
    if (existeDistribucion(archivo, nueDis.nombre) = false) then
        begin
            reset(archivo);
            leer(archivo, d);
            if (d.cantDesarroladores > 0) then
                begin
                    seek(archivo, abs(d.cantDesarroladores));
                    read(archivo, aux);
                    seek(archivo, filepos(archivo)-1);
                    d := nueDis;
                    write(archivo, d);
                    seek(archivo, 0);
                    write(archivo, aux);
                end
            else
                begin
                    seek(archivo, filesize(archivo));
                    d := nueDis;
                    write(archivo, d);
                end;
            close(archivo);
        end
    else
        writeln('Ya existe la distribucion');
end;

procedure BajasDistribucion(var archivo: archivo_Distribuciones; nombre: string);
var
    d, aux: distribucion;
    eliminado: boolean;
begin
    eliminado := false;
    if (existeDistribucion(archivo, nombre) = true) then
        begin
            reset(archivo);
            leer(archivo, aux);
            leer(archivo, d);
            while (d.nombre <> valorAlto) do
                begin
                    if (d.nombre = nombre) and (not eliminado) then
                        begin
                            d.cantDesarroladores := aux.cantDesarroladores;
                            seek(archivo, filepos(archivo)-1);
                            aux.cantDesarroladores := filepos(archivo) * -1;
                            write(archivo, d);
                            seek(archivo, 0);
                            write(archivo, aux);
                            eliminado := true;
                        end
                    else
                        leer(archivo, d)
                end;
            close(archivo);
        end
    else
        writeln('Distribucion no existente');
end;

procedure imprimirArchivo(var archivo: archivo_Distribuciones);
var
    d:distribucion;
begin
    reset(archivo);
    while (not eof(archivo)) do
        begin
            read(archivo, d);
            with d do
                begin
                    writeln('Nombre: ' , nombre);
                    writeln('Anio Lanzamiento: ', anioLanzamiento, ' Version del kernel: ', versionKernel);
                    writeln('Cant de desarroladores: ', cantDesarroladores, ' Descripcion: ', descripcion);
                    writeln();
                end;
        end;
    close(archivo);
end;

var
    archivo: archivo_Distribuciones;
    nombre: string;
    nueDis: distribucion;
begin
    assign(archivo, 'Archivo_Distribuciones');
    //crearArchivo(archivo);
    writeln('Eliminar una distribucion');
    writeln();
    writeln('Ingrese el nombre de una distribucion para eliminar');
    readln(nombre);
    BajasDistribucion(archivo, nombre);
    writeln();
    writeln('Archivo con baja efecutada');
    writeln();
    imprimirArchivo(archivo);
    writeln();
    writeln('Agregar una nueva distribucion');
    writeln();
    writeln('Ingrese los datos de una nueva distribucion');
    cargarDisrtibucion(nueDis);
    AltaDistribucion(archivo, nueDis);
    writeln();
    writeln('Archivo con la alta efectuada');
    writeln();
    imprimirArchivo(archivo);
end.