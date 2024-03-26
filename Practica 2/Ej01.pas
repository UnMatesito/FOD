program E01P2;

type
    empleado = record
        codigo: integer;
        nombre: string;
        monto: real;
    end;

    archivo_empleados = file of empleado;

var
    arch: archivo_empleados;
    arch_nuevo: archivo_empleados;
    regA: empleado;
    codActual: integer;
    montoTotal: real;
begin
    assign(arch, 'Archivo_antiguo');
    assign(arch_nuevo, 'Archivo_Compactado');
    reset(arch);
    rewrite(arch_nuevo);
    while (not eof(arch)) do
        begin
            montoTotal := 0;
            read(arch, regA);
            codActual := regA.codigo;
            while (regA.codigo = codActual) do
                begin
                    montoTotal := montoTotal + regA.monto;
                    read(arch, regA);
                end;
            regA.monto := montoTotal;
            write(arch_nuevo, regA);
        end;
    close(arch);
    close(arch_nuevo);
end.