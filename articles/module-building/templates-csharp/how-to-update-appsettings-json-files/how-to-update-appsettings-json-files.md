---
uid: module-building.templates-csharp.how-to-update-appsettings-json-files
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
> This extension method requires `Intent.Modules.Common.CSharp` NuGet package to be installed in your module project.
>
> [!IMPORTANT]
> This can only be invoked after construction of the template, otherwise the template which responds to this event might not yet have been constructed.
> 
> Placing this method in the override of either the `AfterTemplateRegistration` or `BeforeTemplateExecution` methods will ensure it is called only after all other templates have been constructed.

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
