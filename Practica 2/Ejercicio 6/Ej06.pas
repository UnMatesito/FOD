program E06P2;

Uses sysutils;

const
    valorAlto = 9999;
    cantMaquinas = 5;

type
    s_dias = 1..30;

    s_meses = 1..12;

    fecha = record
        dia: s_dias;
        mes: s_meses;
        anio: integer;
    end;
    
    servidor = record
        codUsuario: integer;
        fecha: fecha;
        tiempoTotal: integer;
    end;

    detalle = record
        codUsuario: integer;
        fecha: fecha;
        tmpSesion: integer;
    end;

    indice = 1..cantMaquinas;

    archivo_maestro = file of servidor;

    archivo_detalle = file of detalle;

    maquinas = array[indice] of archivo_detalle;

    reg_Detalle = array[indice] of detalle;


procedure cargarDetalle(var d: detalle);
begin
    with d do
        begin
            writeln('Ingrese el codigo de usuario');
            readln(codUsuario);
            if (codUsuario <> valorAlto) then
                begin
                    writeln('Ingrese la fecha de la sesion');
                    write('Dia '); readln(fecha.dia);
                    write('Mes '); readln(fecha.mes);
                    write('Anio '); readln(fecha.anio);
                    writeln('Ingrese el tiempo de sesion');
                    readln(tmpSesion);
                end;
            writeln();
        end;
end;

procedure crearDetalles(var det: maquinas);
var
    i: integer;
    d: detalle;
begin
    for i:=1 to cantMaquinas do
        begin
            writeln('Cargado de datos del archivo detalle ', i);
            rewrite(det[i]);
            cargarDetalle(d);
            while (d.codUsuario <> 9999) do
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
        dato.codUsuario := valorAlto;
end;

procedure minimo(var det: maquinas; var regD: reg_Detalle; var min: detalle);
var
    i, indiceMin: integer;
begin
    indiceMin := 0;
    min.codUsuario := valorAlto;
    for i:=1 to cantMaquinas do
        begin
            if (regD[i].codUsuario <> valorAlto) then
                begin
                    if ((regD[i].codUsuario < min.codUsuario) or (regD[i].codUsuario = min.codUsuario) and (regD[i].fecha.dia < min.fecha.dia) and (regD[i].fecha.mes < min.fecha.mes) and (regD[i].fecha.anio < min.fecha.anio)) then
                        begin
                            min := regD[i];
                            indiceMin := i;
                        end;
                end;
        end;
    if (indiceMin <> 0) then
        leer(det[indiceMin], regD[indiceMin]);
end;


var
    mae: archivo_maestro;
    det: maquinas;
    regD: reg_Detalle;
    regM: servidor;
    min: detalle;
    i: integer;
begin
    //merge
    assign(mae, 'Servidor');
    for i:= 1 to cantMaquinas do
        assign(det[i], 'Det'+IntToStr(i));
    crearDetalles(det);
    rewrite(mae);
    for i:=1 to cantMaquinas do
        begin
            reset(det[i]);
            leer(det[i], regD[i]);
        end;
    minimo(det, regD, min);
    while (min.codUsuario <> valorAlto) do
        begin
            regM.codUsuario := min.codUsuario;
            while (regM.codUsuario = min.codUsuario) do
                begin
                    regM.fecha.dia := min.fecha.dia;
                    regM.tiempoTotal := 0;
                    while ((regM.codUsuario = min.codUsuario) and (regM.fecha.dia = min.fecha.dia)) do
                        begin
                            regM.fecha.mes := min.fecha.mes;
                            while ((regM.codUsuario = min.codUsuario) and (regM.fecha.dia = min.fecha.dia) and (regM.fecha.mes = min.fecha.mes)) do
                                begin
                                    regM.fecha.anio := min.fecha.anio;
                                    while ((regM.codUsuario = min.codUsuario) and (regM.fecha.dia = min.fecha.dia) and (regM.fecha.mes = min.fecha.mes) and (regM.fecha.anio = min.fecha.anio)) do
                                        begin
                                            regM.tiempoTotal := regM.tiempoTotal + min.tmpSesion;
                                            minimo(det, regD, min);
                                        end;
                                end;
                        end;
                    write(mae, regM);
                end;
        end;
    close(mae);
    for i:= 1 to cantMaquinas do
        close(det[i]);
    
    //imprimir resultado
    reset(mae);
    while(not eof(mae)) do
        begin
            read(mae, regM);
            writeln('Ususario: ', regM.codUsuario);
            writeln('Dia: ', regM.fecha.dia, ' Mes: ', regM.fecha.mes, ' Anio: ', regM.fecha.anio);
            writeln('Horas totales de uso de sesion: ', regM.tiempoTotal);
        end;
    close(mae);
end.