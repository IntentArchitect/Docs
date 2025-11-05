---
uid: module-building.designers.scripting-advanced-mappings
---

# Scripting Advanced Mappings

Learn how to automate advanced mapping creation using scripts. This guide is for module builders and developers who want to programmatically create mappings between designer elements.

## What You'll Learn

This guide covers:
- Creating basic field-to-field mappings
- Mapping collections and nested objects
- Querying and validating existing mappings
- Common patterns and troubleshooting

## What Are Advanced Mappings?

Advanced Mappings are **blueprints for code generation**. When you map a `CreateOrder` command to an `Order` entity, you're telling templates:
- Which constructor or method to call (**Invocation Mapping**)
- Which fields map to which properties (**Data Mapping**)
- How to filter or query data (**Filter Mapping**)

Templates read these mappings and generate code:

```csharp
// Your mapping creates this blueprint:
// Invocation: new Order()
// Data: RefNo → RefNo, CreatedDate → CreatedDate

// Template generates:
var order = new Order
{
    RefNo = command.RefNo,
    CreatedDate = command.CreatedDate
};
```

**When to use scripting:**
- Automate repetitive mapping patterns across many elements
- Enforce consistent mapping conventions
- Build tools that help users create mappings

**When NOT to use scripting:**
- Simple one-off mappings (use the UI instead)
- You're still learning the basics (practice manual mapping first)

## Complete Setup Script

> [!IMPORTANT]
> 
> Before running any examples, execute this comprehensive setup script. It creates all the model elements needed for every example in this guide.

### Step 1: Domain Designer Setup

Open your **Domain Designer** and run this script:

```javascript
// Get the first package
let packageId = getPackages()[0]?.id;
if (!packageId) {
    await dialogService.error("Create a Domain package first");
    return;
}

const GuidTypeId = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";

// Create Order entity with attributes
let order = createElement("Class", "Order", packageId);
createElement("Attribute", "RefNo", order.id);
createElement("Attribute", "CreatedDate", order.id);
createElement("Attribute", "TotalAmount", order.id);

// Create OrderLine entity for collection example
let orderLine = createElement("Class", "OrderLine", packageId);
createElement("Attribute", "Description", orderLine.id);
let orderIdAttr = createElement("Attribute", "OrderId", orderLine.id);
orderIdAttr.typeReference.setType(GuidTypeId);

// Order -> OrderLines (1:many)
let orderLinesAssoc = createAssociation("Association", order.id, orderLine.id, "OrderLines");
orderLinesAssoc.typeReference.setIsCollection(true);
orderLinesAssoc.getOtherEnd().typeReference.setIsCollection(false);

// Create ShippingInfo for nested object example
let shippingInfo = createElement("Class", "ShippingInfo", packageId);
createElement("Attribute", "Street", shippingInfo.id);
createElement("Attribute", "City", shippingInfo.id);

// Order -> ShippingInfo (1:1)
let shippingAssoc = createAssociation("Association", order.id, shippingInfo.id, "ShippingInfo");
shippingAssoc.typeReference.setIsCollection(false);
shippingAssoc.getOtherEnd().typeReference.setIsCollection(false);

await dialogService.info("Domain entities created!");
```

### Step 2: Services Designer Setup

Switch to your **Services Designer** and run this script:

```javascript
// Get the first package
let packageId = getPackages()[0]?.id;
if (!packageId) {
    await dialogService.error("Create a Services package first");
    return;
}

const GuidTypeId = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";

// Create CreateOrder command
let createOrder = createElement("Command", "CreateOrder", packageId);
createElement("DTO-Field", "RefNo", createOrder.id);
createElement("DTO-Field", "CreatedDate", createOrder.id);
createElement("DTO-Field", "TotalAmount", createOrder.id);

// Create OrderLineDto for collection example
let orderLineDto = createElement("DTO", "OrderLineDto", packageId);
createElement("DTO-Field", "Description", orderLineDto.id);

// Add OrderLines collection to CreateOrder
let orderLinesField = createElement("DTO-Field", "OrderLines", createOrder.id);
orderLinesField.typeReference.setType(orderLineDto.id);
orderLinesField.typeReference.setIsCollection(true);

// Create ShippingDetailsDto for nested example
let shippingDetailsDto = createElement("DTO", "ShippingDetailsDto", packageId);
createElement("DTO-Field", "Street", shippingDetailsDto.id);
createElement("DTO-Field", "City", shippingDetailsDto.id);

// Add ShippingDetails to CreateOrder
let shippingField = createElement("DTO-Field", "ShippingDetails", createOrder.id);
shippingField.typeReference.setType(shippingDetailsDto.id);

// Create GetOrderById query
let getOrderById = createElement("Query", "GetOrderById", packageId);
let idField = createElement("DTO-Field", "Id", getOrderById.id);
idField.typeReference.setType(GuidTypeId);

// Create OrderDto for query return
let orderDto = createElement("DTO", "OrderDto", packageId);
idField = createElement("DTO-Field", "Id", orderDto.id);
idField.typeReference.setType(GuidTypeId);
createElement("DTO-Field", "RefNo", orderDto.id);
createElement("DTO-Field", "CreatedDate", orderDto.id);
createElement("DTO-Field", "TotalAmount", orderDto.id);

getOrderById.typeReference.setType(orderDto.id);

await dialogService.info("Services elements created!");
```

