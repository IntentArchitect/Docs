---
uid: module-building.templates.how-to-update-appsettings-json-files
---
# How to update `appsettings.json` files

The `Intent.VisualStudio.Projects` module automatically generates the `appsettings.json` file for relevant .NET project types.

To have additional configuration applied to an `appsettings.json` file, use the `ApplyAppSetting` extension method in your Template, for example:

```csharp
public override void BeforeTemplateExecution()
{
    this.ApplyAppSetting(
        field: "CustomSectionName:SomeStringField",
        value: "Some Value");

    this.ApplyAppSetting(
        field: "OtherCustomSectionName",
        value: new
        {
            IntValue = 10,
            StrValue = "My String"
        });
}
```

> [!NOTE]
> This extension method requires `Intent.Modules.Common.CSharp` nuget package to be installed in your module project.
>
> [!IMPORTANT]
> This should only be invoked from `BeforeTemplateExecution` inside your template.

In the example above, your `appsettings.json` file will receive the following:

```json
{
    // ... other configuration...

    "CustomSectionName": {
        "SomeStringField": "Some Value"
    },
    "OtherCustomSectionName": {
        "IntValue": 10,
        "StrValue": "My String"
    }
}
```
