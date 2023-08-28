# August 2023

Welcome to the August 2023 edition of highlights of What's New with Intent Architect.

- Highlights

- More updates
  - **[Import OpenApi / Swagger documents into the Services Designer](#import-openapi--swagger-documents-into-the-services-designer)** - Created a new import tool for populating service package metadata from OpenApi / Swagger contracts.
  - **[Module building tutorial updated to use the File builder pattern](#module-building-tutorial-updated-to-use-the-file-builder-pattern)** - The module building tutorial has been updated to use the File builder pattern, more inline with how we recommend building templates today.
  - **[Modeling different Document DB technologies with-in one application](#modeling-different-document-db-technologies-with-in-one-application)** - We now support modeling different Document Store databases within a single application.
  - **[Dapr - Configuration Module](#dapr---configuration-module)** - Added a module for Dapr Configuration patterns.
  - **[Dapr - Secrets Module](#dapr---secrets-module)** - Added a module for Dapr Secrets patterns.
  - **[MassTransit Finbuckle integration](#masstransit-finbuckle-integration)** - Updated the MassTransit module to  support tenancy on messaging with Finbuckle.
  - **[Improved Queue Trigger support in Azure Functions applications](#improved-queue-trigger-support-in-azure-functions-applications)** - Improved the Azure Functions Queue Trigger functionality to support additional features. 
  - **[Abstract domain operations](#abstract-domain-operations)** - Domain operations can now be modeled as abstract.
  - **[DataAnnotation validations on Blazor data contracts](#dataannotation-validations-on-blazor-data-contracts)** - Blazor proxies module now generated DataAnnotation validations on proxy contracts, inline with service modelled validations.

## Update details

### Import OpenApi / Swagger documents into the Services Designer

We have released a new Metadata import tool which can import OpenApi / Swagger (3.*) documents and produce an Intent Architect `Service Package`.
Service can be imported in either the CQRS or traditional services paradigm.

Here is an example of having imported the [Pet Store 3 Swagger](https://petstore3.swagger.io/).

![Pet Store Import](./images/pet-store-import.png)

For more information on accessing and using the tool, check out the [documentation](https://docs.intentarchitect.com/articles/tools/open-api-metadata-synchronizer/open-api-metadata-synchronizer.html).

### Module building tutorial updated to use the File builder pattern

On our documentation website, we have updated the Module building tutorial to use the File Builder template paradigm, to be more inline with our own current template building practices.

You can find the start of the tutorial [here](https://docs.intentarchitect.com/articles/module-building/templates-general/tutorial-create-a-template/01-create-a-template-introduction/create-a-template-introduction.html).

### Modeling different Document DB technologies with-in one application

When creating a Domain Modelling package and marking it as a Document DB backed model, through the use of the the `Document Database` package stereotype,  you can now specify which Document DB technology you want this model to be realized as. This stereotype has a Provider property, to specify which specific type of Document Db technology the Domain Package should be realized in. This drop down has the following options.

- Default (None selected), if no provider is specified and you have a single Document DB Provider module installed (e.g. Intent.CosmosDB), that module will be used by default.
- Custom, the backing implementation will need to be implemented through custom code.
- Dynamic installed module providers (e.g. CosmosDB, MongoDd, Dapr), any Document DB Provider implementing modules will show as options here.

If you have multiple Document DB technologies you would need to configure which Domain Packages are for which Document DB technologies.

[Configure you Document DB Provider](./images/document-db-provider.png)

Available from:

- Intent.Metadata.DocumentDB 1.1.3

With the following DocumentDB providers

- Intent.CosmosDB 1.0.0-alpha.14
- Intent.MongoDb 1.0.3
- Intent.Dapr.AspNetCore.StateManagement 1.1.0

### Dapr - Configuration Module

A new module which implements patterns for working with Dapr (Distributed Application Runtime) Configuration component, alongside our existing Dapr modules.
The Dapr Configuration component is all about centralizing configuration for distributed systems.

Check out the module documentation for full [details](https://github.com/IntentArchitect/Intent.Modules.NET/tree/development/Modules/Intent.Modules.Dapr.AspNetCore.Configuration/README.md).

Available from:

- Intent.Dapr.AspNetCore.Secrets 1.0.0

### Dapr - Secrets Module

A new module which implements patterns for working with Dapr (Distributed Application Runtime) Secrets component, alongside our existing Dapr modules.
The Dapr Secrets component is all about centralizing secrets for distributed systems.

Check out the module documentation for full [details](https://github.com/IntentArchitect/Intent.Modules.NET/tree/development/Modules/Intent.Modules.Dapr.AspNetCore.Secrets/README.md).

Available from:

- Intent.Dapr.AspNetCore.Configuration 1.0.0

### MassTransit Finbuckle integration

Our MassTransit module now supports consuming and propagating tenancy information in message headers, when used in conjunction with Finbuckle.

Check out the module documentation for full [details](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Eventing.MassTransit/README.md#multitenancy-finbuckle-integration).

Available from:

- Intent.Eventing.MassTransit 5.2.0

### Improved Queue Trigger support in Azure Functions applications

Our AzureFunctions module now has improved support for Queue Triggers. These improvement allow for:

- Gaining access to the message envelope
- Contracting response messages

Check out the module documentation for full [details](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.AzureFunctions/README.md#queue-triggers).

Available from:

- Intent.AzureFunctions 4.0.7

### Abstract domain operations

In the domain designer, operations can now bw marked as abstract resulting in the expected abstract implementation.

Available from:

- Intent.Entities 4.3.7

### DataAnnotation validations on Blazor data contracts

Blazor proxies now produce DataAnnotation validation attributes, like `Required` on `DTO` contracts inline which any validations configured on the services themselves.

Available from:

- Intent.Blazor.HttpClients 2.0.1
