---
uid: module-building.templates-java.how-to-add-application-properties
description: "How to add entries to a Java application.properties file from a template using the ApplyApplicationProperty extension method."
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
