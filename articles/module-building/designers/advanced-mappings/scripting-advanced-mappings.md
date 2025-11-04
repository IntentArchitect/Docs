---
uid: module-building.designers.scripting-advanced-mappings
---

# Scripting Advanced Mappings

Advanced Mappings enable you to define data transformation paths between model elements programmatically. This guide builds on [Designer Scripting](xref:module-building.designers.designer-scripting) and shows you how to create and configure advanced mappings within your scripts.

## What Are Advanced Mappings?

An Advanced Mapping is a configuration that establishes a relationship between a source and a target element, defining an intended interaction. This interaction can be an **invocation flow** (like calling a method or constructor) or a **data transformation** (like mapping properties).

Think of it as creating a pointer from a source to a target to signify an action. You can then specify how to perform that action:
- An **Invocation Mapping** defines *what* to invoke on the target element.
- A **Data Mapping** defines *how* to flow data between the elements (e.g., which source fields correspond to which target fields).

> [!NOTE]
> 
> The examples in this guide use Command and Entity elements from a typical Services/Domain designer architecture, but advanced mappings are designer-agnostic. You can set up mappings between any custom designer elements and associate them with any custom association types you define. The underlying principles remain the same regardless of the specific elements or designers involved.

For example, when mapping a `CreateOrderCommand` to an `Order` class, advanced mappings act as a **blueprint for code generation**. They don't execute code themselves as they provide a declarative plan that templates can follow:

- An **Invocation Mapping** tells templates to create an `Order` instance.
- **Data Mappings** tell templates which command fields to assign to which order attributes.

A code generation template reads this blueprint and produces the corresponding C# code:

```csharp
// Template sees the Invocation Mapping and generates:
var order = new Order
{
    // Template sees the Data Mappings and generates:
    RefNo = command.RefNo,
    CreatedDate = command.CreatedDate
};
```

## Core Concepts: The Mapping Types

Advanced Mappings are configured using different mapping types. While developers can create custom types, most use cases involve two primary ones: `Invocation Mapping` and `Data Mapping`.

> [!NOTE]
> 
> The mapping type names and interaction patterns are intentional abstractions. Any designer can define its own mapping types and use them for any purpose. The examples below reference common CRUD patterns from Services/Domain designers, but the same concepts apply to custom designer designs.

Each type defines a specific kind of interaction:

### Invocation Mapping

**Purpose:** Establishes the "call" or "invocation" relationship. It points from a source to a target operation, constructor, or factory method that should be executed.

**Common Targets:**
- Class constructors
- Operation methods
- Factory methods

**Generated Pattern:**
```csharp
new Order(...)
// or
entity.UpdateStatus(...)
// or
Order.CreateOrder(...)
```

**When to Use:**
- To specify that a constructor should be called.
- To trigger a method on an existing entity.
- To create new instances as part of a larger transformation.

### Data Mapping

**Purpose:** Defines how data flows between the source and target. It acts as the "arguments" for an invocation, specifying which source properties map to which target properties.

**Common Targets:**
- Entity Attributes
- Association Target Ends (for nested objects)
- Collection properties

**Generated Pattern:**
```csharp
result.RefNo = source.RefNo;
result.ShippingInfo.Street = source.ShippingDetails.Street;
result.ShippingInfo.City = source.ShippingDetails.City;
result.OrderLines = source.OrderLines.Select(...).ToList();
```

**When to Use:**
- Copying field values from source to target.
- Handling both simple and collection properties.
- Mapping nested objects.

### Filter Mapping

A third fundamental type, `Filter Mapping`, is used for query operations.

**Purpose:** Define query conditions, typically for identifying which entity to operate on.

**Common Targets:**
- Primary Key attributes
- Unique identifier fields

**Generated Pattern:**
```csharp
where(x => x.Id == id)
// or
.FirstOrDefault(x => x.OrderId == orderId && x.LineId == lineId)
```

**When to Use:**
- Finding entities by ID in Update/Delete operations
- Creating WHERE clauses for queries
- Specifying lookup conditions

