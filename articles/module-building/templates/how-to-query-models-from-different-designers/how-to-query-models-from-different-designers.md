---
uid: module-building.templates.how-to-query-models-from-different-designers
---
# How to query models from different designers

When a Template is configured to be a _File per Model_ a `Designer` and `Model Type` need to be specified under `Template Settings`. For additional Designers along with their Model Types to be available for selection, their corresponding Module needs installed with the `Install Metadata only` option checked. For example, to use the `Domain` Designer and a Model Type from it, install the `Intent.Modelers.Domain` or for the `Services` designer install the `Intent.Modelers.Services` module.

The `Install Metadata only` option checkbox can be made visible by clicking on the `Options` arrow:

![Install Metadata Only](images/install-module-metadata-only.png)

Once the Module is installed, create or select a Template and in the properties panel choose the Domain Designer as well as the Model Type that will be represented in the Template (i.e. `Class`).

![Select Designer and Model Type](images/template-select-designer.png)

Run the Software Factory and open the Template's corresponding Registration class.

It has generated a `GetModels` method that will look in the `Domain` for Class models using the `GetClassModels` query method. When run, your module will now make an instance of the Template for each Class  Thus once the Module is installed in an Intent Architect application, the Classes being modeled in the Domain designer will be queried and transformed into template output for each Class instance.

```csharp
public override IEnumerable<ClassModel> GetModels(IApplication application)
{
    return _metadataManager.Domain(application).GetClassModels();
}
```

For any other Designer the query will be different depending on the Designer and the Elements that's provided by the Designer. An example from a Services Designer will look like:

```csharp
public override IEnumerable<ServiceModel> GetModels(IApplication application)
{
    return _metadataManager.Services(application).GetServiceModels();
}
```

The above example will query the Services Designer for all modeled Services and pass them on to the Template to be generated into code.

## See more

- [](xref:module-building.templates.how-to-filter-templates)
