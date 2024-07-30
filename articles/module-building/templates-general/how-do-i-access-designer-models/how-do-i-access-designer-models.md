---
uid: module-building.templates-general.how-do-i-access-designer-models
---

# How to Access Designer Models in Templates?

When building modules using Intent Architect, it is very common to want to use the metadata you have modeled in the designers as part of the code generation. For example, if you've built a Domain model, you might want to generate a set of C# classes as the code realization of that domain model. This article covers how to achieve this.

## Overview of Designer Models and Their Usage Within Templates

When using Intent Architect, you build up metadata models in various designers. For example, in the `Domain Designer`, you create a domain model reflecting your business domain. This designer describes concepts like `Class`es, `Attribute`s, `Associations`, etc. All of these concepts are models in their own right and collectively make up your domain model.

![Domain Model Example](./images/domain-model-example.png)

If you select individual items in the Domain Designer, you can see what type it is by looking at the Properties pane.

For example, if you select `Customer`, you can see this is of type `Class`. In code, this will be represented by a `ClassModel`.

![Class Model](./images/properties-class.png)

Now, if you select an attribute on the `Customer`, you can see this is of type `Attribute`. In code, this will be represented by an `AttributeModel`.

![Attribute Model](./images/properties-attribute.png)

These models can then be used as data for your templates to work with. Here is a simple example of reading this data from within a template:

```csharp
// Get the Domain Designer for my currently running Application
var domainDesigner = ExecutionContext.MetadataManager.Domain(ExecutionContext.GetApplicationConfig().Id);
var classModels = domainDesigner.GetClassModels();
```

Based on what we can visually see in the Domain Designer above, this would be a list of 5 `ClassModel`s, namely:

- Preferences
- Customer
- Address
- Order
- OrderItem

This is a simplified view of what the ClassModel looks like:

```csharp
public class ClassModel : ...
{
    public const string SpecializationType = "Class";
    public const string SpecializationTypeId = "04e12b51-ed12-42a3-9667-a6aa81bb6d10";
    public string Name { get; }
    public bool IsAbstract { get; }
    public IEnumerable<string> GenericTypes { get; } 
    public IEnumerable<IStereotype> Stereotypes { get; }
    public FolderModel Folder { get; }
    public IList<AttributeModel> Attributes { get; }
    ...
}
```

There are two common scenarios for accessing this data:

- Binding Models to the template within the `Module Designer`.
- Fetching the models using `MetadataManager` from within a template.

> [!NOTE]
> `ClassModel` and the `Domain` extension method off of `ExecutionContext` will not be present in your own module by default. As Intent Architect is a modular extensible platform, these concepts are bundled and packaged with the `Domain Designer`. The next section covers how to set this up.

## Accessing the Designer Data in Your Own Module

Assuming you are building your own Module and you would like to access the metadata from the Domain Designer, you can simply install the `Intent.Modelers.Domain` with the `Install Metadata only` option checked. The option can be made visible by clicking on the Options arrow:

![Install Domain Designer](./images/install-designer.png)

Next, you may need to add the Designer's `NuGet` package to your solution. Simply add the `Intent.Modules.Modelers.Domain` package to your module in your IDE (e.g., Visual Studio).

> [!NOTE]
> Certain actions in the `Module Builder` will cause the designer package to be automatically added. The NuGet package name is convention-based off the Module name, i.e., the same as the module name with a `.Modules` after the `Intent` part. For example, `Intent.Modelers.Domain`'s NuGet package is `Intent.Modules.Modelers.Domain`. The version numbers of NuGet packages correlate with the version of the Modules, e.g., a version 3.9 module will have a version 3.9 NuGet package.

You should now have access to all the APIs you need to access the Designer data, which will be in the `Intent.Modelers.Domain.Api` namespace. This includes:

- Designer's Model classes
- Extension methods to `MetadataManager` for accessing the designer's Model classes
- Stereotype extension methods

> [!NOTE]
> This article uses the `Domain Designer` as an example, but the same principles apply to any of the `Designer Modules`.

## Designer Extensions

It is worth noting that Designers can be extended, i.e., new functionality added through additional modules. For example, the `Intent.Modelers.Services.CQRS` module extends the `Intent.Modelers.Services` designer, introducing `CQRS` paradigm models to the `Services Designer`.

This works exactly the same as mentioned above. However, note that you would need to add these Modules and NuGet packages if you want to access the extension data.

## Common Intent Architect Designers

### Domain Designer (Intent.Modelers.Domain)

This Designer is centered around describing your Domain / Persistence model.

Common Extensions:

- **Modelers.Domain.ValueObjects**
- **Modelers.Domain.Services**
- **Modelers.Domain.Events**

### Services Designer (Intent.Modelers.Services)

This Designer is used to model your Services and, more broadly, your application layer.

Common Extensions:

- **Modelers.Services.CQRS**
- **Modelers.Services.DomainInteractions**
- **Modelers.Services.EventInteractions**
- **Modelers.Services.GraphQL**

### Visual Studio Designer (Intent.Modelers.Services)

Model how Intent Architect integrates with Visual Studio.

## Accessing the Models in Template Code

As mentioned previously, these models can be accessed through extension methods off the `IMetadataManager` interface. For example:

```csharp
// Get the Domain Designer for my currently running Application
var domainDesigner = ExecutionContext.MetadataManager.Domain(ExecutionContext.GetApplicationConfig().Id);
// Get all the Class models from the Domain Designer
var classModels = domainDesigner.GetClassModels();
```

The `IMetadataManager` interface can be accessed in the following ways:

### Within a Template Which Inherits from `IntentTemplateBase`

`IMetadataManager` is available on the template instance through the `ExecutionContext.MetadataManager` property.

```csharp
var metadataManager = ExecutionContext.MetadataManager;
var metadataManager = this.ExecutionContext.MetadataManager;
```

### Within a `FactoryExtension`

`IMetadataManager` is available on the `IApplication` interface.

```csharp
public class MyFactoryExtension : FactoryExtensionBase
{
    ...
    protected override void OnAfterTemplateRegistrations(IApplication application)
    {
        var metadataManager = application.MetadataManager;
    }
}
```

> [!NOTE]
> This section covers fetching the Designer models directly within your template. Another way to get access to Designer Models in your templates is to data bind them to the template. In this scenario, the Model(s) will be injected into your template's constructor. [](xref:module-building.templates-general.how-do-i-bind-designer-models-to-templates)

## See More

- [](xref:module-building.templates-general.how-do-i-bind-designer-models-to-templates)