## The Three-Step Process

Creating an advanced mapping always follows the same pattern:

```javascript
// Step 1: Create the container association
let action = createAssociation("Create Entity Action", source.id, target.id);

// Step 2: Create the mapping object from the association
let mapping = action.createAdvancedMapping(source.id, target.id);

// Step 3: Add mapped ends to define the data flow
mapping.addMappedEnd("Invocation Mapping", [source.id], [target.id]);
mapping.addMappedEnd("Data Mapping", [source.id, field.id], [target.id, attribute.id]);
```

### Step 1: Create an Association Action

The association "action" is a container that establishes the **intent** of the relationship between two elements. It signals "these elements are connected for this purpose." From this association, mappings then flow to define the specific data transformations or behaviors.

**Common Association Action Types (CRUD Examples):**
- `"Create Entity Action"` - Intent: Maps input to entity creation
- `"Update Entity Action"` - Intent: Maps input to entity update
- `"Delete Entity Action"` - Intent: Maps input to entity deletion
- `"Query Entity Action"` - Intent: Maps input to entity query

> [!NOTE]
> 
> These CRUD action types are conventions used in Services/Domain designer patterns. You can create any association type for any purpose—the underlying principle is the same: the association declares the intent, and mappings attached to it specify how to fulfill that intent.

```javascript
let action = createAssociation("Create Entity Action", sourceElement.id, targetEntity.id);
```

### Step 2: Create the Advanced Mapping

From the association, create the actual mapping object. Optionally specify a mapping type ID to enable different mapping strategies.

```javascript
// Simple mapping (will use default mapping type)
let mapping = action.createAdvancedMapping(sourceElement.id, targetEntity.id);

// Specific mapping type (Query mapping, for example)
let mapping = action.createAdvancedMapping(
    sourceElement.id,
    targetEntity.id,
    "25f25af9-c38b-4053-9474-b0fabe9d7ea7"  // Query mapping type ID
);
```

### Step 3: Add Mapped Ends

Add the actual data flow paths to the mapping. Each `addMappedEnd` call defines one transformation rule.

```javascript
mapping.addMappedEnd(
    "Invocation Mapping",      // The type of mapping
    [source.id],               // Source path (array of element IDs)
    [target.id]                // Target path (array of element IDs)
);
```

---

## Elementary Examples

### Prerequisites for Running Examples

Before running any of the examples below, you'll need to set up some basic model elements. Since Intent Architect only has access to the context of the currently open designer tab, you'll need to run two separate scripts in different designers.

**Step 1: Create the Order Entity (in Domain Designer)**

First, open your Domain Designer and run this script in the **Execute Script Dialog**:

```javascript
// Domain Designer Setup - Run this first in the Domain Designer

// Get the first package (or create one if needed)
let packageId = getPackages()[0]?.id;
if (!packageId) {
    await dialogService.error("No packages found. Please create a Domain package first.");
    return;
}

// Define type constants
const guidType = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";

// Create the Order entity
let orderEntity = createElement("Class", "Order", packageId);

// Add attributes to Order entity
createElement("Attribute", "RefNo", orderEntity.id);
createElement("Attribute", "CreatedDate", orderEntity.id);
createElement("Attribute", "TotalAmount", orderEntity.id);

// Note: Id attribute is typically auto-generated by Intent.Metadata.RDBMS module

// Create the OrderLine entity
let orderLineEntity = createElement("Class", "OrderLine", packageId);
createElement("Attribute", "Description", orderLineEntity.id);
let orderIdAttr = createElement("Attribute", "OrderId", orderLineEntity.id);
orderIdAttr.typeReference.setType(guidType);

// Create composite association: Order (1) -> OrderLines (*)
let association = createAssociation("Association", orderEntity.id, orderLineEntity.id, "OrderLines");
association.typeReference.setIsCollection(true);
association.getOtherEnd().typeReference.setIsCollection(false);

// Create ShippingInfo entity for nested object mapping
let shippingInfoEntity = createElement("Class", "ShippingInfo", packageId);
createElement("Attribute", "Street", shippingInfoEntity.id);
createElement("Attribute", "City", shippingInfoEntity.id);

// Create association: Order (1) -> ShippingInfo (1)
let shippingAssoc = createAssociation("Association", orderEntity.id, shippingInfoEntity.id, "ShippingInfo");
shippingAssoc.typeReference.setIsCollection(false);
shippingAssoc.getOtherEnd().typeReference.setIsCollection(false);

await dialogService.info("Domain entities and associations created successfully!");
```

