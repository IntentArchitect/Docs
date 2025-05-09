---
uid: application-development.code-weaving-and-generation.about-code-management-razor
---
# Razor Code Management

This article explains how to control [Code Management / Merging](xref:application-development.code-management.about-code-management) behaviour for `.razor` files when using the `Intent.Code.Weaving.Razor` module.

## Overview of how it works

The Razor Merger parses `.razor` files into an [abstract syntax tree](https://en.wikipedia.org/wiki/Abstract_syntax_tree) and applies code management logic on a node-by-node basis. An individual node on the _abstract syntax tree_ is referred to as a _syntax node_. _Syntax nodes_ may have one or more children which are also _syntax nodes_.

The Razor Merger compares the generated content from the template with the existing file (if there is one) on a node-by-node basis. Instructions are used by the Razor Merger for it to determine for a particular syntax node what content it should ignore, replace with content generated by the template or perhaps remove entirely.

## Code management instructions

Instructing the Razor Merger on how to treat particular syntax nodes is done using code management instructions in your source code, within Razor syntax, these are instructions like `@Intent.Ignore` above elements.

Within `@codeblock` directives, the Razor Merger is delegating to the RoslynWeaver, please refer to its [article](xref:application-development.code-weaving-and-generation.about-code-management-csharp) for information on controlling C# Code management behaviour.

## Management modes

- **`@Intent.Fully`** - Intent has full control over the particular syntax node, any deviations in the existing file's syntax node are overwritten with the content generated by the template. Descendant syntax nodes can be opted-out of being fully managed having an `@Intent.<mode>` instruction applied to them.
- **`@Intent.Merge`** - Intent will add and remove Intent generated code for the syntax node but will never remove code which was manually added.
- **`@Intent.Ignore`** - Intent must ignore this syntax node and not remove or overwrite it with content generated by the template. Code management instructions on descendant syntax nodes are likewise ignored, i.e. it is not possible to opt-out of being ignored as a descendant.

Each of the above can be suffixed with the following:

- **`Body`** - Override only the body mode behaviour of the syntax node, generally body refers to inner syntax nodes or the content of a syntax node.
- **`Signature`** - Override only the signature mode behaviour of the syntax node, generally this refers to aspects like HTML element / Directive attributes of a syntax node.

If you want to manage specific attributes:

- **`@Intent.FullyAttributes("attribute1", "attribute2", ...)`** - Fully manages the specified attributes.
- **`@Intent.MergeAttributes("attribute1", "attribute2", ...)`** - Separates the value of the attribute by space and will merge them. By default `class` attributes are in merge mode.
- **`@Intent.IgnoreAttributes("attribute1", "attribute2", ...)`** - Ignores the specified attributes.

For example:

```razor
@Intent.Fully
@Intent.IgnoreAttributes("class")
<div class="content-block">
    content
</div>
```

In the above the `class` attribute will be ignored, but not the content.

Management modes and their suffixes can be combined, for example:

```razor
@Intent.Fully
@Intent.IgnoreBody
<div class="content-block">
    content
</div>
```

In the above, the `<div>` will be "Fully" controlled, while its body mode is overridden to be ignored, i.e. the Razor Merger should always update the attributes to match that generated by the template, but it should never update its body ("content" in this case).

With some Razor Components placing Razor expressions within them will cause a compilation error. In such cases the instructions can be placed in Razor comments, for example:

```razor
@* @Intent.Fully *@
@* @Intent.IgnoreBody *@
<div class="content-block">
    content
</div>
```

Or alternatively:

```razor
@* Intent.Fully *@
@* Intent.IgnoreBody *@
<div class="content-block">
    content
</div>
```

## Default code management behaviour

By default, templates are in `Merge` mode. This default can be changed in the [settings](xref:module-building.application-settings) for your application:

![Razor Merger Settings](images/razor-merger-settings.png)

## Syntax node matching

The Razor Merger applies a heuristic to try "match" syntax nodes in your "existing" file with a corresponding syntax node generated by the template it is merging with.

### Matching by identity

There are cases where syntax nodes can't be easily differentiated and the Merger's default match may not be correct, this is particularly common with HTML Elements and Directives which appear numerous times within the same parent syntax node or root of the document. In such cases, an "identity" can be assigned to the syntax node which will force the Razor Merger to correlate the Syntax Node only with syntax nodes with a matching identity.

An "identity" can be assigned to a syntax node using any of the following ways:

- **An `id="<identity>"` HTML element attribute** - As this is a default attribute for HTML element it can be a "natural" identifier to use on elements if it's present.
- **An `intent-id="<identity>"` HTML element attribute** - This takes precedence over the `id` HTML element attribute and is useful for scenarios an HTML element's `id` is not "stable", i.e. if it's expected that the template output's `id` may change based on other factors.
- **An `@Intent.Id("<identity>")` or `@* @Intent.Id("<identity>") *@` or `@* Intent.Id("<identity>") *@` instruction above the syntax node** - This takes precedence over both of the HTML element attributes and was created with Directives in mind as trying to apply unknown attributes to them causes a compilation error.

### Matching by other attribute types

If a syntax node doesn't have an identifier, a match is performed in order by the following attributes:

- `@bind-Value`
- `@bind`
- `Value`

### Component specific attribute matching configuration

Module authors can configure matching behaviour for particular element/component tag names by using the `ConfigureRazor` extension method on any instance of `ISoftwareFactoryExecutionContext`.

> [!TIP]
>
> The `IApplication` interface and the `ExecutionContext` property on template base types are two common places which are `ISoftwareFactoryExecutionContext` and this extension method can be used.

The extension method takes an `Action<IRazorConfigurator>` argument which allows fluent style configuration to occur. The following methods are available:

- **AllowMatchByTagNameOnly** - Adds an item to the Razor Weaver's list of element/directive tag names which may be matched by tag name alone rather than requiring content also be matched.
- **AddTagNameAttributeMatch** - Adds an entry to the Razor Weaver's list of attributes for a tag name which can be used to find matches of elements/directives between existing and generated files.

> [!NOTE]
>
> This extension method is only available from version `3.8.7` and later of the `Intent.Common.CSharp` module and corresponding `Intent.Modules.Common.CSharp` NuGet package.

Example from a template:

```csharp
public override void AfterTemplateRegistration()
{
    ExecutionContext.ConfigureRazor(configurator =>
    {
        configurator.AllowMatchByTagNameOnly("MudDialogProvider");
        configurator.AddTagNameAttributeMatch("MudDatePicker", "@bind-Date");
    });
}
```

Example from a factory extension:

```csharp
protected override void OnAfterTemplateRegistrations(IApplication application)
{
    application.ConfigureRazor(configurator =>
    {
        configurator.AllowMatchByTagNameOnly("MudDialogProvider");
        configurator.AddTagNameAttributeMatch("MudDatePicker", "@bind-Date");
    });
}
```
