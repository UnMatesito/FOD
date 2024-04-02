program E04P2;
const
    valorAlto = 'zzzzz';

//tipos de datos
type
    informe = record
        nomProvincia: string;
        alfavetizados: integer;
        totEncuestados: integer;
    end;

    detalle = record
        nomProvincia: string;
        codLocalidad: integer;
        alfavetizados: integer;
        encuestados: integer;
    end;

    archivo_informe file of informe;

    archivo_detalle = file of detalle;

//modulos
procedure leer(var det: archivo_detalle; datos: detalle);
begin
    if (not eof(det)) then
        read(det, datos);
    else
        datos.nomProvincia := valorAlto;
end;

procedure minimo (var det1, det2: archivo_detalle; var regD1,regD2: detalle; var min: detalle);
begin
    if (regD1.nomProvincia <= regD2.nomProvincia) then
        begin
            min := regD1
            leer(det1, regD1);
        end
    else
        begin
            min := regD2;
            leer(det2, regD2);
        end;
end;

procedure actMaestro(var mae: archivo_informe; var det1, det2: archivo_detalle);
var
    regD1, regD2: detalle;
    min: detalle;
begin
    reset(mae);
    reset(det1); reset(det2);
    leer(det1, regD1); leer(det2, regD2);
    minimo(det1, det2, regD1, regD2, min);
    while (min.nomProvincia <> valorAlto) do
        begin
            read(mae, regM);
            while (regM.nomProvincia <> min.nomProvincia) do
                read(mae, regM);
            while (regM.nomProvincia = min.nomProvincia) do
                begin
                    regM.alfavetizados := regM.alfavetizados + min.alfavetizados;
                    regM.encuestados := regM.encuestados + min.encuestados;
                    minimo(det1, det2, regD1, regD2, min);
                end;
            seek(mae, filepos(mae)-1);
            write(mae, regM);
        end;
    close(mae);
    close(det1);
    close(det2);
end;

//Aca iria el programa principal (creacion del archivo maestro/detalle)