**Step 2: Create Services Elements (in Services Designer)**

Next, switch to your Services Designer and run this script in the **Execute Script Dialog**:

```javascript
// Services Designer Setup - Run this second in the Services Designer

// Get the first package (or create one if needed)
let packageId = getPackages()[0]?.id;
if (!packageId) {
    await dialogService.error("No packages found. Please create a Services package first.");
    return;
}

// Define type constants
const guidType = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";

// Create the CreateOrder command
let createOrderCommand = createElement("Command", "CreateOrder", packageId);

// Add fields to CreateOrder command
createElement("DTO-Field", "RefNo", createOrderCommand.id);
createElement("DTO-Field", "CreatedDate", createOrderCommand.id);
createElement("DTO-Field", "TotalAmount", createOrderCommand.id);

// Create the OrderDto
let orderDto = createElement("DTO", "OrderDto", packageId);

// Add fields to OrderDto
let idField = createElement("DTO-Field", "Id", orderDto.id);
idField.typeReference.setType(guidType); // guid type

createElement("DTO-Field", "RefNo", orderDto.id);
createElement("DTO-Field", "CreatedDate", orderDto.id);
createElement("DTO-Field", "TotalAmount", orderDto.id);

// Create the GetOrderById query
let getOrderByIdQuery = createElement("Query", "GetOrderById", packageId);

// Add Id field to query
idField = createElement("DTO-Field", "Id", getOrderByIdQuery.id);
idField.typeReference.setType(guidType); // guid type

// Set return type to OrderDto
getOrderByIdQuery.typeReference.setType(orderDto.id);

await dialogService.info("Services elements created successfully!");
```

These scripts will automatically create:
- An `Order` entity with `RefNo`, `CreatedDate`, and `TotalAmount` attributes (Domain Designer, `Id` is auto-generated)
- An `OrderLine` entity with `Description` and `OrderId` attributes (Domain Designer)
- A `ShippingInfo` entity with `Street` and `City` attributes (Domain Designer)
- Associations between Order→OrderLine and Order→ShippingInfo (Domain Designer)
- A `CreateOrder` command with matching fields (Services Designer)
- An `OrderDto` with matching fields (Services Designer)
- A `GetOrderById` query with an `Id` parameter and `OrderDto` return type (Services Designer)

Once you've run both setup scripts, you can run the individual examples below in the **Execute Script Dialog** while in the **Services Designer**.

---

### Example 1: Basic Create Mapping

Create a mapping that invokes a target constructor and maps all data fields.

```javascript
// Find elements
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

if (!command || !orderEntity) {
    await dialogService.error("Could not find Command or Entity");
    return;
}

// Step 1: Create the container
let action = createAssociation("Create Entity Action", command.id, orderEntity.id);

// Step 2: Create the mapping
let mapping = action.createAdvancedMapping(command.id, orderEntity.id);

// Step 3: Add the invocation - trigger the Order constructor
mapping.addMappedEnd("Invocation Mapping", [command.id], [orderEntity.id]);

// Step 4: Add data mappings for all fields
let refNoField = command.getChildren("DTO-Field").find(x => x.getName() === "RefNo");
let refNoAttr = orderEntity.getChildren("Attribute").find(x => x.getName() === "RefNo");

if (refNoField && refNoAttr) {
    mapping.addMappedEnd(
        "Data Mapping",
        [command.id, refNoField.id],    // Path: from command, through RefNo field
        [orderEntity.id, refNoAttr.id]  // Path: to entity, to RefNo attribute
    );
}

let createdDateField = command.getChildren("DTO-Field").find(x => x.getName() === "CreatedDate");
let createdDateAttr = orderEntity.getChildren("Attribute").find(x => x.getName() === "CreatedDate");

if (createdDateField && createdDateAttr) {
    mapping.addMappedEnd(
        "Data Mapping",
        [command.id, createdDateField.id],
        [orderEntity.id, createdDateAttr.id]
    );
}

let totalAmountField = command.getChildren("DTO-Field").find(x => x.getName() === "TotalAmount");
let totalAmountAttr = orderEntity.getChildren("Attribute").find(x => x.getName() === "TotalAmount");

if (totalAmountField && totalAmountAttr) {
    mapping.addMappedEnd(
        "Data Mapping",
        [command.id, totalAmountField.id],
        [orderEntity.id, totalAmountAttr.id]
    );
}

await dialogService.info("Complete create mapping created!");
```

