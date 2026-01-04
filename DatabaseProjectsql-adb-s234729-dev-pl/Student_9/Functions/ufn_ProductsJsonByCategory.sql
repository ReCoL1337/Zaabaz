
CREATE FUNCTION Student_9.ufn_ProductsJsonByCategory
(
    @CategoryName NVARCHAR(50)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @JsonResult NVARCHAR(MAX);
    SET @JsonResult = (
        SELECT 
            p.ProductID,
            p.Name AS ProductName,
            p.ProductNumber,
            p.ListPrice,
            p.Color,
            pc.Name AS Category
        FROM 
            SalesLT.Product AS p
        INNER JOIN 
            SalesLT.ProductCategory AS pc ON p.ProductCategoryID = pc.ProductCategoryID
        WHERE 
            pc.Name = @CategoryName
        FOR JSON AUTO
    );

    RETURN @JsonResult;
END;
GO

