-- 1
SELECT p.Name, c.Name
FROM [Production].[Product] AS p
JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN [Production].[ProductCategory] AS c
ON s.ProductCategoryID = c.ProductCategoryID
WHERE p.Color = 'red' AND p.ListPrice > 100;

-- 2
SELECT s1.Name
FROM [Production].[ProductSubcategory] AS s1, [Production].[ProductSubcategory] AS s2
WHERE s1.ProductSubcategoryID != s2.ProductSubcategoryID AND s1.Name = s2.Name;

-- 3
SELECT c.Name, COUNT(*) AS 'ProductsInCategory'
FROM [Production].[Product] AS p
JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN [Production].[ProductCategory] AS c
ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name;

-- 4
SELECT s.Name, COUNT(*) AS 'ProductsInSubcategory'
FROM [Production].[Product] AS p
JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
GROUP BY s.Name;

-- 5
SELECT TOP(3) WITH TIES s.Name, COUNT(p.Name) AS 'ProductsInSubcategory'
FROM [Production].[Product] AS p
JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
GROUP BY s.Name
ORDER BY COUNT(*) DESC;

-- 6
SELECT s.Name, MAX(p.ListPrice) AS 'MaxRedPrice'
FROM [Production].[Product] AS p
JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE p.Color = 'red'
GROUP BY s.Name
ORDER BY COUNT(p.Name) DESC;

-- 7
SELECT v.Name, COUNT(*) AS 'ProductsAmount'
FROM [Purchasing].[Vendor] as v
JOIN [Purchasing].[ProductVendor] as pv
ON v.BusinessEntityID = pv.BusinessEntityID
JOIN [Production].[Product] as p
ON p.ProductID = pv.ProductID
GROUP BY v.Name;

-- 8
SELECT p.Name
FROM [Purchasing].[ProductVendor] as pv
JOIN [Production].[Product] as p
ON p.ProductID = pv.ProductID
GROUP BY p.Name
HAVING COUNT(*) > 1;

-- 9
SELECT TOP(1) p.Name, SUM(s.OrderQty) AS 'Top1Sold'
FROM [Sales].[SalesOrderDetail] as s
JOIN [Production].[Product] as p
ON s.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY SUM(s.OrderQty) DESC

-- 10
SELECT TOP(1) c.Name, SUM(sd.OrderQty) AS 'ProductsSold'
FROM [Sales].[SalesOrderDetail] AS sd
JOIN [Production].[Product] AS p
ON sd.ProductID = p.ProductID
JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN [Production].[ProductCategory] AS c
ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name
ORDER BY SUM(sd.OrderQty) DESC;

-- 11
SELECT c.Name, COUNT(DISTINCT s.ProductSubcategoryID) AS 'CountSubcategories', COUNT(p.ProductID) AS 'CountProducts'
FROM [Production].[Product] AS p
JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN [Production].[ProductCategory] AS c
ON s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name;

-- 12
SELECT v.CreditRating, COUNT(pv.ProductID) AS 'ProductsAmount'
FROM [Purchasing].[Vendor] as v
JOIN [Purchasing].[ProductVendor] as pv
ON v.BusinessEntityID = pv.BusinessEntityID
GROUP BY v.CreditRating;