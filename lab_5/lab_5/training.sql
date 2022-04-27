-- 1.1
SELECT tmp.CustomerID, tmp.TotalBought * 1.0 / tmp.CountOrders AS 'AvgBought'
FROM (SELECT soh.CustomerId, COUNT(DISTINCT sod.SalesOrderID) AS 'CountOrders', COUNT(*) AS 'TotalBought'
FROM [Sales].[SalesOrderDetail] AS sod
JOIN [Sales].[SalesOrderHeader] AS soh
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY soh.CustomerID) AS tmp;

-- 1.2
WITH SalesBought (CustomerID, TotalOrders, TotalBought) AS
(SELECT soh.CustomerId, COUNT(DISTINCT sod.SalesOrderID), SUM(sod.OrderQty)
FROM [Sales].[SalesOrderDetail] AS sod
JOIN [Sales].[SalesOrderHeader] AS soh
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY soh.CustomerID)

SELECT CustomerID, TotalBought * 1.0 / TotalOrders AS 'AvgBought'
FROM SalesBought;

-- 2
WITH ProductionBought (CustomerID, ProductID, ProductBought) AS
(SELECT soh.CustomerID, sod.ProductID, SUM(sod.OrderQty)
FROM [Sales].[SalesOrderHeader] AS soh
JOIN [Sales].[SalesOrderDetail] AS sod
ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY soh.CustomerID, sod.ProductID),

CustomerBought (CustomerID, TotalBought) AS
(SELECT soh.CustomerID, SUM(sod.OrderQty)
FROM [Sales].[SalesOrderHeader] AS soh
JOIN [Sales].[SalesOrderDetail] AS sod
ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY soh.CustomerID)

SELECT pb.CustomerID, pb.ProductID, pb.ProductBought * 1.0 / cb.TotalBought AS 'Ratio'
FROM ProductionBought AS pb
JOIN CustomerBought AS cb
ON pb.CustomerID = cb.CustomerID
ORDER BY pb.CustomerID;

-- 3
WITH ProductInfo (ProductID,  ProductCount, CustomerCount) AS
(SELECT sod.ProductID, SUM(sod.OrderQty), COUNT(DISTINCT soh.CustomerID)
FROM Sales.SalesOrderDetail AS sod
JOIN Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY sod.ProductID)

SELECT p.Name, pin.ProductCount, pin.CustomerCount
FROM ProductInfo AS pin
JOIN [Production].[Product] AS p
ON p.ProductID = pin.ProductID;

-- 4
WITH CustomerPaid (CustomerID, TotalValue) AS
(SELECT soh.CustomerID, SUM(sod.LineTotal)
FROM [Sales].[SalesOrderHeader] AS soh
JOIN [Sales].[SalesOrderDetail] AS sod
ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY sod.SalesOrderID, CustomerID)

SELECT CustomerID, MIN(TotalValue) AS 'MinPaid', MAX(TotalValue) AS 'MaxPaid'
FROM CustomerPaid
GROUP BY CustomerID;

-- 5
WITH CustomerOrders (CustomerID, CountOrders) AS
(SELECT soh.CustomerID, COUNT(sod.ProductID)
FROM [Sales].[SalesOrderHeader] AS soh
JOIN [Sales].[SalesOrderDetail] AS sod
ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY sod.SalesOrderID, soh.CustomerID)

SELECT DISTINCT CustomerID
FROM CustomerOrders
WHERE CustomerID NOT IN (
	SELECT CustomerID
	FROM CustomerOrders
	GROUP BY CustomerID, CountOrders
	HAVING COUNT(*) > 1
);

-- 6
WITH CustomerBought(CustomerID, ProductID, CountBought) AS
(SELECT soh.CustomerID, sod.ProductID, COUNT(*)
FROM [Sales].[SalesOrderHeader] AS soh
JOIN [Sales].[SalesOrderDetail] AS sod
ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY soh.CustomerID, sod.ProductID)

SELECT DISTINCT CustomerID
FROM CustomerBought
WHERE CustomerID NOT IN (
	SELECT DISTINCT CustomerID
	FROM CustomerBought
	WHERE CountBought = 1
);