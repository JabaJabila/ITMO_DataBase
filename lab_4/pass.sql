SELECT soh.CustomerID, soh.SalesOrderID
FROM [Sales].[SalesOrderHeader] AS soh
WHERE soh.SalesOrderID = (
	SELECT TOP 1 soh2.SalesOrderID
	FROM [Sales].[SalesOrderHeader] AS soh2
	JOIN [Sales].[SalesOrderDetail] AS sod2
	ON soh2.SalesOrderID = sod2.SalesOrderID
	WHERE soh2.CustomerID = soh.CustomerID
	GROUP BY soh2.SalesOrderID
	ORDER BY COUNT(sod2.ProductID) DESC
);