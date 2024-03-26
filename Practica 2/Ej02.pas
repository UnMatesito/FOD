program E02P2
const
    s_aprobacion = 1..2;

type
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

var
    
begin
    assign() //se dispone de alumnos
end.