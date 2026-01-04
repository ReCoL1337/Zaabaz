CREATE   PROCEDURE sp_UpdateCustomer
    @CustomerID INT,
    @FirstName NVARCHAR(50) = NULL,
    @LastName N234729_Chojna.Nazwisko = NULL,
    @CompanyName NVARCHAR(128) = NULL,
    @EmailAddress NVARCHAR(50) = NULL
AS
BEGIN
	SET XACT_ABORT ON;
    BEGIN TRY
        DECLARE @CustomerExists INT;
        DECLARE @UpdatedRows INT = 0;
        
        IF @CustomerID IS NULL OR @CustomerID <= 0
            THROW 50001, 'CustomerID musi być dodatnią liczbą', 1;
        
        IF @FirstName IS NULL AND @LastName IS NULL AND @CompanyName IS NULL AND @EmailAddress IS NULL
            THROW 50002, 'Przynajmniej jeden parametr do aktualizacji musi być przekazany', 1;
        
        -- Sprawdzenie czy klient istnieje
        SELECT @CustomerExists = COUNT(*)
        FROM SalesLT.Customer
        WHERE CustomerID = @CustomerID;
        
        IF @CustomerExists = 0
            THROW 50003, 'Rekord klienta nie istnieje w bazie', 1;
        
        IF @EmailAddress IS NOT NULL AND @EmailAddress NOT LIKE '%@%.%'
            THROW 50004, 'EmailAddress ma niepoprawny format', 1;
        
        BEGIN TRAN;
        
        UPDATE SalesLT.Customer
        SET 
            FirstName = ISNULL(@FirstName, FirstName),
            LastName = ISNULL(@LastName, LastName),
            CompanyName = ISNULL(@CompanyName, CompanyName),
            EmailAddress = ISNULL(@EmailAddress, EmailAddress),
            ModifiedDate = GETDATE()
        WHERE CustomerID = @CustomerID;
        
        SET @UpdatedRows = @@ROWCOUNT;
        
        COMMIT TRAN;
        
        SELECT 
            CustomerID,
            FirstName,
            LastName,
            CompanyName,
            EmailAddress,
            ModifiedDate
        FROM SalesLT.Customer
        WHERE CustomerID = @CustomerID;
    
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

