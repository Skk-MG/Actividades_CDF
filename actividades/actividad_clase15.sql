USE emarket;

/*
Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
	- Id de la factura
	- fecha de la factura
	- nombre de la empresa de correo
	- nombre del cliente
	- categoría del producto vendido
	- nombre del producto
	- precio unitario
	- cantidad
*/

SELECT f.FacturaID,
    f.FechaFactura,
    co.Compania AS empresaCorreo,
    cli.Compania AS nombreCliente,
    ca.CategoriaNombre AS categoriaProducto,
    p.ProductoNombre AS nombreProducto,
    p.PrecioUnitario,
    p.UnidadesStock AS cantidad
FROM facturas AS f, productos AS p
INNER JOIN correos co ON f.EnvioVia = co.CorreoID
INNER JOIN clientes cli ON f.ClienteID = cli.ClienteID
INNER JOIN categorias ca ON p.CategoriaID = ca.CategoriaID;

# Listar todas las categorías junto con información de sus productos. Incluir todas las categorías aunque no tengan productos.
SELECT * FROM categorias;

# Listar la información de contacto de los clientes que no hayan comprado nunca en emarket.
SELECT c.*
FROM clientes c
LEFT JOIN facturas f ON c.ClienteID = f.ClienteID
WHERE f.ClienteID IS NULL;

# Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y la información de contacto de su proveedor. 
-- Tener en cuenta que puede haber productos para los cuales no se indicó quién es el proveedor.
SELECT p.ProductoNombre,
		c.CategoriaNombre,
		pro.*
FROM productos AS p
LEFT JOIN categorias as c 
ON p.CategoriaID = c.CategoriaID
LEFT JOIN proveedores as pro
ON p.ProveedorID = pro.ProveedorID
WHERE pro.ProveedorID IS NOT NULL;

# Para cada categoría listar el promedio del precio unitario de sus productos.
SELECT ca.CategoriaNombre AS categoriaProducto,
		ROUND(AVG(p.PrecioUnitario),2) AS precioPromedio
FROM productos AS p
INNER JOIN categorias AS ca 
ON p.CategoriaID = ca.CategoriaID
GROUP BY ca.CategoriaNombre;

# Para cada cliente, indicar la última factura de compra. Incluir a los clientes que nunca hayan comprado en e-market.
SELECT c.Compania as cliente,
       f.*
FROM clientes AS c
INNER JOIN (
    SELECT ClienteID, MAX(FechaFactura) AS ultimaFechaFactura
    FROM facturas
    GROUP BY ClienteID
) AS ultimaFactura
ON c.ClienteID = ultimaFactura.ClienteID
INNER JOIN facturas AS f
ON ultimaFactura.ClienteID = f.ClienteID
    AND ultimaFactura.ultimaFechaFactura = f.FechaFactura;

# Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un listado con todas las empresas de correo, y la cantidad de facturas correspondientes. Realizar la consulta utilizando RIGHT JOIN.
SELECT co.Compania AS empresaCorreo,
    COUNT(f.FacturaID) AS cantidadFacturas
FROM correos AS co
RIGHT JOIN facturas AS f ON co.CorreoID = f.EnvioVia
GROUP BY co.Compania;
