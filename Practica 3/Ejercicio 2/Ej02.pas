program E02P3;
const
    valorAlto = 9999;

type
    asistente = record
        num: integer;
        apeYnom: string[50];
        email: string[30];
        telefono: string;
        dni: integer;
    end;

archivo_congreso = file of asistente;

procedure cargarAsistente(var a: asistente);
begin
    with a do
        begin
            writeln('Ingrese el numero de asistente del congreso');
            readln(num);
            if (num <> valorAlto) then
                begin
                    writeln('Ingrese el apellido y nombre del aisitente');
                    readln(apeYnom);
                    writeln('Ingrese el E-mail del asistente');
                    readln(email);
                    writeln('Ingrese el telefono del asistente');
                    readln(telefono);
                    writeln('Igrese el D.N.I. del aisstente');
                    readln(dni);
                end;
            writeln();
        end;
end;

procedure crearArchivoCongreso(var archivo: archivo_congreso);
var
    asist: asistente;
begin
    rewrite(archivo);
    cargarAsistente(asist);
    while (asist.num <> valorAlto) do
        begin
            write(archivo, asist);
            cargarAsistente(asist);
        end;
    close(archivo);
end;

procedure leer (var archivo: archivo_congreso; var dato: asistente);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.num := valorAlto;
end;

procedure eliminarAsistentesNumMenorQue1000(var archivo: archivo_congreso);
var
    asist: asistente;
    charEsp: char;
begin
    charEsp := '@';
    Reset(archivo);
    leer(archivo, asist);
    while (asist.num < 1000) do
        begin
            Insert(charEsp, asist.apeYnom, 1);
            seek(archivo, filepos(archivo)-1);
            write(archivo, asist);
            leer(archivo, asist);
        end;
    close(archivo);
end;

procedure impirmirArchivo(var archivo: archivo_congreso);
var
    asist: asistente;
begin
    Reset(archivo);
    while (not eof(archivo)) do
        begin
            read(archivo, asist);
            writeln('Numero: ', asist.num);
            writeln('Nombre y Apellido: ', asist.apeYnom);
        end;
    close(archivo)
end;

var
    archivo: archivo_congreso;
begin
    Assign(archivo, 'Archivo_Asistentes_Congreso');
    //crearArchivoCongreso(archivo);
    eliminarAsistentesNumMenorQue1000(archivo);
    impirmirArchivo(archivo);
end.