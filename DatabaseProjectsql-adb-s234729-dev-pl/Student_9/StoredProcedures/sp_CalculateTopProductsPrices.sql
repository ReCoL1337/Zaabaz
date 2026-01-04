
CREATE   PROCEDURE Student_9.sp_CalculateTopProductsPrices
AS
BEGIN
	SET XACT_ABORT ON;
    BEGIN TRY
        IF OBJECT_ID('tempdb..#TopProducts') IS NULL
            THROW 50001, 'Tabela tymczasowa #TopProducts nie istnieje', 1;
        
        DECLARE @Summary Student_9.ProductSummaryType;
        
        BEGIN TRAN;
        
        INSERT INTO @Summary
        SELECT 
            ProductID,
            Name,
            ListPrice,
            ListPrice - (ListPrice * 0.09) AS AdjustedPrice,
            ListPrice * 0.09 AS PriceDiscount
        FROM #TopProducts;
        
        SELECT * FROM @Summary
        ORDER BY OriginalPrice DESC;
        
        COMMIT TRAN;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;
        
        PRINT 'Błąd: ' + ERROR_MESSAGE();
        PRINT 'Numer błędu: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Linia: ' + CAST(ERROR_LINE() AS NVARCHAR(10));

    END CATCH;
END;
GO

