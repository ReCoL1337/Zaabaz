CREATE TYPE [dbo].[OrderHistoryType] AS TABLE (
    [Product]    NVARCHAR (128) NULL,
    [OrderDate]  DATETIME       NULL,
    [Quantity]   INT            NULL,
    [TotalPrice] MONEY          NULL);
GO

