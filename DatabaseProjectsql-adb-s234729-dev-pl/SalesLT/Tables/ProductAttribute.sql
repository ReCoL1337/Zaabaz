CREATE TABLE [SalesLT].[ProductAttribute] (
    [ProductAttributeID] INT                                         IDENTITY (1, 1) NOT NULL,
    [ProductID]          INT                                         NOT NULL,
    [AttributeData]      XML(CONTENT [dbo].[ProductAttributeSchema]) NOT NULL,
    [ModifiedDate]       DATETIME                                    DEFAULT (getutcdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ProductAttributeID] ASC),
    FOREIGN KEY ([ProductID]) REFERENCES [SalesLT].[Product] ([ProductID])
);
GO

