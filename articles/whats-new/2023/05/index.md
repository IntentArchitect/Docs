# May 2023

Welcome to the May 2023 edition of highlights of What's New with Intent Architect.

- Product updates
  - **[Intent Architect 4.0.0 is live](#intent-architect-400-is-live)**
- Module updates (C#)
  - **[`IReadOnlyCollection` support for "private setter" Domain Entities](#ireadonlycollection-support-for-private-setter-domain-entities)** - Make entity collections immutable except from within the same class.

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
