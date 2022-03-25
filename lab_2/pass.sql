SELECT p.ProductSubcategoryID, COUNT(*) AS "Amount"
FROM [Production].[Product] AS p
WHERE p.Color = 'Red'
GROUP BY p.ProductSubcategoryID
HAVING COUNT(*) >= 2
