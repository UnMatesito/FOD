program Ej05y6P1;

type
    celular = record
        codigo: integer;
        nombre: string;
        descripcion: string;
        marca: string;
        precio: real;
        stock_min: integer;
        stock_disp: integer;
        end;
    
    archivo_celulares = File of celular;

procedure crearArchivo(var a: archivo_celulares; var t_cel: Text);
var
    c: celular;
begin
    Reset(t_cel);
    Rewrite(a);
    while (not eof(t_cel)) do
        begin
            with c do
                begin
                    readln(t_cel, codigo, precio, marca);
                    readln(t_cel, stock_disp, stock_min, descripcion);
                    readln(t_cel, nombre);
                end;
            write(a, c);
        end;
    writeln('Archivo creado');
    close(a);
    close(t_cel);
end;

procedure listarCelular(c: celular);
begin
    with c do
        begin
            write('Codigo: '); writeln(codigo);
            write('Nombre: '); writeln(nombre);
            write('Descripcion: '); writeln(descripcion);
            write('Marca: '); writeln(marca);
            write('Precio: '); writeln(precio);
            write('Stock Minimo: '); writeln(stock_min);
            write('Stock Actual: '); writeln(stock_disp);
        end;
    writeln();
end;

procedure stockMenor(var a: archivo_celulares);
var
    c: celular;
begin
    Reset(a);
    while (not eof(a)) do
        begin
            Read(a, c);
            if (c.stock_disp < c.stock_min) then
                listarCelular(c);
        end;
    close(a);
end;

procedure descripcionUsuario(var a: archivo_celulares);
var
    c: celular;
begin
    Reset(a);
    while (not eof(a)) do
        begin
            Read(a, c);
            if (c.descripcion <> ' ') then
                listarCelular(c);
        end;
    close(a);
end;

procedure exportar(var a: archivo_celulares; var t_cel:Text);
var
    c: celular;
begin
    Reset(a);
    Rewrite(t_cel);
    while not eof(a) do
        begin
            Read(a, c);
            with c do
            begin
                writeln(t_cel, codigo, ' ' , precio:0:2, ' ' ,marca);
                writeln(t_cel, stock_disp, ' ' , stock_min, ' ' ,descripcion);
                writeln(t_cel, nombre); 
            end;
        end;
    close(a);
    close(t_cel);
end;

procedure cargarCelular(var c:celular);
begin
    with c do
        begin
            writeln('Ingrese el Codigo del celular');
            readln(codigo);
            writeln('Ingrese el nombre del celular');
            readln(nombre);
            writeln('Ingrese la descripcion del celular');
            readln(descripcion);
            writeln('Ingrese la marca del celular');
            readln(marca);
            writeln('Ingrese el precio del celular');
            readln(precio);
            writeln('Ingrese el stock actual del celular');
            readln(stock_disp);
            writeln('Ingrese el stock minimo del celular');
            readln(stock_min);
        end;
    writeln();
end;

procedure aniadir(var a: archivo_celulares);
var
    c: celular;
    cantidad, i: integer;
begin
    Reset(a);
    seek(a, filesize(a));
    writeln('Ingrese la cantidad de celulares que quiere aniadir');
    readln(cantidad);
    for i:=1 to cantidad do
        begin
            cargarCelular(c);
            write(a, c);
        end;
    close(a);
end;

procedure modificarStock(var a: archivo_celulares);
var
    c:celular;
    nom: string;
    stock_nuevo:integer;
begin
    Reset(a);
    writeln('Ingrese un nombre de celular para realizar la modificacion de stock');
    readln(nom);
    while (not eof(a)) do
        begin
            Read(a, c);
            if (c.nombre = nom) then
                begin
                    writeln('Celular encontrado ingres la nueva cantidad de stock');
                    readln(stock_nuevo);
                    c.stock_disp := stock_nuevo;
                    write(a, c);
                end;
        end;
    close(a);
end;

procedure exportarSinStock(var a: archivo_celulares);
var
    c:celular;
    sinStock: Text;
begin
    assign(sinStock, 'SinStock.txt');
    Reset(a);
    Rewrite(sinStock);
    while (not eof(a)) do
        begin
            Read(a, c);
            if (c.stock_disp = 0) then
                with c do
                    writeln(sinStock, codigo, ' ', nombre, ' ', descripcion, ' ', marca, ' ', precio:0:2, ' ', stock_disp, ' ', stock_min);
        end;
    close(a);
    close(sinStock);
end;

var
    a_cel: archivo_celulares;
    nombre_archivo: string;
    loop: boolean;
    opcion: char;
    t_celulares: Text;
begin
    writeln('Ingrese el nombre del archivo');
    readln(nombre_archivo);
    assign(a_cel, nombre_archivo);
    assign(t_celulares, 'celulares.txt');
    loop := true;
    while (loop) do
        begin
            writeln('-Ejecicio 5 y 6-----------------------------------------');
            writeln();
            writeln('A: Crear archivo a partir de un archivo de texto');
            writeln();
            writeln('Otras opciones');
            writeln();
            writeln('B: Listar en pantalla los celulares que poseean un stock menor al minimo');
            writeln('C: Listar los celulares cuya descripcion este proporcionada por el usuario');
            writeln('D: Exportar el archivo al archivo de texto');
            writeln();
            writeln('Opciones ejercicio 6');
            writeln();
            writeln('E: Añadir 1 o mas Celulares al archivo');
            writeln('F: Modificar un stock de un celular');
            writeln('G: Exporat celulares que no poseen stock');
            writeln('Seleccione una opcion. Para salir precione otra tecla');
            write('Opcion '); readln(opcion);
            opcion := UpCase(opcion);
            case opcion of
                'A' : crearArchivo(a_cel, t_celulares);
                'B' : stockMenor(a_cel);
                'C' : descripcionUsuario(a_cel);
                'D' : exportar(a_cel, t_celulares);
                'E' : aniadir(a_cel);
                'F' : modificarStock(a_cel);
                'G' : exportarSinStock(a_cel);
                else
                    begin
                        writeln('Opcion no valida');
                        loop := false;
                    end;
            end;
            writeln();
        end;
end.