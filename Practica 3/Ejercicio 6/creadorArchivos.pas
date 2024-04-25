program creadorArchivos;
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

procedure cargarPrenda(var p:prenda);
begin
    with p do
        begin
            writeln('Ingrese el codigo de prenda');
            readln(codigo);
            if (codigo <> valorAlto) then
                begin
                    writeln('Ingrese la descripcion de la prenda');
                    readln(descripcion);
                    writeln('Ingrese los colores de la prenda');
                    readln(colores);
                    writeln('Ingrese el tipo de prenda');
                    readln(tipo);
                    writeln('Ingrese el stock actual de la prenda');
                    readln(stock);
                    writeln('Ingrese el precio unitario de la prenda');
                    readln(precio_unitario);
                end;
            writeln();
        end;
end;

procedure crearArchivoPrendas(var archivo: archivo_prendas);
var
    p: prenda;
begin
    Rewrite(archivo);
    cargarPrenda(p);
    while (p.codigo <> valorAlto) do
        begin
            write(archivo, p);
            cargarPrenda(p);
        end;
    Close(archivo);
end;

procedure crearArchivoBajas(var archivo: codigos_prendas_obsoletas);
var
    codigo: integer;
begin
    Rewrite(archivo);
    writeln('Ingrese un codigo de prenda que ya no se venda mas');
    readln(codigo);
    writeln();
    while (codigo <> -1) do
        begin
            write(archivo, codigo);
            writeln('Ingrese un codigo de prenda que ya no se venda mas');
            readln(codigo);
            writeln();
        end;
    Close(archivo);
end;

var
    archivoPrendas: archivo_prendas;
    archivoBajas: codigos_prendas_obsoletas;
begin
    Assign(archivoPrendas, 'Archivo_Prendas');
    Assign(archivoBajas, 'Prendas_Obsoletas');
    crearArchivoPrendas(archivoPrendas);
    crearArchivoBajas(archivoBajas);
end.