---
uid: module-building.designer-scripting
---

# Designer Scripting

In the coding editor, documentation for code constructs is readily available, along with powerful scripting capabilities that allow developers to automate certain front-end related concerns.

![Code Docs in Code Completion Screenshot](images/code-complete-code-docs.png)

You can access the documentation by simply clicking on the small arrow beside each code construct to expand the respective documentation and learn more about the available functions for automation.

## Execute Script Dialog

Intent Architect includes a scripting editor, which can be launched by clicking the on the Execute Script Dialog button (`</>`) located in the toolbar. This editor allows you to execute scripts directly within your designer environment.

```typescript
let mainPackage = getPackages()[0];
for (let classIndex = 1; classIndex <= 10; classIndex++) {
    let newClass = createElement("Class", `Class${classIndex}`, mainPackage.id);
    for (let attrIndex = 1; attrIndex <= 5; attrIndex++) {
        let attr = createElement("Attribute", `Attribute${attrIndex}`, newClass.id);
        const stringTypeId = "d384db9c-a279-45e1-801e-e4e8099625f2";
        attr.typeReference.setType(stringTypeId);
    }
}
```

The example script provided will locate the main package in the current designer and create 10 Classes with 5 Attributes each and setting each Attribute's type to a `string`.

Complete API documentation with IntelliSense is available in the built-in editor. For the full TypeScript definitions, see the [GitHub repository](https://github.com/IntentArchitect/Intent.Modules/blob/development/Modules/Intent.Modules.ModuleBuilder/Api/ApiMetadataProviderExtensions.cs).

## Designer-Specific Elements

Different designers support different element types. Here's a reference of which elements are available in which designers (not an exhaustive list):

**Services Designer:**
- DTO
- Service  
- Command
- Query
- DTO-Field

**Domain Designer:**
- Class
- Attribute
- Constructor

**Common (available in multiple designers):**
- Operation
- Parameter

## Common Type IDs Reference

When setting type references for elements, you'll need to use these common type IDs. **Best practice:** Define these as constants rather than using magic strings:

```javascript
// Define type constants for better maintainability
const stringType = "d384db9c-a279-45e1-801e-e4e8099625f2";
const intType = "fb0a362d-e9e2-40de-b6ff-5ce8167cbe74";
const longType = "33013006-E404-48C2-AC46-24EF5A5774FD";
const boolType = "e6f92b09-b2c5-4536-8270-a4d9e5bbd930";
const guidType = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";
const datetimeType = "a4107c29-7851-4121-9416-cf1236908f1e";
const decimalType = "675c7b84-997a-44e0-82b9-cd724c07c9e6";
const doubleType = "24A77F70-5B97-40DD-8F9A-4208AD5F9219";
```

| Type | ID |
|------|-----|
| string | `d384db9c-a279-45e1-801e-e4e8099625f2` |
| int | `fb0a362d-e9e2-40de-b6ff-5ce8167cbe74` |
| long | `33013006-E404-48C2-AC46-24EF5A5774FD` |
| bool | `e6f92b09-b2c5-4536-8270-a4d9e5bbd930` |
| guid | `6b649125-18ea-48fd-a6ba-0bfff0d8f488` |
| datetime | `a4107c29-7851-4121-9416-cf1236908f1e` |
| decimal | `675c7b84-997a-44e0-82b9-cd724c07c9e6` |
| double | `24A77F70-5B97-40DD-8F9A-4208AD5F9219` |

## Bulk Domain Model Creation

This example shows how to create a complete e-commerce domain model with entities and different relationship types:

```javascript
// Define type constants
const stringType = "d384db9c-a279-45e1-801e-e4e8099625f2";
const guidType = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";
const intType = "fb0a362d-e9e2-40de-b6ff-5ce8167cbe74";
const datetimeType = "a4107c29-7851-4121-9416-cf1236908f1e";
const decimalType = "675c7b84-997a-44e0-82b9-cd724c07c9e6";

// Helper function to add attributes to entities
function addAttributes(entity, attributes) {
    // Note: Id attributes are auto-generated when Intent.Metadata.RDBMS module is installed
    attributes.forEach(attr => {
        let attribute = createElement("Attribute", attr.name, entity.id);
        attribute.typeReference.setType(attr.type);
    });
}

// Find target package
let domainPackage = getPackages().find(p => p.name === "Domain") || getPackages()[0];

// Create entities
let customer = createElement("Class", "Customer", domainPackage.id);
let order = createElement("Class", "Order", domainPackage.id);
let orderItem = createElement("Class", "OrderItem", domainPackage.id);
let product = createElement("Class", "Product", domainPackage.id);

// Add attributes to each entity
addAttributes(customer, [
    { name: "Name", type: stringType },
    { name: "Email", type: stringType }
]);

addAttributes(order, [
    { name: "OrderDate", type: datetimeType },
    { name: "TotalAmount", type: decimalType }
]);

addAttributes(orderItem, [
    { name: "Quantity", type: intType },
    { name: "UnitPrice", type: decimalType }
]);

addAttributes(product, [
    { name: "Name", type: stringType }
]);

// Create relationships with different patterns:

// 1. Aggregate: Customer -> Orders (defaults to 1-to-many aggregate relationship)
createAssociation("Association", customer.id, order.id);

// 2. Composition: Order -> OrderItems (1-to-many composite - OrderItem can't exist without Order)
// Key: Use getOtherEnd() to configure both sides for composite relationships
let orderItemAssoc = createAssociation("Association", order.id, orderItem.id);
orderItemAssoc.getOtherEnd().typeReference.setIsCollection(false); // Order side (one)
orderItemAssoc.typeReference.setIsCollection(true); // OrderItem side (many)

// 3. Reference: OrderItem -> Product (many-to-1 reference - Product exists independently)
createAssociation("Association", orderItem.id, product.id);

await dialogService.info("Created e-commerce domain model with proper relationship types!");
```

![Bulk domain element creation](images/bulk-domain-element-creation.png)

## Dynamic Form for User Input

This example demonstrates using dynamic forms to gather user input before executing bulk operations:

```javascript
// Define type constants
const guidType = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";
const intType = "fb0a362d-e9e2-40de-b6ff-5ce8167cbe74";
const longType = "33013006-E404-48C2-AC46-24EF5A5774FD";
const datetimeType = "a4107c29-7851-4121-9416-cf1236908f1e";

// Configure a form to collect entity generation parameters
let formConfig = {
    title: "Bulk Entity Generator",
    submitButtonText: "Generate Entities",
    minWidth: "500px",
    fields: [
        {
            id: "entityNames",
            fieldType: "textarea",
            label: "Entity Names (one per line)",
            isRequired: true,
            placeholder: "Customer\nOrder\nProduct\nCategory",
            hint: "Enter each entity name on a separate line"
        },
        {
            id: "addIdAttribute",
            fieldType: "checkbox",
            label: "Add Id attribute to each entity",
            value: true
        },
        {
            id: "idType",
            fieldType: "select",
            label: "Id Type",
            selectOptions: [
                { id: guidType, description: "Guid" },
                { id: intType, description: "Int" },
                { id: longType, description: "Long" }
            ],
            value: guidType
        },
        {
            id: "addAuditFields",
            fieldType: "checkbox",
            label: "Add audit fields (CreatedDate, UpdatedDate)",
            value: true
        }
    ]
};

// Show the form and get user input
let result = await dialogService.openForm(formConfig);
let entityNames = result.entityNames.split('\n').filter(name => name.trim());

// Create entities based on form input
let targetPackage = getPackages()[0];
entityNames.forEach(name => {
    let entity = createElement("Class", name.trim(), targetPackage.id);
    
    // Add Id attribute if requested
    if (result.addIdAttribute) {
        let idAttr = createElement("Attribute", "Id", entity.id);
        idAttr.typeReference.setType(result.idType);
    }
    
    // Add audit fields if requested
    if (result.addAuditFields) {
        let createdDate = createElement("Attribute", "CreatedDate", entity.id);
        createdDate.typeReference.setType(datetimeType);
        
        let updatedDate = createElement("Attribute", "UpdatedDate", entity.id);
        updatedDate.typeReference.setType(datetimeType);
    }
});

await dialogService.info(`Successfully created ${entityNames.length} entities!`);
```

## Event Triggered Scripts for Elements

Event Triggered Scripts in a module building environment enable developers to execute custom logic when specified events occur for elements.

![Event Triggered Script for Elements Screenshot](images/event-triggered-script-element.png)

Inside the Module Builder designer you can add Element Event Handlers for an Element you've created or to an Element you want to extend from an existing Designer.


```typescript
const stereotypeId = "65860af3-8805-4a63-9fb9-3884b80f4380";
const boolTypeId = "e6f92b09-b2c5-4536-8270-a4d9e5bbd930";

if (element.hasStereotype(stereotypeId)) {
    let isDeleteAttr = element.getChildren("Attribute").filter(x => x.hasMetadata("soft-delete"))[0] ||
        createElement("Attribute", "IsDeleted", element.id);
    isDeleteAttr.typeReference.setType(boolTypeId);
    isDeleteAttr.setMetadata("soft-delete", true);
    return;
}

let isDeleteAttr = element.getChildren("Attribute").filter(x => x.hasMetadata("soft-delete"))[0];
if (isDeleteAttr) {
    isDeleteAttr.delete();
}
```

In the provided TypeScript example, the script will activate when a Class element is modified. It performs the following actions:

- When a Class is modified and has a Soft Delete stereotype applied, it adds an `IsDeleted` attribute of boolean type, marked with soft-delete metadata.
- When the Soft Delete stereotype is removed, it searches for any attribute with soft-delete metadata and deletes it from the Class.

## Auto-Configure New Entities

This example shows how to automatically add common attributes when new entities are created:

```javascript
// Define type constants
const guidType = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";
const datetimeType = "a4107c29-7851-4121-9416-cf1236908f1e";

// When a new Class is created, auto-add common attributes
if (element.specialization === "Class") {
    // Add Id attribute if it doesn't exist
    let hasId = element.getChildren("Attribute").some(attr => attr.getName().toLowerCase() === "id");
    if (!hasId) {
        let idAttr = createElement("Attribute", "Id", element.id);
        idAttr.typeReference.setType(guidType);
    }
    
    // Add CreatedDate and UpdatedDate for audit trail
    let createdDate = createElement("Attribute", "CreatedDate", element.id);
    createdDate.typeReference.setType(datetimeType);
    
    let updatedDate = createElement("Attribute", "UpdatedDate", element.id);
    updatedDate.typeReference.setType(datetimeType);
}
```

## Service Layer Generation

This example demonstrates generating CRUD operations for domain entities:

```javascript
// Define type constants
const guidType = "6b649125-18ea-48fd-a6ba-0bfff0d8f488";

// Generate CRUD operations for all domain classes
let domainClasses = lookupTypesOf("Class").filter(c => c.getPackage().name === "Domain");
let servicesPackage = getPackages().find(p => p.name === "Services") || getPackages()[0];

domainClasses.forEach(domainClass => {
    let service = createElement("Service", `${domainClass.getName()}Service`, servicesPackage.id);
    
    // Create CRUD operations
    let createOp = createElement("Operation", `Create${domainClass.getName()}`, service.id);
    let getOp = createElement("Operation", `Get${domainClass.getName()}`, service.id);
    let updateOp = createElement("Operation", `Update${domainClass.getName()}`, service.id);
    let deleteOp = createElement("Operation", `Delete${domainClass.getName()}`, service.id);
    
    // Set return types
    getOp.typeReference.setType(domainClass.id); // Return the domain class
    createOp.typeReference.setType(guidType); // Return guid
    
    // Add parameters to operations
    let createParam = createElement("Parameter", `create${domainClass.getName()}Request`, createOp.id);
    createParam.typeReference.setType(domainClass.id);
    
    let idParam = createElement("Parameter", "id", getOp.id);
    idParam.typeReference.setType(guidType);
});
```

## Event Triggered Scripts for Associations

Event Triggered Scripts in a module building environment enable developers to execute custom logic when specified events occur for associations. Below is an example of an event triggered script and an overview of the available APIs to interact with elements in an event-driven manner.

![Event Triggered Script for Associations Screenshot](images/event-triggered-script-association.png)

Inside the Module Builder designer you can add Association Event Handlers for an Association you've created or to an Association you want to extend from an existing Designer.

```typescript
if (!association) {
    return;
}
let sourceEnd = association.getOtherEnd().typeReference;
sourceEnd.setIsCollection(false);
sourceEnd.setIsNullable(false);
```

The example above gets executed when an associated is created which then turns the association into a 1 -> 1 composite relationship by disabling `Is Collection` and `Is Nullable` on the source end of the association.

## Auto-Configure Association Properties

This example shows how to automatically configure association properties based on naming conventions:

```javascript
// Auto-configure association properties based on naming patterns
if (!association) {
    return;
}

let sourceElement = association.getOtherEnd().typeReference.getType();
let targetElement = association.typeReference.getType();

// If association is from Order to Customer, make it many-to-one
if (sourceElement.getName() === "Order" && targetElement.getName() === "Customer") {
    association.getOtherEnd().typeReference.setIsCollection(false); // Order side
    association.typeReference.setIsCollection(false); // Customer side
    association.typeReference.setIsNullable(false); // Customer is required
}

// If association is from Order to OrderItem, make it one-to-many
if (sourceElement.getName() === "Order" && targetElement.getName().includes("Item")) {
    association.getOtherEnd().typeReference.setIsCollection(false); // Order side
    association.typeReference.setIsCollection(true); // Items side
    association.typeReference.setIsNullable(false); // Items are required
}

// Set meaningful names for navigation properties
if (association.getName() === "") {
    if (association.isTargetEnd()) {
        association.setName(pluralize(targetElement.getName().toLowerCase()));
    } else {
        association.setName(targetElement.getName().toLowerCase());
    }
}
```

## Command/Query Pattern Generator

This example demonstrates generating Commands and Queries from Service Operations:

```javascript
// Generate Commands and Queries for selected service operations
let services = lookupTypesOf("Service");
let commandsPackage = getPackages().find(p => p.name === "Commands") || getPackages()[0];
let queriesPackage = getPackages().find(p => p.name === "Queries") || getPackages()[0];

services.forEach(service => {
    service.getChildren("Operation").forEach(operation => {
        let operationName = operation.getName();
        
        if (operationName.startsWith("Get") || operationName.startsWith("Find") || operationName.startsWith("Search")) {
            // Create Query
            let query = createElement("Query", `${operationName}Query`, queriesPackage.id);
            
            // Copy parameters as DTO fields
            operation.getChildren("Parameter").forEach(param => {
                let field = createElement("DTO-Field", param.getName(), query.id);
                if (param.typeReference) {
                    field.typeReference.setType(param.typeReference.getTypeId());
                    field.typeReference.setIsNullable(param.typeReference.getIsNullable());
                    field.typeReference.setIsCollection(param.typeReference.getIsCollection());
                }
            });
            
            // Set return type to match operation
            if (operation.typeReference && operation.typeReference.getTypeId()) {
                query.typeReference.setType(operation.typeReference.getTypeId());
                query.typeReference.setIsCollection(operation.typeReference.getIsCollection());
            }
            
        } else {
            // Create Command
            let command = createElement("Command", `${operationName}Command`, commandsPackage.id);
            
            // Copy parameters as DTO fields
            operation.getChildren("Parameter").forEach(param => {
                let field = createElement("DTO-Field", param.getName(), command.id);
                if (param.typeReference) {
                    field.typeReference.setType(param.typeReference.getTypeId());
                    field.typeReference.setIsNullable(param.typeReference.getIsNullable());
                    field.typeReference.setIsCollection(param.typeReference.getIsCollection());
                }
            });
            
            // Commands typically return void or an ID
            if (operation.typeReference && operation.typeReference.getTypeId()) {
                command.typeReference.setType(operation.typeReference.getTypeId());
            }
        }
    });
});

await dialogService.info("Commands and Queries generated successfully!");
```
