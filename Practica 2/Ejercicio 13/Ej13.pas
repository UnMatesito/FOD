program E13P2;
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

procedure leer(var archivo:archivo_detalle; var datos: vuelo);
begin
    if (not eof(archivo)) then
        read(archivo, datos)
    else
        datos.destino := valorAlto;
end;

procedure minimo(var det1, det2: archivo_detalle; var regD1, regD2: vuelo; var min: vuelo);
begin
    if (regD1.destino < min.destino) and (regD1.fecha.anio < min.fecha.anio) and (regD1.fecha.mes < min.fecha.mes) and (regD1.fecha.dia < min.fecha.dia) and (regD1.horaSalida < min.horaSalida) then
        begin
            min := regD1;
            leer(det1, regD1);
        end
    else if (regD2.destino < min.destino) and (regD2.fecha.anio < min.fecha.anio) and (regD2.fecha.mes < min.fecha.mes) and (regD2.fecha.dia < min.fecha.dia) and (regD2.horaSalida < min.horaSalida) then
        begin
            min := regD2;
            leer(det2, regD2);
        end;
end;    

procedure actMaestro(var m: archivo_vuelos; var det1,det2: archivo_detalle);
var
    regM, regD1, regD2, min: vuelo;
begin
    reset(m);
    reset(det1);
    reset(det2);
    leer(det1, regD1);
    leer(det2, regD2);
    min.destino := valorAlto;
    minimo(det1, det2, regD1, regD2, min);
    while (min.destino <> valorAlto) do
        begin
            read(m, regM);
            while (regM.destino <> min.destino) and (regM.fecha.anio <> min.fecha.anio) and (regM.fecha.mes <> min.fecha.mes) and (regM.fecha.dia <> min.fecha.dia) and (regM.horaSalida <> min.horaSalida) do
                begin
                    read(m, regM)
                end;
            while (regM.destino = min.destino) and (regM.fecha.anio = min.fecha.anio) and (regM.fecha.mes = min.fecha.mes) and (regM.fecha.dia = min.fecha.dia) and (regM.horaSalida = min.horaSalida) do
                begin
                    regM.asientos := regM.asientos - min.asientos;
                    minimo(det1, det2, regD1, regD2, min);
                end;
            seek(m, filepos(m)-1);
            write(m, regM);
        end;
    close(m);
    close(det1);
    close(det2);
end;

var
    maestro: archivo_vuelos;
    det1: archivo_detalle;
    det2: archivo_detalle;
begin
    assign(maestro, 'Archivo_Vuelos');
    assign(det1, 'Detalle 1');
    assign(det2, 'Detalle 2');
    actMaestro(maestro, det1, det2);
    
end.