> [!TIP]
> **📸 SCREENSHOT NEEDED**: Show the **Execute Script Dialog** in Intent Architect:
> - Location: Designer toolbar → Tools → Execute Script
> - Empty script editor with "Run" button highlighted
> - Caption: "Access the Execute Script Dialog from the Designer toolbar to run setup scripts"

**What was created:**
- `Order`, `OrderLine`, `ShippingInfo` entities with associations (Domain)
- `CreateOrder` command with fields, collections, and nested objects (Services)
- `GetOrderById` query and `OrderDto` for query example (Services)

---

## Examples

All examples run in the **Services Designer**. Make sure you've completed the [setup scripts](#complete-setup-script) first.

### Example 1: Map Command Fields to Entity

Map `CreateOrder` command fields to `Order` entity attributes using the three-step process.

```javascript
// Find the command and entity
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let entity = lookupTypesOf("Class").find(x => x.getName() === "Order");

// Step 1: Create association (declares intent)
let action = createAssociation("Create Entity Action", command.id, entity.id);

// Step 2: Create the mapping
let mapping = action.createAdvancedMapping(command.id, entity.id);

// Step 3a: Add invocation (tells template to call constructor)
mapping.addMappedEnd("Invocation Mapping", [command.id], [entity.id]);

// Step 3b: Map each field
let fields = ["RefNo", "CreatedDate", "TotalAmount"];
fields.forEach(name => {
    let field = command.getChildren("DTO-Field").find(x => x.getName() === name);
    let attr = entity.getChildren("Attribute").find(x => x.getName() === name);
    
    if (field && attr) {
        mapping.addMappedEnd(
            "Data Mapping",
            [command.id, field.id],  // Source: command.Field
            [entity.id, attr.id]     // Target: entity.Attribute
        );
    }
});

await dialogService.info("Mapping created!");
```

**Understanding the code:**
- `lookupTypesOf("Command")` - Finds all Commands in the Services Designer
- `createAssociation()` - Creates "Create Entity Action" connecting command to entity
- `createAdvancedMapping()` - Creates the mapping blueprint on the association
- `addMappedEnd()` - Adds each transformation rule (Invocation + Data mappings)
- **Path arrays** `[command.id, field.id]` - Represents "command.RefNo" traversal

**Generated code:**
```csharp
var order = new Order  // From Invocation Mapping
{
    RefNo = command.RefNo,             // From Data Mapping
    CreatedDate = command.CreatedDate, // From Data Mapping
    TotalAmount = command.TotalAmount  // From Data Mapping
};
```

> [!TIP]
> **📸 SCREENSHOT NEEDED**: Show the resulting mapping in the Services Designer UI:
> - CreateOrder command element selected
> - "Create Entity Action" association visible connecting to Order entity
> - Advanced Mapping panel showing Invocation Mapping and Data Mappings
> - Mapped ends visible: RefNo→RefNo, CreatedDate→CreatedDate, TotalAmount→TotalAmount
> - Caption: "Advanced mapping created by Example 1 script, visible in the Services Designer"

### Example 2: Filter Mapping for Queries

Create a query mapping that filters by ID.

```javascript
let query = lookupTypesOf("Query").find(x => x.getName() === "GetOrderById");
let entity = lookupTypesOf("Class").find(x => x.getName() === "Order");

// Create query action and mapping
let action = createAssociation("Query Entity Action", query.id, entity.id);
let mapping = action.createAdvancedMapping(query.id, entity.id);

// Map Id field to Id attribute (filter condition)
let idField = query.getChildren("DTO-Field").find(x => x.getName() === "Id");
let idAttr = entity.getChildren("Attribute").find(x => x.getName() === "Id");

if (idField && idAttr) {
    mapping.addMappedEnd(
        "Filter Mapping",  // Tells template this is a WHERE clause
        [query.id, idField.id],
        [entity.id, idAttr.id]
    );
}

await dialogService.info("Filter mapping created!");
```

**Understanding the code:**
- `"Query Entity Action"` - Association type for query operations
- `"Filter Mapping"` - Tells templates to generate a WHERE clause
- Same path array pattern: `[parent.id, child.id]`

