program E03P2;
const
    max_sucursales = 30;
    valorAlto = 9999;

type
    cant_sucursales = 1..max_sucursales;
    
    producto = record
        codigo: integer;
        nombre: string;
        precio: real; 
        stockDisp: integer;
        stockMin: integer;
    end;

    detalle = record
        codigo: integer;
        cantVendida: integer;
    end;

    archivo_productos = file of producto;

    archivo_detalle = file of detalle;

procedure cargarProducto(var p:producto);
begin
    with p do
        begin
            writeln('Ingrese el codigo del producto');
            readln(codigo);
            if (codigo <> 9999) then
                begin
                    writeln('Ingrese el nombre comercial del producto');
                    readln(nombre);
                    writeln('Ingrese el precio del producto');
                    readln(precio);
                    writeln('Ingrese el stock disponible actualmente del producto');
                    readln(stockDisp);
                    writeln('Ingrese el stock minimo del producto');
                    readln(stockMin);
                end;
            writeln();
        end;
end;

procedure cargarDetalle(var d:detalle);
begin
    with d do
        begin
            writeln('Ingrese el codigo del producto');
            readln(codigo);
            if (codigo <> 9999) then
                begin
                    writeln('Ingrese la cantidad vendida de dicho producto');
                    readln(cantVendida);
                end;
            writeln();
        end;
end;

procedure crearMaestro(var a: archivo_productos);
var
    p: producto;
begin
    rewrite(a);
    cargarProducto(p);
    while (p.codigo <> 9999) do
        begin
            write(a, p);
            cargarProducto(p);
        end;
    close(a);
end;

procedure crearDetalle(var det: archivo_detalle);
var
    d: detalle;
begin
    rewrite(det);
    cargarDetalle(d);
    while (d.codigo <> 9999) do
        begin
            write(det, d);
            cargarDetalle(d);
        end;
    close(det);
end;

procedure leerDetalle(var det: archivo_detalle; var dato: detalle);
begin
    if (not eof(det)) then
        read(det, dato)
    else
        dato.codigo := valorAlto;
end;

procedure actMaestro(var mae: archivo_productos; var det: archivo_detalle);
var
    regM: producto;
    regD: detalle;
    total: integer;
begin
    reset(mae);
    reset(det);
    leerDetalle(det, regD);
    while (regD.codigo <> valorAlto) do
        begin
            read(mae, regM);
            while (regM.codigo <> regD.codigo) do
                read(mae, regM);
            while (regM.codigo = regD.codigo) do
                begin
                    regM.stockDisp := regM.stockDisp - regD.cantVendida;
                    leerDetalle(det, regD);
                end;
            seek(mae, filepos(mae)-1);
            write(mae, regM);
        end;
    close(mae);
    close(det);
end;

procedure crearTxt(var a: archivo_productos);
var
    arch_texto: Text;
    p: producto;
begin
    assign(arch_texto, 'stock_minimo.txt');
    reset(a);
    rewrite(arch_texto);
    while (not eof(a)) do
        begin
            read(a, p);
            if (p.stockDisp < p.stockMin) then
                writeln(arch_texto, 'Codigo: ', p.codigo, ' Precio: ', p.precio:0:2, ' Stock Disponible: ', p.stockDisp, ' Stock Minimo: ', p.stockMin, ' Nombre comercial: ', p.nombre);
        end;
    close(a);
    close(arch_texto);
end;

var
    a : archivo_productos;
    det: archivo_detalle;
    opcion: char;
begin
    assign(a, 'Archivo_productos');
    assign(det, 'Archivo_detalle');
    crearMaestro(a);
    //crearDetalle(det);
    writeln('-Ejercicio 3--------------------------------------------------------------------');
    writeln();
    writeln('Ingrese una opcion');
    writeln();
    writeln('A: Actualizar el archivo productos con un detalle');
    writeln('B: Listar en un archivo de texto donde el stock disponible es menor al minimo');
    writeln();
    write('Opcion: '); readln(opcion);
    opcion := UpCase(opcion);
    case opcion of
        'A': actMaestro(a, det);
        'B': crearTxt(a);
        else writeln('La opcion no existe');
    end;
end.