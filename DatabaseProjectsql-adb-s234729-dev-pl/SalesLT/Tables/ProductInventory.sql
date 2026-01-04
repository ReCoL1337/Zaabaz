CREATE TABLE [SalesLT].[ProductInventory] (
    [InventoryID]   INT      IDENTITY (1, 1) NOT NULL,
    [ProductID]     INT      NOT NULL,
    [StockQuantity] INT      DEFAULT ((0)) NOT NULL,
    [LastUpdated]   DATETIME DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([InventoryID] ASC),
    FOREIGN KEY ([ProductID]) REFERENCES [SalesLT].[Product] ([ProductID])
);
GO

