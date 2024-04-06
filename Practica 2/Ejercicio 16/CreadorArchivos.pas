program Creador;

Uses sysutils;

const
    valorAlto = 9999;
    cantEmpelados = 10;

type
    moto = record
        codMoto: integer;
        nombre: string;
        descripcion: string;
        modelo: string;
        marca: string;
        stockAct: integer;
    end;

    s_dias = 1..30;

    s_meses = 1..12;
    
    fecha = record
        dia: s_dias;
        mes: s_meses;
        anio: integer;
    end;

    detalle = record
        codMoto: integer;
        precio: real;
        fechaVenta: fecha;
    end;

    indice = 1..cantEmpelados;

    archivo_maestro = file of moto;

    archivo_detalle = file of detalle;

    detalles_empleados = array[indice] of archivo_detalle;

procedure cargarMoto(var m: moto);
begin
    with m do
        begin
            writeln('Ingrese el codigo de la moto');
            readln(codMoto);
            if (codMoto <> valorAlto) then
                begin
                    writeln('Ingrese el nombre de la moto');
                    readln(nombre);
                    writeln('Ingrese la descripcion de la moto');
                    readln(descripcion);
                    writeln('Ingrese el modelo de la moto');
                    readln(modelo);
                    writeln('Ingrese la marca de la moto');
                    readln(marca);
                    writeln('Ingrese el stock actual de la moto');
                    readln(stockAct);
                end;
            writeln();
        end;
end;

procedure cargarDetalle(var d: detalle);
begin
    with d do
        begin
            writeln('Ingrese el codigo de la moto');
            readln(codMoto);
            if (codMoto <> valorAlto) then
                begin
                    writeln('Ingrese el precio de la moto');
                    readln(precio);
                    writeln('Ingrese la fecha de la venta');
                    write('Dia '); readln(fechaVenta.dia);
                    write('Mes '); readln(fechaVenta.mes);
                    write('Anio '); readln(fechaVenta.anio);
                end;
            writeln();
        end;
end;

procedure crearMaestro(var mae: archivo_maestro);
var
    m: moto;
begin
    rewrite(mae);
    cargarMoto(m);
    while (m.codMoto <> valorAlto) do
        begin
            write(mae, m);
            cargarMoto(m);
        end;
    close(mae);
end;

procedure crearDetalle(var det: detalles_empleados);
var
    i:integer;
    d: detalle;
begin
    for i:= 1 to cantEmpelados do
        begin
            rewrite(det[i]);
            cargarDetalle(d);
            while (d.codMoto <> valorAlto) do
                begin
                    write(det[i], d);
                    cargarDetalle(d);
                end;
            close(det[i]);
        end;
end;

var
    mae: archivo_maestro;
    det: detalles_empleados;
    i: integer;
begin
    assign(mae, 'Archivo_Motos');
    for i:= 1 to cantEmpelados do
        assign(det[i], 'Det'+IntToStr(i));
    crearMaestro(mae);
    crearDetalle(det);
end.