**What This Does:**
- Tells templates that `CreateOrder` should invoke the `Order` constructor
- Maps all command fields to corresponding entity attributes
- Templates will generate:
  ```csharp
  new Order
  {
      RefNo = command.RefNo,
      CreatedDate = command.CreatedDate,
      TotalAmount = command.TotalAmount
  }
  ```

### Example 2: Filter Mapping for Queries

Define a filter condition using primary keys.

```javascript
let query = lookupTypesOf("Query").find(x => x.getName() === "GetOrderById");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

// Create the query action and mapping
let action = createAssociation("Query Entity Action", query.id, orderEntity.id);
let mapping = action.createAdvancedMapping(query.id, orderEntity.id);

// Add filter mapping: Id field → Id attribute (primary key)
let idField = query.getChildren("DTO-Field").find(x => x.getName() === "Id");
let idAttr = orderEntity.getChildren("Attribute").find(x => x.getName() === "Id");

if (idField && idAttr) {
    mapping.addMappedEnd(
        "Filter Mapping",
        [query.id, idField.id],
        [orderEntity.id, idAttr.id]
    );
}

await dialogService.info("Filter mapping created!");
```

**What This Does:**
- Tells templates to filter by Id
- Templates will generate: `where(x => x.Id == id)`

---

## Intermediate Examples

### Prerequisites for Intermediate Examples

The intermediate examples (3-4) require additional model elements beyond the basic setup. Run this script in the **Services Designer** before attempting Examples 3-4:

```javascript
// Advanced Elements Setup - Run this in the Services Designer before Examples 3-4

// Get the first package
let packageId = getPackages()[0]?.id;
if (!packageId) {
    await dialogService.error("No packages found. Please create a Services package first.");
    return;
}

// Define type constants
const guidType = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";

// Find existing elements
let createOrderCommand = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let orderDto = lookupTypesOf("DTO").find(x => x.getName() === "OrderDto");

if (!createOrderCommand || !orderDto) {
    await dialogService.error("Run the basic Services setup first!");
    return;
}

// Create OrderLine DTO for collections
let orderLineDto = createElement("DTO", "OrderLineDto", packageId);
createElement("DTO-Field", "Description", orderLineDto.id);

// Add OrderLines collection field to CreateOrder command
let orderLinesField = createElement("DTO-Field", "OrderLines", createOrderCommand.id);
orderLinesField.typeReference.setType(orderLineDto.id);
orderLinesField.typeReference.setIsCollection(true);

// Create ShippingDetails DTO for nested objects
let shippingDetailsDto = createElement("DTO", "ShippingDetailsDto", packageId);
createElement("DTO-Field", "Street", shippingDetailsDto.id);
createElement("DTO-Field", "City", shippingDetailsDto.id);

// Add ShippingDetails field to CreateOrder command
let shippingDetailsField = createElement("DTO-Field", "ShippingDetails", createOrderCommand.id);
shippingDetailsField.typeReference.setType(shippingDetailsDto.id);

// Create UpdateOrder command
let updateOrderCommand = createElement("Command", "UpdateOrder", packageId);
let idField = createElement("DTO-Field", "Id", updateOrderCommand.id);
idField.typeReference.setType(guidType);
createElement("DTO-Field", "RefNo", updateOrderCommand.id);
createElement("DTO-Field", "CreatedDate", updateOrderCommand.id);

// Create CreateOrderLine command
let createOrderLineCommand = createElement("Command", "CreateOrderLine", packageId);
createElement("DTO-Field", "Description", createOrderLineCommand.id);
let orderIdField = createElement("DTO-Field", "OrderId", createOrderLineCommand.id);
orderIdField.typeReference.setType(guidType);

await dialogService.info("Advanced elements created successfully!");
```

