---
uid: module-building.tutorial-advanced-mapping
---
# Tutorial: Advanced Mapping

## Overview

This tutorial will guide you through setting up an advanced mapping configuration and corresponding consuming code in a template between a CQRS Command and a Domain Entity Class using Intent Architect. This allows for automatic code generation that maps properties from a command (or DTO) to associated properties or fields of a domain entity.

![Advanced mapping](images/advanced-mapping.png)

## Create a new Module Builder Application

- On the Intent Architect home screen select the _Create a new module_ button on the left under _Get started_.
- On the create application dialogue set the _Name_ to `ElementMappingModule` and press _NEXT_.
- On the component selection screen of the dialogue, ensure the following optional components are selected:
  - _Module Builder - C#_
  - _Domain_
  - _Services_
- Press the _CREATE_ button and wait for the application creation process to complete.
- Right-click on the `ElementMappingModule` application in the Solution Explorer and select the _Manage Modules_ option.
- Search for `cqrs`.
- Select the _Intent.Modelers.Services.CQRS_ search result.
- Expand the _Options_ dropdown in the right pane and check the _Install metadata only_ option:

  ![The install metadata only option](images/install-metadata-only-option.png)

- Press the _Install_ button on the right.

## Create the Designer Settings

Designer settings enable the definition of new designer components such as elements, associations and mapping configurations as well as extending the behaviour of existing designer components.

Highly customizable and configurable designers is a key feature of Intent Architect as it allows the creation of visual designers which are perfectly suited to developers using Intent Architect to design their applications for particular technologies or architectural concepts.

![Designer settings](images/designer-settings.png)

- Open the _Module Builder_ designer from the _Solution Explorer_.
- Right-click the package (the root node of the tree view) and select the _Add Designers Folder_.
- Right-click the `designers` folder and select the _New Designer Setting_ option and give it the name `Explicit Mapper Settings`.
- In _Properties_ pane for the _Extend Designers_ property add `Services`:

  ![The "Extend Designers" "Designer Settings" property](images/extend-designers-designer-settings-property.png)

## Define Associations onto which Advanced Mapping configurations will be added

Defining mapping associations allows users to establish explicit relationships between elements, e.g. between _Commands_ and domain _Classes_, we are then able to add any number of Advanced Mapping configurations onto these associations which users can leverage as needed.

![Designer Associations](images/designer-associations.png)

- Right-click on `Explicit Mapper Settings`, select the _New Association Type_ option and give it a name of `Map to Element`.
- Select the `Map to Element Source End` element in the tree view and under _Settings_ in the _Properties_ pane on the right:
  - For the _Target Type_ property set it to `Command`:

     ![Target Types property](images/target-types-property.png)

  - For the _Display Text Function_ property, use the pencil icon on the right of the text field to bring up a JavaScript code editor. We're going to want to return a string which makes key information about the mapping visible in the designer. You can enter the following into the code editor dialogue:

    ```javascript
    return `mapped by : ${typeReference.getType().getParent().getName()}.${typeReference.display}`;
    ```

  - Set the _Name Accessibility_ property to `Hidden`, this will prevent users from being able to change the name of the association.
- Select the `Map to Element Target End` element and under _Settings_ in the _Properties_ pane on the right:
  - Set the _Target Type_ property to `Class`.
  - Set the _Display Text Function_ property to:

    ```javascript
    const returnType = typeReference.getType()?.typeReference?.display ?? "void";
    return `[map] ${getName()}: ${`${typeReference.getType()?.getName()}(...): ${returnType}` ?? "<not set>"}`;
    ```

  - Set the _Name Accessibility_ property to `Optional`.
- Right-click on the `Map to Element` element, select the _Add Visual Settings_ option and ensure the _Type_ is set to `void`.
- Select the `[visual]` element in the tree view and in the _Properties_ pane on the right:
  - Set the _Line Type_ property to `Curved`.
  - Set the _Line Dash Array_ property to `return "3, 7";`.
