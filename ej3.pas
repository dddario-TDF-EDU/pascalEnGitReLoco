{3- Generar un archivo con los datos personales de los clientes de un comercio. Estos datos son: Nombre, Dirección, Teléfono, Tope de Crédito.
a) Realizar un subprograma que reciba el archivo generado e imprima su contenido.
b) Actualizar el archivo anteriormente generado aumentando en un 20 % el tope de crédito.}


//probamos elhecho de eliminar archivos, sobreEscribir

program ej3;

uses 
sysutils;

const

maxDatos = 5;

Type

    DatosCliente = record
        nombre: string;
        direccion: string;
        telefono: string;
        topeCredito: string;
        end;

    DataAccesible = record
        existe: boolean;
        datos: DatosCliente;
        end;

    ArchivosExistentes = file of DataAccesible;

procedure abrirArchivo(var registros: ArchivosExistentes; rutaArchivo: string);
begin
    Assign(registros, rutaArchivo);
    {$I-}
    Reset(registros);
    {$I+}
    if (IOresult<>0) then
        begin
            writeln('Archivo no existente, creado nuevo archivo');
            Rewrite(registros); 
        end;
    writeln('Archivo abierto, ya puede ver los registros');
end;

procedure cargarCliente(var auxCliente: DataAccesible);
begin
        with auxCliente.datos do
        begin
            writeln('Ingrese nombre del cliente');
            readln(nombre);
            writeln('Ingrese direccion del cliente');
            readln(direccion);
            writeln('Ingrese telefono del cliente');
            readln(telefono);
            writeln('Ingrese tope de credito del cliente');
            readln(topeCredito);
        end;
        auxCliente.existe:= true;
end;

procedure deseaContinuar(var cerrar: string);
begin
    writeln('ingrese Y si desea dejar de cargar datos, sino ingrese otra tecla');
    readln(cerrar);
end;

// procedure inicializarDatos(var registros: ArchivosExistentes);
// var 
// i: byte;
// begin
    
// end;

procedure cargarDatos(var registros: ArchivosExistentes);
var
i: byte;
decision: string[1];
auxCliente: DataAccesible;
begin
    decision:='';
    i:=1;
    while (UpperCase(decision) <> 'Y') and (i<maxDatos) do
    begin
        Seek(registros, i);
        Read(registros, auxCliente);
        if (auxCliente.existe) then
            begin
                cargarCliente(auxCliente);
                Write(registros, auxCliente);
                deseaContinuar(decision);
            end;
        i+=1;
    end;
end;

procedure mostrarDatos(miCliente: DatosCliente);
begin
    with miCliente do
        begin
            writeln('Nombre del cliente: ', nombre);
            writeln('Direccion del cliente: ', direccion);
            writeln('Telefono del cliente: ',telefono);
            writeln('Tope de credito del cliente: ',topeCredito);
        end;
end;

procedure listarClientes(var registros: ArchivosExistentes);
var
i: byte;
auxCliente: DataAccesible;
begin
	i:=1;
    while (i<maxDatos)  do
    begin
        Seek(registros, i);
        Read(registros, auxCliente);
        if auxCliente.existe then
            begin
                writeln('Cliente nro',i);
                mostrarDatos(auxCliente.datos);
            end;
        i+=1;
        writeln('revisando archivo ',i);
    end;

end;

procedure eliminarRegistro(var registros: ArchivosExistentes);
var
pos: byte;
begin
    writeln('Ingrese el indice del cliente que desea borrar.');
    readln(pos);
    if (pos < 1) or (pos > maxDatos) then
    repeat
        writeln('valor ingresado incorrecto, intente nuevamente');
        readln(pos);
    until ((pos<maxDatos) and (pos>0));

end;

var
misClientes: ArchivosExistentes;
rutaGuardado: string;
begin
    rutaGuardado:='registroTrabajo3.dat';
    abrirArchivo(misClientes, rutaGuardado);
    listarClientes(misClientes); 
    cargarDatos(misClientes);
    listarClientes(misClientes); 
    eliminarRegistro(misClientes);   
end.


{buscando solucionar el soft-delete creamos un nuevo tipo de dato}

{
    Type

    DatosCliente = record
        nombre: string;
        direccion: string;
        telefono: string;
        topeCredito: string;
        end;

    DataAccesible = record
        existe: boolean;
        datos: DatosCliente;
        end;

    ArchivosExistentes = file of DataAccesible;

    RegistrosFinales = record
        cantExistente: byte;
        datosExistentes: ArchivosExistentes;
        end;
    
    TClientes = file of RegistrosFinales;

}