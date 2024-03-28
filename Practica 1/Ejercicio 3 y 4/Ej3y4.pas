program E03y04P01;

type
    empleado = record
        numero: integer;
        apellido: string[30];
        nombre: string[30];
        edad: integer;
        dni: string[8];
        end;

    archivo_empleados = file of empleado;

procedure cargarEmpleado(var e: empleado);
begin
    with e do
        begin
        writeln('Ingrese el numero del empleado');
        readln(numero);
        writeln('Ingrese el apellido del empleado');
        readln(apellido);
        if (apellido <> 'fin') then
            begin
                writeln('Ingrese el nombre del empleado');
                readln(nombre);
                writeln('Ingrese la edad del empleado');
                readln(edad);
                writeln('Ingrese el DNI del empleado');
                readln(dni);
            end;
        end;
        writeln();
end;

procedure listarEmpleado(e: empleado);
begin
    with e do
        begin
            write('Numero de empleado: ');
            writeln(numero);
            write('Apellido: ');
            writeln(apellido);
            write('Nombre: ');
            writeln(nombre);
            write('Edad: ');
            writeln(edad);
            write('DNI: ');
            writeln(dni);
        end;
    writeln();
end;

procedure menu(var opcion:char);
begin
    writeln('-Ejecicio 3 y 4----------------------------------------------------------------------------------------------------');
    writeln();
    writeln('A: Crear archivo');
    writeln();
    writeln('B: Acceder al archivo');
    writeln();
    writeln('C: Otras opciones');
    writeln();
    write('Opcion '); readln(opcion);
end;

procedure crearArchivo (var arch_emp: archivo_empleados);
var
    e:empleado;
begin
    Rewrite(arch_emp);
    cargarEmpleado(e);
    while (e.apellido <> 'fin') do
        begin
            Write(arch_emp, e);
            cargarEmpleado(e);
        end;
    close(arch_emp);
end;

procedure opcionA(var arch_emp: archivo_empleados);
var
    nomOape: string;
    e: empleado;
begin
    Reset(arch_emp);
    writeln('Ingrese un nombre o apellido');
    readln(nomOape);
    while not eof(arch_emp) do
        begin
            Read(arch_emp, e);
            if (e.nombre = nomOape) or (e.apellido = nomOape) then
                listarEmpleado(e);
        end;
    close(arch_emp);
end;

procedure opcionB(var arch_emp: archivo_empleados);
var
    e:empleado;
begin
    Reset(arch_emp);
    while not eof(arch_emp) do
        begin
            Read(arch_emp, e);
            listarEmpleado(e);
        end;
    close(arch_emp);
end;

procedure opcionC(var arch_emp: archivo_empleados);
var
    e:empleado;
begin
    Reset(arch_emp);
    while not eof(arch_emp) do
        begin
            Read (arch_emp, e);
            if (e.edad > 70) then
                listarEmpleado(e);
        end;
    close(arch_emp);
end;

procedure ej4opA(var arch_emp: archivo_empleados);
var
    e:empleado;
begin
    Reset(arch_emp);
    seek(arch_emp, FileSize(arch_emp));
    cargarEmpleado(e);
    while (e.apellido <> 'fin') do
        begin
            Write(arch_emp, e);
            cargarEmpleado(e);
        end;
    close(arch_emp);
end;

procedure ej4opB(var arch_emp: archivo_empleados);
var
    num: integer;
    edad:integer;
    e: empleado;
begin
    Reset(arch_emp);
    writeln('Ingrese un numero del empleado a modificar su edad');
    readln(num);
    while (not eof(arch_emp)) do
        begin
            Read(arch_emp, e);
            if (e.numero = num) then
                begin
                    writeln('Empleado encontrado, ingrese la edad a modificar');
                    readln(edad);
                    e.edad := edad;
                    Write(arch_emp, e);
                end;
        end;
    close(arch_emp);
end;

procedure ej4opC(var arch_emp: archivo_empleados; var t_empleados: Text);
var
    e:empleado;
begin
    Reset(arch_emp);
    Rewrite(t_empleados);
    while not eof(arch_emp) do
        begin
            Read(arch_emp, e);
            writeln(t_empleados, 'Empleado Numero: ', e.numero, ' Apellido: ', e.apellido, ' Nombre: ', e.nombre, ' Edad: ', e.edad, ' DNI: ', e.dni);
        end;
    close(arch_emp);
    close(t_empleados);
end;

procedure ej4opD(var arch_emp: archivo_empleados; var sin_dni: Text);
var
    e: empleado;
begin
    Reset(arch_emp);
    Rewrite(sin_dni);
    while not eof(arch_emp) do
        begin
            Read(arch_emp, e);
            if (e.dni = '00') then
                writeln(sin_dni, 'Empleado Numero: ', e.numero, ' Apellido: ', e.apellido, ' Nombre: ', e.nombre, ' Edad: ', e.edad, ' DNI: ', e.dni);
        end;
    close(arch_emp);
    close(sin_dni);
end;

var
    arch_emp: archivo_empleados;
    t_empleados, sin_dni: Text;
    opcion: char;
    nombre_archivo: string;
    loop: boolean;
begin
    writeln('Ingrese el nombre del archivo');
    readln(nombre_archivo);
    Assign(arch_emp, nombre_archivo);
    Assign(t_empleados, 'todos_empleados.txt');
    Assign(sin_dni, 'faltaDNIEmpleado.txt');
    loop := true;
    while (loop) do
        begin
            menu(opcion);
            if (opcion = 'A') or (opcion = 'a') then
                begin
                    crearArchivo(arch_emp);
                end
            else if (opcion = 'B') or (opcion = 'b') then
                begin
                    writeln('Ingrese la operacion que quiera realizar');
                    writeln('A: Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado');
                    writeln('B: Listar en pantalla a todos los empleados');
                    writeln('C: Listar en pantalla a los empleados proximos a jubilarse');
                    write('Opcion '); readln(opcion);
                    writeln();
                    case opcion of
                        'A' : opcionA(arch_emp);
                        'B' : opcionB(arch_emp);
                        'C' : opcionC(arch_emp);
                        else writeln('No se encuentra la opcion');
                    end;
                end
            else if (opcion = 'C') or (opcion = 'c') then
                begin
                    writeln('Ingrese la operacion que quiera realizar');
                    writeln('A: Añadir uno o mas empleados');
                    writeln('B: Modificar la edad de un empleado');
                    writeln('C: Exportar contenido');
                    writeln('D: Exportar los empleados que no poseean DNI');
                    write('Opcion '); readln(opcion);
                    writeln();
                    case opcion of
                        'A' : ej4opA(arch_emp);
                        'B' : ej4opB(arch_emp);
                        'C' : ej4opC(arch_emp, t_empleados);
                        'D' : ej4opD(arch_emp, sin_dni);
                        else writeln('No se encuentra la opcion');
                    end;
                end
            else
                begin
                writeln('Opcion no valida');
                loop := false;
            end;
        end;
end.