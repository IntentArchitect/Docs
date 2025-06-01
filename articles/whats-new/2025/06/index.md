# What's new in Intent Architect (June 2025)

Welcome to the June 2025 edition of highlights of What's New in Intent Architect. Here's a roundup of the latest updates and improvements.

- Highlights
  - **[Entity Framework OData Module](#entity-framework-odata-module)** - This module enables you to expose `Entity`'s as OData endpoints.
  - **[Diff Audit Module](#diff-audit-module)** - This module adds functionality to model differential auditing on an `Entity`.

- More updates
  - **[AutoMapper option for separating Profiles from DTOs](#automapper-option-for-separating-profiles-from-dtos)** - As AutoMapper `Profile`s and DTO have very different dependencies it is often better to have these as seperate files.
  - **[PostgreSQL Stored Procedure Support](#postgresql-stored-procedure-support)** - Stored Procedure support has been added for PostgreSQL Entity Framework database provider type.
  - **[Improved VS Solution modeling options](#improved-vs-solution-modeling-options)** - Improvements in the VS Designer.
  - **[Replaced IdentityModel and IdentityModel.AspNetCore NuGet packages](#updated-identitymodel-and-identitymodelaspnetcore-packages)** - Upgraded dependencies on `IdentityModel` and `Identity.AspNetCore` NuGet packages, to newer alternatives.
  - **[EntityFramework.Application.LinqExtensions module](#entityframeworkapplicationlinqextensions-module)** - This modules adds `AsTracking` and `AsNoTracking` Linq Extensions methods for convenience with out the direct dependency on EF Core.


## Update details

### Entity Framework OData Module

This module enables you to expose `Entity`'s as OData endpoints.

![Expose as OData](images/entityframework-expose-as-odata.png)

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-aspnetcore-odata-entityframework/intent-aspnetcore-odata-entityframework.html).

Available from:

- Intent.AspNetCore.OData.EntityFramework 1.0.1

### Diff Audit Module

This module adds functionality to allow you to audit an `Entity`.

All state changes with be auditted on a property level. These audit entries will be stored in a audit table within your Entity Framework database provider.

![Diff Audit](images/entityframework-diffaudit.png)

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-entityframeworkcore-diffaudit/intent-entityframeworkcore-diffaudit.html).

Available from:

- Intent.EntityFrameworkCore.DiffAudit 1.0.1

### AutoMapper option for separating Profiles from DTOs

There now a configuration application setting under `AutoMapper Settings` named **Proflie Location**, the options are as follows:

- Profile in Dto, the existing pattern where `Profile`'s existing in the corresponding **Dto** file.
- Profile Separate from Dto, `Profile`s are no in their own files, in a `Mappings` folder by default. Profiles are still per Dto.

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-application-automapper/intent-application-automapper.html#profile-location).

Available from:

- Intent.Application.AutoMapper 5.2.1

### PostgreSQL Stored Procedure Support

Added support for PostgreSQL Stored Procedures.

In the `Domain Designer` you are now able to model `Stored Procedures` that will be executed against a PostgreSQL database provider using Entity Framework Core.

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-entityframeworkcore-repositories/intent-entityframeworkcore-repositories.html).

Available from:

- Intent.EntityFrameworkCore.Repositories 4.7.9
 
### Improved VS Solution modeling options

You can now explicitly configure the following:

- VS Solutions name, as opposed to defaulting to the package name.
- Specify a relative location for the VS Solution, easily move the solution file or shared a solution between applications.

You can also choose to have solution folder realized as actual folders in your VS Solution using the `Folder Options` stereotype and checking `Materialize Folder`.

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-visualstudio-projects/intent-visualstudio-projects.html#the-visual-studio-solution-options-stereotype).

Available from:

- Intent.VisualStudio.Projects  3.8.12

### Updated IdentityModel and IdentityModel.AspNetCore Packages

These unlisted NuGet packages have been updated with the relevant Duende equivalents. This does introduce a breaking change. If you are upgrading this module, please ensure to populate the `TokenEndpoint` with the same value as your `Address` within your 'appsettings.json' configuration files.

Available from:

- Intent.Security.JWT 4.2.8
- Intent.Security.MSAL 4.2.8
- Intent.Integration.HttpClients 6.0.0
- Intent.AspNetCore.Identity.AccountController 4.1.4

### EntityFramework.Application.LinqExtensions module

Adds helper Linq Extension methods for EF which can be used as follows:

```csharp
var customers = await _customerRepository.FindAllAsync(o => o.AsNoTracking(), cancellationToken);
```

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-entityframework-application-linqextensions/intent-entityframework-application-linqextensions.html).

Available from:

- Intent.EntityFramework.Application.LinqExtensions 1.0.0
