program E03P2;
const
    max_sucursales = 30;
    valorAlto = 9999;

type
    cant_sucursales = 1..max_sucursales;
    
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

    registro_det = array[cant_sucursales] of detalle;
    
    vectorDetalles = array [cant_sucursales] of file of detalle;

procedure leer(var det: vectorDetalles; var datos: registro_det);
var
    i: integer;
begin
    if (not eof(det[i])) then
        read(det[i], datos[i])
    else
        datos[i].codigo := valorAlto;
end;

procedure minimo(var det: vectorDetalles; regD: registro_det; var min: detalle);
var
    i: integer;
begin
    min.codigo := valorAlto;
    for i:=1 to max_sucursales do
        begin
            if (det[i].codigo < min.codigo) then
                min := det[i];
                leer(det[i], regD[i]);
        end;
end;



var
    mae: archivo_productos;
    det: vectorDetalles;
    regD: registro_det;
    min: detalle;
    regM: producto;
    i: integer;
begin
    assign(mae, 'archivo_productos'); 
    for i:= 1 to max_sucursales do
        begin
            assign(det[i], 'det'+i);
            reset(det[i]); //se dispone de datos
            read(det[i], regD[i]);
        end;
    reset(mae); //se dispone de productos
    minimo(det[i], regD[i], min);
    while (min.codigo <> valorAlto) do
        begin
            read(mae, regM);
            while (regM.codigo <> min.codigo) do
                read(mae, regM);
            while (regM.codigo = min.codigo) do
                begin
                    regM.stockDisp := regM.stockDisp - min.cantVendida;
                    read(mae, regM);
                end;
            seek(mae, filepos(mae)-1);
            write(mae, regM);
        end;
    close(mae);
    for i:= 1 to max_sucursales do
        begin
            close(det[i]);
        end; 
end.