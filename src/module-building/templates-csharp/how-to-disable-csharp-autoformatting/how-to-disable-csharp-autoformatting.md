---
uid: module-building.templates-csharp.how-to-disable-auto-formatting
description: "How to disable automatic code formatting for a C# template by setting AutoFormat to false in DefineFileConfig."
---
# How to disable auto-formatting for C# templates

By default the Software Factory will automatically format files under [code management](xref:application-development.code-management.about-code-management). If this is undesired you can disable this behaviour by setting the `AutoFormat` property to `false` in the `DefineFileConfig` method of your template:

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
