program E17P2;
const
    valorAlto = 9999;

type
    s_dias = 1..30;

    s_meses = 1..12;
    
    Rfecha = record
        dia: s_dias;
        mes: s_meses;
        anio: integer;
    end;
    
    casos = record
        codLocalidad: integer;
        nomLocalidad: string;
        codMunicipio: integer;
        nomMunicipio: string;
        codHospital: integer;
        nomHospital: string;
        fecha: Rfecha;
        cantCasos: integer;
    end;

    archivo_maestro = file of casos;

procedure cargarMaestro(var c: casos);
begin
    with c do
        begin
            writeln('Ingrese el codigo de localidad');
            readln(codLocalidad);
            if (codLocalidad <> valorAlto) then
                begin
                    writeln('Ingrese el nombre de la localidad');
                    readln(nomLocalidad);
                    writeln('Ingrese el codigo de localidad');
                    readln(codMunicipio);
                    writeln('Ingrese el nombre del municipio');
                    readln(nomMunicipio);
                    writeln('Ingrese el codigo de hospital');
                    readln(codHospital);
                    writeln('Ingrese el nombre del hospital');
                    readln(nomHospital);
                    writeln('Ingrese la fecha');
                    write('Dia '); readln(fecha.dia);
                    write('Mes '); readln(fecha.mes);
                    write('Anio '); readln(fecha.anio);
                    writeln('Ingrese la cantidad de casos positivos detectados');
                    readln(cantCasos);
                end;
            writeln();
        end;
end;

procedure crearMaestro(var mae: archivo_maestro);
var
    c:casos;
begin
    rewrite(mae);
    cargarMaestro(c);
    while (c.codLocalidad <> valorAlto) do
        begin
            write(mae, c);
            cargarMaestro(c);
        end;
    close(mae);
end;

procedure leer(var archivo: archivo_maestro; var dato: casos);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.codLocalidad := valorAlto;
end;

procedure Informe(var mae: archivo_maestro);
var
    regM: casos;
    locAct, munAct, hosAct, totMun, totLoc: integer;
begin
    reset(mae);
    leer(mae, regM);
    while (regM.codLocalidad <> valorAlto) do
        begin
            writeln('Nombre: ', regM.nomLocalidad);
            totLoc := 0;
            locAct := regM.codLocalidad;
            while (regM.codLocalidad = locAct) do
                begin
                    writeln('Nombre: ', regM.nomMunicipio);
                    totMun := 0;
                    munAct := regM.codMunicipio;
                    while ((regM.codLocalidad = locAct) and (regM.codMunicipio = munAct)) do
                        begin
                            write('   Nombre: ', regM.nomHospital);
                            hosAct := regM.codHospital;
                            while ((regM.codLocalidad = locAct) and (regM.codMunicipio = munAct) and (regM.codHospital = hosAct)) do
                                begin
                                    writeln('..........Cantidad de casos: ', regM.cantCasos);
                                    totMun := totMun + regM.cantCasos;
                                    leer(mae, regM);
                                end;
                        end;
                    writeln('   Cantidad de casos del municipio ', munAct, ' : ', totMun);
                    totLoc := totLoc + totMun;
                    writeln('......................................................................');
                end;
            writeln('Cantidad de casos de la localidad ', locAct, ' : ', totLoc);
            writeln('----------------------------------------------------------------------------------------------------------');
        end;
    close(mae);
end;

var
    mae: archivo_maestro;
begin
    assign(mae, 'Archivo_Maestro');
    crearMaestro(mae);
    Informe(mae);
end.