SELECT c.Name, SUM(sod.OrderQty) AS 'AmountSold'
FROM [Sales].[SalesOrderDetail] AS sod
JOIN [Production].[Product] AS p
ON sod.ProductID = p.ProductID
JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN [Production].[ProductCategory] AS c
ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name
ORDER BY sum(sod.OrderQty);