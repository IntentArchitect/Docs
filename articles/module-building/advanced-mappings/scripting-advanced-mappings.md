---
uid: module-building.scripting-advanced-mappings
---

# Scripting Advanced Mappings

Advanced Mappings enable you to define data transformation paths between model elements programmatically. This guide builds on [Designer Scripting](xref:module-building.designers.designer-scripting) and shows you how to create and configure advanced mappings within your scripts.

## What Are Advanced Mappings?

An Advanced Mapping is a configuration that establishes a relationship between a source and a target element, defining an intended interaction. This interaction can be an **invocation flow** (like calling a method or constructor) or a **data transformation** (like mapping properties).

Think of it as creating a pointer from a source to a target to signify an action. You can then specify how to perform that action:
- An **Invocation Mapping** defines *what* to invoke on the target element.
- A **Data Mapping** defines *how* to flow data between the elements (e.g., which source fields correspond to which target fields).

> **Note:** The examples in this guide use Command and Entity elements from a typical Services/Domain designer architecture, but advanced mappings are designer-agnostic. You can set up mappings between any custom designer elements and associate them with any custom association types you define. The underlying principles remain the same regardless of the specific elements or designers involved.

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

> **Designer Flexibility:** The mapping type names and interaction patterns are intentional abstractions. Any designer can define its own mapping types and use them for any purpose. The examples below reference common CRUD patterns from Services/Domain designers, but the same concepts apply to custom designer designs.

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

> **Note:** These CRUD action types are conventions used in Services/Domain designer patterns. You can create any association type for any purpose—the underlying principle is the same: the association declares the intent, and mappings attached to it specify how to fulfill that intent.

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

### Example 1: Simple Invocation Mapping

Create a mapping that invokes a target constructor.

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

await dialogService.info("Invocation mapping created!");
```

**What This Does:**
- Tells templates that `CreateOrder` should invoke the `Order` constructor
- Templates will generate: `new Order(...)`

### Example 2: Single Data Mapping

Map one field to one attribute.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

// Create the container and mapping (invocation already done)
let action = createAssociation("Create Entity Action", command.id, orderEntity.id);
let mapping = action.createAdvancedMapping(command.id, orderEntity.id);

// Add invocation mapping
mapping.addMappedEnd("Invocation Mapping", [command.id], [orderEntity.id]);

// Add data mapping: RefNo field → RefNo attribute
let refNoField = command.getChildren("DTO-Field").find(x => x.getName() === "RefNo");
let refNoAttr = orderEntity.getChildren("Attribute").find(x => x.getName() === "RefNo");

if (refNoField && refNoAttr) {
    mapping.addMappedEnd(
        "Data Mapping",
        [command.id, refNoField.id],    // Path: from command, through RefNo field
        [orderEntity.id, refNoAttr.id]  // Path: to entity, to RefNo attribute
    );
}

await dialogService.info("Data mapping created!");
```

**What This Does:**
- Tells templates to assign command.RefNo to result.RefNo
- Templates will generate: `RefNo = source.RefNo`

### Example 3: Filter Mapping for Queries

Define a filter condition using primary keys.

```javascript
let query = lookupTypesOf("Query").find(x => x.getName() === "GetOrderById");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

// Create the query action and mapping
let action = createAssociation("Query Entity Action", query.id, orderEntity.id);
let mapping = action.createAdvancedMapping(query.id, orderEntity.id);

// Add filter mapping: Id field → Id attribute (primary key)
let idField = query.getChildren("DTO-Field").find(x => x.getName() === "Id");
let idAttr = orderEntity.getChildren("Attribute").find(x => {
    return x.hasStereotype && x.hasStereotype("Primary Key");
});

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

### Example 4: Multiple Data Mappings

Map several fields to an entity.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

let action = createAssociation("Create Entity Action", command.id, orderEntity.id);
let mapping = action.createAdvancedMapping(command.id, orderEntity.id);

// Invocation mapping
mapping.addMappedEnd("Invocation Mapping", [command.id], [orderEntity.id]);

// Helper function to add data mappings
function mapField(fieldName) {
    let field = command.getChildren("DTO-Field").find(x => x.getName() === fieldName);
    let attr = orderEntity.getChildren("Attribute").find(x => x.getName() === fieldName);
    
    if (field && attr) {
        mapping.addMappedEnd(
            "Data Mapping",
            [command.id, field.id],
            [orderEntity.id, attr.id]
        );
        return true;
    }
    return false;
}

// Map multiple fields
let mappedCount = 0;
const fieldsToMap = ["RefNo", "CreatedDate", "TotalAmount"];

fieldsToMap.forEach(fieldName => {
    if (mapField(fieldName)) {
        mappedCount++;
    }
});

await dialogService.info(`Mapped ${mappedCount} fields!`);
```

