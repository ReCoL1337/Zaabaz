
CREATE   FUNCTION Student_9.ufn_CalcAdjustedPrices(
    @ProductID INT,
    @Name NVARCHAR(MAX),
    @ListPrice DECIMAL(10,2)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        @ProductID AS ProductID,
        @Name AS ProductName,
        @ListPrice AS OriginalPrice,
        @ListPrice - (@ListPrice * 0.09) AS AdjustedPrice,
        @ListPrice * 0.09 AS PriceDiscount
);
GO

