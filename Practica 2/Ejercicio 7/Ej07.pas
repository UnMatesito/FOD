program E07P2;

Uses sysutils;

const
    valorAlto = 9999;
    maxDetalles = 10;

type
    maestro = record
        codLocalidad: integer;
        nomLocalidad: string;
        codCepa: integer;
        nomCepa: string;
        casosAct: integer;
        casosNue: integer;
        cantRec: integer;
        cantFall: integer;
    end;

    detalle = record
        codLocalidad: integer;
        codCepa: integer;
        casosAct: integer;
        casosNue: integer;
        cantRec: integer;
        cantFall: integer;
    end;

    cant_detalles = 1..maxDetalles;
    
    archivo_maestro = file of maestro;

    archivo_detalle = file of detalle;

    vector_detalles = array [cant_detalles] of archivo_detalle;

    registros_detalle = array [cant_detalles] of detalle;

procedure leer(var archivo: archivo_detalle; var dato: detalle);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.codLocalidad := valorAlto;
end;

procedure minimo(var det: vector_detalles; var regD: registros_detalle; var min: detalle);
var
    i: integer;
begin
    min.codLocalidad := valorAlto;
    for i:= 1 to maxDetalles do
        begin
            if (regD[i].codLocalidad < min.codLocalidad) then
                begin
                    min := regD[i];
                    leer(det[i], regD[i]);
                end;
        end;
end;

procedure actMaestro(var mae: archivo_maestro; var det: vector_detalles);
var
    regM: maestro;
    regD: registros_detalle;
    min: detalle;
    cepaAct: integer;
    i: integer;
begin
    reset(mae);
    for i:=1 to maxDetalles do
        begin
            reset(det[i]);
            leer(det[i], regD[i]);
        end;
    minimo(det, regD, min);
    while (min.codLocalidad <> valorAlto) do
        begin
            read(mae, regM);
            while (min.codLocalidad <> regM.codLocalidad) do
                read(mae, regM);
            while (min.codLocalidad = regM.codLocalidad) do
                begin
                    cepaAct := min.codCepa;
                    while (min.codLocalidad = regM.codLocalidad) and (cepaAct = min.codCepa) do
                        begin
                            regM.cantFall := regM.cantFall + min.cantFall;
                            regM.cantRec := regM.cantRec + min.cantRec;
                            regM.casosAct := min.casosAct;
                            regM.casosNue := min.casosNue;
                            minimo(det, regD, min);
                        end;
                end;
            seek(mae, filepos(mae)-1);
            write(mae, regM);
        end;
    close(mae);
    for i:= 1 to maxDetalles do
        close(det[i]);
end;   

procedure informar(var mae: archivo_maestro);
var
    m: maestro;
begin
    reset(mae);
    while (not eof(mae)) do
        begin
            read(mae, m);
            with m do
                begin
                    if (casosAct > 50) then
                        begin
                            writeln('Codigo de localidad: ', codLocalidad, ' Nombre de localidad: ', nomLocalidad);
                            writeln('Codigo de la Cepa: ', codCepa, ' Nombre de la Cepa: ', nomCepa);
                            writeln('Datos de la Cepa');
                            writeln('Casos Activos: ', casosAct, ' Casos nuevos: ', casosNue);
                            writeln('Recuperados: ', cantRec, ' Fallecidos: ', cantFall);
                        end;
                end;
        end;    
    close(mae);
end;

var
    mae: archivo_maestro;
    i:integer;
    det: vector_detalles;
begin
    assign(mae, 'Archivo_Maestro');
    for i:= 1 to maxDetalles do
        assign(det[i], 'Det'+IntToStr(i));
    actMaestro(mae, det);
    informar(mae);
end.