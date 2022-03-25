-- 1
SELECT p.Color, COUNT(*) AS 'ProductAmount'
FROM [Production].[Product] AS p
WHERE p.ListPrice >= 30
GROUP BY p.Color;

-- 2
SELECT p.Color
FROM [Production].[Product] AS p
GROUP BY p.Color
HAVING MIN(p.ListPrice) > 100;

-- 3
SELECT p.ProductSubcategoryID, COUNT(*) AS 'ProductAmount'
FROM [Production].[Product] AS p
GROUP BY p.ProductSubcategoryID;

-- 4
SELECT s.ProductID, COUNT(*) AS 'SoldAmount'
FROM [Sales].[SalesOrderDetail] AS s
WHERE s.ProductID IS NOT NULL
GROUP BY s.ProductID;

-- 5
SELECT s.ProductID
FROM [Sales].[SalesOrderDetail] AS s
GROUP BY s.ProductID
HAVING COUNT(*) > 5;

-- 6
SELECT s.CustomerID
FROM [Sales].[SalesOrderHeader] AS s
GROUP BY s.CustomerID, s.OrderDate
HAVING COUNT(*) > 1;

-- 7
SELECT s.SalesOrderID
FROM [Sales].[SalesOrderDetail] AS s
WHERE s.ProductID IS NOT NULL
GROUP BY s.SalesOrderID
HAVING COUNT(*) > 3;

-- 8
SELECT s.ProductID
FROM [Sales].[SalesOrderDetail] AS s
WHERE s.ProductID IS NOT NULL
GROUP BY s.ProductID
HAVING COUNT(*) > 3;

-- 9
SELECT s.ProductID
FROM [Sales].[SalesOrderDetail] AS s
WHERE s.ProductID IS NOT NULL
GROUP BY s.ProductID
HAVING COUNT(*) IN (3, 5);

-- 10
SELECT p.ProductSubcategoryID
FROM [Production].[Product] AS p
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY p.ProductSubcategoryID
HAVING COUNT(*) > 10;

-- 11
SELECT s.ProductID
FROM [Sales].[SalesOrderDetail] AS s
WHERE s.ProductID IS NOT NULL
GROUP BY s.ProductID
HAVING MAX(s.OrderQty) = 1

-- 12
SELECT TOP(1) s.SalesOrderID, COUNT(*) as 'PositionAmount'
FROM [Sales].[SalesOrderDetail] AS s
GROUP BY s.SalesOrderID
ORDER BY COUNT(*) DESC;

-- 13
SELECT TOP(1) s.SalesOrderID, SUM(s.OrderQty * s.UnitPrice) as 'TotalPrice'
FROM [Sales].[SalesOrderDetail] AS s
GROUP BY s.SalesOrderID
ORDER BY SUM(s.OrderQty * s.UnitPrice) DESC;

-- 14
SELECT p.ProductSubcategoryID, COUNT(*) AS 'ProductAmount'
FROM [Production].[Product] AS p
WHERE p.ProductSubcategoryID IS NOT NULL AND p.Color IS NOT NULL
GROUP BY p.ProductSubcategoryID;

-- 15
SELECT p.Color, COUNT(*) AS 'ProductAmount'
FROM [Production].[Product] AS p
WHERE p.Color IS NOT NULL
GROUP BY p.Color
ORDER BY COUNT(*) DESC;

-- 16
SELECT s.ProductID
FROM [Sales].[SalesOrderDetail] AS s
WHERE s.ProductID IS NOT NULL
GROUP BY s.ProductID
HAVING COUNT(*) > 2 AND MIN(s.OrderQty) > 1