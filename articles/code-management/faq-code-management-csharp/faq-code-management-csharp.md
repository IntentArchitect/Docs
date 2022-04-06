---
uid: code-management.faq-code-management-csharp
---
# FAQs for Code Management (C#)

## Why is Intent Architect formatting my C# files?

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

## Why can Intent Architect not fully manage my `using directives`?

It is a design choice that Intent Architect will not fully overwrite your `using directives` so as to give developers more control in the event where some edge cases might occur. However, there is a way to instruct Intent Architect to take full control if so desired by adding the following attribute underneath the `DefaultIntentManaged` one:

```csharp
[assembly: DefaultIntentManaged(Mode.Fully)]
[assembly: DefaultIntentManaged(Mode.Fully, Targets = Targets.Usings)]
```
