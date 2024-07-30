# What's new in Intent Architect (September 2024)

Welcome to the September 2024 edition of highlights of What's New in Intent Architect.

- Highlights

- More updates
  - **[Map CQRS Operations and Application Services to Repository Operations](#map-cqrs-operations-and-application-services-to-repository-operations)** - Add bespoke Operations on Repositories in the Domain designer and invoke them from Services using mappings in the Services designer.
  - **[Razor Code Management](#razor-code-management)** - "Code Management" capabilities for `.razor` files for intelligent and powerful code merging between existing and generated content.

## Update details

### Map CQRS Operations and Application Services to Repository Operations

Add Operations on Repositories in the Domain designer and invoke them from Services using mappings in the Services designer.

Example Repository with Operation:

![Example Domain](images/repository-operation-mapping-domain.png)

Example Command:

![Example Command](images/repository-operation-mapping-command-menu.png)

Example invocation from Command to Repository Operation:

![Mapping between Command and Repository](images/repository-operation-mapping-service-invocation.png)

![Data Mapping](images/repository-operation-mapping-invocaiton-mapping.png)

Available from:

- Intent.Modelers.Services.DomainInteractions 1.1.4

Ensure you are using at least the versions of the following modules (if you have them installed):

- Intent.Application.MediatR.CRUD 6.0.12
- Intent.Application.ServiceImplementations.Conventions.CRUD 5.0.9

### Razor Code Management

[Code Management / Merging](xref:application-development.code-management.about-code-management) capabilities for `.razor` files for intelligent and powerful code merging between existing and generated content.

For more information, refer to [this](xref:application-development.code-weaving-and-generation.about-code-management-razor) Docs article.

Available from:

- Intent.Code.Weaving.Razor 1.0.0-beta.0