- Right-click on the `[visual]` element and select the _Add Source Visual_ option.
- Select the `[source]` element in the tree view and in the _Properties_ pane on the right:
  - Under the _Point Settings_ section:
    - Set the _Path_ property to the following to control the [SVG path](https://developer.mozilla.org/docs/Web/SVG/Tutorial/Paths) to define the visual for the end of the line, in this case an arrow:

      ```js
      return `a 4,4 0 1,0 4,4 a 4,4 0 1,0 -4,4`;
      ```
  
    - Set the _Line Width_ property to `return 3;`.
    - We have now configured that a solid circle is to be drawn on the Source end.
- Right-click on the `[visual]` element and select the _Add Destination Visual_ option.
- Select the `[source]` element in the tree view and in the _Properties_ pane on the right:
  - Under the _Point Settings_ section:
    - Set the _Path_ property to the following to have it in this case draw a triangle:

      ```js
      return `l 4 8 l -8 0 l 4 -8 Z`;
      ```

## Define the Element Mapping

Element mappings specify how different element types (like DTOs and Commands) should map to the target (like Domain Classes and Associations). This allows for detailed configuration of how data should be transferred and transformed between different parts of the application.

![Element Mapping](images/element-mapping.png)

The _Source_ elements within the settings (such as Command or DTO with nested Fields) indicate the elements from which you can map. On the other hand, the _Target_ elements (such as Class, Attribute, or Associations) indicate where you can map to. This setup ensures there's a clear and traversable path for data or actions between various parts of your model.

Right-click on the `Explicit Mapper Settings` element on the tree view, select the _New Mapping Settings_ option and give it a name of `Element Mapping`.

Starting on the `Source` element, right-click it and select the `Add Mappable Element` option to create tree structure:

- Name of `Command` with it's _Target Type_ set to `Command`.
- Name of `DTO` with it's _Target Type_ set to `DTO`
  - Name of `Field` with it's _Target Type_ set to `DTO-Field`
  - Name of `Collection Field` with it's _Target Type_ set to `DTO-Field`.

The next steps will be addressing the following property types:

- **Represents**: . This will be further addressed in the [Invocation Mapping](#invocation-mapping) and [Data Mapping](#data-mapping).
- **Is Mappable Function**: If it returns `true` the element is allowed to be mapped from/to. This is useful in cases where elements may be greyed out since they are read-only for instance on the target end.
- **Allow Multiple Mappings**: Allow for the element to be mapped from/to multiple times.
- **Can Be Modified**: Should it be permissible to generate and automatically link these fields if they do not already exist at the other end upon a double-click action (as an example)?
- **Traversable Mode**: This mode enables elements that link to other types of elements to be expanded, making their child elements accessible for mapping. By choosing this mode, you can specify which types of elements are permitted to enter the traversal. For instance, consider a Class `Order` that contains a collection of `OrderLines` as an association; using this mode, you can navigate through the collection to map to its constituent elements.
- **Use Child Mappings From**: Rather than replicating mappings for child elements along with their associated property values, you have the option to "re-use" the child-element structure from another element type. For instance, `Command` could adopt the child mappings from `DTO`, given their structural similarity despite serving different purposes.

Set the properties for the following source elements:

- **Command**
  - Represents `Data`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Can Be Modified `checked`.
  - Use Child Mappings From `DTO: DTO`.
- **DTO**
  - Represents `Data`.
  - Is Mappable Function `return false;`.
  - Allow Multiple Mappings `checked`.
  - Can Be Modified `checked`.
  - Create Name Function:

    ```js
    return element.getParent('Command').getName() + element.getName() + 'Dto';
    ```

- **Field**
  - Represents `Data`.
  - Filter Function:

    ```js
    return !element.typeReference.getIsCollection();
    ```

  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Traversable Mode `Traverse Specific Types`.
  - Traversable Types `DTO: DTO`.
  - Can Be Modified `checked`.
- **Collection Field**
  - Represents `Data`.
  - Filter Function:

    ```js
    return element.typeReference.getIsCollection();
    ```

  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Traversable Types `DTO: DTO`.
  - Can Be Modified `checked`.

Create the following `Mappable Element Settings` inside the `Target` (or Destination) element (with its own Target Type) by right-clicking on `Target` element and selecting the `Add Mappable Element` option:

- Name of `Create Class` with it's _Target Type_ set to `Class`.
  - Name of `Set Attribute` with it's _Target Type_ set to `Attribute`.
  - Name of `Set Association Target End` with it's _Target Type_ set to `Association Target End`.
  - Name of `Set Association Source End` with it's _Target Type_ set to `Association Source End`.

Set the properties for the following target elements:

- **Create Class**
  - Represents `Invokable`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
- **Set Attribute**
  - Represents `Data`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
- **Set Association Target End**
  - Represents `Data`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Traversable Mode `Traverse Specific Types`.
  - Traversable Types `Create Class: Class`.
  - Use Child Mappings From `Create Class: Class`.
- **Set Association Source End**
  - Represents `Data`.
  - Is Required Function `return false;`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Traversable Mode `Traverse Specific Types`.
  - Traversable Types `Create Class: Class`.
  - Use Child Mappings From `Create Class: Class`.

Add the following Mapping Types to the `Element Mapping` by right-clicking and selecting the `Add Mapping Type` option and set their properties accordingly:

### Invocation mapping

- Source Types `Command: Command`.
- Target Types `Create Class: Class`.
- Represents `Invokable`.

![Invocation mapping](images/invocation-mapping.png)

_Example of an Invocation mapping._

This mapping method facilitates the creation of an instance or execution of an operation on a target Entity. This can be done by directly calling the Entity's constructor, either explicitly or implicitly, or by solely executing the Entity's operation. To illustrate, a `CreateOrderCommand` could correspond to the constructor of an `Order` class, initializing necessary fields directly.

### Data mapping

- Source Types `Field: DTO-Field`, `Collection Field: DTO-Field`.
- Target Types `Set Attribute: Attribute`, `Set Association Target End: Association Target End`.
- Represents `Data`.

![Data Mapping](images/data-mapping.png)

_Example of a Data mapping._

This type of mapping is intended for direct assignment of values from fields in the source object to attributes or relationships in the target object. It handles both s
ingle-value fields and collections. By defining these mappings, fields from a command or DTO can be accurately transferred and mapped to corresponding properties of a domain entity, ensuring data integrity and consistency. For example, the `RefNo` and `CreatedDate` attributes of an `Order` entity can be directly mapped from fields in a command or DTO, ensuring each attribute is correctly populated.

## Create Command element extensions

An _Element Extension_ allows extension of behaviour of an Element defined in another module, such as adding a context menu option. We're going to want to want to extend `Command` elements to have a context menu option to:

- Right-click the `Explicit Mapper Settings` element and select the Within this folder, create a `Designer Settings` item named `Command Extension`.
- Set the `Extended Designers` property to reference the `Services` designer.
- Add an `Element Extension` with the name `Command Extension` and target the `Command` type from the CQRS module.

## Add a context menu option to Commands to create a mapping

To provide a way for users to create these Element Mappings between Commands and Domain Classes and to map the data flow between them, context menus will be added to enable the user to perform those functions.

To create the `Map To Element` association and perform the `Element Mapping` mapping, we need to set up their context menu options.

On the `Command Extension`, ensure that the `[context menu]` element exists by right-clicking on it and selecting the `Add Menu Options` option.

On the `[context menu]` element, right-click and selecting the `Add Association Creation` option. Name it `Add element mapping` and set the type to `Map To Element`.

Next, go to the `Map To Element` association and locate the `Map To Element Target End` destination end. Ensure it too has the `[context menu]` created by selecting `Add Menu Options` when right-clicking on the element.

On the `[context menu]`, right-click and select `Add Mapping Option` and name it `Map to Element` with the type being `Element Mapping`.

![Context menus](images/context-menus.png)

## Interpreting a mapping from a template to generate code

Creating a template for mapping code involves defining a custom template that generates the necessary code to perform the mappings. This step ensures that the mappings defined in the designer are translated into executable code.

![Template for Mapping code](images/template-mapping-code.png)

Create a new template in the `ElementMappingModule` for mapping commands to domain entities by right-clicking on the `ElementMappingModule` package and selecting the `New C# Template` option.

Ensure the following properties are set:

- Name `ElementMappingTemplate`.
- Type `Single File`.
- Templating Method `C# File Builder`.
- Designer `Services`.
- Model Type `Command`.

## Implement ElementMappingTemplate

The implementation of the `ElementMappingTemplate` and `ElementMappingTypeResolver` provides the logic for how the mappings should be executed and ensures that the correct methods and logic are generated based on the defined mappings.

Run the Software Factory and open the solution in Visual Studio.

Open the `ElementMappingTemplatePartial` class. Implement the constructor like this:

```csharp
public ElementMappingTemplate(IOutputTarget outputTarget, IList<CommandModel> model) : base(TemplateId, outputTarget, model)
{
    CSharpFile = new CSharpFile(this.GetNamespace(), this.GetFolderPath())
        .AddClass($"ElementMapping", @class =>
        {
            @class.Static();
            foreach (var commandModel in model)
            {
                var commandTypeName = GetTypeName("Application.Command", commandModel);
                foreach (var target in commandModel.MapToElementTargets())
                {
                    var entityTypeName = GetTypeName("Domain.Entity", target.Association.TargetEnd.Element);
                    var entityName = target.Association.TargetEnd.Element.Name;
                    @class.AddMethod(entityTypeName, $"MapTo{entityName.ToPascalCase()}", method =>
                    {
                        method.Static();
                        method.AddParameter(commandTypeName, "source", param => param.WithThisModifier());

                        var manager = new CSharpClassMappingManager(this);

                        manager.SetFromReplacement(commandModel, "source");

                        var resultStatement = new CSharpAssignmentStatement(
                            "var result",
                            manager.GenerateCreationStatement(target.Mappings.First())).WithSemicolon();
                        method.AddStatement(resultStatement);
                        method.AddStatement("return result;");
                    });
                }
            }
        });
}
```

Create a new class `ElementMappingTypeResolver` and implement it as follows:

```csharp
public class ElementMappingTypeResolver : IMappingTypeResolver
{
    private readonly ICSharpFileBuilderTemplate _template;

    public ElementMappingTypeResolver(ICSharpFileBuilderTemplate template)
    {
        _template = template;
    }

    public ICSharpMapping ResolveMappings(MappingModel mappingModel)
    {
        if (mappingModel.MappingTypeId != "ENTER ID HERE")
        {
            return null;
        }

        var model = mappingModel.Model;

        if (model.SpecializationType is "Class" || model.TypeReference?.Element?.SpecializationType == "Class")
        {
            return new ObjectInitializationMapping(mappingModel, _template);
        }

        if (model.SpecializationType == "Association Target End" && model.TypeReference?.IsCollection == true)
        {
            return new SelectToListMapping(mappingModel, _template);
        }

        return null;
    }
}
```

In Intent Architect, go to your `Element Mapping` element, left-click on it and locate the 3 dots on the right-hand side. Click on it and select `Copy Id to clipboard`.

![Copy Id to clipboard](images/copy-id-clipboard.png)

Go back to the `ElementMappingTypeResolver` and locate the `ENTER ID HERE` string. Replace it with the Id you copied in Intent Architect.

```csharp
if (mappingModel.MappingTypeId != "eba4de6c-8b26-4a4e-ab7d-48e327495227")
{
    return null;
}
```

In the `ElementMappingTemplatePartial` constructor, add this resolver like this:

```csharp
var manager = new CSharpClassMappingManager(this);
manager.AddMappingResolver(new ElementMappingTypeResolver(this));
```

## Build and Install the Module

Once the custom module is set up and implemented, we'll cover the process of installing the module into your application. This step makes the new mapping capabilities available for use in the application.

Compile the `ElementMappingModule` project in Visual Studio.

Note the location of the created module in the `Build` log:

`Successfully created package C:\Code\MyModules\Intent.Modules\ElementMappingModule.1.0.0.imod`

Create a Clean Architecture application in Intent Architect for testing this newly created module. Call it `TestApp`.

To set it up to install the custom module in the `TestApp`, follow the `Install the Module` instructions here: [Install and Run the Module](xref:module-building.tutorial-create-a-template.install-and-run-the-module#install-the-module).

## Testing the Module

Testing the module involves creating domain models and commands within the application and applying the mappings to ensure that the generated code correctly maps between commands and domain entities, confirming the intended functionality.

Navigate to the Domain Designer for `TestApp`. Create two Classes defined like this:

- **Order**
  - `RefNo` as `string`
  - `CreatedDate` as `datetime`
- **OrderLine**
  - `Description` as `string`
  - `Amount` as `decimal`
  - `Quantity` as `int`

Create an association from `Order` to `OrderLine` as a `1 -> *` relationship.

![Domain Model](images/domain-model.png)

Next, navigate to the Services Designer and create a Command called `CreateOrderCommand`. Provide it with a `RefNo` as `string` and `CreatedDate` as `datetime` fields. Last, right-click on the Command and select `Add element mapping`. Skip the name for the association by pressing tab to jump right into the type dropdown and select `Order`.

![Service Model](images/service-model.png)

![Diagram on Service designer](images/service-designer-diagram.png)

Right-click on the `[map] : Order(...): void` element and select `Map To Element`. This presents an advanced mapping screen where you can map the two Mapping Types: `Invocation Mapping` and `Data Mapping`.

- Double-click on the `Order` class on the right-hand side to set up the `Invocation Mapping` represented as a dotted purple line.
- Double-click on the `RefNo` and `CreatedDate` fields on the right-hand side to set up the `Data Mappings` represented as solid blue lines.
- Double-click on the `OrderLines` field twice to set up the `Data Mappings` represented as solid blue lines.
- Click DONE.

![Advanced mapping](images/advanced-mapping.png)

Run the Software Factory and open the `ElementMapping` class located in the Application project. It should look like this:

```csharp
namespace TestApp.Application
{
    public static class ElementMapping
    {
        public static Order MapToOrder(this CreateOrderCommand source)
        {
            var result = new Order
            {
                RefNo = source.RefNo,
                CreatedDate = source.CreatedDate,
                OrderLines = source.OrderLines
                    .Select(ol => new OrderLine
                    {
                        Id = ol.Id,
                        Description = ol.Description,
                        Amount = ol.Amount,
                        Quantity = ol.Quantity,
                        OrderId = ol.OrderId
                    })
                    .ToList()
            };
            return result;
        }
    }
}
```

This allows you to write the following code inside the `CreateOrderCommandHandler` class:

```csharp
public async Task Handle(CreateOrderCommand request, CancellationToken cancellationToken)
{
    var order = request.MapToOrder();
}
```
