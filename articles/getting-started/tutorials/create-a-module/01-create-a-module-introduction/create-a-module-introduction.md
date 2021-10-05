---
uid: tutorials.create-a-module.introduction
---
# Tutorial: Create a Module

This tutorial will walk you through creating an Intent Architect [Module](xref:references.modules).

## What is Intent Architect?

Intent Architect is a non-prescriptive, integrated, architecture-design platform that combines together the power of visual modeling, code-management and pattern-reuse to help software development teams build enterprise-grade, scalable applications at lightning speed.

## What is a Module?

Modules are distributable artifacts which are the _building blocks_ of pattern reuse in Intent Architect.

Typically, the purpose of a Module is to generate and manage a set of code files in a codebase, usually around a particular architectural pattern. This could for example be the entities in our domain, simple bootstrapping files, ORM mappings, controllers in our Api, etc.

Modules have similarities with package systems such as NuGet, NPM, and Maven. However, where the primary objective of these systems is to facilitate code-reuse, the primary objective of Modules is to facilitate _pattern-reuse_.

## Prerequisites

- Ensure Intent Architect has been [installed](xref:getting-started.get-the-application).
- The latest [Microsoft Visual Studio for Windows/Mac](https://visualstudio.microsoft.com/), [JetBrains Rider](https://www.jetbrains.com/rider/download/) or any other IDE capable of working with .NET Core projects and able to pre-compile `.tt` files.
- Recommended: If you're using Visual Studio 2019 for Windows, we recommend installing an extension to add syntax highlighting support for `.tt` files, such as [tangible T4 Editor](https://t4-editor.tangible-engineering.com/T4-Editor-Visual-T4-Editing.html).

## Next Steps

### [Create a simple module](xref:tutorials.create-a-module.create-a-simple-module)

Create a Module using the Intent Module Builder with a simple Template that generates and manages a single file.