This script adds:
- `OrderLines` collection field to `CreateOrder` command
- `ShippingDetails` nested object field to `CreateOrder` command  
- `UpdateOrder` command for update operations
- `CreateOrderLine` command for hierarchical scenarios

### Example 3: Mapping Collections

*Requires the Advanced Elements Setup script to be run first.*

Handle collection fields that map to associations.

```javascript
let command = lookupTypesOf("Command").filter(x => x.getName() === "CreateOrder")[0];
let orderEntity = lookupTypesOf("Class").filter(x => x.getName() === "Order")[0];

if (!command || !orderEntity) {
    await dialogService.error("Could not find Command or Entity");
    return;
}

// Check if association already exists between command and entity
let action = command.getAssociations("Create Entity Action")
    .filter(x => x.typeReference?.typeId === orderEntity.id)[0];

if (!action) {
    // Create association if it doesn't exist
    action = createAssociation("Create Entity Action", command.id, orderEntity.id);
}

// Get or create mapping for the association
// Note: Check the API documentation for methods to retrieve existing mappings
let mapping = action.getAdvancedMapping("5f172141-fdba-426b-980e-163e782ff53e") ?? 
    action.createAdvancedMapping(command.id, orderEntity.id);

// Map the collection field to the association
let orderLinesField = command.getChildren("DTO-Field").find(x => x.getName() === "OrderLines");

// Find the OrderLines association on the entity
let orderLinesAssoc = orderEntity.getAssociations("Association").find(x => x.getName() === "OrderLines");

if (orderLinesField && orderLinesAssoc) {
    // Check if it's a collection
    if (orderLinesField.typeReference.getIsCollection()) {
        // Note: Check the API documentation for methods to check existing mapped ends
        mapping.addMappedEnd(
            "Data Mapping",
            [command.id, orderLinesField.id],
            [orderEntity.id, orderLinesAssoc.id]
        );
        
        // Also map the Description field within the collection
        let orderLineDto = orderLinesField.typeReference.getType();
        let descField = orderLineDto.getChildren("DTO-Field").find(x => x.getName() === "Description");
        let orderLineEntity = orderLinesAssoc.typeReference.getType();
        let descAttr = orderLineEntity.getChildren("Attribute").find(x => x.getName() === "Description");
        
        if (descField && descAttr) {
            mapping.addMappedEnd(
                "Data Mapping",
                [command.id, orderLinesField.id, descField.id],
                [orderEntity.id, orderLinesAssoc.id, descAttr.id]
            );
        }
        
        await dialogService.info("Collection mapping created!");
    }
}
```

**What This Does:**
- Maps collection fields to navigation properties
- Tells templates to handle nested SelectMany operations
- Generates: `OrderLines = source.OrderLines.Select(...).ToList()`

### Example 4: Deeply Nested Data Mapping

*Requires the Advanced Elements Setup script to be run first.*

Map nested objects within objects using multi-level path traversal.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

if (!command || !orderEntity) {
    await dialogService.error("Could not find Command or Entity");
    return;
}

// Check if association already exists between command and entity
let action = command.getAssociations("Create Entity Action")
    .filter(x => x.typeReference?.typeId === orderEntity.id)[0];

if (!action) {
    // Create association if it doesn't exist
    action = createAssociation("Create Entity Action", command.id, orderEntity.id);
}

