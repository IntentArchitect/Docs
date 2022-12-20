---
uid: module-building.templates-java.how-to-add-application-properties
---
# How to add `application.properties` entries

To add an entry to the `application.properties` file, override the your template's `BeforeTemplateExecution()` method (if not done already) and call the `.ApplyApplicationProperty(<name>, <value>)` extension method:

```csharp
public override void BeforeTemplateExecution()
{
    base.BeforeTemplateExecution();
    this.ApplyApplicationProperty("Name", "Value");
}
```
