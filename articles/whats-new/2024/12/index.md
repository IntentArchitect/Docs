# What's new in Intent Architect (December 2024)

Welcome to the December 2024 edition of highlights of What's New in Intent Architect.

- Highlights
  - **[SonarQube Analysis](#sonarqube-module)** - Provides real-time code quality analysis and feedback on the quality, readability and complexity of the code using [SonarQube](https://www.sonarsource.com/products/sonarlint/)
  - **[Multi-tenancy Route Strategy](#multi-tenancy-route-strategy)** - In a multi-tenancy application, determine the tenant from a route parameter.
  - **[Service Designer authorization improvements](#service-designer-authorization-improvements)** - New Security module, consolidation of security stereotypes and additional authorization requirements can now be represented.
  - **[ASP.NET Core MVC Module](#aspnet-core-mvc-module)** - View stubs and basic MVC controllers can now be generated for, and which dispatch to, Services in the Service designer.
  - **[Azure Functions upgradeable to Isolated Processes for .NET 8](#azure-functions-upgradeable-to-isolated-processes-for-net-8)** - Azure Functions for Isolated Processes are now accessible in Intent Architect.

## Update details

### SonarQube Module

This module installs the SonarQube IDE linter into your application, providing real-time code quality analysis and feedback on the quality, readability and complexity of the code.

An example of some warnings raised by SonarQube (as well as other analysis tools):

![SonarQube warning](images/sonarqube-warnings.png)

### Multi-tenancy Route Strategy

When configuring multi-tenancy settings, `Route` is now as strategy option, as well as the `parameter` name to use as the tenant:

![Route strategy](images/route-strategy.png)
![Route parameter](images/route-parameter.png)

The `route parameter` specified can then be used as a valid placeholder when defining an HTTP route:

![Route parameter](images/route-placeholder.png)

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

- Intent.Application.MediatR 4.3.0-pre.0
- Intent.Application.MediatR.Behaviours 4.3.0-pre.0
- Intent.AspNetCore.Controllers 7.0.0-pre.0
- Intent.AspNetCore.Controllers.Dispatch.MediatR 6.0.0-pre.0
- Intent.HotChocolate.GraphQL 5.0.0-pre.0
- Intent.HotChocolate.GraphQL.AspNetCore 6.0.0-pre.0
- Intent.HotChocolate.GraphQL.AzureFunctions 2.0.0-pre.0
- Intent.HotChocolate.GraphQL.Dispatch.MediatR 2.0.0-pre.0
- Intent.HotChocolate.GraphQL.Dispatch.Services 2.0.0-pre.0
- Intent.Metadata.WebApi 4.6.4-pre.0
- Intent.Metadata.Security Intent.Metadata.Security 1.0.0-pre.0

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

### Azure Functions upgradeable to Isolated Processes for .NET 8

Azure Functions for Isolated Processes are now accessible by configuring your API project to target .NET 8 and setting the Output Type to `Console` in the Visual Studio designer.

To learn about migrating existing Azure Functions from .NET 6 In-Process to .NET 8 Isolated Processes, [click here](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.AzureFunctions/README.md#migrating-from-in-process-functions).

Available from:

- Intent.AzureFunctions 5.0.1-pre.2
