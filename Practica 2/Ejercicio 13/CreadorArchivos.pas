program creadorArchivos;
const
    valorAlto = 'ZZZ';

type
    s_dias = 1..31;
    s_meses = 1..12;
    
    r_fecha = record
        dia: s_dias;
        mes: s_meses;
        anio: integer;
    end;

    
    vuelo = record
        destino: string;
        fecha : r_fecha;
        horaSalida: string;
        asientos: integer;
    end;

    archivo_vuelos = file of vuelo;

    archivo_detalle = file of vuelo;

procedure cargarVuelo(var v:vuelo);
begin
    with v do
        begin
            writeln('Ingrese el Destino del vuelo');
            readln(destino);
            if (destino <> valorAlto) then
                begin
                    writeln('Fecha del vuelo');
                    writeln('Ingrese el dia');
                    readln(fecha.dia);
                    writeln('Ingrese el mes');
                    readln(fecha.mes);
                    writeln('Ingrese el anio');
                    readln(fecha.anio);
                    writeln('Ingrese la hora de salida');
                    readln(horaSalida);
                    writeln('Ingrese la cantidad de asientos disponibles/comprados');
                    readln(asientos);
                end;
            writeln();
        end;
end;

procedure cargarMaestro(var m: archivo_vuelos);
var
    v: vuelo;
begin
    rewrite(m);
    cargarVuelo(v);
    while (v.destino <> valorAlto) do
        begin
            write(m, v);
            cargarVuelo(v);
        end;
    close(m);
end;

procedure cargarDetalle(var d: archivo_detalle);
var
    v:vuelo;
begin
    rewrite(d);
    cargarVuelo(v);
    while (v.destino <> valorAlto) do
        begin
            write(d, v);
            cargarVuelo(v);
        end;
    close(d);
end;

    
var
    maestro: archivo_vuelos;
    det1: archivo_detalle;
    det2: archivo_detalle;
begin
    assign(maestro, 'Archivo_Vuelos');
    assign(det1, 'Detalle 1');
    assign(det2, 'Detalle 2');
    cargarMaestro(maestro);
    cargarDetalle(det1);
    cargarDetalle(det2);
end.