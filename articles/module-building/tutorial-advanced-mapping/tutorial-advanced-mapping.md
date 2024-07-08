---
uid: module-building.tutorial-advanced-mapping
---
# Tutorial: Advanced Mapping

## Overview

This tutorial will guide you through the process of setting up an advanced mapping between a CQRS Command and a Domain Entity Class using Intent Architect. This allows for the automatic generation of code that maps the properties from a command (or DTO) to the associated properties or fields of a domain entity. 

## Create a New Module Builder Application

- Open Intent Architect and create a new Module Builder application named `ElementMappingModule`.
- Ensure you include the necessary components: `Module Builder C#`, `Domain` and `Services`.
- Once the `ElementMappingModule` is created, right-click on the newly created application and select `Manage Modules`.
- Search for `cqrs`.
- Install the  `Intent.Modelers.Services.CQRS` module. Expand the `Options` section on the right hand side and check `Install metadata only`.

## Setup designer settings

![Designer settings](images/designer-settings.png)

- In the `Module Builder`, create a `Designer Settings` named `Explicit Mapper Settings`.
- Within this folder, create a `Designer Settings` item and name it `Command Extension`.
- Set the `Extended Designers` property to reference the `Services` designer.
- Add an `Element Extension` with the name `Command Extension` and target the `Command` type from the CQRS module.

## Define the Mapping Associations

![Designer Associations](images/designer-associations.png)

- Create a new `Association Type` named `Map to Element`.
- Set the `Source End` to `Command`.
  - Set the Display Text Function to

    ```javascript
    return `mapped by : ${typeReference.getType().getParent().getName()}.${typeReference.display}`;
    ```

  - Set the Name Accessibility to `Hidden`.
- Set the `Target End` to `Class`.
  - Set the Display Text Function to

    ```javascript
    const returnType = typeReference.getType()?.typeReference?.display ?? "void";
    return `[map] ${getName()}: ${`${typeReference.getType()?.getName()}(...): ${returnType}` ?? "<not set>"}`;
    ```

  - Set the Name Accessibility to `Optional`.
- Right click on `Map to Element` and select `Add Visual Settings`, ensure the Type is `void`.
- Set its properties:
  - Line Type `Curved`.
  - Line Dash Array `return "3, 7";`.
- Right click on the `[visual]` and add a `Source` visual.
- Set its properties on Point Settings:
  - Path

    ```js
    return `a 4,4 0 1,0 4,4 
        a 4,4 0 1,0 -4,4`;
    ```

  - Line Width `return 3;`.
- Right click on the `[visual]` and add a `Destination` visual.
- Set its properties on Point Settings:
  - Path

    ```js
    return `l 4 8 l -8 0 l 4 -8 Z`;
    ```

## Define the Element Mapping

![Element Mapping](images/element-mapping.png)

Create a new `Mapping Settings` in the `Explicit Mapper Settings` Designer Settings and name it `Element Mapping`.

Create the following `Mappable Element Settings` inside the `Source` element (with its own Target Type) by right clicking on `Source` and selecting `Add Mappable Element`:

- Command (`Command`)
- DTO (`DTO`)
  - Field (`DTO-Field`)
  - Collection Field (`DTO-Field`)

Set the properties for the following source elements:

- Command
  - Represents `Data`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Can Be Modified `checked`.
  - Use Child Mappings From `DTO: DTO`.
- DTO
  - Represents `Data`.
  - Is Mappable Function `return false;`.
  - Allow Multiple Mappings `checked`.
  - Can Be Modified `checked`.
  - Create Name Function

    ```js
    return element.getParent('Command').getName() + element.getName() + 'Dto';
    ```

- Field
  - Represents `Data`.
  - Filter Function

    ```js
    return !element.typeReference.getIsCollection();
    ```

  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Traversable Mode `Traverse Specific Types`.
  - Traversable Types `DTO: DTO`.
  - Can Be Modified `checked`.
- Collection Field
  - Represents `Data`.
  - Filter Function

      ```js
      return element.typeReference.getIsCollection();
      ```

  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Traversable Types `DTO: DTO`.
  - Can Be Modified `checked`.

Create the following `Mappable Element Settings` inside the `Target` element (with its own Target Type) by right clicking on `Target` and selecting `Add Mappable Element`:

- Create Class (`Class`)
  - Set Attribute (`Attribute`)
  - Set Association Target End (`Association Target End`)
  - Set Association Source End (`Association Source End`)

Set the properties for the following target elements:

- Create Class
  - Represents `Invokable`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
- Set Attribute
  - Represents `Data`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
- Set Association Target End
  - Represents `Data`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Traversable Mode `Traverse Specific Types`.
  - Traversable Types `Create Class: Class`.
  - Use Child Mappings From `Create Class: Class`.
- Set Association Source End
  - Represents `Data`.
  - Is Required Function `return false;`.
  - Is Mappable Function `return true;`.
  - Allow Multiple Mappings `checked`.
  - Traversable Mode `Traverse Specific Types`.
  - Traversable Types `Create Class: Class`.
  - Use Child Mappings From `Create Class: Class`.

Add the following Mapping Types to the `Element Mapping` by right clicking and selecting `Add Mapping Type` and set their properties accordingly:

- Invocation Mapping
  - Source Types `Command: Command`.
  - Target Types `Create Class: Class`.
  - Represents `Invokable`.
- Data Mapping
  - Source Types `Field: DTO-Field`, `Collection Field: DTO-Field`.
  - Target Types `Set Attribute: Attribute`, `Set Association Target End: Association Target End`.
  - Represents `Data`.

## Create Template for Mapping code

![Template for Mapping code](images/template-mapping-code.png)

Create a new template in the `ElementMappingModule` for mapping commands to domain entities by right clicking on the `ElementMappingModule` package and selecting `New C# Template`.

Ensure the following properties are set:

- Type `Single File`.
- Templating Method `C# File Builder`.
- Designer `Services`.
- Model Type `Command`.
