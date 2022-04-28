---
uid: templates.how-to-control-file-properties-in-cs-projects
---
# How to control file properties in C# projects

If you need to control aspects of a file's entry within its `.csproj` file, this can be done by updating the `GetTemplateFileConfig()` method in the template and using various `ITemplateFileConfig` extension methods prefixed with `With` available when you have a using directive for the `Intent.Modules.Common.CSharp.VisualStudio` namespace.

> [!NOTE]
> These extension methods are only available if you are using version `3.3.1` or higher of the `Common.CSharp` Module and its corresponding NuGet package.

Each method has been documented such that supporting IDEs (such as Visual Studio or Rider) will show additional details with intellisense or mousing-over method names.

For example, to make a file's `ItemType` be `None` and have it always be copied to the output directory, do the following:

```csharp
public override ITemplateFileConfig GetTemplateFileConfig()
{
    return new TemplateFileConfig(
        fileName: $"script",
        fileExtension: "sql")
            .WithItemType("None")
            .WithCopyToOutputDirectory(CopyToOutputDirectory.CopyAlways);
}
```

Most of the methods use hard-coded XML node names, but the following generic methods can be used to affect any node name of your choosing:

|Method name|Description|
|-|-|
|`.WithNestedProjectElement(…)`|For creating a nested element with any name and value of your choosing.|
|`.WithAttribute(…)`|For setting or clearing an attribute with any name and value of your choosing. Setting an attributes value to `null` will cause it to be removed.|
