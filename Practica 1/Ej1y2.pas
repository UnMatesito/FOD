program E01y2P1;

type
    archivo_numeros = file of integer;

var
    arch_num : archivo_numeros;
    nombre_archivo: string;
    num: integer;
    cant_menor: integer;
    suma_numeros: integer;
begin
    //ejercicio 1
    writeln('Ingrese un nombre de archivo');
    readln(nombre_archivo);
    writeln();
    Assign(arch_num, nombre_archivo);
    Rewrite(arch_num);
    writeln('Ingrese un numero');
    readln(num);
    while num <> 30000 do
        begin
            Write(arch_num, num);
            writeln('Ingrese un numero');
            readln(num);
        end;

    //ejercicio 2
    cant_menor := 0;
    suma_numeros := 0;
    Reset(arch_num);
    while not eof(arch_num) do
        begin
            Read(arch_num, num);
            if (num < 1500) then
                cant_menor := cant_menor + 1;
            suma_numeros := suma_numeros + num;
        end;
    writeln('Cantidad de numeros menores a 1500: ', cant_menor);
    if (FileSize(arch_num) <> 0) then
        writeln('Promedio de numeros ingresados: ', suma_numeros/FileSize(arch_num):0:2)
    else
        writeln('No hay numeros');
end.