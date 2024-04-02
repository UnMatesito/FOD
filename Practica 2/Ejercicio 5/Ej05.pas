program E05P2;

Uses sysutils;

const
    valorAlto = 9999;
    maxSucursales = 30;

type
    producto = record
        codigo: integer;
        nombre: string;
        descripcion: string;
        stockDisp: integer;
        stockMin: integer;
        precio: real;
    end;

    detalle = record
        codigo: integer;
        cantVendida: integer;
    end;

    archivo_productos = file of producto;

    archivo_detalle = file of detalle;
    
    sucursales = array [1..maxSucursales] of archivo_detalle;

    registro_detalles = array [1..maxSucursales] of detalle;

procedure cargarProducto (var p: producto);
begin
    with p do
        begin
            writeln('Ingrese el codigo del producto');
            readln(codigo);
            if (codigo <> 9999) then
                begin
                    writeln('Ingrese el nombre del producto');
                    readln(nombre);
                    writeln('Ingrese la descripcion del producto');
                    readln(descripcion);
                    writeln('Ingrese el stock disponible del producto');
                    readln(stockDisp);
                    writeln('Ingrese el stock minimo del producto');
                    readln(stockMin);
                    writeln('Ingrese el precio del producto');
                    readln(precio);
                end;
            writeln();
        end;
end;

procedure cargarDetalle (var d:detalle);
begin
    with d do
        begin
            writeln('Ingrese el codigo del producto');
            readln(codigo);
            if (codigo <> 9999) then
                begin
                    writeln('Ingrese la cantidad vendida del producto');
                    readln(cantVendida);
                end;
            writeln();
        end;
end;

procedure crearMaestro(var a:archivo_productos);
var
    p: producto;
begin
    rewrite(a);
    writeln('Cargado de datos del archivo maestro');
    cargarProducto(p);
    while (p.codigo <> 9999) do
        begin
            write(a,p);
            cargarProducto(p);
        end;
    close(a);
end;

procedure crearDetalles(var det: sucursales);
var
    d: detalle;
    i: integer;
begin
    for i:=1 to maxSucursales do
        begin
            writeln('Cargado de datos del archivo detalle ', i);
            rewrite(det[i]);
            cargarDetalle(d);
            while (d.codigo <> 9999) do
                begin
                    write(det[i], d);
                    cargarDetalle(d);
                end;
            close(det[i]);
        end;
end;

procedure leer(var archivo: archivo_detalle; var dato: detalle);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.codigo := valorAlto;
end;

procedure minimo(var det: sucursales; var regD: registro_detalles; var min: detalle);
var
    i: integer;
begin
    min.codigo := valorAlto;
    for i:= 1 to maxSucursales do
        begin
            if (regD[i].codigo < min.codigo) then
                begin
                    min := regD[i];
                    leer(det[i], regD[i]);
                end;
        end;
end;

procedure actMaestro(var mae: archivo_productos; var det: sucursales);
var
    regM: producto;
    regD: registro_detalles;
    min: detalle;
    i: integer;
begin
    reset(mae);
    for i:=1 to maxSucursales do
        begin
            reset(det[i]);
            leer(det[i], regD[i]);
        end;
    minimo(det, regD, min);
    while (min.codigo <> valorAlto) do
        begin
            read(mae, regM);
            while (min.codigo <> regM.codigo) do
                read(mae, regM);
            while (min.codigo = regM.codigo) do
                begin
                    regM.stockDisp := regM.stockDisp - min.cantVendida;
                    minimo(det, regD, min);
                end;
            seek(mae, filepos(mae)-1);
            write(mae, regM);
        end;
    for i:=1 to maxSucursales do
        begin
            close(det[i]);
        end;
    close(mae);
end;

procedure crearTxt(var a: archivo_productos);
var
    sinStock: Text;
    p: producto;
begin
    assign(sinStock, 'sin-Stock.txt');
    reset(a);
    rewrite(sinStock);
    while (not eof(a)) do
        begin
            read(a, p);
            if (p.stockDisp < p.stockMin) then
                writeln(sinStock, 'Precio: ', p.precio:0:2, ' Stock Disponible: ', p.stockDisp, ' Nombre: ', p.nombre);
                writeln(sinStock, p.descripcion);
        end;
    close(a);
    close(sinStock);
end;

var
    a: archivo_productos;
    det: sucursales;
    i: integer;
    opcion: char;
begin
    assign(a, 'Archivo_Productos');
    for i:=1 to maxSucursales do
        assign(det[i], 'Det'+IntToStr(i));
    crearMaestro(a);
    crearDetalles(det); //En la carpeta creo 5 detalles porque con 30 me pego un corchazo :)
    writeln('-Ejercicio 5---------------------------------------------------------');
    writeln();
    writeln('Ingrese alguna de las 2 opciones');
    writeln();
    writeln('A: Actualizar el archivo de productos con un detalle');
    writeln('B: crear un archivo de texto con los productos que poseean menos stock disponible que el actual');
    writeln();
    write('Opcion: '); readln(opcion);
    opcion := UpCase(opcion);
    case opcion of
        'A': actMaestro(a, det);
        'B': crearTxt(a);
        else
            writeln('La opcion no existe');
    end;
end.