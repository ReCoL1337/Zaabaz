
CREATE   VIEW Student_9.TheBestCustomers AS
SELECT TOP 10
    c.CustomerID,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.EmailAddress,
    COUNT(DISTINCT soh.SalesOrderID) AS TotalOrders,
    SUM(sod.LineTotal) AS TotalSpent,
    MAX(soh.OrderDate) AS LastOrderDate
FROM [SalesLT].[Customer] c
LEFT JOIN [SalesLT].[SalesOrderHeader] soh ON c.CustomerID = soh.CustomerID
LEFT JOIN [SalesLT].[SalesOrderDetail] sod ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.EmailAddress
ORDER BY SUM(sod.LineTotal) DESC;
GO

