# November 2023

Welcome to the November 2023 edition of highlights of What's New with Intent Architect.

- Highlights
- More updates
  - **[.NET 8 support](#net-8-support)** - All modules have been updated to support .NET 8.
  - **[CRUD Implementations using DbContext](#crud-implementations-using-dbcontext)** - The ability to have your CRUD implementation use the DbContext rather than the repository pattern .
  - **[OData Query support](#odata-query-support)** - Leverage OData query functionality on your ASP.Net Core controllers .
  - **[AutoMapper Projection support on EF repositories](#automapper-projection-support-on-ef-repositories)** - Added support to leverage AutoMapper Projections on our EF repository pattern .
  - **[EF repository enhancements](#ef-repository-enhancements)** - Added several overloads to EF repositories to make generic LINQ features more available.
  - **[EF Bulk Operations module](#ef-bulk-operations-module)** - Extends EF repositories to support Bulk Operations.
  - **[AutoMapper version upgrade](#automapper-version-upgrade)** - Upgraded various AutoMapper dependencies to the latest version.
  - **[Synchronous method support on EF repositories ](#synchronous-method-support-on-ef-repositories)** - You can optionally add synchronous repository method overloads through an application setting.
  - **[Email Address Validation](#email-address-validation)** - "Email Address" checkbox property added to the "Validation" stereotype.

## Update details

### .NET 8 support

Final support for Intent Architect's modules for .NET 8 has been added, this includes auto upgrading of NuGet packages to their .NET 8 versions.

> [!NOTE]
> Intent Architect will need to be upgraded to the 4.1.0 beta or greater before the following modules will be visible.

Available from:

- Intent.Application.DependencyInjection 4.0.7
- Intent.Application.MediatR.Behaviours 4.2.7
- Intent.Modules.AspNetCore.Docker 3.3.9
- Intent.AspNetCore.HealthChecks 2.0.0
- Intent.AspNetCore.Identity.AccountController 3.0.1
- Intent.AspNetCore.Identity 4.0.8
- Intent.Modules.AspNetCore.MultiTenancy 5.1.0
- Intent.AspNetCore.Versioning 1.0.4
- Intent.EntityFrameworkCore.DesignTimeDbContextFactory 4.0.7
- Intent.EntityFrameworkCore 4.4.16
- Intent.Eventing.GoogleCloud.PubSub 1.0.6
- Intent.IdentityServer4.Identity.EFCore 4.0.6
- Intent.Infrastructure.DependencyInjection 4.0.8
- Intent.Security.JWT 4.1.7
- Intent.Security.MSAL 4.1.7
- Intent.VisualStudio.Projects 3.5.0

### CRUD Implementations using DbContext

To Do

> [!NOTE]
> Intent Architect will need to be upgraded to the 4.1.0 beta or greater for this feature.

### OData Query support

This modules adds OData Query support to your CQRS paradigm service end points, specifically `Query`s.

![OData Modeling](images/odata-designer.png)

For more detail, refer to the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.AspNetCore.ODataQuery/README.md).

Available from:

- Intent.AspNetCore.ODataQuery 1.0.0-beta.*

### AutoMapper Projection support on EF repositories

The AutoMapper not add Projection support to the Entity Framework Core Repository's.
The following methods will query the relevant `Entity` and the use AutoMapper->ProjectTo functionality to materialize the results.

![Project To](images/odata-designer.png)

Available from:

- Intent.Application.AutoMapper 5.0.0

### EF repository enhancements

Added several overloads to EF repositories to make generic LINQ features easier to express, for example OrderBy, Include, etc.

![Repository Enhancements](images/repository-enhancments.png)

Available from:

- Intent.EntityFrameworkCore.Repositories 4.3.0

### EF Bulk Operations module

This module provides patterns for doing Bulk data operation with Entity Framework Core using the `EFCore BulkExtensions`.

For more detail, refer to the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.EntityFrameworkCore.BulkOperations/README.md).

Available from:

- Intent.EntityFrameworkCore.BulkOperations 1.0.0-beta.*

### AutoMapper version upgrade

Upgrades AutoMapper modules to the latest NuGet packages.

Available from:

- Intent.Application.AutoMapper 5.0.0
- Intent.Application.DependencyInjection.AutoMapper 4.0.0

### Synchronous method support on EF repositories

Added support for Synchronous versions of EF repository methods. This option is off by default but can be opted into through application settings, `Database Settings -> Add synchronous methods to repositories`.

Available from:

- Intent.EntityFrameworkCore.Repositories 4.3.0

### Email Address Validation

An "Email Address" checkbox property has been added to the "Validation" stereotype, when checked it applies the [Email Validator](https://docs.fluentvalidation.net/en/latest/built-in-validators.html#email-validator) in FluentValidation modules and the [EmailAddressAttribute](https://learn.microsoft.com/dotnet/api/system.componentmodel.dataannotations.emailaddressattribute) in DataAnnotations modules.

Available from:

- Intent.Application.FluentValidation 3.8.3
- Intent.Application.FluentValidation.Dtos 3.7.1
- Intent.Application.MediatR.FluentValidation 4.4.2
- Intent.Blazor.HttpClients.Dtos.DataAnnotations 1.0.1
- Intent.Blazor.HttpClients.Dtos.FluentValidation 1.0.1

