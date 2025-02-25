# What's new in Intent Architect (March 2025)

Welcome to the March 2025  edition of highlights of What's New in Intent Architect.

- Highlights
  - **[Improved HTTP Route Heuristics](#improved-http-route-heuristics)** - An update to the heuristic used to generate HTTP routes to better avoid route conflicts.
  - **[Map stored procedure invocations](#map-repository-operations-to-stored-procedures)** - Map stored procedure invocations for automated generation of CQRS and Service Operation implementations.

- More updates
  - **[Domain Services Registration Options](#domain-service-registration-options)** - Easily control and configure how `Domain Services` are registered with the dependency injection container.
  - **[Permission constants](#permission-constants)** - Constants are now generated and reused for modeled roles and policies.
  - **[Soft Delete pattern added to Cosmos DB](#soft-delete-pattern-added-to-cosmos-db)** - The Soft Delete functionality is now available for the CosmosDB module.
  - **[Improved Domain-to-DTO Field Mapping in Services Designer](#improved-domain-to-dto-field-mapping-in-services-designer)** - When mapping from the Domain Entity to a DTO, mapping fields will first try to match with existing fields before creating new ones.
  - **[204 response codes for nullable returning operations now on Swagger UI](#204-no-content-now-automatically-added-as-appropriate-to-controller-operations-for-openapi--swagger-ui)** - Generated OpenAPI specs for the Swagger UI will now automatically have `204` responses added as appropriate.
  - **[Manage particular attributes in Razor files](#manage-particular-attributes-in-razor-files)** - Control merge behaviour on an attribute-by-attribute basis for components / HTML Elements in `.razor` files.

## Update details

### Improved HTTP Route Heuristics

The process of auto-generating HTTP routes has been enhanced to ensure greater relevance and reduce the likelihood of conflicts. Additionally, the handling of acronyms and initialisms has been improved for better accuracy and consistency.

An example of the previous route generation:

![Previous Generation](images/old-route.png)

Compared with the updated route generation:

![Updated Generation](images/new-route.png)

Available from:

- Intent.Metadata.WebApi 4.7.3

### Map Repository Operations to Stored Procedures

It is now possible to map repository operations to stored procedures enabling scenarios of being able to fully generate CQRS / Service Operation implementations which invoke and return results for Stored Procedure with output parameters.

![Stored Procedure Invocation Mapping](images/stored-procedure-invocation-mapping.png)

![Stored Procedure Result Mapping](images/stored-procedure-result-mapping.png)

For more information and examples refer to the [module documentation](https://docs.intentarchitect.com/articles/modules-common/intent-modules-modelers-domain-storedprocedures/intent-modules-modelers-domain-storedprocedures.html).

Available from:

- Intent.Modules.Modelers.Domain.StoredProcedures 1.1.4
- Intent.EntityFrameworkCore.Repositories 4.7.5

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

### Improved Domain-to-DTO Field Mapping in Services Designer

When mapping from the Domain Entity to a DTO, mapping fields will first try to match with existing fields before creating new ones.

As an example, you have a predefined DTO.

![Predefined DTO](images/domain-to-dto-mapping-predefined-dto.png)

When you `Map from Domain` you can them select the Domain Entity to map from and select the Attributes you wish to map onto the DTO.

![Select attributes to map](images/domain-to-dto-mapping-map-from-domain.png)

The mapped DTO will now have the existing fields mapped because they matched by name.

![Mapped DTO](images/domain-to-dto-mapping-mapped-dto.png)

Available from:

- Intent.Modelers.Services 3.9.2

### Improved SQL Server Importer Filter File

Specify which Tables to include and which Columns to exclude using the SQL Server Importer.

The improvements include:

- Richer definition experience using a JSON file with a structure you can learn about [here](https://docs.intentarchitect.com/articles/modules-dotnet/intent-sqlserverimporter/intent-sqlserverimporter.html#import-filter-file).
- When you import you can now specify a relative file path to the file used for filtering based on the package you are importing into.
- You can specify which SQL Tables to import, which Columns to exclude.
- Specifying the Schemes to filter on has moved to this filter file.

Available from:

- Intent.SqlServerImporter 1.1.0

### `204 No Content` now automatically added as appropriate to controller operations for OpenAPI / Swagger UI

If a controller method is known to be able to return a nullable result a `[ProducesResponseType(StatusCodes.Status204NoContent)]` is now automatically added to it.

Available from:

- Intent.AspNetCore.Controllers 7.1.1

### Manage particular attributes in Razor files

It is now possible to specify on an attribute-by-attribute basis the merge behaviour on a component or HTML element, for example you can fully manage an element except for the `class` attribute as follows:

```razor
@Intent.Fully
@Intent.IgnoreAttributes("class")
<div class="content-block">
    content
</div>
```

For more information refer to [the documentation](https://docs.intentarchitect.com/articles/application-development/code-management/code-management-razor/code-management-razor.html#management-modes).

Available from:

- Intent.Code.Weaving.Razor 1.0.4
