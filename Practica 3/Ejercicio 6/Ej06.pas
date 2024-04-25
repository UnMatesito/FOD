program E06P3;
const
    valorAlto = 9999;

type
    prenda = record
        codigo: integer;
        descripcion: string;
        colores: string;
        tipo: string;
        stock: integer;
        precio_unitario: real;
    end;

    archivo_prendas = file of prenda;

    codigos_prendas_obsoletas = file of integer;

procedure leerDetalle(var archivo: codigos_prendas_obsoletas; var datos: integer);
begin
    if (not eof(archivo)) then
        read(archivo, datos)
    else
        datos := valorAlto;
end;

procedure realizarBajas(var archivoPrendas: archivo_prendas; var archivoBajas: codigos_prendas_obsoletas);
var
    regM: prenda;
    regD: integer;
begin
    reset(archivoPrendas);
    reset(archivoBajas);
    leerDetalle(archivoBajas, regD);
    while (regD <> valorAlto) do
        begin
            read(archivoPrendas, regM);
            while (regM.codigo <> regD) and (not eof(archivoPrendas)) do
                read(archivoPrendas, regM);
            if (regM.codigo = regD) then
                begin
                    regM.stock := -1;
                    seek(archivoPrendas, filepos(archivoPrendas)-1);
                    write(archivoPrendas, regM);
                    reset(archivoPrendas);
                end;
            leerDetalle(archivoBajas, regD);
        end;
    close(archivoPrendas);
    close(archivoBajas);
end;

procedure leerMaestro(var archivo: archivo_prendas; var datos: prenda);
begin
    if (not eof(archivo)) then
        read(archivo, datos)
    else
        datos.codigo := valorAlto;
end;

procedure efectivizarBajas(var archivoPrendas: archivo_prendas; var archivoNuevo: archivo_prendas);
var
    regM: prenda;
begin
    reset(archivoPrendas);
    rewrite(archivoNuevo);
    leerMaestro(archivoPrendas, regM);
    while (regM.codigo <> valorAlto) do
        begin
            if (regM.stock <> -1) then
                begin
                    write(archivoNuevo, regM);
                end;
            leerMaestro(archivoPrendas, regM);
        end;
    close(archivoPrendas);
    close(archivoNuevo);
end;

procedure impimirMaestro(var archivoPrendas: archivo_prendas);
var
    p: prenda;
begin
    reset(archivoPrendas);
    while (not eof(archivoPrendas)) do
        begin
            read(archivoPrendas, p);
            with p do
                begin
                    writeln('Codigo: ', codigo);
                    writeln('Descripcion: ', descripcion);
                    writeln('Colores: ', colores, ' Tipo: ', tipo);
                    writeln('Stock: ', stock, ' Precio Unitario: ', precio_unitario:0:2);
                    writeln();
                end;
        end;
    close(archivoPrendas);
end;

var
    archivoPrendas: archivo_prendas;
    archivoBajas: codigos_prendas_obsoletas;
    archivoNuevo: archivo_prendas;
begin
    Assign(archivoPrendas, 'Archivo_Prendas');
    Assign(archivoBajas, 'Prendas_Obsoletas');
    writeln('Original--------------------------------------------------------------------------------------------');
    writeln();
    impimirMaestro(archivoPrendas);
    realizarBajas(archivoPrendas, archivoBajas);
    writeln('Con bajas-------------------------------------------------------------------------------------------------------------------' );
    writeln();
    impimirMaestro(archivoPrendas);
    Assign(archivoNuevo, 'Archivo_Compactado');
    efectivizarBajas(archivoPrendas, archivoNuevo);
    writeln('Archivo Compactado-----------------------------------------------------------------------------------------------------------');
    writeln();
    impimirMaestro(archivoNuevo);
    Assign(archivoNuevo, 'Archivo_Prendas');
end.