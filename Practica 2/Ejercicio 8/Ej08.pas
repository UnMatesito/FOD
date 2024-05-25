program E08P2;
const
    valorAlto = 9999;

type
    s_dias = 1..31;
    s_meses = 1..12;

    datosCliente = record
        codigo: integer;
        nomYape: string[50];
    end;

    datosVenta = record
        dia: s_dias;
        mes: s_meses;
        anio: integer;
        monto: real;
    end;

    r_maestro = record
        cliente: datosCliente;
        venta: datosVenta;
    end;

    maestro = file of r_maestro;

procedure cargarRegistro(var r: r_maestro);
begin
    with r do
        begin
            writeln('Datos del cliente');
            writeln();
            writeln('Ingrese el codigo del cliente');
            readln(cliente.codigo);
            if (cliente.codigo <> valorAlto) then
                begin
                    writeln('Ingrese el Nombre y Apellido del cliente');
                    readln(cliente.nomYape);
                    writeln('Datos de la Venta');
                    writeln();
                    writeln('Ingrese el dia de la venta');
                    readln(venta.dia);
                    writeln('Ingrese el mes de la venta');
                    readln(venta.mes);
                    writeln('Ingrese el anio de la venta');
                    readln(venta.anio);
                    writeln('Ingrese el monto de la venta');
                    readln(venta.monto);
                end;
        end;
end;

procedure crearMaestro(var m: maestro);
var
    r: r_maestro;
begin
    rewrite(m);
    cargarRegistro(r);
    while (r.cliente.codigo <> valorAlto) do
        begin
            write(m, r);
            cargarRegistro(r);
        end;
    close(m);
end;

procedure leer(var archivo: maestro; var datos: r_maestro);
begin
    if (not eof(archivo)) then
        read(archivo, datos)
    else
        datos.cliente.codigo := valorAlto
end;

procedure reporteVentas(var m: maestro);
var
    clienteAct: integer;
    mesAct: s_meses;
    anioAct: integer;
    montoTotal, montoMensual, montoAnual: real;
    regM: r_maestro;
begin
    reset(m);
    leer(m, regM);
    montoTotal := 0;
    while (regM.cliente.codigo <> valorAlto) do
        begin
            writeln('Cliente Numero: ', regM.cliente.codigo, ' Nombre: ', regM.cliente.nomYape);
            writeln('-------------------------------------------------');
            clienteAct := regM.cliente.codigo;
            while (regM.cliente.codigo = clienteAct) do
                begin
                    anioAct := regM.venta.anio;
                    montoAnual := 0;
                    while (regM.cliente.codigo = clienteAct) and (regM.venta.anio = anioAct) do
                        begin
                            montoMensual := 0;
                            mesAct := regM.venta.mes;
                            while (regM.cliente.codigo = clienteAct) and (regM.venta.anio = anioAct) and (regM.venta.mes = mesAct) do
                                begin
                                    montoMensual := montoMensual + regM.venta.monto;
                                    leer(m, regM);
                                end;
                            writeln('Monto del mes ', mesAct, ' : ', montoMensual:0:2);
                            montoAnual := montoAnual + montoMensual;
                        end;
                    writeln('-------------------------------------------------');
                    writeln('Monto del anio ', anioAct, ' : ', montoAnual:0:2);
                    montoTotal := montoTotal + montoAnual;
                    writeln('-------------------------------------------------');
                    writeln()
                end;
        end;
    writeln('Monto total de la empresa: ', montoTotal:0:2);
    close(m);
end;

var
    m: maestro;
begin
    assign(m, 'Archivo_Ventas');
    //crearMaestro(m);
    reporteVentas(m);
end.