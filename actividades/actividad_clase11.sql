use emarket;

-- Categorias y productos

# Queremos tener un listado de todas las categorías.
select * from categorias;

# Cómo las categorías no tienen imágenes, solamente interesa obtener un listado de CategoriaNombre y Descripcion.
select categoriaNombre, descripcion from categorias;

#Obtener un listado de los productos.
select * from productos;

# ¿Existen productos discontinuados? (Discontinuado = 1).
select * from productos
where Discontinuado = 1;

# Para el viernes hay que reunirse con el Proveedor 8. ¿Qué productos son los que nos provee?
select * from productos
where ProveedorID = 8;

# Queremos conocer todos los productos cuyo precio unitario se encuentre entre 10 y 22.
select * from productos
where PrecioUnitario >= 10
and PrecioUnitario <= 22;

#Se define que un producto hay que solicitarlo al proveedor si sus unidades en stock son menores al Nivel de Reorden. ¿Hay productos por solicitar?
select * from productos
where UnidadesStock < NivelReorden;

# Se quiere conocer todos los productos del listado anterior, pero que unidades pedidas sea igual a cero.
select * from productos
where UnidadesStock < NivelReorden
and UnidadesPedidas = 0;

-- Clientes

# Obtener un listado de todos los clientes con Contacto, Compania, Título, País. Ordenar el listado por País.
select Contacto, Compania, Titulo, Pais from clientes
order by Pais asc;

# Queremos conocer a todos los clientes que tengan un título “Owner”.
select * from clientes
where Titulo = 'Owner';

# El operador telefónico que atendió a un cliente no recuerda su nombre. 
# Solo sabe que comienza con “C”. 
# ¿Lo ayudamos a obtener un listado con todos los contactos que inician con la letra “C”?
select * from clientes
where Contacto like 'c%';

-- Facturas 

# Obtener un listado de todas las facturas, ordenado por fecha de factura ascendente.
select * from facturas
order by FechaFactura asc; 

# Ahora se requiere un listado de las facturas con el país de envío “USA” y que su correo (EnvioVia) sea distinto de 3.
select * from facturas
where PaisEnvio = 'USA'
and EnvioVia != 3;

# ¿El cliente 'GOURL' realizó algún pedido?
select * from facturas
where ClienteID = 'GOURL';

# Se quiere visualizar todas las facturas de los empleados 2, 3, 5, 8 y 9.
select * from facturas
where EmpleadoID in (2,3,5,8,9);

-- Productos

# Obtener el listado de todos los productos ordenados descendentemente por precio unitario.
select * from productos
order by PrecioUnitario desc;

# Obtener el listado de top 5 de productos cuyo precio unitario es el más caro.
select * from productos
order by PrecioUnitario desc
limit 5;

# Obtener un top 10 de los productos con más unidades en stock.
select * from productos
order by UnidadesStock desc
limit 10;

-- Factura Detalle 

# Obtener un listado de FacturaID, ProductoID, Cantidad.
select FacturaID, ProductoID, Cantidad from facturadetalle;

# Ordenar el listado anterior por cantidad descendentemente.
select FacturaID, ProductoID, Cantidad from facturadetalle
order by Cantidad desc;

# Filtrar el listado solo para aquellos productos donde la cantidad se encuentre entre 50 y 100.
select * from facturadetalle
where Cantidad >= 50
and Cantidad <= 100;

# En otro listado nuevo, obtener un listado con los siguientes nombres de columnas: 
# NroFactura (FacturaID), Producto (ProductoID), Total (PrecioUnitario*Cantidad).
select FacturaID NroFactura, ProductoID Producto, (PrecioUnitario*Cantidad) Total
from facturadetalle;

-- Extras 

# Obtener un listado de todos los clientes que viven en “Brazil" o “Mexico”, o que tengan un título que empiece con “Sales”. 
select * from clientes
where Pais = 'Brazil'
or Pais = 'Mexico'
or Titulo like 'Sales%';

# Obtener un listado de todos los clientes que pertenecen a una compañía que empiece con la letra "A".
select * from clientes
where Compania like 'a%';

# Obtener un listado con los datos: Ciudad, Contacto y renombrarlo como Apellido y Nombre, Titulo y renombrarlo como Puesto, de todos los clientes que sean de la ciudad "Madrid".
select Ciudad, Contacto Apellido_y_Nombre, Titulo Puesto from clientes
where Ciudad = 'Madrid';

# Obtener un listado de todas las facturas con ID entre 10000 y 10500
select * from facturas
where FacturaID >= 10000
and FacturaID <= 10500;

# Obtener un listado de todas las facturas con ID entre 10000 y 10500 o de los clientes con ID que empiecen con la letra “B”.
select * from facturas
where FacturaID >= 10000
and FacturaID <= 10500
or ClienteID like 'B%';

# ¿Existen facturas que la ciudad de envío sea “Vancouver” o que utilicen el correo 3?
select * from facturas
where CiudadEnvio = 'Vancouver'
or EnvioVia = 3;

# ¿Cuál es el ID de empleado de “Buchanan”?
select EmpleadoID from empleados 
where Apellido = 'Buchanan';

# ¿Existen facturas con EmpleadoID del empleado del ejercicio anterior? (No relacionar, sino verificar que existan facturas)
select * from facturas
where EmpleadoID = 5;