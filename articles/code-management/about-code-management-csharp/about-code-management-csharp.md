---
uid: code-management.about-code-management-csharp
---
# About Code Management (C#)

This article provides information about [Code Management](xref:code-management.about-code-management) done in a C# context using the `Intent.OutputManager.RoslynWeaver` Module.

## Introduction

In C# files it is quite common to notice this line of code near the top of the file:

```csharp
[assembly: DefaultIntentManaged(Mode.Fully)]
```

This attribute is located on a global scope which indicates that it will instruct Intent Architect to treat the whole file according to the configuration mode of `Fully` (in this case).

`Mode` comes with three configuration options:

* `Fully` - It has **full** control over the file for Code Automation (like typical Code Automation).
* `Merge` - It may only make modifications and additions to this file but it's not allowed to remove anything.
* `Ignore` - It has **no** control over the file and will not generate or overwrite anything in it.

> [!NOTE]
> Comments that are made by the developer (not the Code Automation) outside the scope of a `namespace` will not be modified in any way even if `Mode` is set to `Fully`.

## Override different parts using `[IntentManaged]`

Within a C# source file, one may choose to override certain behaviour of how Intent Architect performs code automation by inserting a `[IntentManaged]` attribute right above a class, property, field or method (or various other language elements).

For example, adding this attribute above a method will look something like this:

```csharp
[IntentManaged(Mode.Ignore)]
public void ChangeCountry(string country)
{
    throw new NotImplementedException();
}
```

It will instruct Intent Architect not to modify (or remove) this method in any way during the Software Factory Execution.

This attribute does have additional properties of configuration which gives a developer finer grain of control. Below can be seen the attribute written in C# in its entirety, followed by more in depth descriptions of what each piece does (for this example within the context of a method).

```csharp
[IntentManaged(Mode.Merge, Body = Mode.Ignore, Signature = Mode.Fully, Comments = Mode.Fully, Attributes = Mode.Fully)]
```
> [!NOTE]
> The `Mode` configuration works exactly the same as with the `DefaultIntentManaged` attribute, except that the scope is now on a method level and not a file level.

| Component       | Mandatory | Description                                                                                                                                                         |
|-----------------|-----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| First parameter | Yes       | Base setting which targets the entire method (including the method name, parameter list, attributes, comments and method body).                                     |
| Body            | No        | Overrides the base setting in order for the method body to be overwritten by Intent Architect or not.                                                               |
| Signature       | No        | Overrides the base setting in order for the method name, parameter list, attributes and comments to be overwritten by Intent Architect or not.                      |
| Comments        | No        | Overrides the base setting **and** signature setting in order for the comments located right above the method to be overwritten by Intent Architect or not.         |
| Attributes      | No        | Overrides the base setting **and** signature setting in order for the attributes (other than the `IntentManaged` one) to be overwritten by Intent Architect or not. |

## Module Settings

![RoslynWeaver Settings](images/roslynweaver-settings.png)

The `Intent.OutputManager.RoslynWeaver` Module has the following settings which will instruct Intent Architect to behave in certain ways:

### Usings Sorting

This will instruct Intent Architect to order the `using directives` located above or within a `namespace` scope within a C# file.

| Option                                        | Description                                                                                                               |
|-----------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| None                                          | The order of the using directives will remain unchanged.                                                                  |
| Alphabetical                                  | The using directives will be sorted alphabetically in ascending order.                                                    |
| Alphabetical, place 'System' directives first | The using directives will be sorted alphabetically except it will give first priority to `System` based using directives. |

### Tag Mode

Intent Architect will use this setting to know how to take guidance from `[IntentManaged]` attributes located within C# files that exist on your hard drive.

It is worth noting that content that gets generated and written to existing C# files may also have `[IntentManaged]` attributes in them which gives the initial placement of those attributes from the first Software Factory Execution.

| Option        | Description                                                                                                                                                                                                                                                                                                                                                                                            |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Explicit      | `IntentManaged` attributes located on existing files will take precedence over the ones found in the generated content.                                                                                                                                                                                                                                                                                |
| Implicit      | Generated content that have their own `IntentManaged` attributes will be primarily used to guide Intent Architect where to overwrite code within a C# file, however attributes modified by the developer will still take precedence. Everywhere where `IntentManaged` attribute configuration settings matches exactly will be removed in the existing file. This gives the code a cleaner experience. |
| Template Only | Any `IntentManaged` attributed located in an existing C# file will be removed and the generated content will take precedence over how Intent Architect will overwrite code within a C# file.                                                                                                                                                                                                           |

### Usings Placement

This will instruct Intent Architect where to place the `using directives` within a C# file.

| Option                   | Description                                                            |
|--------------------------|------------------------------------------------------------------------|
| Default                  | All using directives will be placed at the top of the C# file.         |
| Move to inside namespace | All using directives will be placed within the scope of a `namespace`. |

## See also

* [](xref:code-management.faq-code-management-csharp)