**Generated code:**
```csharp
var order = dbContext.Orders
    .Where(x => x.Id == query.Id)  // From Filter Mapping
    .FirstOrDefault();
```

### Example 3: Map Collection Fields

Map a collection property from command to entity.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let entity = lookupTypesOf("Class").find(x => x.getName() === "Order");

// Get or create mapping (reuse from Example 1 if it exists)
let action = command.getAssociations("Create Entity Action")
    .find(x => x.typeReference?.typeId === entity.id);
if (!action) {
    action = createAssociation("Create Entity Action", command.id, entity.id);
}

let mapping = action.getAdvancedMappings()[0];
if (!mapping) {
    mapping = action.createAdvancedMapping(command.id, entity.id);
}

// Find collection field and association
let orderLinesField = command.getChildren("DTO-Field").find(x => x.getName() === "OrderLines");
let orderLinesAssoc = entity.getAssociations("Association").find(x => x.getName() === "OrderLines");

if (orderLinesField && orderLinesAssoc) {
    // Map the collection
    mapping.addMappedEnd(
        "Data Mapping",
        [command.id, orderLinesField.id],
        [entity.id, orderLinesAssoc.id]
    );
    
    // Map fields within the collection
    let lineDto = orderLinesField.typeReference.getType();
    let lineEntity = orderLinesAssoc.typeReference.getType();
    
    let descField = lineDto.getChildren("DTO-Field").find(x => x.getName() === "Description");
    let descAttr = lineEntity.getChildren("Attribute").find(x => x.getName() === "Description");
    
    if (descField && descAttr) {
        mapping.addMappedEnd(
            "Data Mapping",
            [command.id, orderLinesField.id, descField.id],  // 3-level path
            [entity.id, orderLinesAssoc.id, descAttr.id]     // command.OrderLines[].Description
        );
    }
}

await dialogService.info("Collection mapping created!");
```

**Understanding the code:**
- **3-level paths** `[command.id, orderLinesField.id, descField.id]` - Represents "command.OrderLines[].Description"
- First `addMappedEnd()` maps the collection itself
- Second `addMappedEnd()` maps fields within each collection item

**Generated code:**
```csharp
OrderLines = command.OrderLines.Select(line => new OrderLine
{
    Description = line.Description  // From 3-level Data Mapping
}).ToList()
```

> [!TIP]
> **📸 SCREENSHOT NEEDED**: Show a collection mapping visualization:
> - CreateOrder.OrderLines field (collection) pointing to Order.OrderLines association
> - Nested path: OrderLines[].Description → OrderLines[].Description
> - Visual representation of the array traversal with [*] notation
> - Caption: "Collection mapping with nested field mappings"

### Example 4: Map Nested Objects

Map nested objects using multi-level paths.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let entity = lookupTypesOf("Class").find(x => x.getName() === "Order");

// Get existing mapping
let action = command.getAssociations("Create Entity Action")
    .find(x => x.typeReference?.typeId === entity.id);
let mapping = action.getAdvancedMappings()[0];

// Find nested object field and association
let shippingField = command.getChildren("DTO-Field").find(x => x.getName() === "ShippingDetails");
let shippingAssoc = entity.getAssociations("Association").find(x => x.getName() === "ShippingInfo");

if (shippingField && shippingAssoc) {
    // Get the nested types
    let detailsDto = shippingField.typeReference.getType();
    let infoEntity = shippingAssoc.typeReference.getType();
    
    // Map nested fields
    ["Street", "City"].forEach(fieldName => {
        let field = detailsDto.getChildren("DTO-Field").find(x => x.getName() === fieldName);
        let attr = infoEntity.getChildren("Attribute").find(x => x.getName() === fieldName);
        
        if (field && attr) {
            mapping.addMappedEnd(
                "Data Mapping",
                [command.id, shippingField.id, field.id],
                [entity.id, shippingAssoc.id, attr.id]
            );
        }
    });
}

await dialogService.info("Nested object mapping created!");
```

**Understanding the code:**
- Same 3-level path pattern for nested objects
- `command.ShippingDetails.Street` → `entity.ShippingInfo.Street`

**Generated code:**
```csharp
ShippingInfo = new ShippingInfo
{
    Street = command.ShippingDetails.Street,
    City = command.ShippingDetails.City
}
```

> [!TIP]
> **📸 SCREENSHOT NEEDED**: Show nested object mapping visualization:
> - Path diagram: CreateOrder → ShippingDetails → Street (source side)
> - Path diagram: Order → ShippingInfo → Street (target side)
> - Arrows showing the traversal through nested objects
> - Highlight the multi-level path arrays: [command.id, shippingDetails.id, street.id]
> - Caption: "Deeply nested mapping with multi-level path traversal"

---

### Example 5: Query and Validate Mappings

