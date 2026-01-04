CREATE TYPE [Student_9].[ProductSummaryType] AS TABLE (
    [ProductID]     INT             NULL,
    [ProductName]   NVARCHAR (MAX)  NULL,
    [OriginalPrice] DECIMAL (10, 2) NULL,
    [AdjustedPrice] DECIMAL (10, 2) NULL,
    [PriceDiscount] DECIMAL (10, 2) NULL);
GO