// Get or create mapping for the association
let mapping = action.getAdvancedMapping("5f172141-fdba-426b-980e-163e782ff53e") ?? 
    action.createAdvancedMapping(command.id, orderEntity.id);

// Map nested object: Command.ShippingDetails -> Order.ShippingInfo
let shippingDetailsField = command.getChildren("DTO-Field").find(x => x.getName() === "ShippingDetails");
let shippingInfoAssocEnd = orderEntity.getAssociations("Association").find(x => x.getName() === "ShippingInfo");

if (shippingDetailsField && shippingInfoAssocEnd) {
    let shippingInfoAssoc = shippingInfoAssocEnd;
    
    // Get the types to access their nested fields
    let shippingDetailsType = shippingDetailsField.typeReference.getType();
    let shippingInfoType = shippingInfoAssoc.typeReference.getType();
    
    // Map nested field: ShippingDetails.Street -> ShippingInfo.Street
    let streetField = shippingDetailsType.getChildren("DTO-Field").find(x => x.getName() === "Street");
    let streetAttr = shippingInfoType.getChildren("Attribute").find(x => x.getName() === "Street");
    
    if (streetField && streetAttr) {
        mapping.addMappedEnd(
            "Data Mapping",
            [command.id, shippingDetailsField.id, streetField.id],
            [orderEntity.id, shippingInfoAssoc.id, streetAttr.id]
        );
    }
    
    // Map another nested field: ShippingDetails.City -> ShippingInfo.City
    let cityField = shippingDetailsType.getChildren("DTO-Field").find(x => x.getName() === "City");
    let cityAttr = shippingInfoType.getChildren("Attribute").find(x => x.getName() === "City");
    
    if (cityField && cityAttr) {
        mapping.addMappedEnd(
            "Data Mapping",
            [command.id, shippingDetailsField.id, cityField.id],
            [orderEntity.id, shippingInfoAssoc.id, cityAttr.id]
        );
    }
}

await dialogService.info("Deeply nested mapping created!");
```

**What This Does:**
- Maps a nested object type to another nested object type
- Establishes the invocation to create the target entity
- Maps multiple fields within the nested objects using multi-level paths
- Templates will generate:
  ```csharp
  ShippingInfo = new ShippingAddress
  {
      Street = command.ShippingDetails.Street,
      City = command.ShippingDetails.City
  }
  ```

## Reference: Standard Mapping Type IDs

When working with Intent Architect's standard elements (Commands, Queries, Entities), you can use these predefined mapping type IDs to specify which kind of mapping to create:

| Mapping Type | ID |
|---|---|
| Query Entity Mapping | `25f25af9-c38b-4053-9474-b0fabe9d7ea7` |
| Create Entity Mapping | `5f172141-fdba-426b-980e-163e782ff53e` |
| Update Entity Mapping | `01721b1a-a85d-4320-a5cd-8bd39247196a` |
| Invocation Mapping | `a4c4c5cc-76df-48ed-9d4e-c35caf44b567` |

**Example Usage:**
```javascript
// Create a Query Entity mapping
let queryMapping = action.createAdvancedMapping(
    query.id,
    entity.id,
    "25f25af9-c38b-4053-9474-b0fabe9d7ea7"  // Query Entity Mapping ID
);

// Create a Create Entity mapping
let createMapping = action.createAdvancedMapping(
    command.id,
    entity.id,
    "5f172141-fdba-426b-980e-163e782ff53e"  // Create Entity Mapping ID
);
```

> [!NOTE]
> 
> These IDs are specific to Intent Architect's standard elements. Custom designers may define their own mapping type IDs. Refer to your module's documentation for custom mapping type identifiers.

---

## Next Steps

- See [Tutorial: Advanced Mapping](xref:module-building.tutorial-advanced-mapping) to learn how to configure mapping-enabled designers in the Module Builder
- Return to [Designer Scripting](xref:module-building.designers.designer-scripting) for other scripting techniques and API reference
- Review [Full API Documentation](xref:module-building.designers.designer-scripting#full-api-documentation) in the Designer Scripting reference for detailed method signatures
