program E10P2;

const
    valorAlto = 'zzzz';
    cantCategorias = 15;

type
    empleado = record
        departamento: string;
        division: string;
        numEmp: integer;
        categoria: integer;
        cantHoras: integer;
    end;

    cate = record
        num: integer;
        monto: real;
    end;

    archivo_empleados = file of empleado;
    
    categ = 1..cantCategorias;

    horas_Extra = array[categ] of real;

procedure cargarEmpleado(var e: empleado);
begin
    with e do
        begin
            writeln('Ingrese el nombre del departamento');
            readln(departamento);
            if (departamento <> 'zzzz') then
                begin
                    writeln('Ingrese la division donde trabaja el empleado');
                    readln(division);
                    writeln('Ingrese el numero de empleado');
                    readln(numEmp);
                    writeln('Ingrese la categoria del empleado');
                    readln(categoria);
                    writeln('Ingrese cantidad de horas extras que hizo el empleado');
                    readln(cantHoras);
                end;
            writeln();
        end;
end;

procedure crearMaestro(var mae: archivo_empleados);
var
    e: empleado;
begin
    rewrite(mae);
    cargarEmpleado(e);
    while (e.departamento <> 'zzzz') do
        begin
            write(mae, e);
            cargarEmpleado(e);
        end;
    close(mae);
end;

procedure asignarTxt(var he: horas_Extra);
var
    hExtras: Text;
    c: cate;
    i: integer;
begin
    assign(hExtras, 'Horas_Extras.txt');
    reset(hExtras);
    for i:= 1 to cantCategorias do
        begin
            readln(hExtras, c.num, c.monto);
            he[c.num] := c.monto;
        end;
    close(hExtras);
end;

procedure leer(var archivo: archivo_empleados; var dato: empleado);
begin
    if (not eof(archivo)) then
        read(archivo, dato)
    else
        dato.departamento := valorAlto
end;

var
    mae: archivo_empleados;
    he: horas_Extra;
    e: empleado;
    depActual: string;
    divActual: string;
    empActual: integer;
    totalHrsEmp, totalHrsDiv: integer;
    totalMontoDiv, importe: real;
begin
    assign(mae, 'Archivo_Empleados');
    crearMaestro(mae);
    asignarTxt(he);
    reset(mae);
    leer(mae, e);
    while (e.departamento <> valorAlto) do
        begin
            writeln('Departamento ', e.departamento);
            depActual := e.departamento;
            writeln('Division ', e.division);
            while (depActual = e.departamento) do
                begin
                    divActual := e.division;
                    totalHrsDiv := 0;
                    totalMontoDiv := 0;
                    while ((depActual = e.departamento) and (divActual = e.division)) do
                        begin
                            empActual := e.numEmp;
                            totalHrsEmp := 0;
                            importe := 0;
                            while ((depActual = e.departamento) and (divActual = e.division) and (empActual = e.numEmp)) do
                                begin
                                    totalHrsEmp := totalHrsEmp + e.cantHoras;
                                    importe := importe + (e.cantHoras*he[e.categoria]);
                                    leer(mae, e);
                                end;
                            writeln(e.numEmp, ' ', totalHrsEmp, ' ', importe:0:2);
                        end;
                    totalHrsDiv := totalHrsDiv + e.cantHoras;
                    totalMontoDiv := totalMontoDiv + importe;
                end;
            writeln('Total Horas Division ', totalHrsDiv);
            writeln('Total Monto Division ', totalMontoDiv:0:2);
            writeln();
        end;
    close(mae);
end.