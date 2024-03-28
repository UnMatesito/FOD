program E01P2;

type
    empleado = record
        codigo: integer;
        nombre: string;
        monto: real;
    end;

    archivo_empleados = file of empleado;

procedure compactarArchivo(var arch: archivo_empleados; var arch_nuevo: archivo_empleados);
var
    montoTotal: real;
    codActual: integer;
    regA: empleado;
begin
    reset(arch); //se dispone de empleados
    rewrite(arch_nuevo);
    while (not eof(arch)) do
        begin
            montoTotal := 0;
            read(arch, regA);
            codActual := regA.codigo;
            while (not eof(arch) and (regA.codigo = codActual) do
                begin
                    montoTotal := montoTotal + regA.monto;
                    read(arch, regA);
                end;
            regA.monto := montoTotal;
            write(arch_nuevo, regA);
        end;
    close(arch);
    close(arch_nuevo);
end;

var
    arch: archivo_empleados;
    arch_nuevo: archivo_empleados;
begin
    assign(arch, 'Archivo_Comisiones');
    assign(arch_nuevo, 'Archivo_Compactado');
    compactarArchivo(arch, arch_nuevo);
end.