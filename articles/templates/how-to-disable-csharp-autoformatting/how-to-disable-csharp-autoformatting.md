---
uid: references.code-management.csharp-code-management
---
# How to Disable auto-formatting for C# templates

By default the Software Factory will automatically format files under [code management](xref:references.code-management). If this is undesired you can disable this behaviour by setting the the `AutoFormat` property to `false` in the `DefineFileConfig` method of your template:

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
