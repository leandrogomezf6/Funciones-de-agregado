/*
* Por Leandro Gómez 1-23-7035.
* Practica propuesta por el profe Arismendy Rodríguez en la materia Base de Datos II.
* Uso del: SUM, AVG, YEAR, COUNT, DATEDIFF, AS, GROUP BY, JOIN y abreviatura de tablas.
*/

-- 1. Calcular el promedio de descuentos aplicados por cada cliente.
SELECT o.CustomerID AS ClienteID, AVG(od.Discount) AS descuentos_promedios FROM [Order Details] od
JOIN Orders o ON od.OrderID = o.OrderID GROUP BY o.CustomerID;

-- 2. Número de pedidos por país y año
SELECT YEAR(o.OrderDate) AS ano, c.Country AS pais, COUNT(o.OrderID) AS numero_pedidos FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID GROUP BY YEAR(o.OrderDate), c.Country;

-- 3. Determinar el monto total de fletes pagados por cada proveedor.
SELECT p.SupplierID AS SuplidorID, SUM(o.Freight) AS flete_total FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.SupplierID;

-- 4. Calcular el promedio de días de entrega por cada región.
SELECT c.Region, AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) AS dias_entrega FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID GROUP BY c.Region;

-- 5. Total de ingresos por categoría de producto
SELECT p.CategoryID AS CategotiaID, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS ingresos_productos FROM [Order Details] od
JOIN Products p ON od.ProductID = p.ProductID GROUP BY p.CategoryID;

-- 6. Número de productos vendidos por cliente
SELECT o.CustomerID AS ClienteID, COUNT(DISTINCT od.ProductID) AS numero_productos FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID GROUP BY o.CustomerID;

-- 7. Total de ventas por año
SELECT YEAR(o.OrderDate) AS ano, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS ventas_totales FROM [Order Details] od
JOIN Orders o ON od.OrderID = o.OrderID GROUP BY YEAR(o.OrderDate);

-- 8. Número de pedidos por país
SELECT c.Country AS pais, COUNT(o.OrderID) AS numero_pedidos FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID GROUP BY c.Country;

-- 9. Promedio de días entre orden y envío por proveedor
SELECT p.SupplierID AS suplidorID, AVG(DATEDIFF(day, o.OrderDate, o.ShippedDate)) AS prom_dias_envios FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.SupplierID;

-- 10. Total de ingresos por región
SELECT c.Region, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS ingresos_totales FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.Region;
