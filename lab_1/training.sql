-- 1
SELECT p.Name, p.Color, p.Size
FROM [Production].[Product] AS p;

-- 2
SELECT p.Name, p.Color, p.Size
FROM [Production].[Product] AS p
WHERE p.ListPrice > 100;

-- 3
SELECT p.Name, p.Color, p.Size, p.ListPrice
FROM [Production].[Product] AS p
WHERE p.ListPrice > 100 AND p.Color = 'black';

-- 4
SELECT p.Name, p.Color, p.Size, p.ListPrice
FROM [Production].[Product] AS p
WHERE p.ListPrice > 100 AND p.Color = 'black'
ORDER BY p.ListPrice;

-- 5
SELECT TOP(3) WITH TIES p.Name, p.Size
FROM [Production].[Product] AS p
WHERE p.Color = 'black'
ORDER BY p.ListPrice DESC;
-- 6
SELECT p.Name, p.Color
FROM [Production].[Product] AS p
WHERE p.Color IS NOT NULL AND p.Size IS NOT NULL;

-- 7
SELECT DISTINCT p.Color
FROM [Production].[Product] AS p
WHERE p.ListPrice BETWEEN 10 AND 50;

-- 8
SELECT DISTINCT p.Color
FROM [Production].[Product] AS p
WHERE p.Name like 'l_n%';

-- 9
SELECT p.Name
FROM [Production].[Product] AS p
WHERE p.Name LIKE '[dm]__%';

-- 10
SELECT p.Name, p.SellStartDate
FROM [Production].[Product] AS p
WHERE YEAR(p.SellStartDate) <= 2012;

-- 11
SELECT p.Name
FROM [Production].[ProductSubcategory] AS p;

-- 12
SELECT p.Name
FROM [Production].[ProductCategory] AS p;

-- 13
SELECT CONCAT_WS(' ', p.FirstName, p.MiddleName, p.LastName) AS 'FullName'
FROM [Person].[Person] as p
WHERE p.Title = 'mr.';

-- 14
SELECT CONCAT_WS(' ', p.FirstName, p.MiddleName, p.LastName) AS 'FullName'
FROM [Person].[Person] AS p
WHERE p.Title IS NULL;