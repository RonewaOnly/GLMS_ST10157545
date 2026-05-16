IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Clients] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(150) NOT NULL,
    [ContractDetails] nvarchar(500) NOT NULL,
    [Region] nvarchar(100) NOT NULL,
    [CreatedOn] datetime2 NOT NULL,
    CONSTRAINT [PK_Clients] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Contracts] (
    [Id] int NOT NULL IDENTITY,
    [ClientId] int NOT NULL,
    [StartDate] datetime2 NOT NULL,
    [EndDate] datetime2 NOT NULL,
    [Status] nvarchar(max) NOT NULL,
    [ServiceLevel] nvarchar(200) NOT NULL,
    [SignedAgreementPath] nvarchar(500) NULL,
    [SignedAgreementFileName] nvarchar(260) NULL,
    [CreatedOn] datetime2 NOT NULL,
    CONSTRAINT [PK_Contracts] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Contracts_Clients_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [Clients] ([Id]) ON DELETE NO ACTION
);
GO

CREATE TABLE [ServiceRequests] (
    [Id] int NOT NULL IDENTITY,
    [ContractId] int NOT NULL,
    [Description] nvarchar(1000) NOT NULL,
    [CostUsd] decimal(18,2) NOT NULL,
    [CostZar] decimal(18,2) NOT NULL,
    [ExchangeRateUsed] decimal(18,4) NOT NULL,
    [Status] nvarchar(max) NOT NULL,
    [CreatedOn] datetime2 NOT NULL,
    CONSTRAINT [PK_ServiceRequests] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ServiceRequests_Contracts_ContractId] FOREIGN KEY ([ContractId]) REFERENCES [Contracts] ([Id]) ON DELETE NO ACTION
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ContractDetails', N'CreatedOn', N'Name', N'Region') AND [object_id] = OBJECT_ID(N'[Clients]'))
    SET IDENTITY_INSERT [Clients] ON;
INSERT INTO [Clients] ([Id], [ContractDetails], [CreatedOn], [Name], [Region])
VALUES (1, N'Air & sea freight', '2024-01-01T00:00:00.0000000', N'Acme Freight Ltd', N'EMEA'),
(2, N'Road haulage', '2024-01-01T00:00:00.0000000', N'FastTrack Logistics', N'SADC'),
(3, N'Ocean freight', '2024-01-01T00:00:00.0000000', N'Global Ship Co', N'APAC');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ContractDetails', N'CreatedOn', N'Name', N'Region') AND [object_id] = OBJECT_ID(N'[Clients]'))
    SET IDENTITY_INSERT [Clients] OFF;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ClientId', N'CreatedOn', N'EndDate', N'ServiceLevel', N'SignedAgreementFileName', N'SignedAgreementPath', N'StartDate', N'Status') AND [object_id] = OBJECT_ID(N'[Contracts]'))
    SET IDENTITY_INSERT [Contracts] ON;
INSERT INTO [Contracts] ([Id], [ClientId], [CreatedOn], [EndDate], [ServiceLevel], [SignedAgreementFileName], [SignedAgreementPath], [StartDate], [Status])
VALUES (1, 1, '2024-01-01T00:00:00.0000000', '2025-01-01T00:00:00.0000000', N'Priority 1 — 4-hour response', NULL, NULL, '2024-01-01T00:00:00.0000000', N'Active'),
(2, 2, '2023-06-01T00:00:00.0000000', '2024-06-01T00:00:00.0000000', N'Standard — 24-hour response', NULL, NULL, '2023-06-01T00:00:00.0000000', N'Expired');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ClientId', N'CreatedOn', N'EndDate', N'ServiceLevel', N'SignedAgreementFileName', N'SignedAgreementPath', N'StartDate', N'Status') AND [object_id] = OBJECT_ID(N'[Contracts]'))
    SET IDENTITY_INSERT [Contracts] OFF;
GO

CREATE INDEX [IX_Contracts_ClientId] ON [Contracts] ([ClientId]);
GO

CREATE INDEX [IX_ServiceRequests_ContractId] ON [ServiceRequests] ([ContractId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260503151425_InitialCreationofDBEntity', N'8.0.6');
GO

COMMIT;
GO

