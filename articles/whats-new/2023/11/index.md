# November 2023

Welcome to the November 2023 edition of highlights of What's New with Intent Architect.

- Highlights
- More updates
  - **[Email Address Validation](#email-address-validation)** - "Email Address" checkbox property added to the "Validation" stereotype.
  - **[.NET 8 support](#net-8-support)** - All modules have been updated to support .NET 8.

## Update details

### Email Address Validation

An "Email Address" checkbox property has been added to the "Validation" stereotype, when checked it applies the [Email Validator](https://docs.fluentvalidation.net/en/latest/built-in-validators.html#email-validator) in FluentValidation modules and the [EmailAddressAttribute](https://learn.microsoft.com/dotnet/api/system.componentmodel.dataannotations.emailaddressattribute) in DataAnnotations modules.

Available from:

- Intent.Application.FluentValidation 3.8.3
- Intent.Application.FluentValidation.Dtos 3.7.1
- Intent.Application.MediatR.FluentValidation 4.4.2
- Intent.Blazor.HttpClients.Dtos.DataAnnotations 1.0.1
- Intent.Blazor.HttpClients.Dtos.FluentValidation 1.0.1

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