**What This Does:**
- Creates multiple data mappings in a single operation
- Generates:
  ```csharp
  new Order
  {
      RefNo = source.RefNo,
      CreatedDate = source.CreatedDate,
      TotalAmount = source.TotalAmount
  }
  ```

### Example 5: Mapping Collections

Handle collection fields that map to associations.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

let action = createAssociation("Create Entity Action", command.id, orderEntity.id);
let mapping = action.createAdvancedMapping(command.id, orderEntity.id);

mapping.addMappedEnd("Invocation Mapping", [command.id], [orderEntity.id]);

// Map the collection field to the association
let orderLinesField = command.getChildren("DTO-Field").find(x => x.getName() === "OrderLines");

// Find the OrderLines association on the entity
let orderLinesAssoc = orderEntity.getAssociations("Association").find(x => x.getName() === "OrderLines");

if (orderLinesField && orderLinesAssoc) {
    // Check if it's a collection
    if (orderLinesField.typeReference.getIsCollection()) {
        mapping.addMappedEnd(
            "Data Mapping",
            [command.id, orderLinesField.id],
            [orderEntity.id, orderLinesAssoc.id]
        );
        
        await dialogService.info("Collection mapping created!");
    }
}
```

**What This Does:**
- Maps collection fields to navigation properties
- Tells templates to handle nested SelectMany operations
- Generates: `OrderLines = source.OrderLines.Select(...).ToList()`

### Example 6: Deeply Nested Data Mapping

Map nested objects within objects using multi-level path traversal.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

let action = createAssociation("Create Entity Action", command.id, orderEntity.id);
let mapping = action.createAdvancedMapping(command.id, orderEntity.id);

// Add invocation
mapping.addMappedEnd("Invocation Mapping", [command.id], [orderEntity.id]);

// Map nested object: Command.ShippingDetails -> Order.ShippingInfo
let shippingDetailsField = command.getChildren("DTO-Field").find(x => x.getName() === "ShippingDetails");
let shippingInfoAssoc = orderEntity.getAssociations("Association").find(x => x.getName() === "ShippingInfo");

if (shippingDetailsField && shippingInfoAssoc) {
    // First: map the container object itself
    mapping.addMappedEnd(
        "Data Mapping",
        [command.id, shippingDetailsField.id],
        [orderEntity.id, shippingInfoAssoc.id]
    );
    
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
- Maps multiple fields within the nested objects using multi-level paths
- Templates will generate:
  ```csharp
  ShippingInfo = new ShippingAddress
  {
      Street = command.ShippingDetails.Street,
      City = command.ShippingDetails.City
  }
  ```

### Example 7: Combining Multiple Mapping Types

Create an Update scenario with both Query and Data Mappings.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "UpdateOrder");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

let action = createAssociation("Update Entity Action", command.id, orderEntity.id);

// First mapping: Query to find the entity
let queryMapping = action.createAdvancedMapping(
    command.id,
    orderEntity.id,
    "25f25af9-c38b-4053-9474-b0fabe9d7ea7"  // Query mapping type
);

let idField = command.getChildren("DTO-Field").find(x => x.getName() === "Id");
let idAttr = orderEntity.getChildren("Attribute").find(x => x.hasStereotype("Primary Key"));

if (idField && idAttr) {
    queryMapping.addMappedEnd(
        "Filter Mapping",
        [command.id, idField.id],
        [orderEntity.id, idAttr.id]
    );
}

// Second mapping: Data to update fields (excluding PK)
let dataMapping = action.createAdvancedMapping(
    command.id,
    orderEntity.id,
    "01721b1a-a85d-4320-a5cd-8bd39247196a"  // Update mapping type
);

// Add data mappings for fields other than Id
["RefNo", "CreatedDate"].forEach(fieldName => {
    let field = command.getChildren("DTO-Field").find(x => x.getName() === fieldName);
    let attr = orderEntity.getChildren("Attribute").find(x => x.getName() === fieldName);
    
    if (field && attr) {
        dataMapping.addMappedEnd(
            "Data Mapping",
            [command.id, field.id],
            [orderEntity.id, attr.id]
        );
    }
});

await dialogService.info("Update mapping created!");
```

**What This Does:**
- Creates two separate mappings: find + update
- Generates:
  ```csharp
  var existing = dbContext.Orders.Where(x => x.Id == command.Id).FirstOrDefault();
  existing.RefNo = command.RefNo;
  existing.CreatedDate = command.CreatedDate;
  ```

---

## Advanced Use Cases

### Example 8: Nested Object Mapping with Path Traversal

Map deeply nested objects using path traversal.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");
let orderLineEntity = lookupTypesOf("Class").find(x => x.getName() === "OrderLine");

