# What's new in Intent Architect (May 2025)

Welcome to the May 2025 edition of highlights of What's New in Intent Architect. Here's a roundup of the latest updates and improvements.

- Highlights
  - **[Primary Key Configuration Enhancements](#primary-key-configuration-enhancements)** - Improved primary key configuration with better control over identity generation and data source specification.
  - **[Model Event Integration using Azure Event Grid](#model-event-integration-using-azure-event-grid)** - This module enables you to use the Azure Event Grid as the medium to send and receive Integration Events for your application.

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
