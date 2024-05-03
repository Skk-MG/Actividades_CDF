use emarket;

# Consultas queries XL parte I - GROUP BY

-- Clientes

# ¿Cuántos clientes existen?
select Count(ClienteID) from clientes;

# ¿Cuántos clientes hay por ciudad?
select ciudad, count(*) totalClientes from clientes
group by ciudad;

-- Facturas

# ¿Cuál es el total de transporte?
select sum(Transporte) from facturas;

# ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?
select sum(EnvioVia) from facturas;

# Calcular la cantidad de facturas por cliente. Ordenar descendentemente por cantidad de facturas.
select ClienteID, COUNT(*) totalFacturas 
from facturas 
group by ClienteID 
order by totalFacturas desc;

# Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.
select ClienteID, COUNT(*) totalFacturas 
from facturas 
group by ClienteID 
order by totalFacturas desc
limit 5;

# Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?
select PaisEnvio, COUNT(*) totalFacturas 
from facturas 
group by PaisEnvio 
order by totalFacturas asc
limit 1;

# Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado realizó más operaciones de ventas?
select EmpleadoID, COUNT(*) totalVentas 
from facturas 
group by EmpleadoID 
order by totalVentas desc
limit 1;

-- Factura detalle

# ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?
select ProductoID, count(*) totalFacturas
from facturadetalle
group by ProductoID
order by totalFacturas desc
limit 1;

# ¿Cuál es el total facturado? Considerar que el total facturado es la suma de cantidad por precio unitario.
select ProductoID, SUM(PrecioUnitario * Cantidad) totalFacturado
from facturadetalle
group by ProductoID
order by ProductoID asc;

# ¿Cuál es el total facturado para los productos ID entre 30 y 50?
select ProductoID, SUM(PrecioUnitario * Cantidad) totalFacturado
from facturadetalle
where ProductoID between 30 and 50
group by ProductoID;

# ¿Cuál es el precio unitario promedio de cada producto?
select ProductoID, ceiling(avg(PrecioUnitario))
from facturadetalle
group by ProductoID;

# ¿Cuál es el precio unitario máximo?
select PrecioUnitario
from facturadetalle
group by PrecioUnitario
order by PrecioUnitario desc
limit 1;

# Consultas queries XL parte II - JOIN

# Generar un listado de todas las facturas del empleado 'Buchanan'. 


# Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.
# Generar un listado de todas las facturas con el nombre y apellido de los empleados.
# Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.
# Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.
# Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los producto id = “80” o ”42”.
# Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).
# Generar un listado de facturas, con los campos id, nombre y apellido del cliente, fecha de factura, país de envío, Total, ordenado de manera descendente por fecha de factura y limitado a 10 filas.

