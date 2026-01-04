CREATE   FUNCTION Student_9.ufn_GetMoreExpensiveProducts(@PriceThreshold DECIMAL(10,2))
RETURNS TABLE
AS
RETURN
	SELECT
        p.ProductID,
        p.Name,
        p.ProductNumber,
        p.ListPrice
    FROM 
        [SalesLT].[Product] AS p
    WHERE
    Student_9.ufn_IsPriceHigherThanCurrent(
        N'{"ProductID": ' + CAST(p.ProductID AS NVARCHAR(10)) + ', "ListPrice": ' + CAST(@PriceThreshold AS NVARCHAR(20)) + '}'
    ) = 0;
GO

