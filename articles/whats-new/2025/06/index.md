# What's new in Intent Architect (June 2025)

Welcome to the June 2025 edition of highlights of What's New in Intent Architect. Here's a roundup of the latest updates and improvements.

- Highlights
  - **[Entity Framework OData Module](#entity-framework-odata-module)** - This module enables you to expose `Entity`'s as OData endpoints.
  - **[Diff Audit Module](#diff-audit-module)** - This module adds functionality to allow you to audit an `Entity`.

- More updates
  - **[PostgreSQL Stored Procedure Support](#postgresql-stored-procedure-support)** - Stored Procedure support has been added for PostgreSQL Entity Framework database provider type.
  - **[Updated IdentityModel and IdentityModel.AspNetCore packages](#updated-identitymodel-and-identitymodelaspnetcore-packages)** - Updated IdentityModel and Identity.AspNetCore.


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

### PostgreSQL Stored Procedure Support

Added support for PostgreSQL Stored Procedures.

In the `Domain Designer` you are now able to model `Stored Procedures` that will be executed against a PostgreSQL database provider using Entity Framework Core.

To learn more, read the [module documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-entityframeworkcore-repositories/intent-entityframeworkcore-repositories.html).

Available from:

- Intent.EntityFrameworkCore.Repositories 4.7.9

### Updated IdentityModel and IdentityModel.AspNetCore Packages

These packages have been updated with the Duende equivalents. This does introduce a breaking change. If you are upgrading this module, please ensure to populate the `TokenEndpoint` with the same value as your `Address` within your configuration files.

Available from:

- Intent.Security.JWT 4.2.8
- Intent.Security.MSAL 4.2.8
- Intent.Integration.HttpClients 6.0.0
- Intent.AspNetCore.Identity.AccountController 4.1.4