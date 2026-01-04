CREATE FUNCTION fn_CustomerExists(
    @FirstName NVARCHAR(50),
    @LastName N234729_Chojna.Nazwisko,
    @EmailAddress NVARCHAR(50)
)
RETURNS BIT
AS
BEGIN
    DECLARE @Exists BIT = 0;
    
    IF EXISTS (
        SELECT 1
        FROM SalesLT.Customer
        WHERE FirstName = @FirstName
          AND LastName = @LastName
          AND EmailAddress = @EmailAddress
    )
    BEGIN
        SET @Exists = 1;
    END
    
    RETURN @Exists;
END;
GO

