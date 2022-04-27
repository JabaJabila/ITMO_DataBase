WITH ProductsInSubcategory (SubcategoryID, SubcategoryName, CountProducts) AS
(SELECT ps.ProductSubcategoryID, ps.Name, COUNT(p.ProductID)
FROM [Production].[ProductSubcategory] AS ps
JOIN [Production].[Product] AS p
ON p.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY ps.ProductSubcategoryID, ps.Name)

SELECT p.Name, pis.SubcategoryName, pis.CountProducts
FROM ProductsInSubcategory AS pis
JOIN [Production].[Product] AS p
ON p.ProductSubcategoryID = pis.SubcategoryID