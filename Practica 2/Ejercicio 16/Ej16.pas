program E16P2;

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
        fechaVenta: integer;
    end;

    indice = 1..cantEmpelados;

    archivo_maestro = file of moto;

    archivo_detalle = file of detalle;

    detalles_empleados = array[indice] of archivo_detalle;

    registros_detalles = array[indice] of detalle;

procedure leer(var archivo: archivo_detalle; var dato: detalle);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.codMoto := valorAlto;
end;

procedure minimo(var det: detalles_empleados; var regD: registros_detalles; var min: detalle);
var
    i: integer;
begin
    min.codMoto := valorAlto;
    for i:= 1 to cantEmpelados do
        begin
            if (regD[i].codMoto < min.codMoto) then
                begin
                    min := regD[i];
                    leer(det[i], regD[i]);
                end;
        end;
end;

procedure motoMasVendida(regM: moto; totalVentas: integer; var maxCod, max: integer);
begin
    if (totalVentas > max) then
        begin
            max := totalVentas;
            maxCod := regM.codMoto;
        end;
end;


procedure actMaestro(var mae: archivo_maestro; var det: detalles_empleados);
var
    i: integer;
    regD: registros_detalles;
    regM: moto;
    codAct: integer;
    totalVentas: integer;
    min: detalle;
    max, maxCod: integer;
begin
    max := -1;
    reset(mae);
    for i:=1 to cantEmpelados do
        begin
            reset(det[i]);
            leer(det[i], regD[i]);
        end;
    minimo(det, regD, min);
    while (min.codMoto <> valorAlto) do
        begin
            read(mae, regM);
            while (regM.codMoto <> min.codMoto) do
                read(mae, regM);
            while (regM.codMoto = min.codMoto) do
                begin
                    codAct := min.codMoto;
                    totalVentas := 0;
                    while (codAct = min.codMoto) do
                        begin
                            totalVentas := totalVentas + 1;
                            minimo(det, regD, min);
                        end;
                    regM.stockAct := regM.stockAct - totalVentas;
                    motoMasVendida(regM, totalVentas, maxCod, max);
                end;
            seek(mae, filepos(mae)-1);
            write(mae, regM);
        end;
    writeln('La Moto que mas se vendio es la de codigo ', maxCod, ' Con un total de: ', max);
end;

var
    mae: archivo_maestro;
    det: detalles_empleados;
    i: integer;
begin
    assign(mae, 'Archivo_Motos');
    for i:= 1 to cantEmpelados do
        assign(det[i], 'Det'+IntToStr(i));
    actMaestro(mae, det);
end.