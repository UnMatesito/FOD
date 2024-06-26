program E02P2
const
    valorAlto = 9999;

type
    s_aprobacion = 1..2; // 1: cursada | 2: final
    
    alumno = record
        codigo: integer;
        apellido: string;
        nombre: string;
        cursadas: integer;
        aprobadas: integer;
    end;

    detalle = record
        codigo: integer;
        queAprobo: s_aprobacion;
    end;

    archivo_alumnos = file of alumno;

    archivo_detalle = file of detalle;

procedure leerDetalle(var det: archivo_detalle; dato: detalle);
begin
    if (not eof(det)) then
        read(det, dato)
    else
        dato.codigo := valorAlto;
end;

procedure actMaestro(var mae: archivo_alumnos);
var
    det: archivo_detalle;
    regM: alumno;
    regD: detalle;
begin
    assign(det, 'Detalle_Alumnos');
    reset(mae); reset(det);
    leer(det, regD);
    while (regD <> valorAlto) do
        begin
            read(mae, regM);
            while (regM.codigo <> regD.codigo) do
                read(mae, regM);
            while (regM.codigo = regD.codigo) do
                begin
                    if (regD.queAprobo = 1) then
                        regM.cursadas := regM.cursadas + 1
                    else
                        begin
                            regM.aprobadas := regM.aprobadas + 1;
                            regM.cursadas := regM.cursadas - 1;
                        end;
                    leer(det, regD);
                end;
            seek(mae, filepos(mae)-1);
            write(mae, regM);
        end;
    close(det);
    close(mae);
end;

procedure crearTxt(var mae: archivo_alumnos);
var
    arch_finales: Text;
    a: alumno;
begin
    assign(arch_finales, 'AlumnosFinales.txt');
    reset(mae);
    rewrite(arch_finales);
    while (not eof(mae)) do
        begin
            read(mae, a);
            if (a.aprobadas > a.cursadas) then
                writeln(arch_finales, 'Codigo de alumno: ', a.codigo,' Apellido: ', a.apellido, ' Nombre: ', a.nombre, ' Materias con cursada aprobada: ', a.cursada, ' Materias con final aprobado: ', a.final);
        end;
    close(mae);
    close(arch_finales);
end;

var
    opcion: char;
    a: archivo_alumnos;
begin
    assign(a, 'Archivo_Alumnos');
    writeln('-Ejercicio 2--------------------------------------------------');
    writeln();
    writeln('Ingrese una opcion');
    writeln();
    writeln('A: Actualizar el archivo de alumnos con un detalle');
    writeln('B: Listar en un archivo de texto alumnos con mas finales aprobados');
    writeln();
    write('Opcion')readln(opcion);
    opcion := UpCase(opcion);
    case opcion of
        'A': actMaestro(a);
        'B': crearTxt(a);
        else
            writeln('La opcion no existe');
end.