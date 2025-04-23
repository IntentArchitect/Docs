# What's new in Intent Architect (May 2025)

Welcome to the May 2025 edition of highlights of What's New in Intent Architect. Here's a roundup of the latest updates and improvements.

- Highlights
  - **[Primary Key Configuration Enhancements](#primary-key-configuration-enhancements)** - Improved primary key configuration with better control over identity generation and data source specification.
  - **[Model Event Integration using Azure Event Grid](#model-event-integration-using-azure-event-grid)** - This module enables you to use the Azure Event Grid as the medium to send and receive Integration Events for your application.
  - **[Model Integration Messages directly with Azure Service Bus](#model-integration-messages-directly-with-azure-service-bus)** - Direct implementation to use Azure Service Bus as the message broker of choice to send and receive Integration Events and Commands for your application.
  - **[SQL Database Project Support](#sql-database-project-support)** - Generate SQL scripts based on your Domain design to produce DACPAC files for deploying SQL Schema changes.

## Update details

### Primary Key Configuration Enhancements

The `Primary Key` stereotype provides more flexibility and consistency across technology stacks. These changes make it easier to configure how primary keys are generated and managed in your applications:

- Removed the limiting `Identity` flag in favor of a more versatile approach using the `Data Source` setting.
- Enhanced cross-platform support by ensuring the `Data Source` setting is properly interpreted by both Java and .NET persistence modules:
  - When `Auto-generated` is selected, the system will automatically configure identity columns in your database.
  - When `User supplied` is selected, identity behavior is explicitly disabled, requiring manual ID assignment when persisting entities.

![Primary Key Data Source Configuration](images/primary-key.png)

More information can be found [here](https://docs.intentarchitect.com/articles/modules-common/intent-metadata-rdbms/intent-metadata-rdbms.html#create-a-primary-key-constraint).

Available from:

- Intent.Java.Persistence.JPA 5.0.2
- Intent.EntityFrameworkCore 5.0.21-pre.1

### Model Event Integration using Azure Event Grid

This module enables you to use the Azure Event Grid as the medium to send and receive Integration Events for your application.

![Azure Event Grid Modeling](images/azure-event-grid-modeling.png)

![Azure Event Grid Topic](images/azure-event-grid-topic.png)

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-eventing-azureeventgrid/intent-eventing-azureeventgrid.html).

Available from:

- Intent.Eventing.AzureEventGrid 1.0.1-pre.0

### Model Integration Messages directly with Azure Service Bus

Direct implementation to use Azure Service Bus as the message broker of choice to send and receive Integration Events and Commands for your application.

![Modeling Events and Commands](images/azure-service-bus-modeling-event-command.png)

![Customize Topic Name](images/azure-service-bus-topic-name.png)

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-eventing-azureservicebus/intent-eventing-azureservicebus.html).

Available from:

- Intent.Eventing.AzureServiceBus 1.0.2-pre.0

### SQL Database Project Support

Generate SQL scripts based on your Domain design to produce DACPAC files for deploying SQL Schema changes.

This module consumes your `Domain Model`, which you build in the `Domain Designer` (and can import using the [Intent.SqlServerImporter](https://docs.intentarchitect.com/articles/modules-dotnet/intent-sqlserverimporter/intent-sqlserverimporter.html)) and generates a SQL Database Project.

![SQL DB Project Domain Model](images/sql-db-project-domain-model.png)

Once your domain model is properly configured, the module generates a complete SQL Database Project:

![Generated SQL DB Project](images/sql-db-project-generated.png)

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-sqldatabaseproject/intent-sqldatabaseproject.html).

Available from:

- Intent.SqlDatabaseProject 1.0.1-pre.1
