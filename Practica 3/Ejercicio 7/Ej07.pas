program E07P3;
const

type
    ave = record
        codigo: integer;
        nombreEspecie: string;
        familia: string;
        descripcion: string;
        zonaGeografica: string;
    end;

    archivo_Aves = file of ave;


var
    archivoMaestro: archivo_Aves;
begin
    
end.