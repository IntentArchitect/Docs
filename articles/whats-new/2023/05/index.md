# May 2023

Welcome to the May 2023 edition of highlights of What's New with Intent Architect.

- Product updates
  - **[Intent Architect 4.0.0 is live](#intent-architect-400-is-live)**
- Module updates (C#)
  - **[`IReadOnlyCollection` support for "private setter" Domain Entities](#ireadonlycollection-support-for-private-setter-domain-entities)** - Make entity collections immutable except from within the same class.
  - **[`async` and `CancellationToken` support in more places](#async-and-cancellationtoken-support-in-more-places)** - Domain operations, domain services and normal services now now support `async` and `CancellationToken`s.
  - **[Stored Procedure support for EF Core](#stored-procedure-support-for-ef-core)** - It's now possible to have methods generated on repositories for using stored procedures.
  - **[OpenAPI support for Azure Functions](#openapi-support-for-azure-functions)** - Provides `OpenAPI` support for `Azure Functions` applications.
  - **[GraphQL support for Azure Functions](#graphql-support-for-azure-functions)** - Provides `GraphQL` support for `Azure Functions` applications, through `Hot Chocolate`.
  - **[Designer comments as Xml documentation comments](#designer-comments-as-xml-documentation-comments)** - `Service` and `Domain` designer element comments are being included in relevant `Xml document comments`.
  - **[Parameter default value support for Domain and Service Designers](#parameter-default-value-support-for-domain-and-service-designers)** - It is now possible to specify default values for Parameters that are found on Service operations, Domain Class operations (and constructors) and Domain Service operations.
  - **[Support for EF Core 7 _JSON Columns_](#support-for-ef-core-7-json-columns)** - It is now possible to leverage JSON Columns support which was introduced in Entity Framework Core 7.
  - **[Azure Key Vault support added for ASP.NET Core](#azure-key-vault-support-added-for-aspnet-core)** - Secrets that are stored in Azure Key Vault can now be queried from the `IConfiguration` service inside your app.


## Product updates

### Intent Architect 4.0.0 is live

Intent Architect v4 is now live and available for [download](https://intentarchitect.com/#/downloads). V4 introduces tabs, a solution explorer and many other improvements, click [here](xref:release-notes.intent-architect-v4.0#version-400) for the full release notes.

> [!Video https://www.youtube.com/embed/xAiYWoImpSU]

## Module updates (C#)

### `IReadOnlyCollection` support for "private setter" Domain Entities

It was already possible to enable `Private Setters` for domain entities, but collection properties were previously exposed as mutable `ICollection<T>`s. Now enabling `Private Setters` will change `ICollection<T>` properties to instead be `IReadOnlyCollection<T>` properties with a backing `private` field of type `List<T>`.

This is to help developers adhere to the DDD principle that mutation of properties of domain entities should be impossible except through methods on the entity which ensures that business rules and consistency is maintained.

Available from:

- Intent.Entities 4.3.0.

### `async` and `CancellationToken` support in more places

- Application services (as modelled in the `Services` designer) now have a `CancellationToken cancellationToken = default` parameter and which is also populated as an argument when dispatched to from controllers.
- Appending `Async` to an operation on class or domain service will now also make the method asynchronous and have a `CancellationToken cancellationToken = default` parameter added.

Available from:

- Intent.Application.Contracts 5.0.1-pre.0
- Intent.Application.ServiceImplementations 4.2.1-pre.0
- Intent.AspNetCore.Controllers.Dispatch.ServiceContract 5.1.1-pre.0
- Intent.Entities 4.3.1-pre.1

### Stored Procedure support for EF Core

It's now possible to have methods generated on repositories for using stored procedures:

- Create a `Repository` in the Domain Designer (either in the package root or a folder).
- You can optionally set the "type" of the repository to a `Class` which will extend the existing repository which is already generated for it, otherwise if no "type" is   specified a new Repository is generated.
- On a repository you can create `Stored Procedure`s.
- At this time, the module supports a Stored Procedure returning: nothing, an existing `Class` or a `Data Contract` (`Domain Object`).
- The Software Factory will generate methods on the Repositories for calling the Stored Procedures.

Available from:

- Intent.EntityFrameworkCore.Repositories 4.2.2-pre.1

### OpenAPI support for Azure Functions

This module brings in `OpenAPI` support for your `Azure Function` application. 

Available from:

- Intent.AzureFunction.OpenApi 1.0.0. 

### GraphQL support for Azure Functions

This module brings in `GraphQL` support for your `Azure Function` application, allowing you to expose your `Azure Function`s through a `GraphQL` api. This module uses `Hot Chocolate` as it's `GraphQL` engine.

- In the `Service` designer simply apply the `GraphQL Enabled` stereotype to the `Service Operation`s you wish to expose through `GraphQL`

Available from:

- Intent.HotChocolate.GraphQL.AzureFunctions 1.0.0. 

### Designer comments as Xml documentation comments

Most designer elements support a comments field, if these comments are captured, these comments are included in the relevant generated code as `Xml document comments.`

Available from:

- Intent.Application.Contracts 5.0.0
- Intent.Application.Dtos 4.0.3
- Intent.Application.MediatR 4.0.6
- Intent.Application.ServiceImplementations 4.2.0
- Intent.DomainEvents 4.0.4
- Intent.DomainServices 1.1.0
- Intent.Entities 4.3.0
- Intent.EntityFrameworkCore.Interop.DomainEvents 4.0.3

### Parameter default value support for Domain and Service Designers

It is now possible to specify default values for Parameters that are found on Service operations, Domain Class operations (and constructors) and Domain Service operations.

Available from:

- Intent.Application.ServiceImplementations 4.2.0
- Intent.AspNetCore.Controllers 5.1.0
- Intent.DomainServices 1.1.0
- Intent.Entities 4.3.0

### Support for EF Core 7 _JSON Columns_

It is now possible to leverage [JSON Columns](https://learn.microsoft.com/ef/core/what-is-new/ef-core-7.0/whatsnew#json-columns) support which was introduced in Entity Framework Core 7. Adding a `Serialization Settings` stereotype on `Value Objects` in the Domain designer will cause `Value Object`s and their associated entities to be stored in a `JSON` serialized format in a single database column.

Available from:

- Intent.EntityFrameworkCore 4.4.0
- Intent.ValueObjects 4.1.0

### Azure Key Vault support added for ASP.NET Core

Secrets that are stored in Azure Key Vault can now be queried from the `IConfiguration` service inside your app. It is also configurable so that secrets may only be accessed from particular environments, using specified credentials or automated discovery.

Available from:

- Intent.Azure.KeyVault 1.0.0
- Intent.AspNetCore 5.0.0
