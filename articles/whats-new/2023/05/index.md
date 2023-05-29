# May 2023

Welcome to the May 2023 edition of highlights of What's New with Intent Architect.

- Product updates
  - **[Intent Architect 4.0.0 is live](#intent-architect-400-is-live)**
- Module updates (C#)
  - **[`IReadOnlyCollection` support for "private setter" Domain Entities](#ireadonlycollection-support-for-private-setter-domain-entities)** - Make entity collections immutable except from within the same class.
  - **[`async` and `CancellationToken` support in more places](#async-and-cancellationtoken-support-in-more-places)** - Domain operations, domain services and normal services now now support `async` and `CancellationToken`s.
  - **[Stored Procedure support for EF Core](#stored-procedure-support-for-ef-core)** - It's now possible to have methods generated on repositories for using stored procedures.

## Product updates

### Intent Architect 4.0.0 is live

Intent Architect v4 is now live and available for [download](https://intentarchitect.com/#/downloads). V4 introduces tabs, a solution explorer and many other improvements, click [here](xref:release-notes.intent-architect-v4.0#version-400) for the full release notes.

> [!Video https://www.youtube.com/embed/xAiYWoImpSU]

## Module updates (C#)

### `IReadOnlyCollection` support for "private setter" Domain Entities

It was already possible to enable `Private Setters` for domain entities, but collection properties were previously exposed as mutable `ICollection<T>`s. Now enabling `Private Setters` will change `ICollection<T>` properties to instead be `IReadOnlyCollection<T>` properties with a backing `private` field of type `List<T>`.

This is to help developers adhere to the DDD principle that mutation of properties of domain entities should be impossible except through methods on the entity which ensures that business rules and consistency is maintained.

Available from:

- Intent.Entities 4.3.0.

### `async` and `CancellationToken` support in more places

- Application services (as modelled in the `Services` designer) now have a `CancellationToken cancellationToken = default` parameter and which is also populated as an argument when dispatched to from controllers.
- Appending `Async` to an operation on class or domain service will now also make the method asynchronous and have a `CancellationToken cancellationToken = default` parameter added.

Available from:

- Intent.Application.Contracts 5.0.1-pre.0
- Intent.Application.ServiceImplementations 4.2.1-pre.0
- Intent.AspNetCore.Controllers.Dispatch.ServiceContract 5.1.1-pre.0
- Intent.Entities 4.3.1-pre.1

### Stored Procedure support for EF Core

It's now possible to have methods generated on repositories for using stored procedures:

- Create a `Repository` in the Domain Designer (either in the package root or a folder).
- You can optionally set the "type" of the repository to a `Class` which will extend the existing repository which is already generated for it, otherwise if no "type" is   specified a new Repository is generated.
- On a repository you can create `Stored Procedure`s.
- At this time, the module supports a Stored Procedure returning: nothing, an existing `Class` or a `Data Contract` (`Domain Object`).
- The Software Factory will generate methods on the Repositories for calling the Stored Procedures.

Available from:

- Intent.EntityFrameworkCore.Repositories 4.2.2-pre.1
