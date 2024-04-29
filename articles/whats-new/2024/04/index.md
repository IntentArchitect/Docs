# What's new in Intent Architect (April 2024)

Welcome to the April 2024 edition of highlights of What's New in Intent Architect.

- Highlights

- More updates
  - **[CosmosDB multi-tenancy now supports database isolation](#cosmosdb-multi-tenancy-now-supports-database-isolation)** - Have you CosmosDB tenants data stored in tenant specific databases.
  - **[OpenApi.Importer Module](#openapiimporter-module)** - Import Services from OpenAPI/Swagger documents.

## Update details

### CosmosDB multi-tenancy now supports database isolation

If you are using the `Intent.Modules.AspNetCore.MultiTenancy` module, our `Intent.CosmosDB` module now supported the `Data Isolation` - `Separate Database option`.

![OpeConfiguration](./images/cosmos-multi-db-setting.png)

You can configure then configure each tenant to have their own connection string.

For more detail, refer to the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/master/Modules/Intent.Modules.CosmosDB/README.md).

Available from:

- Intent.CosmosDB 1.1.2

### OpenApi.Importer Module

The `Intent.OpenApi.Importer` module enhances the `Service Designer` allowing you to import / reverse engineer service models from OpenApi documents.

In the `Service Designer`, right click on your service package (or a folder in the package) and select the `OpenApi Import` context menu option.

![Open Import context menu item](./images/open-api-import-context-menu.png)

Selecting this option will provide you with the following dialog:

![OpenApi Import dialog](./images/open-api-dialog.png)

For more detail, refer to the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/master/Modules/Intent.Modules.OpenApi.Importer/README.md).

Available from:

- Intent.OpenApi.Importer 1.0.0