let action = createAssociation("Create Entity Action", command.id, orderEntity.id);
let mapping = action.createAdvancedMapping(command.id, orderEntity.id);

// Invocation for Order
mapping.addMappedEnd("Invocation Mapping", [command.id], [orderEntity.id]);

// Navigate: Command.OrderLines (collection field) -> OrderLine DTO
let orderLinesField = command.getChildren("DTO-Field").find(x => x.getName() === "OrderLines");
let orderLinesAssoc = orderEntity.getAssociations("Association").find(x => x.getName() === "OrderLines");

// The association's target is OrderLineEntity
let orderLineTarget = orderLinesAssoc.typeReference.getType();

// Map the collection field itself
mapping.addMappedEnd(
    "Data Mapping",
    [command.id, orderLinesField.id],
    [orderEntity.id, orderLinesAssoc.id]
);

// Now map nested fields: OrderLine.Description -> OrderLine entity
let orderLineDto = orderLinesField.typeReference.getType(); // Get the DTO type
let descField = orderLineDto.getChildren("DTO-Field").find(x => x.getName() === "Description");
let descAttr = orderLineEntity.getChildren("Attribute").find(x => x.getName() === "Description");

if (descField && descAttr) {
    // The path goes: command -> orderLinesField -> orderLinesAssoc -> descAttr
    mapping.addMappedEnd(
        "Data Mapping",
        [command.id, orderLinesField.id, descField.id],
        [orderEntity.id, orderLinesAssoc.id, descAttr.id]
    );
}

await dialogService.info("Nested mapping created!");
```

**What This Does:**
- Creates a path through nested objects
- Generates:
  ```csharp
  OrderLines = source.OrderLines.Select(ol => new OrderLine
  {
      Description = ol.Description
  }).ToList()
  ```

### Example 9: Aggregate Root Scenario with Key Chains

Handle hierarchical entities that need parent keys.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrderLine");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");
let orderLineEntity = lookupTypesOf("Class").find(x => x.getName() === "OrderLine");

// OrderLine is owned by Order, so we need the Order Id
let action = createAssociation("Create Entity Action", command.id, orderLineEntity.id);
let mapping = action.createAdvancedMapping(command.id, orderLineEntity.id);

// Invocation for OrderLine
mapping.addMappedEnd("Invocation Mapping", [command.id], [orderLineEntity.id]);

// Map regular fields
let descField = command.getChildren("DTO-Field").find(x => x.getName() === "Description");
let descAttr = orderLineEntity.getChildren("Attribute").find(x => x.getName() === "Description");

if (descField && descAttr) {
    mapping.addMappedEnd(
        "Data Mapping",
        [command.id, descField.id],
        [orderLineEntity.id, descAttr.id]
    );
}

// Map the aggregate key (OrderId)
let orderIdField = command.getChildren("DTO-Field").find(x => x.getName() === "OrderId");
let orderIdAttr = orderLineEntity.getChildren("Attribute").find(x => x.getName() === "OrderId");

if (orderIdField && orderIdAttr) {
    mapping.addMappedEnd(
        "Data Mapping",
        [command.id, orderIdField.id],
        [orderLineEntity.id, orderIdAttr.id]
    );
}

await dialogService.info("Aggregate root mapping created!");
```

**What This Does:**
- Maps both the entity's own fields and parent reference keys
- Ensures nested entities can be queried through parent-child relationships
- Supports composite aggregate hierarchies

### Example 10: Automatic Mapping by Naming Convention

Programmatically create mappings based on field/attribute name matching.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let orderEntity = lookupTypesOf("Class").find(x => x.getName() === "Order");

if (!command || !orderEntity) return;

let action = createAssociation("Create Entity Action", command.id, orderEntity.id);
let mapping = action.createAdvancedMapping(command.id, orderEntity.id);

// Add invocation
mapping.addMappedEnd("Invocation Mapping", [command.id], [orderEntity.id]);

// Auto-map: for each command field, find matching attribute by name
let commandFields = command.getChildren("DTO-Field");
let entityAttrs = orderEntity.getChildren("Attribute");

let mappedCount = 0;

commandFields.forEach(field => {
    // Find attribute with same name (case-insensitive)
    let matchingAttr = entityAttrs.find(attr => 
        attr.getName().toLowerCase() === field.getName().toLowerCase()
    );
    
    if (matchingAttr) {
        mapping.addMappedEnd(
            "Data Mapping",
            [command.id, field.id],
            [orderEntity.id, matchingAttr.id]
        );
        mappedCount++;
    }
});

