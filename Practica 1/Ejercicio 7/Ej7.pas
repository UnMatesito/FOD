program Ej07P1;

type
    novela = record
        codigo: integer;
        nombre: string;
        genero: string;
        precio: real;
        end;

    archivo_novelas = file of novela;

procedure crearArchivo(var a: archivo_novelas; var txt: Text);
var
    n:novela;
begin
    reset(txt);
    rewrite(a);
    while (not eof(txt)) do
        begin
            with n do
            begin
                readln(txt, codigo, precio, genero);
                readln(txt, nombre);
            end;
        end;
    close(a);
    close(txt);
end;

procedure cargarNovela(var n:novela);
begin
    with n do
        begin
            writeln('Ingrese el codigo de la novela');
            readln(codigo);
            writeln('Ingrese el nombre de la novela');
            readln(nombre);
            writeln('Ingrese el genero de la novela');
            readln(genero);
            writeln('Ingrese el precio de la novela');
            readln(precio);
        end;
    writeln();
end;

procedure agergarNovela(var a: archivo_novelas);
var
    n: novela;
begin
    reset(a);
    seek(a, filesize(a));
    cargarNovela(n);
    write(a, n);
    close(a);
end;

procedure modificarNovela(var a: archivo_novelas);
var
    codigo_buscar:integer;
    n: novela;
    nom_nuevo: string;
    gen_nuevo: string;
    pre_nuevo: real;
begin
    reset(a);
    writeln('Ingrese el codigo de novela a bsucar');
    readln(codigo_buscar);
    while (not eof(a)) do
        begin
            read(a, n);
            if (n.codigo = codigo_buscar) then
                begin
                    writeln('Ingrese un nuevo nuevo');
                    readln(nom_nuevo);
                    n.nombre := nom_nuevo;
                    writeln('Ingrese un genero nuevo');
                    readln(gen_nuevo);
                    n.genero := gen_nuevo;
                    writeln('Ingrese un precio nuevo');
                    readln(pre_nuevo);
                    n.precio := pre_nuevo;
                    write(a, n);
                end;
        end;
    close(a);
end;

procedure accionesB(var a:archivo_novelas);
var
    opcion: char;
begin
   writeln('Ingrese la accion que quiera realizar al archivo');
   writeln();
   writeln('A: Agergar una novela');
   writeln('B: Modificar una novela existente');
   writeln();
   write('Opcion '); readln(opcion);
   opcion := UpCase(opcion);
   case opcion of
        'A' : agergarNovela(a);
        'B' : modificarNovela(a);
        end;
end;

var
    nombre_archivo: string;
    a_nov: archivo_novelas;
    t_novelas: Text;
    loop: boolean;
    opcion: char;
begin
    writeln('Ingrese un nombre de archivo');
    readln(nombre_archivo);
    assign(a_nov, nombre_archivo);
    assign(t_novelas, 'novelas.txt');
    loop:= true;
    while (loop) do
        begin
            writeln('-Ejercicio 7-------------------------------------');
            writeln();
            writeln('Seleccione una opcion');
            writeln();
            writeln('A: Crear Archivo a partir del documento de texto');
            writeln('B: Actualizacion del arhivo');
            writeln();   
            write('Opcion '); readln(opcion);
            opcion := UpCase(opcion);         
            case opcion of
                'A': crearArchivo(a_nov, t_novelas);
                'B': accionesB(a_nov);
                else
                begin
                    writeln('No existe la opcion');
                    loop := false;
                end;
            end;
        end;
end.