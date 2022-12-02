---
uid: module-building.templates-csharp.how-to-control-file-properties-in-cs-projects
---
# How to control file properties in C# projects

If you need to control aspects of a file's entry within its `.csproj` file, this can be done by updating the `GetTemplateFileConfig()` method in the template and using various `ITemplateFileConfig` extension methods prefixed with `With` available when you have a using directive for the `Intent.Modules.Common.CSharp.VisualStudio` namespace.

## Available methods

Below is a list of all available methods, additionally, each method has been documented such that supporting IDEs (such as Visual Studio or Rider) will show additional details with IntelliSense or mousing-over method names.

| Method                                   | Description |
| ---------------------------------------- | ----------- |
| `.AsEmbeddedResource(…)`                 | Indicate that the file entry should be an `EmbeddedResource`. This is a convenience method which calls `.WithFileItemGenerationBehaviour(MsBuildFileItemGenerationBehaviour.Always)`, `.WithItemType("EmbeddedResource")` and `.WithRemoveItemType(removeItemType)` where `removeItemType` is `Compile` for `.cs` files and `None` for all other file types, the `removeItemType` parameter can be used to override this. |
| `.WithAttribute(…)`                      | For setting or clearing an attribute with any name and value. Setting an attribute's value to `null` will cause it to be removed. |
| `.WithAutoFormatting(…)`                 | Controls whether or not auto formatting of the file is applied after code merging. |
| `.WithAutoGen()`                         | Adds an `<AutoGen>True</AutoGen>` child element. |
| `.WithCopyToOutputDirectory(…)`          | Controls the value of the `<CopyToOutputDirectory />` child element. |
| `.WithDependsOn(…)`                      | Adds a `<DependentUpon />` child element. |
| `.WithDesignTime()`                      | Adds a `<DesignTime>True</DesignTime>` child element. |
| `.WithFileItemGenerationBehaviour(…)`    | Controls the generation behaviour of the file item element, this can be used to force the element to be/not be generated. |
| `.WithItemType(…)`                       | Indicate that the file entry should have the specified _ItemType_, ie, `<<itemType> Update="<fileName>"/>` should be added to the `.csproj` file. If the `.WithRemoveItemType(…)` method has also been used, then `<<itemType> Include="<fileName>"/>` will be generated instead. |
| `.WithNestedProjectElement(…)`           | For creating a nested element with any name and value. |
| `.WithRemoveItemType(…)`                 | Indicate that the file entry should have a `Remove` entry added for it, ie, that `<<itemType> Remove="<filename>" />` should be added to the `.csproj` file. |
| `.WithTextTemplatingFilePreprocessor(…)` | Adds the necessary elements to the file item for a pre-processed `.tt` file. |

## Examples

### Make a file be copied to the output directory

The example below will make a file's `ItemType` be `None` and have it always be copied to the output directory.

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

### Make a file an embedded resource

The example below will make a file an embedded resource.

```csharp
public override ITemplateFileConfig GetTemplateFileConfig()
{
    return new TemplateFileConfig(
        fileName: $"File",
        fileExtension: "cs")
            .AsEmbeddedResource();
}
```
