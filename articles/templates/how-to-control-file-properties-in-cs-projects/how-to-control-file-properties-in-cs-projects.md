---
uid: references.code-management.csharp-code-management
---
# How to control file properties in C# projects

If you need a file within a `.csproj` file to be a certain `ItemType` (such as `None`) or change its `CopyToOutputDirectory`, this can be done by setting values to the following `CustomMetadata` keys in the `GetTemplateFileConfig` method:

- `ItemType`
- `CopyToOutputDirectory`

For example, to make a file's `ItemType` be `None` and have it always be copied to the output directory, do the following:

```csharp
public override ITemplateFileConfig GetTemplateFileConfig()
{
    var config = new TemplateFileConfig(
        fileName: $"script",
        fileExtension: "sql");

    config.CustomMetadata.Add("ItemType", "None");
    config.CustomMetadata.Add("CopyToOutputDirectory", "Always");

    return config;
}
```
