CREATE TABLE [234729].[Customer] (
    [CustomerID]   INT                                                IDENTITY (1, 1) NOT NULL,
    [NameStyle]    [dbo].[NameStyle]                                  NOT NULL,
    [Title]        NVARCHAR (8)                                       NULL,
    [FirstName]    [dbo].[Name]                                       NOT NULL,
    [MiddleName]   [dbo].[Name]                                       NULL,
    [LastName]     [N234729_Chojna].[Nazwisko]                        NOT NULL,
    [Suffix]       NVARCHAR (10)                                      NULL,
    [CompanyName]  NVARCHAR (128)                                     NULL,
    [SalesPerson]  NVARCHAR (256)                                     NULL,
    [EmailAddress] NVARCHAR (50)                                      NULL,
    [Phone]        [dbo].[Phone]                                      NULL,
    [PasswordHash] VARCHAR (128)                                      NOT NULL,
    [PasswordSalt] VARCHAR (10)                                       NOT NULL,
    [rowguid]      UNIQUEIDENTIFIER                                   NOT NULL,
    [ModifiedDate] DATETIME                                           NOT NULL,
    [SysStartTime] DATETIME2 (7) GENERATED ALWAYS AS ROW START HIDDEN DEFAULT (getutcdate()) NOT NULL,
    [SysEndTime]   DATETIME2 (7) GENERATED ALWAYS AS ROW END HIDDEN   DEFAULT (CONVERT([datetime2],'9999-12-31 23:59:59.9999999')) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustomerID] ASC),
    PERIOD FOR SYSTEM_TIME ([SysStartTime], [SysEndTime])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[234729].[CustomerHistory], DATA_CONSISTENCY_CHECK=ON));

GO