await dialogService.info(`Auto-mapped ${mappedCount} fields by convention!`);
```

**What This Does:**
- Automatically discovers mappings based on naming conventions
- Reduces boilerplate for straightforward scenarios
- Can be extended with more sophisticated matching logic

---

## Best Practices & Patterns

### Path Construction

When building paths, remember they're arrays of element IDs traversing a hierarchy:

```javascript
// Direct mapping: command → orderEntity
[command.id]
[orderEntity.id]

// Field mapping: command → field → attribute
[command.id, field.id]
[orderEntity.id, attribute.id]

// Nested mapping: command → field → association → nested attribute
[command.id, orderLinesField.id, descriptionField.id]
[orderEntity.id, orderLinesAssoc.id, descriptionAttr.id]
```

### Error Handling

Always validate elements before creating mappings:

```javascript
function createMappingWithValidation(sourceName, targetName, mappingType) {
    let source = lookupTypesOf("Command").find(x => x.getName() === sourceName);
    let target = lookupTypesOf("Class").find(x => x.getName() === targetName);
    
    if (!source) {
        await dialogService.error(`Command '${sourceName}' not found`);
        return false;
    }
    
    if (!target) {
        await dialogService.error(`Class '${targetName}' not found`);
        return false;
    }
    
    try {
        let action = createAssociation("Create Entity Action", source.id, target.id);
        let mapping = action.createAdvancedMapping(source.id, target.id);
        
        mapping.addMappedEnd("Invocation Mapping", [source.id], [target.id]);
        
        return true;
    } catch (err) {
        await dialogService.error(`Failed to create mapping: ${err.message}`);
        return false;
    }
}
```

### Filtering to Non-Collection Fields

When mapping data fields (not collections), filter appropriately:

```javascript
let commandFields = command.getChildren("DTO-Field")
    .filter(f => !f.typeReference.getIsCollection()); // Exclude collections

commandFields.forEach(field => {
    // ... map only scalar fields
});
```

### Detecting Primary Keys

When creating Filter Mappings, target primary keys:

```javascript
let primaryKeyAttrs = orderEntity.getChildren("Attribute")
    .filter(attr => attr.hasStereotype && attr.hasStereotype("Primary Key"));

primaryKeyAttrs.forEach(pkAttr => {
    // Create filter mapping for this primary key
});
```

---

## Common Patterns & When to Use Them

### Pattern: Create from Command/DTO

**When to Use:** Generating code that creates new entities from input commands/DTOs

**Structure:**
```javascript
let action = createAssociation("Create Entity Action", command.id, entity.id);
let mapping = action.createAdvancedMapping(command.id, entity.id);

mapping.addMappedEnd("Invocation Mapping", [command.id], [entity.id]);

// Add data mappings for all fields
```

**Generated Code:**
```csharp
var entity = new Entity { Field1 = source.Field1, Field2 = source.Field2 };
```

### Pattern: Update from Command

**When to Use:** Generating code that updates existing entities

**Structure:**
```javascript
// Query mapping to find the entity
let queryMapping = action.createAdvancedMapping(command.id, entity.id, queryMappingTypeId);
mapping.addMappedEnd("Filter Mapping", [command.id, idField.id], [entity.id, idAttr.id]);

// Data mapping to update fields (excluding PKs)
let dataMapping = action.createAdvancedMapping(command.id, entity.id, updateMappingTypeId);
// Add data mappings for non-PK fields
```

**Generated Code:**
```csharp
var existing = dbContext.Entities.Where(x => x.Id == command.Id).FirstOrDefault();
existing.Field1 = command.Field1;
```

### Pattern: Query with Filter

**When to Use:** Generating code that queries entities by ID or other criteria

**Structure:**
```javascript
let action = createAssociation("Query Entity Action", query.id, entity.id);
let mapping = action.createAdvancedMapping(query.id, entity.id);

mapping.addMappedEnd("Filter Mapping", [query.id, idField.id], [entity.id, idAttr.id]);
```

**Generated Code:**
```csharp
return dbContext.Entities.Where(x => x.Id == id).FirstOrDefault();
```

---

## Reference: CRUD Accelerators as Example

The [CRUD accelerators](xref:module-building.tutorial-advanced-mapping) in Intent Architect internally use these exact patterns to generate complete CRUD operations with advanced mappings. You can study how they:

- Detect entity structures
- Auto-create Commands/Queries with proper field mapping
- Build path hierarchies for nested objects
- Handle aggregate roots and key chains

This is a real-world application of the techniques shown in this guide.

---

## Next Steps

- See [Tutorial: Advanced Mapping](xref:module-building.tutorial-advanced-mapping) to learn how to configure mapping-enabled designers in the Module Builder
- Return to [Designer Scripting](xref:module-building.designers.designer-scripting) for other scripting techniques
- Review [Association and Mapping APIs](xref:module-building.designers.designer-scripting#core-api-interfaces) in the Designer Scripting reference for detailed method signatures
