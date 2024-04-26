program E07P3;
const
    valorAlto = 9999;

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

procedure leer(var archivo: archivo_Aves; var dato: ave);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.codigo := valorAlto;
end;

procedure bajaLogica(var archivo: archivo_Aves; especie: string; charEsp:char);
var
    regM: ave;
begin
    reset(archivo);
    leer(archivo, regM);
    while (regM.codigo <> valorAlto) do
        begin
            if (especie = regM.nombreEspecie) then
                begin
                    Insert(charEsp, regM.nombreEspecie, 1);
                    seek(archivo, filepos(archivo)-1);
                    write(archivo, regM);
                end;
            leer(archivo, regM);
        end;
    close(archivo);
end;

procedure compactarArchivo(var archivo: archivo_Aves; charEsp:char);
var
    regM, aux: ave;
    pos: integer;
    primerChar: char;
begin
    reset(archivo);
    leer(archivo, regM);
    while (regM.codigo <> valorAlto) do
        begin
            primerChar := regM.nombreEspecie[1];
            if (primerChar = charEsp) then
                begin
                    seek(archivo, filepos(archivo)-1);
                    pos := filepos(archivo);
                    seek(archivo, filesize(archivo));
                    leer(archivo, aux);
                    seek(archivo, pos);
                    write(archivo, aux);
                    Truncate(archivo);
                end;
            leer(archivo, regM);
        end;
    close(archivo);
end;

procedure imprimirArchivo(var archivo: archivo_Aves);
var
    a: ave;
begin
    reset(archivo);
    while (not eof(archivo)) do
        begin
            read(archivo, a);
            with a do
                begin
                    writeln('Codigo de Ave: ' , codigo);
                    writeln('Nombre de especie: ', nombreEspecie, ' Familia: ', familia);
                    writeln('Zona Geografica: ', zonaGeografica, ' Descripcion: ', descripcion);
                    writeln();
                end;
        end;
    close(archivo);
end;

var
    archivo: archivo_Aves;
    especie: string;
    charEsp : char;
    codigo: longInt;
begin
    assign(archivo, 'Archivo_Aves');
    //crearArchivo(archivo);
    imprimirArchivo(archivo);
    writeln('Borrado de aves');
    writeln();
    charEsp := '*';
    writeln('Ingrese un codigo de ave');
    readln(codigo);
    while (codigo <> 500000) do
        begin
            writeln('Ingrese un nombre de especie de ave para eliminar');
            readln(especie);
            bajaLogica(archivo, especie, charEsp);
            writeln('Ingrese un codigo de ave');
            readln(codigo);
        end;
    compactarArchivo(archivo, charEsp);
    imprimirArchivo(archivo);
end.