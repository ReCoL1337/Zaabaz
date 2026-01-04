
CREATE   PROCEDURE sp_InsertCustomer
    @FirstName NVARCHAR(50),
    @LastName N234729_Chojna.Nazwisko,
    @CompanyName NVARCHAR(128) = NULL,
    @EmailAddress NVARCHAR(50)
AS
BEGIN
    BEGIN TRY
        DECLARE @CustomerID INT;
        DECLARE @CustomerAlreadyExists BIT;
        
        IF @FirstName IS NULL OR LTRIM(@FirstName) = ''
            THROW 50001, 'FirstName nie może być puste', 1;
        
        IF @LastName IS NULL OR LTRIM(@LastName) = ''
            THROW 50002, 'LastName nie może być puste', 1;
        
        IF @EmailAddress IS NULL OR LTRIM(@EmailAddress) = ''
            THROW 50003, 'EmailAddress nie może być puste', 1;
        
        IF @EmailAddress NOT LIKE '%@%.%'
            THROW 50004, 'EmailAddress ma niepoprawny format', 1;
        
        SET @CustomerAlreadyExists = dbo.fn_CustomerExists(@FirstName, @LastName, @EmailAddress);
        
        IF @CustomerAlreadyExists = 1
            THROW 50005, 'Klient z takimi danymi już istnieje w bazie', 1;
        
        BEGIN TRAN;
        
        INSERT INTO SalesLT.Customer (
            NameStyle,
            FirstName,
            LastName,
            CompanyName,
            EmailAddress,
            PasswordHash,
            PasswordSalt,
            rowguid,
            ModifiedDate
        )
        VALUES (
            0,
            @FirstName,
            @LastName,
            @CompanyName,
            @EmailAddress,
            'hash',
            'salt',
            NEWID(),
            GETDATE()
        );
        
        SET @CustomerID = SCOPE_IDENTITY();
        
        COMMIT TRAN;
        
        SELECT 
            @CustomerID AS CustomerID,
            @FirstName AS FirstName,
            @LastName AS LastName,
            @CompanyName AS CompanyName,
            @EmailAddress AS EmailAddress;
			
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;
        
        PRINT 'Błąd: ' + ERROR_MESSAGE();
        PRINT 'Numer błędu: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Linia: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    
    END CATCH;
END;

EXEC sp_InsertCustomer 
    @FirstName = 'Adam',
    @LastName = 'Nowak',
    @EmailAddress = 'adam.nowak1@example.com';
GO

