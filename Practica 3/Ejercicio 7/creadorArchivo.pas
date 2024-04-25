program creadorArchivo;

type
    ave = record
        codigo: integer;
        nombreEspecie: string;
        familia: string;
        descripcion: string;
        zonaGeografica: string;
    end;

    archivo_Aves = file of ave;

procedure cargarAve(var a: ave);
begin
    with a do
        begin
            writeln('Ingrese el codigo del ave');
            readln(codigo);
            if (codigo <> -1) then
                begin
                    writeln('Ingrese el nombre de la especie');
                    readln(nombreEspecie);
                    writeln('Ingrese la familia de la ave');
                    readln(familia);
                    writeln('Ingrese la descripcion de la ave');
                    readln(descripcion);
                    writeln('Ingrese la zona geografica donde habita la ave');
                    readln(zonaGeografica);
                end;
            writeln();
        end;
end;

procedure crearArchivo(var archivo: archivo_Aves);
var
    a: ave;
begin
    rewrite(archivo);
    cargarAve(a);
    while (a.codigo <> -1) do
        begin
            write(archivo, a);
            cargarAve(a);
        end;
    close(archivo);
end;

var
    archivo: archivo_Aves;
begin
    assign(archivo, 'Archivo_Aves');
    crearArchivo(archivo);
end.