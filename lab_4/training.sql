-- 1
SELECT p.Name
FROM [Production].[Product] AS p
WHERE p.ProductID =
	(SELECT TOP(1) s.ProductID
	FROM [Sales].[SalesOrderDetail] AS s
	GROUP BY s.ProductID
	ORDER BY SUM(s.OrderQty) DESC);

-- 2
SELECT soh.CustomerID
FROM [Sales].[SalesOrderHeader] AS soh
WHERE soh.SalesOrderID =
	(SELECT TOP(1) sod.SalesOrderID
	FROM [Sales].[SalesOrderDetail] AS sod
	GROUP BY sod.SalesOrderID
	ORDER BY SUM(sod.OrderQty * sod.UnitPrice) DESC);

-- 3
SELECT p.ProductID, p.Name
FROM [Production].[Product] AS p
WHERE p.ProductID IN
	(SELECT sod.ProductID
	FROM [Sales].[SalesOrderDetail] AS sod
	JOIN [Sales].[SalesOrderHeader] AS soh
	ON sod.SalesOrderID = soh.SalesOrderID
	GROUP BY sod.ProductID
	HAVING COUNT(DISTINCT soh.CustomerID) = 1);

-- 4
SELECT p1.Name
FROM [Production].[Product] AS p1
WHERE p1.ListPrice >
	(SELECT AVG(p2.ListPrice)
	FROM [Production].[Product] AS p2
	WHERE p2.ProductSubcategoryID = p1.ProductSubcategoryID);

-- 5
SELECT p.ProductID, p.Name
FROM [Production].[Product] AS p
WHERE p.ProductID IN
	(SELECT sod.ProductID
	FROM [Sales].[SalesOrderDetail] AS sod
	JOIN [Sales].[SalesOrderHeader] AS soh
	ON sod.SalesOrderID = soh.SalesOrderID
	WHERE soh.CustomerID IN
		(SELECT soh.CustomerID
		FROM [Sales].[SalesOrderHeader] AS soh
		JOIN [Sales].[SalesOrderDetail] AS sod
		ON soh.SalesOrderID = sod.SalesOrderID
		JOIN [Production].[Product] AS p
		ON sod.ProductID = p.ProductID
		GROUP BY soh.CustomerID
		HAVING COUNT(DISTINCT p.Color) = 1)
	GROUP BY sod.ProductID
	HAVING COUNT(DISTINCT soh.CustomerID) = 1);

-- 6
SELECT DISTINCT p.ProductID, p.Name
FROM [Production].[Product] AS p
WHERE p.ProductID IN
	(SELECT sod.ProductID
	FROM [Sales].[SalesOrderDetail] AS sod
	JOIN [Sales].[SalesOrderHeader] AS soh
	ON sod.SalesOrderID = soh.SalesOrderID
	WHERE soh.CustomerID IN
		(SELECT soh2.CustomerID
		FROM [Sales].[SalesOrderDetail] AS sod2
		JOIN [Sales].[SalesOrderHeader] AS soh2
		ON sod2.SalesOrderID = soh2.SalesOrderID
		GROUP BY soh2.CustomerID
		HAVING COUNT(*) =
			(SELECT COUNT(*)
			FROM [Sales].[SalesOrderDetail] AS sod3
			JOIN [Sales].[SalesOrderHeader] AS soh3
			ON sod3.SalesOrderID = soh3.SalesOrderID
			WHERE sod3.ProductID = sod.ProductID AND soh3.CustomerID = soh2.CustomerID)));

-- 7
SELECT DISTINCT soh.CustomerID
FROM [Sales].[SalesOrderHeader] AS soh
JOIN [Sales].[SalesOrderDetail] AS sod
ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY soh.CustomerID
HAVING COUNT(sod.ProductID) =
	(SELECT TOP 1 COUNT(*)
	FROM [Sales].[SalesOrderDetail] AS sod2
	JOIN [Sales].[SalesOrderHeader] AS soh2
	ON sod2.SalesOrderID = soh2.SalesOrderID
	WHERE soh2.CustomerID = soh.CustomerID
	GROUP BY sod2.ProductID);

-- 8
SELECT DISTINCT p.ProductID, p.Name
FROM [Production].[Product] AS p
WHERE p.ProductID IN
	(SELECT sod.ProductID
	FROM [Sales].[SalesOrderDetail] AS sod
	JOIN [Sales].[SalesOrderHeader] AS soh
	ON sod.SalesOrderID = soh.SalesOrderID
	WHERE soh.CustomerID IN
		(SELECT soh2.CustomerID
		FROM [Sales].[SalesOrderHeader] AS soh2
		JOIN [Sales].[SalesOrderDetail] AS sod2
		ON sod2.SalesOrderID = soh2.SalesOrderID
		WHERE sod2.ProductID = sod.ProductID
		GROUP BY soh2.CustomerID
		HAVING COUNT(*) <= 3));
