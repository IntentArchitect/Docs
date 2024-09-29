# What's new in Intent Architect (October 2024)

Welcome to the October 2024 edition of highlights of What's New in Intent Architect.

- Highlights

- More updates
  - **[Map CQRS Operations and Application Services to Repository Operations](#map-cqrs-operations-and-application-services-to-repository-operations)** - Add bespoke Operations on Repositories in the Domain designer and invoke them from Services using mappings in the Services designer.
  - **[CosmosDB Module Enums stored as String](#cosmosdb-module-enums-stored-as-string)** - CosmosDB module now allows Enums to be stored as strings in your documents.

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

### CosmosDB Module Enums stored as String

CosmosDB module now allows Enums to be stored as strings in your documents.

You can switch this on with the "Store enums as string" setting.

![Store Enums As String Setting](images/store-enum-as-string-setting.png)

The Document's that represent Entities in the Infrastructure layer will then decorate the Enum Properties with a `JsonConverter` attribute when the setting is switched on.

```c#
[JsonConverter(typeof(EnumJsonConverter))]
public EnumExample EnumExample { get; set; }
```

This will allow Enums to be persisted in CosmosDB as `strings` however it is also durable in that it can also parse Enums in their `int` representations allowing for backward compatibility.

Available from:

- Intent.CosmosDB 1.2.4