Check existing mappings and find unmapped fields.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
let entity = lookupTypesOf("Class").find(x => x.getName() === "Order");

// Find the association
let action = command.getAssociations("Create Entity Action")
    .find(x => x.typeReference?.typeId === entity.id);

if (!action) {
    console.log("No mapping found");
    return;
}

// Get the mapping
let mapping = action.getAdvancedMappings()[0];
if (!mapping) {
    console.log("No advanced mapping found");
    return;
}

// Show what's mapped
console.log("\n=== Mapped Fields ===");
mapping.getMappedEnds().forEach(end => {
    let sourcePath = end.sourcePath.map(p => p.name).join(".");
    let targetPath = end.targetPath.map(p => p.name).join(".");
    console.log(`${end.mappingType}: ${sourcePath} → ${targetPath}`);
});

// Find unmapped attributes
let targetAttrs = entity.getChildren("Attribute");
let mappedAttrIds = new Set();

mapping.getMappedEnds().forEach(end => {
    if (end.targetPath.length > 0) {
        let lastElement = end.targetPath[end.targetPath.length - 1];
        mappedAttrIds.add(lastElement.id);
    }
});

let unmapped = targetAttrs.filter(attr => !mappedAttrIds.has(attr.id));

console.log("\n=== Validation ===");
if (unmapped.length > 0) {
    console.log(`⚠ Unmapped attributes: ${unmapped.map(a => a.getName()).join(", ")}`);
} else {
    console.log("✓ All attributes mapped");
}

await dialogService.info("Check Task Output Console for results");
```

**Understanding the code:**
- `getMappedEnds()` - Returns all mapped ends (Invocation + Data mappings)
- `sourcePath.map(p => p.name).join(".")` - Converts path array to readable string
- Uses `Set` to track which attributes are mapped
- Finds unmapped attributes by comparing all attributes vs mapped ones

> [!TIP]
> **📸 SCREENSHOT NEEDED**: Show the Task Output Console with query results:
> - Console panel at bottom of Intent Architect showing logged output
> - Sample output showing "=== Mapped Fields ===" section with field mappings
> - Validation results showing either "✓ All attributes mapped" or warnings
> - Caption: "Task Output Console displaying mapping validation results"

---

## Common Issues

### "Element not found" errors

**Cause:** Script running in wrong designer or elements don't exist yet.

**Fix:** Always check which designer you're in and run the [setup scripts](#complete-setup-script) first.

```javascript
let command = lookupTypesOf("Command").find(x => x.getName() === "CreateOrder");
if (!command) {
    await dialogService.error("CreateOrder not found. Run setup scripts first.");
    return;
}
```

### Duplicate mappings

**Cause:** Running the same script multiple times.

**Fix:** Check if mapping exists before creating:

```javascript
let action = element.getAssociations("Create Entity Action")
    .find(x => x.typeReference?.typeId === targetElement.id);

if (!action) {
    action = createAssociation("Create Entity Action", element.id, targetElement.id);
}
```

### Wrong generated code

**Cause:** Incorrect path arrays. Must be in traversal order: `[parent.id, child.id]`.

**Fix:** Build paths from root to leaf:

```javascript
// ✅ Correct: command → ShippingDetails → Street
[command.id, shippingDetailsField.id, streetField.id]

// ❌ Wrong: Missing intermediate element
[command.id, streetField.id]
```

## Quick Reference

### Common Mapping Type IDs

```javascript
// Use these constants at the top of your scripts
const CreateEntityMappingId = "5f172141-fdba-426b-980e-163e782ff53e";
const UpdateEntityMappingId = "01721b1a-a85d-4320-a5cd-8bd39247196a";
const QueryEntityMappingId = "25f25af9-c38b-4053-9474-b0fabe9d7ea7";
```

### Key Methods

```javascript
// Finding elements
lookupTypesOf("Command")                      // Get all commands
element.getChildren("DTO-Field")              // Get child elements
element.getAssociations("Create Entity Action") // Get associations by type

// Creating mappings
createAssociation(type, sourceId, targetId)   // Step 1: Create association
action.createAdvancedMapping(srcId, tgtId)    // Step 2: Create mapping
mapping.addMappedEnd(type, sourcePath, targetPath) // Step 3: Add mapped ends

// Querying mappings
action.getAdvancedMappings()                  // Get all mappings
action.getAdvancedMapping(typeId)             // Get specific mapping type
mapping.getMappedEnds()                       // Get all mapped ends
```

## Next Steps

- **[Designer Scripting Guide](xref:module-building.designers.designer-scripting)** - Learn the full Designer Scripting API
- **[Advanced Mapping Tutorial](xref:module-building.tutorial-advanced-mapping)** - Configure mapping-enabled designers in the Module Builder
- **[Template Development](xref:module-building.templates-general)** - Learn how templates read mappings to generate code
