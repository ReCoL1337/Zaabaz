-- =============================================
-- Zadanie 2
-- =============================================

CREATE   PROCEDURE sp_GetCustomer
    @FirstName NVARCHAR(50) = NULL,
    @LastName N234729_Chojna.Nazwisko = NULL,
    @CustomerID INT = NULL,
    @EmailAddress NVARCHAR(50) = NULL
AS
BEGIN
	SET XACT_ABORT ON;
    BEGIN TRY
        IF @FirstName IS NULL AND @LastName IS NULL AND @CustomerID IS NULL AND @EmailAddress IS NULL
            THROW 50001, 'Przynajmniej jeden parametr musi być przekazany', 1;
        
        SELECT 
            CustomerID,
            FirstName,
            LastName,
            CompanyName,
            EmailAddress,
            Phone,
            ModifiedDate
        FROM SalesLT.Customer
        WHERE 
            (@FirstName IS NULL OR FirstName LIKE '%' + @FirstName + '%')
            AND (@LastName IS NULL OR LastName LIKE '%' + @LastName + '%')
            AND (@CustomerID IS NULL OR CustomerID = @CustomerID)
            AND (@EmailAddress IS NULL OR EmailAddress LIKE '%' + @EmailAddress + '%')
        ORDER BY CustomerID;
    
    END TRY
    BEGIN CATCH
        PRINT 'Błąd: ' + ERROR_MESSAGE();
        PRINT 'Numer błędu: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Linia: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    
    END CATCH;
END;
GO

