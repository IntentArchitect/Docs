---
uid: module-building.tutorials.create-a-module.introduction
---
# Tutorial: Create a Module

This tutorial will walk you through creating an Intent Architect [Module](xref:application-development.applications-and-solutions.about-modules).

## What is Intent Architect?

Intent Architect is a non-prescriptive, integrated, architecture-design platform that combines the power of visual modeling, code-management, and pattern-reuse to help software development teams build enterprise-grade scalable applications at lightning speed.

## What is a Module?

Modules are distributable artifacts which are the _building blocks_ of pattern reuse in Intent Architect.

Typically, the purpose of a Module is to generate and manage a set of code files in a codebase, usually around a particular architectural pattern. This could, for example, be the entities in our domain, simple bootstrapping files, ORM mappings, controllers in our API, etc.

Modules have similarities with package systems such as NuGet, NPM, and Maven. However, where the primary objective of these systems is to facilitate code-reuse, the primary objective of Modules is to facilitate _pattern-reuse_.

## Module Building Process

Intent Architect allows you to make your own Modules that are used in automating your architectures and patterns quite easily. To efficiently craft those Modules requires a process that is easy to follow.

![Module Building Process](images/module-building-process.png)

### Know the pattern

Know how your architecture looks like in code before you attempt to automate it. Hand-rolling at first can be useful to understand how it is supposed to look like.

### Describe the design

Articulate how your current code should look like through a designer. Model it through a designer to get a feel for how you would like to describe it.

### Templatize

Once you’re able to describe it and you know how it is supposed to look like in code, you can begin to create your templates that will roll out any new design changes you have described in your designers.

## Prerequisites

- Ensure Intent Architect has been [installed](xref:getting-started.get-the-application).
- The latest [Microsoft Visual Studio for Windows/Mac](https://visualstudio.microsoft.com/), [JetBrains Rider](https://www.jetbrains.com/rider/download/), or any other IDE capable of working with .NET Core projects and able to pre-compile `.tt` files.
- **Recommended**: If you're using Visual Studio (for Windows), we recommend installing an extension to add syntax highlighting support for `.tt` files, such as [tangible T4 Editor](https://t4-editor.tangible-engineering.com/T4-Editor-Visual-T4-Editing.html), [devart T4 editor](https://www.devart.com/t4-editor/) or [T4Editor by Tim Maes](https://marketplace.visualstudio.com/items?itemName=TimMaes.t4editor).

## Next Steps

### [Create a simple module](xref:module-building.tutorials.create-a-module.create-a-simple-module)

Create a Module using the Intent Module Builder with a simple Template that generates and manages a single file.
