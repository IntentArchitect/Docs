---
uid: code-management.about-code-management-csharp
---
# C# Code Management

This article explains how to control [Code Management](xref:code-management.about-code-management) (Code Weaving) behaviour for C# files when "RoslynWeaver" (the C# code management extension of the `Intent.OutputManager.RoslynWeaver` Module) is used.

## Introduction

C# files which are managed by the RoslynWeaver typically have a line at the top of them which is very similar to (if not exactly like) the following:

```csharp
[assembly: DefaultIntentManaged(Mode.Fully)]
```

This attribute is located on a global scope which will instruct the Roslyn Weaver to by default treat the whole file according to the configuration mode of `Fully` (in this case). It may be overridden in certain parts of the file which will be addressed later.

`Mode` comes with three configuration options:

* `Fully` - It has **full** control over the file for Code Automation (like typical Code Automation).
* `Merge` - It may only make modifications and additions to this file but it's not allowed to remove anything.
* `Ignore` - It has **no** control over the file and will not generate or overwrite anything in it.

## Override code management using `[IntentManaged]`

For example, to control code management behaviour for a method, you could add an `[IntentManaged]` attribute to it like so:

```csharp
[IntentManaged(Mode.Ignore)]
public void ChangeCountry(string country)
{
    throw new NotImplementedException();
}
```

When the RoslynWeaver sees this, it will know not to modify (or remove) this method in any way during code merging.

This attribute does have additional properties of configuration which gives a developer finer grain of control. Below can be seen the attribute written in C# in its entirety, followed by more in depth descriptions of what each piece does.

```csharp
[IntentManaged(Mode.Merge, Body = Mode.Ignore, Signature = Mode.Fully, Comments = Mode.Fully, Attributes = Mode.Fully)]
```

> [!NOTE]
> The `Mode` configuration works exactly the same as with the `DefaultIntentManaged` attribute, except that the scope is now on a method level and not a file level.

| Syntax Node Type    | Parameter         | Mandatory | Description                                                                                                                                                              |
|---------------------|-------------------|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| All                 | Default Parameter | Yes       | Sets the default values for all parameter types to instruct the RoslynWeaver what to do. Can be overridden on a per-parameter basis.                                     |
|                     | Attributes        | No        | By default the `Signature` parameter determines this parameter's setting but this parameter instructs the RoslynWeaver to treat the syntax node's Attribute differently. |
|                     | Comments          | No        | By default the `Signature` parameter determines this parameter's setting but this parameter instructs the RoslynWeaver to treat the syntax node's Comments differently.  |
| Class               | Signature         | No        | Instructs the RoslynWeaver to treat the definition of a Class (class name, inheritance, etc.) differently to the default parameter setting.                              |
|                     | Body              | No        | Instructs the RoslynWeaver to treat the members of a Class (methods, properties, etc.) differently to the default parameter setting.                                     |
| Constructor, Method | Signature         | No        | Instructs the RoslynWeaver to treat the definition of a Method (method name, parameters, return type, etc.) differently to the default parameter setting.                |
|                     | Body              | No        | Instructs the RoslynWeaver to treat the implementation part of a method (where the code goes) differently to the default parameter setting.                              |
| Field, Property     | Signature         | No        | Instructs the RoslynWeaver to treat the definition of a Field (field name, type, etc.) differently to the default parameter setting.                                     |
|                     | Body              | No        | Instructs the RoslynWeaver to treat the value differently to the default parameter setting.                                                                              |

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

## Frequently Asked Questions

### Why is Intent Architect formatting my C# files?

By default the Software Factory will automatically format files under [code management](xref:code-management.about-code-management). If this is undesired you can disable this behaviour by setting the the `AutoFormat` property to `false` in the `DefineFileConfig` method of your template:

```csharp
protected override CSharpFileConfig DefineFileConfig()
{
    return new CSharpFileConfig(
        className: "MyClass",
        @namespace: OutputTarget.GetNamespace())
    {
        AutoFormat = false
    };
}
```

### Why can Intent Architect not fully manage my `using directives`?

It is a design choice that Intent Architect will not fully overwrite your `using directives` so as to give developers more control in the event where some edge cases might occur. However, there is a way to instruct Intent Architect to take full control if so desired by adding the following attribute underneath the `DefaultIntentManaged` one:

```csharp
[assembly: DefaultIntentManaged(Mode.Fully)]
[assembly: DefaultIntentManaged(Mode.Fully, Targets = Targets.Usings)]
```
