WITH CategoryInfo(CategoryId, CategoryName, CountItems) AS
(SELECT DISTINCT c.ProductCategoryID, c.Name, COUNT(*) OVER (PARTITION BY c.ProductCategoryID, c.Name)
FROM [Production].[ProductCategory] AS c
JOIN [Production].[ProductSubcategory] AS s
ON c.ProductCategoryID = s.ProductCategoryID
JOIN [Production].[Product] AS p
ON s.ProductSubcategoryID = p.ProductSubcategoryID)

SELECT p.Name, ci.CategoryName, ci.CountItems
FROM [Production].[Product] AS p
JOIN [Production].[ProductSubcategory] AS s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
JOIN CategoryInfo AS ci
ON ci.CategoryId = s.ProductCategoryID