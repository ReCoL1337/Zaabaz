
CREATE   FUNCTION Student_9.ufn_IsPriceHigherThanCurrent(@ProductJSON nvarchar(max))
RETURNS BIT
AS
BEGIN
    DECLARE @ProductID INT;
    DECLARE @JSONPrice DECIMAL(10,2);
    DECLARE @CurrentPrice DECIMAL(10,2);
    DECLARE @Result BIT;

    SET @ProductID = JSON_VALUE(@ProductJSON, '$.ProductID');
    SET @JSONPrice = JSON_VALUE(@ProductJSON, '$.ListPrice');

    SELECT @CurrentPrice = ListPrice
    FROM [SalesLT].[Product]
    WHERE ProductID = @ProductID;

    IF @JSONPrice > @CurrentPrice
        SET @Result = 1; 
    ELSE
        SET @Result = 0;

    RETURN @Result;
END;
GO

