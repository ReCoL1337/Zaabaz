
CREATE   PROCEDURE sp_AddNewProduct
    @ProductName NVARCHAR(128),
    @CategoryID INT,
    @UnitPrice MONEY,
    @StockQuantity INT
AS
BEGIN
	SET XACT_ABORT ON;
    BEGIN TRY
        DECLARE @ProductID INT;
        DECLARE @CategoryExists INT;
        DECLARE @ProductNumber NVARCHAR(25);
        
        IF @ProductName IS NULL OR LTRIM(@ProductName) = ''
            THROW 50001, 'Nazwa produktu nie może być pusta', 1;
        
        IF @CategoryID IS NULL OR @CategoryID <= 0
            THROW 50002, 'CategoryID musi być dodatnią liczbą', 1;
        
        IF @UnitPrice IS NULL OR @UnitPrice <= 0
            THROW 50003, 'Cena jednostkowa musi być większa od zera', 1;
        
        IF @StockQuantity IS NULL OR @StockQuantity < 0
            THROW 50004, 'Ilość dostępnych sztuk nie może być ujemna', 1;
        
        SELECT @CategoryExists = COUNT(*)
        FROM SalesLT.ProductCategory
        WHERE ProductCategoryID = @CategoryID;
        
        IF @CategoryExists = 0
            THROW 50005, 'Kategoria nie istnieje', 1;
        
        SET @ProductNumber = 'PROD-' + FORMAT(GETDATE(), 'yyyyMMdd') + '-' + 
                            CAST(ABS(CHECKSUM(NEWID())) % 10000 AS NVARCHAR(10));
        
        BEGIN TRAN;
                
        INSERT INTO SalesLT.Product (
            Name,
            ProductNumber,
            Color,
            StandardCost,
            ListPrice,
            ProductCategoryID,
            SellStartDate,
            rowguid,
            ModifiedDate
        )
        VALUES (
            @ProductName,
            @ProductNumber,
            NULL,
            @UnitPrice * 0.6,
            @UnitPrice,
            @CategoryID,
            GETDATE(),
            NEWID(),
            GETDATE()
        );
        
        SET @ProductID = SCOPE_IDENTITY();
                
        INSERT INTO SalesLT.ProductInventory (ProductID, StockQuantity, LastUpdated)
        VALUES (@ProductID, @StockQuantity, GETDATE());
                
        COMMIT TRAN;
                
        SELECT 
            p.ProductID,
            p.Name,
            p.ProductNumber,
            p.ListPrice,
            pi.StockQuantity,
            pc.Name AS CategoryName
        FROM SalesLT.Product p
        LEFT JOIN SalesLT.ProductInventory pi ON p.ProductID = pi.ProductID
        LEFT JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
        WHERE p.ProductID = @ProductID;
    
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRAN;
        END
        
        PRINT 'Błąd: ' + ERROR_MESSAGE();
        PRINT 'Numer błędu: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Linia: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    
    END CATCH;
END;
GO

