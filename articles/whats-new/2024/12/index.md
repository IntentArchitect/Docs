# What's new in Intent Architect (December 2024)

Welcome to the 2024 Christmas edition of highlights of What's New in Intent Architect.

We are proud to announce the release of Intent Architect 4.4 beta. This release has been largely focused on improving product usability and feature discoverability. This version is fully backwards compatible.

- Highlights
  - **[Context Aware Help Topics](#context-aware-help-topics)** - In product, context aware help topics available on F1.
  - **[Suggestions](#suggestions)** - New hint system, to accelerate your modeling and help discover options with Intent Architect.
  - **[Search Everywhere](#search-everywhere)** - Ability to search everywhere, including across applications.
  - **[SonarQube Analysis](#sonarqube-module)** - Provides real-time code quality analysis and feedback on the quality, readability and complexity of the code using [SonarQube](https://www.sonarsource.com/products/sonarlint/)
  - **[Azure Functions upgradeable to Isolated Processes for .NET 8](#azure-functions-upgradeable-to-isolated-processes-for-net-8)** - Azure Functions for Isolated Processes are now accessible in Intent Architect.

- More updates
  - **[Find Usages](#find-usages)** - Improved find usages functionality.
  - **[Add to Diagram](#add-to-diagram)** - Easily find and add elements to your diagrams.
  - **[Solution folders](#solution-folders)** - Add folders to group your applications.
  - **[Filtered searching](#filtered-searching)** - Solution Explorer and designer tree-view model now filter their contents on searching.
  - **[AutoMapper `ProjectTo` option for CRUD patterns](#automapper-projectto-option-for-crud-patterns)** - Configure your CRUD implementations to use AutoMapper's `ProjectTo` pattern.
  - **[.NET 9 support](#net-9-support)** - Added support for .NET 9.
  - **[Finbuckle Multi-tenancy support for MongoDB](#finbuckle-multi-tenancy-support-for-mongodb)** - Configure `Separate Database` multi-tenancy support for MongoDB using Finbuckle.
  - **[Finbuckle Multi-tenancy support for Google Cloud Storage](#finbuckle-multi-tenancy-support-for-google-cloud-storage)** - Configure `Separate Database` multi-tenancy support for Google Cloud Storage using Finbuckle.
  - **[Service Designer authorization improvements](#service-designer-authorization-improvements)** - New Security module, consolidation of security stereotypes and additional authorization requirements can now be represented.
  - **[ASP.NET Core MVC Module](#aspnet-core-mvc-module)** - View stubs and basic MVC controllers can now be generated for, and which dispatch to, Services in the Service designer.
  - **[Multi-tenancy Route Strategy](#multi-tenancy-route-strategy)** - In a multi-tenancy application, determine the tenant from a route parameter.
  - **[Custom Swagger examples](#custom-swagger-examples)** - Custom examples can now be captured in Intent Architect, to reflect in the OpenAPI specification and Swagger UI.

## Update details

### Context Aware Help Topics

Intent Architect now has built in `Help`. Pressing `F1`, within the context of a designer, will bring up the `Help` dialog
The Help dialog will provide help topics which can further be filtered using the search bar.

![Help Topics Sample](images/help-dialog.png)

The Help dialog is context aware, so when you press F1 in a designer, you will get all the help topics for the designer specifically. If you select an `Element` in the the designer, for example, a domain `Class` or a CQRS `Command`, you will get help topics relevant to the selected `Element`.

Available from:

- Intent Architect 4.4.0

### Suggestions

`Suggestion`s are a new feature intended to give context specific assistance to modelers. When hovering your mouse over an `Element` which has suggestions you will see and Light Bulb icon, indicating there are suggestions available.

![Suggestions Sample](images/suggestions-command.png)

Suggestions aim to assist with the following:

- Quickly model common scenarios, for example
  - Publishing an `Integration Event` from a CQRS Command
  - Subscribing to an `Integration Event`
  - Publishing a `Domain Event` from a domain behaviour.
- Add related Elements / Associations for existing Diagram Elements
- Discover modeling options

Available from:

- Intent Architect 4.4.0

### Search Everywhere

The Search Everywhere dialog, allows you to quickly find aspects of your design using a unified, incremental search box which also supports abbreviation matching.
The Search is performed across applications, and the search results give full context on the search results to make easy to quickly identify the search result you are looking for.

![Search Everywhere Sample](images/search-everywhere.png)

You can access the Search Everywhere dialog using it's shortcut (Ctrl+T).

Available from:

- Intent Architect 4.4.0

### SonarQube Module

This module installs the SonarQube IDE linter into your application, providing real-time code quality analysis and feedback on the quality, readability and complexity of the code.

An example of some warnings raised by SonarQube (as well as other analysis tools):

![SonarQube warning](images/sonarqube-warnings.png)

Available from:

- Intent.SonarQube 1.0.0

### Azure Functions upgradeable to Isolated Processes for .NET 8

Azure Functions for Isolated Processes are now accessible by configuring your API project to target .NET 8 and setting the Output Type to `Console` in the Visual Studio designer.

To learn about migrating existing Azure Functions from .NET 6 In-Process to .NET 8 Isolated Processes, [click here](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.AzureFunctions/README.md#migrating-from-in-process-functions).

Available from:

- Intent.AzureFunctions 5.0.1

### Find Usages

The `Find Usages` (Shift+F12) feature has been vastly improved, leveraging the new `Search Everywhere` feature.

![Find Usages Sample](images/find-usages.png)

Find usages will present you with a list of all references to the modeled element, including across applications.

Example use cases for this feature:

- Who is subscribing to this Integration Event?
- What would be affected if I change this domain attribute?

Available from:

- Intent Architect 4.4.0

### Filtered searching

When searching in the `Solution Explorer` and `designer tree-view`, this trees now filter to only show matching search results.

![Filtered Search Sample](images/filter-search.png)

Available from:

- Intent Architect 4.4.0

### Add to Diagram

Diagrams in the `Service Designer` and `Domain Designer` have a new feature, `Add to Diagram` (Ctrl+Shift+A), which assists with finding and adding items onto the diagram.

![Add to Diagram Sample](images/add-to-diagram.png)

The dialog will show you all elements, which arn't currently on your diagram, which you can add to it. This list included elements in the current package as well as referenced packages.

Common use cases for this feature:

- Adding elements want to model against like:
  - Integration Messages, for Integration Subscriptions
  - Entities, for CRUD implementations
  - Domain Services, for modeling Service Operation Calls.
  - Domain Events, for Domain Event subscriptions
- Adding Custom Commands / Queries to an existing Diagram.
- Creating custom Diagrams

Available from:

- Intent Architect 4.4.0

### Solution folders

You can now group applications together by adding folders to the solution explorer.This is particularly useful is you have:

- Many Microservices
- Logically similar applications, you'd like to group together

![Solution explorer folders](images/solution-explorer-folders.png)

Available from:

- Intent Architect 4.4.0

### AutoMapper `ProjectTo` option for CRUD patterns

There is now an option to have your CRUD data queries realized using `AutoMapper`'s `ProjectTo` feature. There is a new application setting under "Domain Interaction Settings" called "Default Query Implementation" which has the following options:

- **Default**, the current CRUD implementation.
- **Project To**, CRUD queries with be implemented using `ProjectTo`.

Here is an example of `Query` implementation  using the `ProjectTo` option.

```csharp
public async Task<List<CustomerDto>> Handle(GetCustomersQuery request, CancellationToken cancellationToken)
{
    var customers = await _customerRepository.FindAllProjectToAsync<CustomerDto>(cancellationToken);
    return customers;
}
```

Available from:

- Intent.Application.AutoMapper 5.1.6
- Intent.Modelers.Services.DomainInteractions 2.0.3
- Intent.Application.MediatR.CRUD 6.0.22
- Intent.Application.ServiceImplementations.Conventions.CRUD 5.0.19

### .NET 9 support

We have added full support for .NET 9. When creating applications you can configure to target .NET 9 and all of our modules have been updated to resolve the latest NuGet packages for your targeted .NET Framework.

The current default for new applications is .NET 8 as it is the latest LTS.

### Finbuckle Multi-tenancy support for MongoDB

If you install the `Intent.Modules.AspNetCore.MultiTenancy` module with the MongoDB module, you can  now configure what type of Multi-tenancy you want to use. You can set the MongoDB Data Isolation to the following options:

- **Separate Database**, each tenant will connect to their own database.
- **None**, disable multi-tenancy.

See the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/master/Modules/Intent.Modules.MongoDb/README.md#multi-tenancy-support) for more details.

Available from:

- Intent.MongoDb 1.0.18
- Intent.Modules.AspNetCore.MultiTenancy 5.1.5

### Finbuckle Multi-tenancy support for Google Cloud Storage

If you install the `Intent.Modules.AspNetCore.MultiTenancy` module with the Google Cloud Storage module, you can  now configure what type of Multi-tenancy you want to use. You can set the Google Cloud Storage Data Isolation to the following options:

- **Separate Storage Account**, each tenant will connect to their own storage account.
- **None**, disable multi-tenancy.

See the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Google.CloudStorage/README.md#multitenancy-support) for more details.

Available from:

- Intent.Google.CloudStorage 1.0.0-beta.4
- Intent.Modules.AspNetCore.MultiTenancy 5.1.5

### Service Designer authorization improvements

Various improvements have been made around defining authorization within the services designer.

#### Consolidation of security related designer concepts into single `Intent.Metadata.Security` module

The `Secured`, `Unsecured` stereotypes and security related designer settings have been moved from the `Intent.Metadata.WebApi` module to a new `Intent.Metadata.Security` module. This new module will automatically be installed on updating to the latest version `Intent.Metadata.WebApi`.

This has allowed us to remove the separate `Authorize` stereotype for CQRS operations as it was previously impossible to use the existing `Secured` and `Unsecured` stereotypes without adding a dependency to `Intent.Metadata.WebApi`. Any existing `Authorize` stereotypes applied will be automatically converted to `Secured` stereotypes.

#### Apply multiple `Secured` stereotypes

It is now possible to apply multiple `Secured` stereotypes to `Services`, `Operations`, `Commands` and `Queries`. When multiple `Secured` stereotypes are applied they are treated as all needing to have their security requirements fulfilled while for a specific `Secured` stereotype if there are multiple policies or roles applied, only a single one of them has to be fulfilled. Overall this gives more flexibility in representing certain security requirements.

#### Apply the `Secured` to a Service package

It is now possible to apply `Secured` or `Unsecured` stereotypes to a Services package within the Services package which will apply security requirements (such as policies and/or roles) to all Service Operations, Commands or Queries within that package.

Available from:

- Intent.Application.MediatR 4.3.0
- Intent.Application.MediatR.Behaviours 4.3.0
- Intent.AspNetCore.Controllers 7.0.0
- Intent.AspNetCore.Controllers.Dispatch.MediatR 6.0.0
- Intent.HotChocolate.GraphQL 5.0.0
- Intent.HotChocolate.GraphQL.AspNetCore 6.0.0
- Intent.HotChocolate.GraphQL.AzureFunctions 2.0.0
- Intent.HotChocolate.GraphQL.Dispatch.MediatR 2.0.0
- Intent.HotChocolate.GraphQL.Dispatch.Services 2.0.0
- Intent.Metadata.WebApi 4.6.4
- Intent.Metadata.Security Intent.Metadata.Security 1.0.0

### ASP.NET Core MVC Module

View stubs and basic MVC controllers can now be generated for, and which dispatch to, Services in the Service designer.

To get started with the module simply right-click a Service in the Services Designer and select the _Expose with MVC_ option:

![Expose with MVC menu option](images/expose-with-mcv-option.png)

Once exposed, various settings can be configured for particular operations:

![Example of MVC settings](images/mvc-settings-example-1.png)

![Example of MVC settings](images/mvc-settings-example-2.png)

See the [README](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.AspNetCore.Mvc/README.md) for more information.

Available from:

- Intent.AspNetCore.Mvc 1.0.0-beta.2

### Multi-tenancy Route Strategy

When configuring multi-tenancy settings, `Route` is now as strategy option, as well as the `parameter` name to use as the tenant:

![Route strategy](images/route-strategy.png)
![Route parameter](images/route-parameter.png)

The `route parameter` specified can then be used as a valid placeholder when defining an HTTP route:

![Route parameter](images/route-placeholder.png)

Available from:

- Intent.Modules.AspNetCore.MultiTenancy 5.1.5

### Custom Swagger Examples

An `OpenAPI Settings` stereotype is now available to manually be applied to `DTO Field`s and `parameters`.

The value entered for `Example Value` will reflect in the OpenAPI specification and on the Swagger UI.

![Example value](images/swagger-example-value.png)

Available from:

- Intent.Modules.Metadata.WebApi - 4.6.4
- Intent.Application.Dtos - 4.4.3
- Intent.Application.MediatR - 4.3.0
- Intent.AspNetCore.Controllers - 7.0.0
- Intent.AspNetCore.Controllers.Dispatch.MediatR - 6.0.0
