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
select facturas.*
from facturas
inner join empleados 
on empleados.EmpleadoID = facturas.EmpleadoID
where empleados.Apellido = 'Buchanan';

# Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.
select facturas.*
from facturas
inner join correos
on facturas.EnvioVia = correos.CorreoID
where correos.compania = 'Speedy Express';

# Generar un listado de todas las facturas con el nombre y apellido de los empleados.
select facturas.*, empleados.Nombre, empleados.Apellido
from facturas
inner join empleados 
on empleados.EmpleadoID = facturas.EmpleadoID;

# Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.
select facturas.*
from facturas
inner join clientes 
on facturas.ClienteID = clientes.ClienteID
where clientes.Titulo = 'Owner' and clientes.Pais = 'USA';

# Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.
select facturas.*
from facturas
inner join empleados 
on empleados.EmpleadoID = facturas.EmpleadoID
inner join facturadetalle
on facturas.FacturaID = facturadetalle.FacturaID
inner join productos 
on facturadetalle.ProductoID = productos.ProductoID
where empleados.Apellido = 'Leverling' or productos.ProductoID = 42;

# Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los producto id = “80” o ”42”.
select facturas.*
from facturas
inner join empleados 
on empleados.EmpleadoID = facturas.EmpleadoID
inner join facturadetalle 
on facturas.FacturaID = facturadetalle.FacturaID
inner join productos 
on facturadetalle.ProductoID = productos.ProductoID
where empleados.Apellido = 'Leverling' or productos.ProductoID = 42 or productos.ProductoID = 80;

# Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).
SELECT c.compania AS cliente,
       ROUND(SUM(fd.PrecioUnitario * fd.Cantidad), 2) AS totalCompras
FROM clientes AS c
INNER JOIN facturas AS f ON c.ClienteID = f.ClienteID
INNER JOIN facturadetalle AS fd ON f.FacturaID = fd.FacturaID
GROUP BY c.compania
ORDER BY totalCompras DESC
LIMIT 5;

select * from facturas;
# Generar un listado de facturas, con los campos id, nombre y apellido del cliente, fecha de factura, país de envío, Total, ordenado de manera descendente por fecha de factura y limitado a 10 filas.
SELECT f.FacturaID AS idFactura,
       c.Contacto AS nombreContactoCliente,
       f.FechaFactura AS fechaFactura,
       f.PaisEnvio AS paisEnvio,
       ROUND(SUM(fd.PrecioUnitario * fd.Cantidad), 2) AS Total
FROM facturas AS f
INNER JOIN clientes AS c ON f.ClienteID = c.ClienteID
INNER JOIN facturadetalle AS fd ON f.FacturaID = fd.FacturaID
GROUP BY f.FacturaID, c.Contacto, f.FechaFactura, f.PaisEnvio
ORDER BY f.FechaFactura DESC
LIMIT 10;

USE musimundos;

# Listar las canciones cuya duración sea mayor a 2 minutos.
SELECT nombre AS cancion, 
	milisegundos AS duracionMilisegundos,
	milisegundos / 60000.0 AS duracionMinutos
FROM canciones
WHERE milisegundos > 120000
ORDER BY duracionMinutos DESC;

# Listar las canciones cuyo nombre comience con una vocal. 
SELECT nombre AS cancion, 
	compositor AS artista
FROM canciones
WHERE nombre LIKE 'a%' OR
    nombre LIKE 'e%' OR
    nombre LIKE 'i%' OR
    nombre LIKE 'o%' OR
    nombre LIKE 'u%'
ORDER BY cancion ASC;

-- Canciones
# Listar las canciones ordenadas por compositor en forma descendente.
SELECT * FROM canciones
ORDER BY compositor DESC;

# Luego, por nombre en forma ascendente. Incluir únicamente aquellas canciones que tengan compositor. 
SELECT * FROM canciones
WHERE compositor IS NOT NULL AND compositor != ''
ORDER BY nombre ASC;

# Listar la cantidad de canciones de cada compositor. 
SELECT compositor, COUNT(*) AS cantidadCanciones
FROM canciones
WHERE compositor IS NOT NULL AND compositor != ''
GROUP BY compositor;

# Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones. 
SELECT compositor, COUNT(*) AS cantidadCanciones
FROM canciones
WHERE compositor IS NOT NULL AND compositor != ''
GROUP BY compositor
HAVING cantidadCanciones > 10;

-- Facturas

# Listar el total facturado agrupado por ciudad.
SELECT ciudad_de_facturacion as ciudad, 
	SUM(total) AS totalFacturado
FROM facturas
GROUP BY ciudad;

# Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.
SELECT ciudad_de_facturacion AS ciudad, 
	SUM(total) AS totalFacturado
FROM facturas
WHERE pais_de_facturacion = 'Canada'
GROUP BY ciudad;

# Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.
SELECT ciudad_de_facturacion AS ciudad, 
	SUM(total) AS totalFacturado
FROM facturas
GROUP BY ciudad
HAVING totalFacturado > 38;

# Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.
SELECT pais_de_facturacion AS pais,
	ciudad_de_facturacion AS ciudad, 
	SUM(total) AS totalFacturado
FROM facturas
GROUP BY pais, ciudad;

-- Canciones / Géneros

# Listar la duración mínima, máxima y promedio de las canciones. 
SELECT MAX(milisegundos) AS duracionMaxima,
    MIN(milisegundos) AS duracionMinima,
    AVG(milisegundos) AS duracionPromedio
FROM canciones;

/*
SELECT MAX(milisegundos) / 60000.0 AS duracionMaximaMinutos,
    MIN(milisegundos) / 60000.0 AS duracionMinimaMinutos,
    AVG(milisegundos) / 60000.0 AS duracionPromedioMinutoss
FROM canciones;
*/

# Modificar el punto (a) mostrando la información agrupada por género.
SELECT g.nombre AS genero,
	MAX(milisegundos) AS duracionMaxima,
    MIN(milisegundos) AS duracionMinima,
    AVG(milisegundos) AS duracionPromedio
FROM canciones AS c
INNER JOIN generos AS g ON c.id_genero = g.id
GROUP BY genero;
