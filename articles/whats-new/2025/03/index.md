# What's new in Intent Architect (March 2025)

Welcome to the March 2025  edition of highlights of What's New in Intent Architect.

- Highlights
  - **[Improved HTTP Route Heuristics](#improved-http-route-heuristics)** - An update to the heuristic used to generate HTTP routes to better avoid route conflicts.

- More updates
  - **[Domain Services Registration Options](#domain-service-registration-options)** - Easily control and configure how `Domain Services` are registered with the dependency injection container.
  - **[Permission constants](#permission-constants)** - Constants are now generated and reused for modeled roles and policies.
  - **[Soft Delete pattern added to Cosmos DB](#soft-delete-pattern-added-to-cosmos-db)** - The Soft Delete functionality is now available for the CosmosDB module.

## Update details

### Improved HTTP Route Heuristics

The process of auto-generating HTTP routes has been enhanced to ensure greater relevance and reduce the likelihood of conflicts. Additionally, the handling of acronyms and initialisms has been improved for better accuracy and consistency.

An example of the previous route generation:

![Previous Generation](images/old-route.png)

Compared with the updated route generation:

![Updated Generation](images/new-route.png)

Available from:

- Intent.Metadata.WebApi 4.7.3

### Domain Service Registration Options

The global default scope for how `Domain Services` are registered can now be controlled under the `Domain Settings` settings section:

![Global scope](images/global-scope.png)

Changing the registration scope of an individual service can be done via the `Service Registration Scope` setting on the Domain Service itself:

![Service scope](images/service-scope.png)

Available from:

- Intent.DomainServices 1.1.8

### Permission Constants

Instead of using a `string literal` to define a `role` or `permission`, a constant is now automatically generated and used. This enhances code maintainability, reduces the risk of errors from typos and provides a centralized place for the permissions.

Available from:

- Intent.AspNetCore 6.0.8
- Intent.Application.MediatR 4.3.2
- Intent.AspNetCore.Controllers 7.1.1
- Intent.AspNetCore.Mvc 1.0.0-beta.4
- Intent.EntityFrameworkCore.DataMasking 1.0.0-beta.5
- Intent.FastEndpoints 1.0.1

### Soft Delete pattern added to Cosmos DB

The Soft Delete functionality that was originally on the Entity Framework Core module has been extended so that it also now is available for the CosmosDB module. Thus in the same module you have Soft Delete functionality for both Entity Framework Core and CosmosDB.

![Class with Soft Delete](images/soft-delete-class.png)

By applying the `Soft Delete Entity` stereotype on a Class, it will introduce the `ISoftDelete` interface on your Domain Entity which will also introduce these class memebers:

```c#
public bool IsDeleted { get; set; }

void ISoftDelete.SetDeleted(bool isDeleted)
{
    IsDeleted = isDeleted;
}
```

The `CosmosDBRepositoryBase` is also updated to detect those Entities for setting the `IsDeleted` upon removal and filtering based on `IsDeleted == false` when querying.

> [!NOTE]
>
> We have deprecated the `Intent.EntityFrameworkCore.SoftDelete`. If you have that module installed before, update it to version 1.0.6 which will install `Intent.Entities.SoftDelete`. You may now safely uninstall the deprecated module.

Available from:

- Intent.Entities.SoftDelete 1.0.0
