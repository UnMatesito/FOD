program busquedaArbol;

// Modulo busqueda
procedure posicionarYLeerNodo(A, var nodo, NRR);
begin
    seek(A, NRR);
    for i:=1 to M-1 do
        nodo[i] := A[i]
end;

procedure claveEncontrada(A, nodo, clave, pos, var clave_encontrada);
begin
    clave_encontrada := false;
    for pos:=1 to M-1 do
        begin 
            if (nodo[pos] = clave) then
                clave_encontrada := true;
        end;
end;

procedure buscar(NRR, clave, NRR_encontrado, pos_encontrada, resultado);
var 
    clave_encontrada: boolean;
begin
    if (nodo = null)
        resultado := false {clave no encontrada}
    else
        begin
            posicionarYLeerNodo(A, nodo, NRR);
            claveEncontrada(nodo, clave, pos, clave_encontrada);
            if (clave_encontrada) then 
                begin
                    NRR_encontrado := NRR; { NRR actual }
                    pos_encontrada := pos; { posicion dentro del array }
                    resultado := true;
                end;
            end
            else
                buscar(nodo.hijos[pos], clave, NRR_encontrado, pos_encontrada, resultado);
        end;
end;
// Programa principal