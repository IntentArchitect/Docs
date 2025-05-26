---
uid: tools.module-server
---
# Module Server

Intent Architect offers a self-hostable "Module Server" in the form of a Docker image. The [](xref:tools.module-server-client-cli) can be used to upload Modules and Application templates to it and then Intent Architect clients can be configured to use the server as a repository for your organization's custom Modules and Application Templates.

## Dependencies

The Module Server uses Microsoft SQL Server for persistence, all editions of SQL Server 2019 and later should be compatible, including the free [SQL Server Express](https://www.microsoft.com/download/details.aspx?id=101064) edition.

Unless opted-out of, the module server will automatically run any necessary migrations against the database to ensure the schema is up to date. If you alternatively want to run the migration script manually, it is provided [at the bottom of this article](#sql-server-schema-migration-script).

The Module Server is otherwise self-contained.

## Docker image details

|Name      |Value|
|----------|-|
|Registry  |`crintentarchitectprodzanorth.azurecr.io`|
|Repository|`intent-architect/module-server`|
|User      |`anonymous`|
|Password  |`1Ww/o4nfLPIKdComVBukyVGlmtWVgYm7MgfVPwwnfO+ACRAX3G9B`|

## Configurable environment variables

### `ConnectionStrings__DefaultConnection`

**Description:** The Microsoft SQL Server connection string.

**Default value:** `Server=host.docker.internal;Initial Catalog=ModuleServer;MultipleActiveResultSets=True;Encrypt=False;User ID=module-server;Password=password;`

### `ApiKeys`

**Description:** A semi-colon (`;`) separated list of strings of which any can be used as the value for the `api-key` argument for the [](xref:tools.module-server-client-cli).

**Default value:** (blank)

### `APPLICATIONINSIGHTS_CONNECTION_STRING`

**Description:** Optional. An [Azure Application Insights](https://learn.microsoft.com/azure/azure-monitor/app/app-insights-overview?tabs=net) connection string. Leave unset or use the default value to have Azure Application Insights be disabled for the Module Server.

**Default value:** `InstrumentationKey=00000000-0000-0000-0000-000000000000;`

### `EntityFramework__RunMigrations`

**Description:** A boolean value indicating whether or not database schema migrations are automatically run on startup.

**Default value:** `true`

## Running locally

Ensure [Docker is installed](https://www.docker.com/products/docker-desktop/).

Authenticate against the Intent Architect container registry:

```bash
docker login -u anonymous -p 1Ww/o4nfLPIKdComVBukyVGlmtWVgYm7MgfVPwwnfO+ACRAX3G9B crintentarchitectprodzanorth.azurecr.io
```

In the following command replace `<sql-server-connection-string>` with a valid SQL Server connection string (e.g. `Server=host.docker.internal;Initial Catalog=ModuleServer;MultipleActiveResultSets=True;Encrypt=False;User ID=module-server;Password=password;` will connect to a SQL Server on the Docker host machine, to the `ModuleServer` database using the SQL username of `module-server` and password `password`) and then run it.

```bash
docker run --publish 33800:80 --name module-server -e "ConnectionStrings__DefaultConnection=<sql-server-connection-string>" crintentarchitectprodzanorth.azurecr.io/intent-architect/module-server:latest
```

You can confirm the module server is running by visiting [http://localhost:33800/swagger/](http://localhost:33800/swagger/) in your web browser.

## Deploying to Azure

Here is a simple guide on creating an Azure App Service which runs the Module Server Docker image.

### Create the Azure resources

1. Type **app services** in the search. Under **Services**, select **App Services**.
  ![search box](images/search-box.png)
1. In the **App Services** page, select **+ Create** and then select the **+ Web App** option.
  ![create web app](images/app-services-create-web-app.png)
1. In the **Basics** tab, under **Project details**, ensure the correct subscription is selected and then select to Create new resource group. Type `intentArchitectModuleServerResourceGroup` for the name.
  ![project details](images/project-details.png)
1. Under **Instance details**, type a globally unique name for your web app and select **Docker Container**. Select *Linux* for the **Operating System**. Select a **Region** you want to serve your app from.
  ![pricing plans](images/instance-details.png)
1. Under **App Service Plan**, select **Create new** App Service Plan. Type `moduleServerAppServicePlan` for the name and choose a *Pricing plan*.
  ![pricing plans](images/pricing-plans.png)
1. Select the **Next: Docker** > button at the bottom of the page.
1. In the **Docker** tab, select *Single Container* under **Options** and *Private Registry* for the **Image Source**. Under **Private registry options**, set the following values:
   - **Server URL:** `https://crintentarchitectprodzanorth.azurecr.io`
   - **Username:** `anonymous`
   - **Password:** `1Ww/o4nfLPIKdComVBukyVGlmtWVgYm7MgfVPwwnfO+ACRAX3G9B`
   - **Image and tag:** `intent-architect/module-server:latest`
  ![Docker details](images/docker-details.png)
1. Select the **Review + create** button at the bottom of the page.
1. After validation runs, select the **Create** button at the bottom of the page.
1. After deployment is complete, select **Go to resource**.

### Set environment variables for the Docker image

1. In the left pane, click on *Configuration*.
  ![web app configuration pane](images/web-app-configuration.png)
1. For each of the following press the **+ New application setting**, capture the **Name**, **Value** fields, leave the *Deployment slow setting* checkbox unchecked and press the **OK** button:
   - [Microsoft SQL Server connection string](#connectionstrings__defaultconnection):
     - **Name:** `ConnectionStrings__DefaultConnection`
     - **Value:** (A valid SQL Server connection string)
   - [API keys](#apikeys):
     - **Name:** `ApiKeys`
     - **Value:** (Semi-colon separated list of randomly generated API keys)
   - [Azure Application Insights connection string](#applicationinsights_connection_string) (optional):
     - **Name:** `APPLICATIONINSIGHTS_CONNECTION_STRING`
     - **Value:** (A valid Azure Application Insights connection string)
  ![web app configuration pane (save)](images/web-app-configuration-save.png)
1. Press the **💾 Save** button at the top of the pane.

## Configuring Intent Architect clients to be able to use the Module Server

Intent Architect clients can use other Module Servers by entering their address into the **Address** field when [adding a repository](https://docs.intentarchitect.com/articles/application-development/applications-and-solutions/how-to-manage-repositories/how-to-manage-repositories.html).

The value to enter **Address** is "base" URL for the website. For example if you had set up a [local instance](#running-locally) the address would be `http://localhost:33800/`, if you had [deployed it to Azure](#deploying-to-azure) then the address would be something like `https://myorganizationnamemoduleserver.azurewebsites.net/`.

## SQL Server schema migration script

The following SQL Server script can be used to idempotently make sure that the database schema is at the latest version:

> [!NOTE]
>
> Check your connection string as to which Database this script should be executed against. Default: ModuleServer.
> It will create a \[ModuleServer\] schema to ensure clean separation.

```sql
IF OBJECT_ID(N'[ModuleServer].[__EFMigrationsHistory]') IS NULL
BEGIN
    IF SCHEMA_ID(N'ModuleServer') IS NULL EXEC(N'CREATE SCHEMA [ModuleServer];');
    CREATE TABLE [ModuleServer].[__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE TABLE [ApplicationTemplates] (
        [Id] uniqueidentifier NOT NULL,
        [Identifier] nvarchar(150) NOT NULL,
        [MajorVersion] int NOT NULL,
        [MinorVersion] int NOT NULL,
        [PatchVersion] int NOT NULL,
        [DisplayName] nvarchar(150) NOT NULL,
        [ShortDescription] nvarchar(1000) NULL,
        [FullDescription] nvarchar(max) NULL,
        [Priority] int NOT NULL,
        [Authors] nvarchar(150) NULL,
        [IconType] int NULL,
        [IconSource] nvarchar(max) NULL,
        [Tags] nvarchar(1000) NULL,
        [ProjectUrl] nvarchar(512) NULL,
        [LastUpdated] datetime2 NOT NULL,
        [IsListed] bit NOT NULL,
        [CreatedBy] nvarchar(50) NULL,
        [CreateDateTime] datetime2 NULL,
        [UpdatedBy] nvarchar(50) NULL,
        [UpdateDateTime] datetime2 NULL,
        [SupportedClientVersions] nvarchar(64) NOT NULL,
        [MinClientMajor] int NOT NULL,
        [MinClientMinor] int NOT NULL,
        [MinClientPatch] int NOT NULL,
        [MinClientInclusive] bit NOT NULL,
        [MaxClientMajor] int NOT NULL,
        [MaxClientMinor] int NOT NULL,
        [MaxClientPatch] int NOT NULL,
        [MaxClientInclusive] bit NOT NULL,
        [Defaults_Name] nvarchar(128) NOT NULL,
        [Defaults_RelativeOutputLocation] nvarchar(128) NOT NULL,
        [Defaults_PlaceInSameDirectory] bit NOT NULL,
        [Defaults_SeparateIntentFiles] bit NOT NULL,
        [Defaults_SetGitIgnoreEntries] bit NOT NULL,
        CONSTRAINT [PK_ApplicationTemplates] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE TABLE [Modules] (
        [Id] uniqueidentifier NOT NULL,
        [Identifier] nvarchar(150) NOT NULL,
        [Summary] nvarchar(1000) NOT NULL,
        [Authors] nvarchar(150) NOT NULL,
        [LatestStableVersion] nvarchar(20) NOT NULL,
        [SupportedClientVersions] nvarchar(64) NULL,
        [IconUrl] nvarchar(max) NULL,
        [Tags] nvarchar(1000) NULL,
        [CreatedBy] nvarchar(50) NULL,
        [CreateDateTime] datetime2 NULL,
        [UpdatedBy] nvarchar(50) NULL,
        [UpdateDateTime] datetime2 NULL,
        CONSTRAINT [PK_Modules] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE TABLE [ApplicationTemplateFile] (
        [Id] uniqueidentifier NOT NULL,
        [Data] varbinary(max) NOT NULL,
        CONSTRAINT [PK_ApplicationTemplateFile] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ApplicationTemplateFile_ApplicationTemplates_Id] FOREIGN KEY ([Id]) REFERENCES [ApplicationTemplates] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE TABLE [ModuleVersion] (
        [Id] uniqueidentifier NOT NULL,
        [Description] nvarchar(max) NULL,
        [Version] nvarchar(20) NOT NULL,
        [PublishedDate] datetime2 NOT NULL,
        [Authors] nvarchar(150) NOT NULL,
        [ProjectUrl] nvarchar(1000) NULL,
        [Tags] nvarchar(1000) NULL,
        [SupportedClientVersions] nvarchar(64) NULL,
        [ReleaseNotes] nvarchar(max) NULL,
        [IsListed] bit NOT NULL,
        [ModuleId] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_ModuleVersion] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ModuleVersion_Modules_ModuleId] FOREIGN KEY ([ModuleId]) REFERENCES [Modules] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE TABLE [ModuleDependency] (
        [Id] uniqueidentifier NOT NULL,
        [ModuleVersionId] uniqueidentifier NOT NULL,
        [ModuleId] nvarchar(150) NOT NULL,
        [VersionSpec] nvarchar(40) NOT NULL,
        CONSTRAINT [PK_ModuleDependency] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ModuleDependency_ModuleVersion_ModuleVersionId] FOREIGN KEY ([ModuleVersionId]) REFERENCES [ModuleVersion] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE TABLE [ModuleFile] (
        [Id] uniqueidentifier NOT NULL,
        [Data] varbinary(max) NOT NULL,
        CONSTRAINT [PK_ModuleFile] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ModuleFile_ModuleVersion_Id] FOREIGN KEY ([Id]) REFERENCES [ModuleVersion] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE TABLE [ModuleSpecFile] (
        [Id] uniqueidentifier NOT NULL,
        [Data] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ModuleSpecFile] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ModuleSpecFile_ModuleVersion_Id] FOREIGN KEY ([Id]) REFERENCES [ModuleVersion] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE UNIQUE INDEX [IX_ApplicationTemplates_Identifier_MajorVersion_MinorVersion_PatchVersion] ON [ApplicationTemplates] ([Identifier], [MajorVersion], [MinorVersion], [PatchVersion]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE INDEX [IX_ApplicationTemplates_MaxClientMajor_MaxClientMinor_MaxClientPatch_MaxClientInclusive] ON [ApplicationTemplates] ([MaxClientMajor], [MaxClientMinor], [MaxClientPatch], [MaxClientInclusive]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE INDEX [IX_ApplicationTemplates_MinClientMajor_MinClientMinor_MinClientPatch_MinClientInclusive] ON [ApplicationTemplates] ([MinClientMajor], [MinClientMinor], [MinClientPatch], [MinClientInclusive]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE INDEX [IX_ModuleDependency_ModuleVersionId] ON [ModuleDependency] ([ModuleVersionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE UNIQUE INDEX [IX_Modules_Identifier] ON [Modules] ([Identifier]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    CREATE INDEX [IX_ModuleVersion_ModuleId] ON [ModuleVersion] ([ModuleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230814124652_Initial'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230814124652_Initial', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230817095136_AddModuleVersionIndex'
)
BEGIN
    CREATE INDEX [IX_ModuleVersions_IsListed_SupportedClientVersions] ON [ModuleVersion] ([IsListed], [SupportedClientVersions]) INCLUDE ([ModuleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230817095136_AddModuleVersionIndex'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230817095136_AddModuleVersionIndex', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230817110919_BreakOutIcons'
)
BEGIN
    ALTER TABLE [Modules] ADD [IconExists] bit NULL;
    DECLARE @defaultSchema AS sysname;
    SET @defaultSchema = SCHEMA_NAME();
    DECLARE @description AS sql_variant;
    SET @description = N'Although this can be inferred by whether or not the association to ModuleIcon is null, by storing it here we don''t have to worry about lazy loading the entity (which is reduces performance) to check if its null or do some other EF query.';
    EXEC sp_addextendedproperty 'MS_Description', @description, 'SCHEMA', @defaultSchema, 'TABLE', N'Modules', 'COLUMN', N'IconExists';
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230817110919_BreakOutIcons'
)
BEGIN
    CREATE TABLE [ModuleIcons] (
        [Id] uniqueidentifier NOT NULL,
        [Url] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ModuleIcons] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ModuleIcons_Modules_Id] FOREIGN KEY ([Id]) REFERENCES [Modules] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230817110919_BreakOutIcons'
)
BEGIN
    EXECUTE('
                    INSERT INTO [dbo].[ModuleIcons] ([Id], [Url])
                    SELECT [Id], [IconUrl] FROM [Modules]
                    WHERE [IconUrl] IS NOT NULL AND [IconUrl] LIKE ''data:%''

                    UPDATE [dbo].[Modules]
                    SET
                        [IconUrl] = CASE WHEN [IconUrl] IS NOT NULL AND [IconUrl] LIKE ''data:%'' THEN NULL ELSE [IconUrl] END,
                        [IconExists] = CASE WHEN [IconUrl] IS NOT NULL AND [IconUrl] LIKE ''data:%'' THEN 1 ELSE 0 END
                ')
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230817110919_BreakOutIcons'
)
BEGIN
    DECLARE @var1 sysname;
    SELECT @var1 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Modules]') AND [c].[name] = N'IconExists');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Modules] DROP CONSTRAINT [' + @var1 + '];');
    ALTER TABLE [Modules] ALTER COLUMN [IconExists] bit NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20230817110919_BreakOutIcons'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20230817110919_BreakOutIcons', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240130161055_ApplicationTemplate_Version_IsPrerelease'
)
BEGIN
    ALTER TABLE [ApplicationTemplates] ADD [IsPrerelease] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240130161055_ApplicationTemplate_Version_IsPrerelease'
)
BEGIN
    ALTER TABLE [ApplicationTemplates] ADD [Version] nvarchar(20) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240130161055_ApplicationTemplate_Version_IsPrerelease'
)
BEGIN
    EXECUTE('
    UPDATE [dbo].[ApplicationTemplates]
    SET Version = CONVERT(varchar(10), MajorVersion) + ''.'' + CONVERT(varchar(10), MinorVersion) + ''.'' + CONVERT(varchar(10), PatchVersion)')
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240130161055_ApplicationTemplate_Version_IsPrerelease'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240130161055_ApplicationTemplate_Version_IsPrerelease', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240131082207_UpdatedIndex_IX_ApplicationTemplates_Identifier_Version'
)
BEGIN
    DROP INDEX [IX_ApplicationTemplates_Identifier_MajorVersion_MinorVersion_PatchVersion] ON [ApplicationTemplates];
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240131082207_UpdatedIndex_IX_ApplicationTemplates_Identifier_Version'
)
BEGIN
    CREATE UNIQUE INDEX [IX_ApplicationTemplates_Identifier_Version] ON [ApplicationTemplates] ([Identifier], [Version]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240131082207_UpdatedIndex_IX_ApplicationTemplates_Identifier_Version'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240131082207_UpdatedIndex_IX_ApplicationTemplates_Identifier_Version', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240910134034_AddCreateFolderForSolution'
)
BEGIN
    ALTER TABLE [ApplicationTemplates] ADD [Defaults_CreateFolderForSolution] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240910134034_AddCreateFolderForSolution'
)
BEGIN
    EXECUTE('
    UPDATE [dbo].[ApplicationTemplates]
    SET Defaults_CreateFolderForSolution = 1')
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240910134034_AddCreateFolderForSolution'
)
BEGIN
    DECLARE @var2 sysname;
    SELECT @var2 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApplicationTemplates]') AND [c].[name] = N'Defaults_CreateFolderForSolution');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [ApplicationTemplates] DROP CONSTRAINT [' + @var2 + '];');
    ALTER TABLE [ApplicationTemplates] ALTER COLUMN [Defaults_CreateFolderForSolution] bit NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20240910134034_AddCreateFolderForSolution'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20240910134034_AddCreateFolderForSolution', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    DROP INDEX [IX_ModuleVersion_ModuleId] ON [ModuleVersion];
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    DECLARE @var3 sysname;
    SELECT @var3 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ModuleVersion]') AND [c].[name] = N'Version');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [ModuleVersion] DROP CONSTRAINT [' + @var3 + '];');
    ALTER TABLE [ModuleVersion] ALTER COLUMN [Version] nvarchar(64) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    DECLARE @defaultSchema4 AS sysname;
    SET @defaultSchema4 = SCHEMA_NAME();
    DECLARE @description4 AS sql_variant;
    SET @description4 = N'TODO: Remove this column once migration is complete and no longer running old versions of the server.';
    EXEC sp_addextendedproperty 'MS_Description', @description4, 'SCHEMA', @defaultSchema4, 'TABLE', N'ModuleVersion', 'COLUMN', N'ReleaseNotes';
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [IconUrl] nvarchar(1000) NULL;
    DECLARE @defaultSchema5 AS sysname;
    SET @defaultSchema5 = SCHEMA_NAME();
    DECLARE @description5 AS sql_variant;
    SET @description5 = N'Only populated when the icon URL in the ModuleSpecFiles is not a data URL.';
    EXEC sp_addextendedproperty 'MS_Description', @description5, 'SCHEMA', @defaultSchema5, 'TABLE', N'ModuleVersion', 'COLUMN', N'IconUrl';
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [Identifier] nvarchar(150) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    EXECUTE('UPDATE [V]
    SET [V].[Identifier] = [M].[Identifier]
    FROM [dbo].[ModuleVersion] [V]
    JOIN [dbo].[Modules] [M] ON [V].[ModuleId] = [M].[Id]')
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    DECLARE @var6 sysname;
    SELECT @var6 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ModuleVersion]') AND [c].[name] = N'Identifier');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [ModuleVersion] DROP CONSTRAINT [' + @var6 + '];');
    ALTER TABLE [ModuleVersion] ALTER COLUMN [Identifier] nvarchar(150) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [MaxClientInclusive] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [MaxClientVersionNormalized] nvarchar(100) NULL;
    DECLARE @defaultSchema7 AS sysname;
    SET @defaultSchema7 = SCHEMA_NAME();
    DECLARE @description7 AS sql_variant;
    SET @description7 = N'Stores a normalized string of the version (e.g. 0000000001.0000000002.0000000004-pre.0000000000) which is lexically sortable and comparable without requiring complicated SQL.';
    EXEC sp_addextendedproperty 'MS_Description', @description7, 'SCHEMA', @defaultSchema7, 'TABLE', N'ModuleVersion', 'COLUMN', N'MaxClientVersionNormalized';
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [MinClientInclusive] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [MinClientVersionNormalized] nvarchar(100) NULL;
    DECLARE @defaultSchema8 AS sysname;
    SET @defaultSchema8 = SCHEMA_NAME();
    DECLARE @description8 AS sql_variant;
    SET @description8 = N'Stores a normalized string of the version (e.g. 0000000001.0000000002.0000000004-pre.0000000000) which is lexically sortable and comparable without requiring complicated SQL.';
    EXEC sp_addextendedproperty 'MS_Description', @description8, 'SCHEMA', @defaultSchema8, 'TABLE', N'ModuleVersion', 'COLUMN', N'MinClientVersionNormalized';
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [ModuleReleaseNotes_Content] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    EXECUTE('UPDATE [dbo].[ModuleVersion]
    SET [ModuleReleaseNotes_Content] = [ReleaseNotes]')
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [VersionIsPrerelease] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [VersionNormalized] nvarchar(100) NULL;
    DECLARE @defaultSchema9 AS sysname;
    SET @defaultSchema9 = SCHEMA_NAME();
    DECLARE @description9 AS sql_variant;
    SET @description9 = N'Stores a normalized string of the version (e.g. 0000000001.0000000002.0000000004-pre.0000000000) which is lexically sortable and comparable without requiring complicated SQL.';
    EXEC sp_addextendedproperty 'MS_Description', @description9, 'SCHEMA', @defaultSchema9, 'TABLE', N'ModuleVersion', 'COLUMN', N'VersionNormalized';
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    EXECUTE('DECLARE @padding as varchar(max) = ''0000000000000000000000000000000000'';
    DECLARE @amount as int = 10;
    DECLARE @specialChar as varchar(1) = ''Ð'';

    WITH [VersionComponentsCTE_Pre0] AS (
        SELECT
            [Id],
            JSON_VALUE(''["'' + REPLACE([Version], ''-'',''","'') + ''"]'',''$[0]'') AS [Version],
            JSON_VALUE(''["'' + REPLACE(REPLACE([Version], ''+'', ''-''), ''-'', ''","'') + ''"]'',''$[1]'') AS [Prerelease]
        FROM [ModuleVersion]
    ),
    [VersionComponentsCTE_Pre1] AS (
        SELECT
            *,
            JSON_VALUE(''["'' + REPLACE([Version], ''.'', ''","'') + ''"]'',''$[0]'') AS [Major],
            JSON_VALUE(''["'' + REPLACE([Version], ''.'', ''","'') + ''"]'',''$[1]'') AS [Minor],
            JSON_VALUE(''["'' + REPLACE([Version], ''.'', ''","'') + ''"]'',''$[2]'') AS [Patch],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[0]'') AS [Pre0],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[1]'') AS [Pre1],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[2]'') AS [Pre2],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[3]'') AS [Pre3],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[4]'') AS [Pre4],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[5]'') AS [Pre5],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[6]'') AS [Pre6],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[7]'') AS [Pre7],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[8]'') AS [Pre8],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[9]'') AS [Pre9],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[10]'') AS [Pre10],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[11]'') AS [Pre11],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[12]'') AS [Pre12],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[13]'') AS [Pre13],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[14]'') AS [Pre14],
            JSON_VALUE(''["'' + REPLACE([Prerelease], ''.'', ''","'') + ''"]'',''$[15]'') AS [Pre15]
        FROM [VersionComponentsCTE_Pre0]
    ),
    [VersionComponentsCTE] AS (
        SELECT
            [Id],
            CAST((CASE WHEN [Pre0] IS NOT NULL THEN 1 ELSE 0 END) AS bit) AS [VersionIsPrerelease],
            CONCAT(
                RIGHT(@padding + [Major], @amount),
                ''.'',
                RIGHT(@padding + [Minor], @amount),
                ''.'',
                RIGHT(@padding + [Patch], @amount),
                ''-'',
                CASE WHEN [Pre0] IS NULL THEN @specialChar ELSE NULL END,
                CASE WHEN TRY_CAST([Pre0] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre0], @amount) ELSE [Pre0] END,
                CASE WHEN [Pre1] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre1] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre1], @amount) ELSE [Pre1] END,
                CASE WHEN [Pre2] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre2] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre2], @amount) ELSE [Pre2] END,
                CASE WHEN [Pre3] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre3] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre3], @amount) ELSE [Pre3] END,
                CASE WHEN [Pre4] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre4] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre4], @amount) ELSE [Pre4] END,
                CASE WHEN [Pre5] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre5] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre5], @amount) ELSE [Pre5] END,
                CASE WHEN [Pre6] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre6] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre6], @amount) ELSE [Pre6] END,
                CASE WHEN [Pre7] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre7] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre7], @amount) ELSE [Pre7] END,
                CASE WHEN [Pre8] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre8] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre8], @amount) ELSE [Pre8] END,
                CASE WHEN [Pre9] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre9] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre9], @amount) ELSE [Pre9] END,
                CASE WHEN [Pre10] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre10] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre10], @amount) ELSE [Pre10] END,
                CASE WHEN [Pre11] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre11] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre11], @amount) ELSE [Pre11] END,
                CASE WHEN [Pre12] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre12] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre12], @amount) ELSE [Pre12] END,
                CASE WHEN [Pre13] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre13] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre13], @amount) ELSE [Pre13] END,
                CASE WHEN [Pre14] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre14] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre14], @amount) ELSE [Pre14] END,
                CASE WHEN [Pre15] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([Pre15] AS INT) IS NOT NULL THEN RIGHT(@padding + [Pre15], @amount) ELSE [Pre15] END
            ) AS [VersionNormalized]
        FROM [VersionComponentsCTE_Pre1]
    ),
    [SupportedVersionsCTE_Pre0] AS (
        SELECT DISTINCT([SupportedClientVersions])
        FROM [ModuleVersion]
    ),
    [SupportedVersionsCTE_Pre1] AS (
        SELECT
            [SupportedClientVersions],
            RTRIM(LTRIM(JSON_VALUE(''["'' + REPLACE([SupportedClientVersions], '','',''","'') + ''"]'',''$[0]''), ''[( ''), '' '') AS [Min],
            LTRIM(RTRIM(JSON_VALUE(''["'' + REPLACE([SupportedClientVersions], '','',''","'') + ''"]'',''$[1]''), '']) ''), '' '') AS [Max],
            CAST((CASE WHEN LEFT([SupportedClientVersions], 1) = ''('' THEN 0 ELSE 1 END) AS bit) AS [MinIsInclusive],
            CAST((CASE WHEN RIGHT([SupportedClientVersions], 1) = '')'' THEN 0 ELSE 1 END) AS bit) AS [MaxIsInclusive]
        FROM [SupportedVersionsCTE_Pre0]
    ),
    [SupportedVersionsCTE_Pre2] AS (
        SELECT
            *,
            JSON_VALUE(''["'' + REPLACE([Min], ''-'',''","'') + ''"]'',''$[0]'') AS [MinVersion],
            JSON_VALUE(''["'' + REPLACE(REPLACE([Min], ''+'', ''-''), ''-'', ''","'') + ''"]'',''$[1]'') AS [MinPrerelease],
            JSON_VALUE(''["'' + REPLACE([Max], ''-'',''","'') + ''"]'',''$[0]'') AS [MaxVersion],
            JSON_VALUE(''["'' + REPLACE(REPLACE([Max], ''+'', ''-''), ''-'', ''","'') + ''"]'',''$[1]'') AS [MaxPrerelease]
        FROM [SupportedVersionsCTE_Pre1]
    ),
    [SupportedVersionsCTE_Pre3] AS (
        SELECT
            *,
            JSON_VALUE(''["'' + REPLACE([MinVersion], ''.'', ''","'') + ''"]'',''$[0]'') AS [MinMajor],
            JSON_VALUE(''["'' + REPLACE([MinVersion], ''.'', ''","'') + ''"]'',''$[1]'') AS [MinMinor],
            JSON_VALUE(''["'' + REPLACE([MinVersion], ''.'', ''","'') + ''"]'',''$[2]'') AS [MinPatch],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[0]'') AS [MinPre0],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[1]'') AS [MinPre1],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[2]'') AS [MinPre2],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[3]'') AS [MinPre3],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[4]'') AS [MinPre4],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[5]'') AS [MinPre5],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[6]'') AS [MinPre6],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[7]'') AS [MinPre7],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[8]'') AS [MinPre8],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[9]'') AS [MinPre9],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[10]'') AS [MinPre10],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[11]'') AS [MinPre11],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[12]'') AS [MinPre12],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[13]'') AS [MinPre13],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[14]'') AS [MinPre14],
            JSON_VALUE(''["'' + REPLACE([MinPrerelease], ''.'', ''","'') + ''"]'',''$[15]'') AS [MinPre15],
            JSON_VALUE(''["'' + REPLACE([MaxVersion], ''.'', ''","'') + ''"]'',''$[0]'') AS [MaxMajor],
            JSON_VALUE(''["'' + REPLACE([MaxVersion], ''.'', ''","'') + ''"]'',''$[1]'') AS [MaxMinor],
            JSON_VALUE(''["'' + REPLACE([MaxVersion], ''.'', ''","'') + ''"]'',''$[2]'') AS [MaxPatch],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[0]'') AS [MaxPre0],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[1]'') AS [MaxPre1],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[2]'') AS [MaxPre2],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[3]'') AS [MaxPre3],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[4]'') AS [MaxPre4],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[5]'') AS [MaxPre5],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[6]'') AS [MaxPre6],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[7]'') AS [MaxPre7],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[8]'') AS [MaxPre8],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[9]'') AS [MaxPre9],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[10]'') AS [MaxPre10],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[11]'') AS [MaxPre11],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[12]'') AS [MaxPre12],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[13]'') AS [MaxPre13],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[14]'') AS [MaxPre14],
            JSON_VALUE(''["'' + REPLACE([MaxPrerelease], ''.'', ''","'') + ''"]'',''$[15]'') AS [MaxPre15]
        FROM [SupportedVersionsCTE_Pre2]
    ),
    [SupportedVersionsCTE] AS (
        SELECT
            [SupportedClientVersions],
            [MinIsInclusive],
            CONCAT(
                RIGHT(@padding + [MinMajor], @amount),
                ''.'',
                RIGHT(@padding + [MinMinor], @amount),
                ''.'',
                RIGHT(@padding + [MinPatch], @amount),
                ''-'',
                CASE WHEN [MinPre0] IS NULL THEN @specialChar ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre0] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre0], @amount) ELSE [MinPre0] END,
                CASE WHEN [MinPre1] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre1] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre1], @amount) ELSE [MinPre1] END,
                CASE WHEN [MinPre2] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre2] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre2], @amount) ELSE [MinPre2] END,
                CASE WHEN [MinPre3] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre3] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre3], @amount) ELSE [MinPre3] END,
                CASE WHEN [MinPre4] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre4] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre4], @amount) ELSE [MinPre4] END,
                CASE WHEN [MinPre5] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre5] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre5], @amount) ELSE [MinPre5] END,
                CASE WHEN [MinPre6] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre6] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre6], @amount) ELSE [MinPre6] END,
                CASE WHEN [MinPre7] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre7] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre7], @amount) ELSE [MinPre7] END,
                CASE WHEN [MinPre8] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre8] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre8], @amount) ELSE [MinPre8] END,
                CASE WHEN [MinPre9] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre9] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre9], @amount) ELSE [MinPre9] END,
                CASE WHEN [MinPre10] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre10] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre10], @amount) ELSE [MinPre10] END,
                CASE WHEN [MinPre11] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre11] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre11], @amount) ELSE [MinPre11] END,
                CASE WHEN [MinPre12] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre12] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre12], @amount) ELSE [MinPre12] END,
                CASE WHEN [MinPre13] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre13] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre13], @amount) ELSE [MinPre13] END,
                CASE WHEN [MinPre14] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre14] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre14], @amount) ELSE [MinPre14] END,
                CASE WHEN [MinPre15] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MinPre15] AS INT) IS NOT NULL THEN RIGHT(@padding + [MinPre15], @amount) ELSE [MinPre15] END
            ) AS [MinClientVersionNormalized],
            [MaxIsInclusive],
            CONCAT(
                RIGHT(@padding + [MaxMajor], @amount),
                ''.'',
                RIGHT(@padding + [MaxMinor], @amount),
                ''.'',
                RIGHT(@padding + [MaxPatch], @amount),
                ''-'',
                CASE WHEN [MaxPre0] IS NULL THEN @specialChar ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre0] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre0], @amount) ELSE [MaxPre0] END,
                CASE WHEN [MaxPre1] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre1] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre1], @amount) ELSE [MaxPre1] END,
                CASE WHEN [MaxPre2] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre2] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre2], @amount) ELSE [MaxPre2] END,
                CASE WHEN [MaxPre3] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre3] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre3], @amount) ELSE [MaxPre3] END,
                CASE WHEN [MaxPre4] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre4] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre4], @amount) ELSE [MaxPre4] END,
                CASE WHEN [MaxPre5] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre5] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre5], @amount) ELSE [MaxPre5] END,
                CASE WHEN [MaxPre6] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre6] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre6], @amount) ELSE [MaxPre6] END,
                CASE WHEN [MaxPre7] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre7] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre7], @amount) ELSE [MaxPre7] END,
                CASE WHEN [MaxPre8] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre8] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre8], @amount) ELSE [MaxPre8] END,
                CASE WHEN [MaxPre9] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre9] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre9], @amount) ELSE [MaxPre9] END,
                CASE WHEN [MaxPre10] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre10] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre10], @amount) ELSE [MaxPre10] END,
                CASE WHEN [MaxPre11] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre11] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre11], @amount) ELSE [MaxPre11] END,
                CASE WHEN [MaxPre12] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre12] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre12], @amount) ELSE [MaxPre12] END,
                CASE WHEN [MaxPre13] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre13] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre13], @amount) ELSE [MaxPre13] END,
                CASE WHEN [MaxPre14] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre14] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre14], @amount) ELSE [MaxPre14] END,
                CASE WHEN [MaxPre15] IS NOT NULL THEN ''.'' ELSE NULL END,
                CASE WHEN TRY_CAST([MaxPre15] AS INT) IS NOT NULL THEN RIGHT(@padding + [MaxPre15], @amount) ELSE [MaxPre15] END
            ) AS [MaxClientVersionNormalized]
        FROM [SupportedVersionsCTE_Pre3]
    )
    UPDATE [MV]
    SET
        [MV].[VersionNormalized] = [VC].[VersionNormalized],
        [MV].[VersionIsPrerelease] = [VC].[VersionIsPrerelease],
        [MV].[MinClientInclusive] = [SV].[MinIsInclusive],
        [MV].[MinClientVersionNormalized] = [SV].[MinClientVersionNormalized],
        [MV].[MaxClientInclusive] = [SV].[MaxIsInclusive],
        [MV].[MaxClientVersionNormalized] = [SV].[MaxClientVersionNormalized]
    FROM [dbo].[ModuleVersion] AS [MV]
    LEFT OUTER JOIN [VersionComponentsCTE] AS [VC] ON [VC].[Id] = [MV].[ID]
    LEFT OUTER JOIN [SupportedVersionsCTE] AS [SV] ON [SV].[SupportedClientVersions] = [MV].[SupportedClientVersions]')
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    DECLARE @var10 sysname;
    SELECT @var10 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ModuleVersion]') AND [c].[name] = N'VersionIsPrerelease');
    IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [ModuleVersion] DROP CONSTRAINT [' + @var10 + '];');
    ALTER TABLE [ModuleVersion] ALTER COLUMN [VersionIsPrerelease] bit NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    DECLARE @var11 sysname;
    SELECT @var11 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ModuleVersion]') AND [c].[name] = N'VersionNormalized');
    IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [ModuleVersion] DROP CONSTRAINT [' + @var11 + '];');
    ALTER TABLE [ModuleVersion] ALTER COLUMN [VersionNormalized] nvarchar(100) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    DECLARE @var12 sysname;
    SELECT @var12 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Modules]') AND [c].[name] = N'IconUrl');
    IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [Modules] DROP CONSTRAINT [' + @var12 + '];');
    ALTER TABLE [Modules] ALTER COLUMN [IconUrl] nvarchar(1000) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    DECLARE @defaultSchema13 AS sysname;
    SET @defaultSchema13 = SCHEMA_NAME();
    DECLARE @description13 AS sql_variant;
    EXEC sp_dropextendedproperty 'MS_Description', 'SCHEMA', @defaultSchema13, 'TABLE', N'Modules', 'COLUMN', N'IconExists';
    SET @description13 = N'Although this can be inferred by whether the association to ModuleIcon is null, by storing it here we don''t have to worry about lazy loading the entity (which reduces performance) to check if its null or do something else in the query.';
    EXEC sp_addextendedproperty 'MS_Description', @description13, 'SCHEMA', @defaultSchema13, 'TABLE', N'Modules', 'COLUMN', N'IconExists';
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    CREATE INDEX [IX_ModuleVersion_ModuleId_Version] ON [ModuleVersion] ([ModuleId], [Version]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250513225308_ModuleVersionOptimizations'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250513225308_ModuleVersionOptimizations', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521194724_BreakOutReleaseNotes'
)
BEGIN
    CREATE TABLE [ModuleReleaseNotes] (
        [Id] uniqueidentifier NOT NULL,
        [Content] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ModuleReleaseNotes] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ModuleReleaseNotes_ModuleVersion_Id] FOREIGN KEY ([Id]) REFERENCES [ModuleVersion] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521194724_BreakOutReleaseNotes'
)
BEGIN
    EXECUTE('INSERT INTO [dbo].[ModuleReleaseNotes] ([Id], [Content])
    SELECT [Id], [ModuleReleaseNotes_Content]
    FROM [ModuleVersion]
    WHERE [ModuleReleaseNotes_Content] IS NOT NULL')
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521194724_BreakOutReleaseNotes'
)
BEGIN
    DECLARE @var14 sysname;
    SELECT @var14 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ModuleVersion]') AND [c].[name] = N'ModuleReleaseNotes_Content');
    IF @var14 IS NOT NULL EXEC(N'ALTER TABLE [ModuleVersion] DROP CONSTRAINT [' + @var14 + '];');
    ALTER TABLE [ModuleVersion] DROP COLUMN [ModuleReleaseNotes_Content];
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521194724_BreakOutReleaseNotes'
)
BEGIN
    DECLARE @var15 sysname;
    SELECT @var15 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ModuleVersion]') AND [c].[name] = N'ReleaseNotes');
    IF @var15 IS NOT NULL EXEC(N'ALTER TABLE [ModuleVersion] DROP CONSTRAINT [' + @var15 + '];');
    ALTER TABLE [ModuleVersion] DROP COLUMN [ReleaseNotes];
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250521194724_BreakOutReleaseNotes'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250521194724_BreakOutReleaseNotes', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD [IconFileId] uniqueidentifier NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    ALTER TABLE [ApplicationTemplates] ADD [CoverImageFileId] uniqueidentifier NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    ALTER TABLE [ApplicationTemplates] ADD [IconFileId] uniqueidentifier NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    ALTER TABLE [ApplicationTemplates] ADD [Type] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    EXECUTE('UPDATE [ApplicationTemplates] SET [Type] = 1')
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    DECLARE @var16 sysname;
    SELECT @var16 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApplicationTemplates]') AND [c].[name] = N'Type');
    IF @var16 IS NOT NULL EXEC(N'ALTER TABLE [ApplicationTemplates] DROP CONSTRAINT [' + @var16 + '];');
    ALTER TABLE [ApplicationTemplates] ALTER COLUMN [Type] int NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    CREATE TABLE [DeduplicatedFiles] (
        [Id] uniqueidentifier NOT NULL,
        [Hash] nvarchar(64) NOT NULL,
        [FileExtension] nvarchar(5) NOT NULL,
        CONSTRAINT [PK_DeduplicatedFiles] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    CREATE TABLE [ApplicationTemplateDeduplicatedFiles] (
        [AdditionalImageFilesId] uniqueidentifier NOT NULL,
        [ApplicationTemplatesId] uniqueidentifier NOT NULL,
        CONSTRAINT [PK_ApplicationTemplateDeduplicatedFiles] PRIMARY KEY ([AdditionalImageFilesId], [ApplicationTemplatesId]),
        CONSTRAINT [FK_ApplicationTemplateDeduplicatedFiles_ApplicationTemplates_ApplicationTemplatesId] FOREIGN KEY ([ApplicationTemplatesId]) REFERENCES [ApplicationTemplates] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ApplicationTemplateDeduplicatedFiles_DeduplicatedFiles_AdditionalImageFilesId] FOREIGN KEY ([AdditionalImageFilesId]) REFERENCES [DeduplicatedFiles] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    CREATE TABLE [DeduplicatedFileData] (
        [Id] uniqueidentifier NOT NULL,
        [Content] varbinary(max) NOT NULL,
        CONSTRAINT [PK_DeduplicatedFileData] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DeduplicatedFileData_DeduplicatedFiles_Id] FOREIGN KEY ([Id]) REFERENCES [DeduplicatedFiles] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    CREATE INDEX [IX_ModuleVersion_IconFileId] ON [ModuleVersion] ([IconFileId]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    CREATE INDEX [IX_ApplicationTemplates_CoverImageFileId] ON [ApplicationTemplates] ([CoverImageFileId]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    CREATE INDEX [IX_ApplicationTemplates_IconFileId] ON [ApplicationTemplates] ([IconFileId]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    CREATE INDEX [IX_ApplicationTemplateDeduplicatedFiles_ApplicationTemplatesId] ON [ApplicationTemplateDeduplicatedFiles] ([ApplicationTemplatesId]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    CREATE UNIQUE INDEX [IX_DeduplicatedFiles_FileExtension_Hash] ON [DeduplicatedFiles] ([FileExtension], [Hash]) INCLUDE ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    ALTER TABLE [ApplicationTemplates] ADD CONSTRAINT [FK_ApplicationTemplates_DeduplicatedFiles_CoverImageFileId] FOREIGN KEY ([CoverImageFileId]) REFERENCES [DeduplicatedFiles] ([Id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    ALTER TABLE [ApplicationTemplates] ADD CONSTRAINT [FK_ApplicationTemplates_DeduplicatedFiles_IconFileId] FOREIGN KEY ([IconFileId]) REFERENCES [DeduplicatedFiles] ([Id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    ALTER TABLE [ModuleVersion] ADD CONSTRAINT [FK_ModuleVersion_DeduplicatedFiles_IconFileId] FOREIGN KEY ([IconFileId]) REFERENCES [DeduplicatedFiles] ([Id]) ON DELETE NO ACTION;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250523130151_AddDepuplicatedFilesAndAppTemplateType'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250523130151_AddDepuplicatedFilesAndAppTemplateType', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250524150528_AddModuleVersionIndexes'
)
BEGIN
    CREATE INDEX [IX_ForRepositoryMethod_FindVersions] ON [ModuleVersion] ([IsListed], [Identifier], [VersionIsPrerelease], [MinClientInclusive], [MaxClientInclusive], [VersionNormalized]) INCLUDE ([MinClientVersionNormalized], [MaxClientVersionNormalized], [Version]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250524150528_AddModuleVersionIndexes'
)
BEGIN
    CREATE INDEX [IX_ForRepositoryMethod_Search] ON [ModuleVersion] ([IsListed], [VersionIsPrerelease]) INCLUDE ([Description], [Version], [Authors], [Tags], [SupportedClientVersions], [IconUrl], [Identifier], [MaxClientInclusive], [MaxClientVersionNormalized], [MinClientVersionNormalized], [MinClientInclusive], [VersionNormalized], [IconFileId]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250524150528_AddModuleVersionIndexes'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250524150528_AddModuleVersionIndexes', N'9.0.4');
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    DROP TABLE [ApplicationTemplateDeduplicatedFiles];
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    DECLARE @var17 sysname;
    SELECT @var17 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApplicationTemplates]') AND [c].[name] = N'FullDescription');
    IF @var17 IS NOT NULL EXEC(N'ALTER TABLE [ApplicationTemplates] DROP CONSTRAINT [' + @var17 + '];');
    ALTER TABLE [ApplicationTemplates] DROP COLUMN [FullDescription];
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    DECLARE @var18 sysname;
    SELECT @var18 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApplicationTemplates]') AND [c].[name] = N'Defaults_SetGitIgnoreEntries');
    IF @var18 IS NOT NULL EXEC(N'ALTER TABLE [ApplicationTemplates] DROP CONSTRAINT [' + @var18 + '];');
    ALTER TABLE [ApplicationTemplates] ALTER COLUMN [Defaults_SetGitIgnoreEntries] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    DECLARE @var19 sysname;
    SELECT @var19 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApplicationTemplates]') AND [c].[name] = N'Defaults_SeparateIntentFiles');
    IF @var19 IS NOT NULL EXEC(N'ALTER TABLE [ApplicationTemplates] DROP CONSTRAINT [' + @var19 + '];');
    ALTER TABLE [ApplicationTemplates] ALTER COLUMN [Defaults_SeparateIntentFiles] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    DECLARE @var20 sysname;
    SELECT @var20 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApplicationTemplates]') AND [c].[name] = N'Defaults_RelativeOutputLocation');
    IF @var20 IS NOT NULL EXEC(N'ALTER TABLE [ApplicationTemplates] DROP CONSTRAINT [' + @var20 + '];');
    ALTER TABLE [ApplicationTemplates] ALTER COLUMN [Defaults_RelativeOutputLocation] nvarchar(128) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    DECLARE @var21 sysname;
    SELECT @var21 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApplicationTemplates]') AND [c].[name] = N'Defaults_PlaceInSameDirectory');
    IF @var21 IS NOT NULL EXEC(N'ALTER TABLE [ApplicationTemplates] DROP CONSTRAINT [' + @var21 + '];');
    ALTER TABLE [ApplicationTemplates] ALTER COLUMN [Defaults_PlaceInSameDirectory] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    DECLARE @var22 sysname;
    SELECT @var22 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApplicationTemplates]') AND [c].[name] = N'Defaults_Name');
    IF @var22 IS NOT NULL EXEC(N'ALTER TABLE [ApplicationTemplates] DROP CONSTRAINT [' + @var22 + '];');
    ALTER TABLE [ApplicationTemplates] ALTER COLUMN [Defaults_Name] nvarchar(128) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    DECLARE @var23 sysname;
    SELECT @var23 = [d].[name]
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ApplicationTemplates]') AND [c].[name] = N'Defaults_CreateFolderForSolution');
    IF @var23 IS NOT NULL EXEC(N'ALTER TABLE [ApplicationTemplates] DROP CONSTRAINT [' + @var23 + '];');
    ALTER TABLE [ApplicationTemplates] ALTER COLUMN [Defaults_CreateFolderForSolution] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    CREATE TABLE [ApplicationTemplateAdditionalImage] (
        [FileId] uniqueidentifier NOT NULL,
        [ApplicationTemplatesId] uniqueidentifier NOT NULL,
        [Order] int NOT NULL,
        CONSTRAINT [PK_ApplicationTemplateAdditionalImage] PRIMARY KEY ([FileId], [ApplicationTemplatesId]),
        CONSTRAINT [FK_ApplicationTemplateAdditionalImage_ApplicationTemplates_ApplicationTemplatesId] FOREIGN KEY ([ApplicationTemplatesId]) REFERENCES [ApplicationTemplates] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ApplicationTemplateAdditionalImage_DeduplicatedFiles_FileId] FOREIGN KEY ([FileId]) REFERENCES [DeduplicatedFiles] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    CREATE TABLE [ApplicationTemplateLongDescriptions] (
        [Id] uniqueidentifier NOT NULL,
        [Content] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ApplicationTemplateLongDescriptions] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ApplicationTemplateLongDescriptions_ApplicationTemplates_Id] FOREIGN KEY ([Id]) REFERENCES [ApplicationTemplates] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    CREATE INDEX [IX_ApplicationTemplateAdditionalImage_ApplicationTemplatesId] ON [ApplicationTemplateAdditionalImage] ([ApplicationTemplatesId]);
END;

IF NOT EXISTS (
    SELECT * FROM [ModuleServer].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'20250525193144_ApplicationTemplateUpdatesForSamples'
)
BEGIN
    INSERT INTO [ModuleServer].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20250525193144_ApplicationTemplateUpdatesForSamples', N'9.0.4');
END;

COMMIT;
GO
```
