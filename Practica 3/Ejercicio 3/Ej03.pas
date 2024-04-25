program E03P3;
const
    valorAlto = 9999;

type
    novela = record
        cod: integer;
        genero: string;
        nombre: string;
        duracion: integer;
        director: string;
        precio: real;
    end;

    archivo_novelas = file of novela;

procedure cargarNovela(var nov: novela);
begin
    with nov do
        begin
            writeln('Ingrese el codigo de la novela');
            readln(cod);
            if (cod <> valorAlto) then
                begin
                    writeln('Ingrese el genero de la novela');
                    readln(genero);
                    writeln('Ingrese el nombre de la novela');
                    readln(nombre);
                    writeln('Ingrese la duracion de la novela');
                    readln(duracion);
                    writeln('Ingrese el director de la novela');
                    readln(director);
                    writeln('Ingrese el precio de la novela');
                    readln(precio);
                end;
            writeln();
        end;
end;

procedure crearArchivoNovelas(var archivo: archivo_novelas);
var
    nov: novela;
begin
    Rewrite(archivo);
    //Creacion para la recuperacion de espacio libre con lista invertida
    nov.cod := 0;
    write(archivo, nov);
    //Carga de Novelas
    cargarNovela(nov);
    while (nov.cod <> valorAlto) do
        begin
            write(archivo, nov);
            cargarNovela(nov);
        end;
    close(archivo);
end;

procedure leer(var archivo: archivo_novelas; var dato: novela);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.cod := valorAlto;
end;

procedure generarAlta(var archivo: archivo_novelas);
var
    nov, aux: novela;
begin
    Reset(archivo);
    leer(archivo, nov);
    if (nov.cod < 0) then
        begin
            seek(archivo, abs(nov.cod));
            read(archivo, aux);
            seek(archivo, filepos(archivo)-1);
            cargarNovela(nov);
            write(archivo, nov);
            seek(archivo, 0);
            write(archivo, aux);
        end
    else
        begin
            seek(archivo, FileSize(archivo));
            cargarNovela(nov);
            write(archivo, nov);
        end;
    close(archivo);
end;

procedure modificarNovela(var archivo: archivo_novelas);
var
    codigoABuscar: integer;
    nov: novela;
begin
    writeln('Ingrese el codigo de novela a buscar');
    readln(codigoABuscar);
    Reset(archivo);
    leer(archivo, nov);
    while (nov.cod <> valorAlto) do
        begin
            leer(archivo, nov);
            if (nov.cod = codigoABuscar) then
                begin
                    writeln('Codigo de novela encontrado');
                    writeln();
                    with nov do
                        begin
                            writeln('Ingrese un nuevo genero');
                            readln(genero);
                            writeln('Ingrese un nuevo nombre');
                            readln(nombre);
                            writeln('Ingrese una nueva duracion');
                            readln(duracion);
                            writeln('Ingrese una neuvo director');
                            readln(director);
                            writeln('Ingrese una nuevo precio');
                            readln(precio);
                        end;
                    seek(archivo, filepos(archivo)-1);
                    write(archivo, nov);
                end;
        end;
    close(archivo);
end;

procedure eliminarNovela(var archivo: archivo_novelas);
var
    codEliminar: integer;
    nov: novela;
    pos: integer;
    aux: novela;
begin
    writeln('Ingrese un codigo de novela a eliminar');
    readln(codEliminar);
    Reset(archivo);
    leer(archivo, aux); // me guardo lo que vale la cabecera y avanza donde se encuentran los datos
    leer(archivo, nov);
    while (nov.cod <> valorAlto) do
        if (nov.cod = codEliminar) then
            begin
                nov.cod := aux.cod;
                seek(archivo, filepos(archivo)-1);
                pos := filepos(archivo) * -1;
                write(archivo, nov);
                seek(archivo, 0);
                aux.cod := pos;
                write(archivo, aux);
            end
        else
            leer(archivo, nov);
    close(archivo);
end;

procedure opcionesB(var archivo: archivo_novelas);
var
    opcion: char;
begin
    writeln();
    writeln('Ingrese una Opcion');
    writeln();
    writeln('A: Dar de alta una novela');
    writeln('B: Modificar una novela');
    writeln('C: Eliminar una novela');
    writeln();
    write('Opcion '); readln(opcion);
    opcion := UpCase(opcion);
    case opcion of
        'A': generarAlta(archivo);
        'B': modificarNovela(archivo);
        'C': eliminarNovela(archivo);
        else writeln('La opcion ingresada no existe');
    end;
end;

procedure crearTxt(var archivo: archivo_novelas);
var
    novTxt: Text;
    nov: novela;
begin
    Assign(novTxt, 'novelas.txt');
    rewrite(novTxt);
    Reset(archivo);
    leer(archivo, nov);
    while (nov.cod <> valorAlto) do
        begin
            leer(archivo, nov);
            writeln(novTxt, 'Codigo: ', nov.cod, ' Nombre: ', nov.nombre);
            writeln(novTxt, 'Duracion: ', nov.duracion, ' Genero: ', nov.genero);
            writeln(novTxt, 'Precio: ', nov.precio:0:2, ' Director: ', nov.director);
            writeln(novTxt, '');
        end;
    close(novTxt);
    close(archivo);
end;


var
    archivo: archivo_novelas;
    loop: boolean;
    opcion: char;
begin
    Assign(archivo, 'Archivo_Novelas');
    loop := true;
    while (loop) do
        begin
            writeln('-EJERCICIO 3-----------------------------------------');
            writeln();
            writeln('Ingrese una opcion');
            writeln();
            writeln('A: Crear archivo');
            writeln('B: Mantenimiento del archivo');
            writeln('C: Exportar Datos a un archivo de texto');
            writeln();
            write('Opcion '); readln(opcion);
            opcion := UpCase(opcion);
            case opcion of
                'A': crearArchivoNovelas(archivo);
                'B': opcionesB(archivo);
                'C': crearTxt(archivo);
                else
                    begin
                        writeln('La Opcion ingresada no existe');
                        loop := false;
                    end;
            end;
        end;
end.