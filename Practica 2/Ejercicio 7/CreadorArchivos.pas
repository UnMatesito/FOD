program creadorArchivos;

Uses sysutils;

const
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

procedure cargarRegMaestro (var m: maestro);
begin
    with m do
        begin
            writeln('Ingrese el codigo de localidad');
            readln(codLocalidad);
            if (codLocalidad <> 9999) then
                begin
                    writeln('Ingrese el nombre de la localidad');
                    readln(nomLocalidad);
                    writeln('Ingrese el codigo de cepa');
                    readln(codCepa);
                    writeln('Ingrese el nombre de la cepa');
                    readln(nomCepa);
                    writeln('Ingrese la cantidad de casos activos');
                    readln(casosAct);
                    writeln('Ingrese la cantidad de casos nuevos');
                    readln(casosNue);
                    writeln('Ingrese la cantidad de personas recuperadas');
                    readln(cantRec);
                    writeln('Ingrese la cantidad de personas fallecidas');
                    readln(cantFall);
                end;
            writeln();
        end;
end;

procedure cargarRegDetalle(var d: detalle);
begin
    with d do
        begin
            writeln('Ingrese el codigo de localidad');
            readln(codLocalidad);
            if (codLocalidad <> 9999) then
                begin
                    writeln('Ingrese el codigo de cepa');
                    readln(codCepa);
                    writeln('Ingrese la cantidad de casos activos');
                    readln(casosAct);
                    writeln('Ingrese la cantidad de casos nuevos');
                    readln(casosNue);
                    writeln('Ingrese la cantidad de personas recuperadas');
                    readln(cantRec);
                    writeln('Ingrese la cantidad de personas fallecidas');
                    readln(cantFall);
                end;
            writeln();
        end;
end;

procedure crearMaestro(var mae: archivo_maestro);
var
    m: maestro;
begin
    assign(mae, 'Archivo_Maestro');
    rewrite(mae);
    cargarRegMaestro(m);
    while (m.codLocalidad <> 9999) do
        begin
            write(mae, m);
            cargarRegMaestro(m);
        end;
    close(mae);
end;

procedure crearDetalles(var det: vector_detalles);
var
    i: integer;
    d: detalle;
begin
    for i:= 1 to maxDetalles do
        begin
            assign(det[i], 'Det'+IntToStr(i));
            rewrite(det[i]);
            cargarRegDetalle(d);
            while (d.codLocalidad <> 9999) do
                begin
                    write(det[i], d);
                    cargarRegDetalle(d);
                end;
            close(det[i]);
        end;
end;

var
    mae: archivo_maestro;
    det: vector_detalles;
begin
    crearMaestro(mae);
    crearDetalles(det);
end.