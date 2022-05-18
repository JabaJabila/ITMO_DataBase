-- 1
SELECT sod.SalesOrderID, p.Name, SUM(sod.OrderQty)
	OVER(PARTITION BY sod.SalesOrderId, p.Name) * UnitPrice AS 'Share from sales'

FROM [Production].[Product] AS p
JOIN [Sales].[SalesOrderDetail] AS sod
ON p.ProductID = sod.ProductID;

-- 2
SELECT p.Name, p.ListPrice, p.ListPrice - MIN(p.ListPrice) 
	OVER(PARTITION BY p.ProductSubcategoryID) AS 'Diff'

FROM [Production].[Product] AS p;

-- 3
SELECT soh.CustomerID, soh.SalesOrderID, ROW_NUMBER()
	OVER(PARTITION BY soh.CustomerID ORDER BY soh.OrderDate) AS 'SalesNum'

FROM [Sales].[SalesOrderHeader] AS soh;

-- 4
WITH SubcategoryAvgPrice (ProductID, AvgPrice) AS
(SELECT p.ProductID, AVG(p.ListPrice) OVER(PARTITION BY p.ProductSubcategoryID)
FROM [Production].[Product] AS p)

SELECT p.ProductID
FROM [Production].[Product] AS p
JOIN SubcategoryAvgPrice AS a
ON p.ProductID = a.ProductID
WHERE p.ListPrice > a.AvgPrice;

-- 5
WITH NumeredDate(ProductID, Qty, DateNum) AS
(SELECT sod.ProductID, sod.OrderQty, ROW_NUMBER() OVER(PARTITION BY sod.ProductID ORDER BY soh.OrderDate DESC)
FROM [Sales].[SalesOrderDetail] AS sod
JOIN [Sales].[SalesOrderHeader] AS soh
ON sod.SalesOrderID = soh.SalesOrderID)

SELECT p.ProductID, p.Name, AVG(nd.Qty)
FROM [Production].[Product] AS p
JOIN NumeredDate AS nd
ON p.ProductID = nd.ProductID
WHERE nd.DateNum <= 3
GROUP BY p.ProductID, p.Name;