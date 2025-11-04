# Advanced Mappings in Designer Scripting - Comprehensive Analysis

**Document Date:** November 4, 2025  
**Status:** Knowledge Base - For Documentation Planning  
**Target Audience:** Module builders and developers using Intent Architect scripting

---

## 1. EXECUTIVE SUMMARY

Advanced Mappings enable **automatic code generation between structurally different model elements** across Intent Architect designers through designer scripting. The system bridges the gap between domain models, DTOs, Commands, and Queries—allowing developers to define relationships and transformations that generate boilerplate mapping code.

**Core Problem Solved:** Developers need to map data from source structures (e.g., Commands, DTOs) to target structures (e.g., Domain Entities, Attributes) without manually writing repetitive boilerplate code. Advanced Mappings automate this transformation through visual designer associations and metadata.

**Key Use Case:** CRUD Accelerators - automatically generating Create, Read, Update, Delete operations from domain entities with proper advanced mappings from Commands/DTOs to domain classes.

---

## 2. FOUNDATION CONCEPTS

### 2.1 Designer Scripting Context
Designer scripting operates through two mechanisms:
- **Execute Script Dialog** - Ad-hoc, one-time scripts run by users
- **Event Handlers** - Persistent, automatically triggered on modeling events (On Created, On Changed, On Deleted)
- **Context Menu Scripts** - Manual triggers available in right-click menus

**Key API Access:**
- `createElement(type, name, parentId)` - Create elements
- `createAssociation(type, sourceId, targetId)` - Create associations
- `getPackages()` / `lookupTypesOf(type)` - Query elements
- `dialogService.openForm()` - Display dynamic dialogs
- `element.getChildren()`, `element.getAssociations()` - Navigate hierarchy

### 2.2 Element Hierarchy and Types

**Domain Designer Elements:**
- Class (root aggregate entity)
- Attribute (properties)
- Association (relationships)
- Operation (domain methods)
- Constructor (special operations)

**Services Designer Elements:**
- Command (write operations in CQRS)
- Query (read operations in CQRS)
- Service (container for operations)
- DTO (Data Transfer Object)
- DTO-Field (properties of DTOs)

**Advanced Mapping Elements:**
- Association Actions: Create Entity Action, Update Entity Action, Delete Entity Action, Query Entity Action
- Mapping Types: Invocation Mapping, Data Mapping, Filter Mapping

---

## 3. ADVANCED MAPPINGS ARCHITECTURE

### 3.1 What are Advanced Mappings?

Advanced Mappings are **configuration objects that define data transformation paths** between elements. They enable:

1. **Structural Mapping** - Connect different element types (Commands → Classes, DTOs → Attributes)
2. **Path Traversal** - Navigate through associations to map nested elements
3. **Transformation Rules** - Filter, create, or update based on mapping type
4. **Code Generation** - Generate proper C# mapping code (Select, new, etc.)

### 3.2 Core Components

#### Association Actions (Container)
An association between source and target elements that holds advanced mappings:
```
Command --[Create Entity Action]--> Class
Command --[Query Entity Action]--> Class
Command --[Update Entity Action]--> Class
Command --[Delete Entity Action]--> Class
```

These associations are **not standard model associations** but special designer-defined associations that can hold multiple mappings.

#### Mapping Types (3 Primary Categories)

**1. Invocation Mapping**
- **Purpose:** Trigger creation or execution on target
- **Target:** Usually a Class Constructor or Class itself
- **Generated Code:** `new Order(...)`
- **Use Case:** Maps a Command to a Class constructor invocation
- **Example:**
  ```
  Source: CreateOrderCommand [Invocation Mapping] Target: Order Class Constructor
  ```

**2. Data Mapping**
- **Purpose:** Direct property-to-property assignment
- **Source:** DTO Fields, Command Fields
- **Target:** Attributes, Association Target Ends
- **Generated Code:** `result.RefNo = source.RefNo;`
- **Use Case:** Maps field values from commands/DTOs to entity properties
- **Example:**
  ```
  Source: RefNo field [Data Mapping] Target: Order.RefNo attribute
  ```

**3. Filter Mapping**
- **Purpose:** Define query/filter conditions (usually for primary keys)
- **Source:** DTO Fields (typically ID fields)
- **Target:** Entity Attributes marked as Primary Key
- **Generated Code:** `where(x => x.Id == id)`
- **Use Case:** Maps query parameters to find entities by ID
- **Example:**
  ```
  Source: Id field [Filter Mapping] Target: Order.Id (Primary Key)
  ```

---

## 4. CRUD ACCELERATOR DEEP DIVE

### 4.1 Overview

CRUD Accelerators automatically generate **Create, Read (QueryById), Read (QueryAll), Update, Delete operations** from domain entities, with proper advanced mappings to support code generation.

**Location:** `src/crud/crud-api/`

### 4.2 CRUD Strategies

#### Strategy Pattern Implementation
Two strategies inherit from `CrudStrategy` base class:

**CQRSCrudStrategy** - Generates CQRS-style operations:
- `CreateXCommand` with Invocation + Data Mapping
- `UpdateXCommand` with Query + Data Mapping
- `DeleteXCommand` with Query Mapping
- `GetXByIdQuery` with Query Mapping
- `GetXQuery` (all records) with Query Mapping
- `CallXOperation` for domain operations

**TraditionalServicesStrategy** - Generates traditional service operations:
- Service methods instead of commands/queries
- Similar mapping patterns but different element types

#### Execution Flow

```typescript
CrudStrategy.execute() {
  1. askUser()
     - Present CRUD dialog to user
     - Get entity selection
     - Get operation checkboxes (Create, Update, Delete, QueryById, QueryAll, Domain)
     - Get target diagram

  2. executeWithContext()
     - Validate entity (check for multiple owners)
     - Get/create entity folder
     - Initialize strategy
     
     For each operation type:
     a. Create projector (EntityProjector)
     b. Create appropriate element (Command/Query/Service)
     c. Create advanced mapping with appropriate mapping type
     d. Add mapping ends for data flow
     
  3. addElementsToDiagram()
     - Layout created elements on diagram
}
```

### 4.3 Key Classes and Concepts

#### ICrudCreationContext
```typescript
{
  element: IElementApi,                    // Target folder for creation
  dialogOptions: ICrudCreationResult,      // User-selected options
  primaryKeys: IAttributeWithMapPath[],    // PK info for queries
  hasPrimaryKey(): boolean
}
```

#### IAttributeWithMapPath
Enriched attribute information for mapping:
```typescript
{
  id: string,
  name: string,
  typeId: string,
  mapPath: string[],          // Path through associations to attribute
  isNullable: boolean,
  isCollection: boolean
}
```

#### EntityProjector
Helper class that:
- Creates DTO from entity (for query results)
- Creates Commands from entity (for Create/Update/Delete)
- Handles field mapping paths
- Manages nested object mappings

### 4.4 Advanced Mapping Creation in CRUD

#### Create Operation Pattern
```typescript
function doAdvancedMappingCreate(projector: EntityProjector, source: IElementApi) {
  // 1. Create association
  let action = createAssociation("Create Entity Action", source.id, target.id);
  
  // 2. Create mapping
  let mapping = action.createAdvancedMapping(source.id, entity.id);
  
  // 3. Add Invocation Mapping (trigger constructor)
  mapping.addMappedEnd("Invocation Mapping", [source.id], [target.id]);
  
  // 4. Add Data Mappings (field assignments)
  addAdvancedMappingEnds("Data Mapping", source, mapping, projector.getMappings());
}
```

**Result:** Generated mapping enables code generation like:
```csharp
var order = new Order
{
    RefNo = command.RefNo,
    CreatedDate = command.CreatedDate,
    OrderLines = command.OrderLines.Select(ol => new OrderLine { ... }).ToList()
};
```

#### Update Operation Pattern
```typescript
function doAdvancedMappingUpdate(projector: EntityProjector, source: IElementApi) {
  let action = createAssociation("Update Entity Action", source.id, target.id);
  
  // Query mapping: Find by PK
  let queryMapping = action.createAdvancedMapping(source.id, entity.id, 
    "25f25af9-c38b-4053-9474-b0fabe9d7ea7"); // Query mapping type ID
  addAdvancedMappingEnds("Filter Mapping", source, queryMapping, primaryKeyMappings);
  
  // Data mapping: Update fields (excluding PKs)
  let updateMapping = action.createAdvancedMapping(source.id, entity.id, 
    "01721b1a-a85d-4320-a5cd-8bd39247196a"); // Update mapping type ID
  addAdvancedMappingEnds("Data Mapping", source, updateMapping, fieldMappings);
}
```

**Result:** Generated code pattern:
```csharp
var existing = dbContext.Orders.Where(x => x.Id == command.Id).FirstOrDefault();
existing.RefNo = command.RefNo;
existing.UpdatedDate = command.UpdatedDate;
```

#### Delete Operation Pattern
```typescript
function doAdvancedMappingDelete(mappings: IPathMapping[], source: IElementApi) {
  let action = createAssociation("Delete Entity Action", source.id, entity.id);
  let mapping = action.createAdvancedMapping(source.id, entity.id);
  
  // Only Filter Mapping - identify which entity to delete
  addAdvancedMappingEnds("Filter Mapping", source, mapping, pkMappings);
}
```

#### Query Operations Pattern
```typescript
function doAdvancedMappingGetById(mappings: IPathMapping[], source: IElementApi) {
  let action = createAssociation("Query Entity Action", source.id, entity.id);
  let queryMapping = action.createAdvancedMapping(source.id, entity.id, 
    "25f25af9-c38b-4053-9474-b0fabe9d7ea7");
  addAdvancedMappingEnds("Filter Mapping", source, queryMapping, mappings);
}

function doAdvancedMappingGetAll(source: IElementApi) {
  let action = createAssociation("Query Entity Action", source.id, entity.id);
  action.typeReference.setIsCollection(true);  // Multiple results
  action.createAdvancedMapping(source.id, entity.id, 
    "25f25af9-c38b-4053-9474-b0fabe9d7ea7");
}
```

### 4.5 IPathMapping Structure

Maps data flow paths through the object hierarchy:
```typescript
interface IPathMapping {
  type: MappingType,              // Navigation or Direct
  sourcePath: string[],            // [field.id, nested.field.id, ...]
  targetPath: string[],            // [attr.id, assoc.id, attr.id, ...]
  targetPropertyStart?: string,    // Where to start in target path
}
```

**Example:** Nested DTO field to nested entity:
```
DTO.OrderLines (collection field)
  -> Association [Order -> OrderLine]
    -> OrderLine.Description (attribute)

Path: [orderlinesField.id] -> [orderlineAssoc.id, descriptionAttr.id]
```

---

## 5. ADHOC SCRIPTS - BULK MAPPING GENERATION

### 5.1 Generate CQRS Services from Domain

**Location:** `src/adhoc/generate-cqrs-services-from-domain/`

**Purpose:** Batch-create CRUD operations for multiple domain entities

**Workflow:**
1. Get all Classes from domain
2. Present dialog: skip N entities, process M entities
3. For each entity in range: execute CRUD creation

**Key Insight:** This is essentially running the CRUD accelerator script programmatically for multiple entities.

### 5.2 Generate CQRS-to-Domain Mappings

**Location:** `src/adhoc/generate-cqrs-to-domain-mappings/`

**Purpose:** Auto-create advanced mappings based on naming conventions

**Algorithm:**
```
For each Command:
  1. Extract entity name from command name
     - Remove prefix: Create/Update/Delete
     - Remove suffix: Command
  
  2. Find matching domain entity
  
  3. Create advanced mappings:
     - If CreateX → Invocation + Data Mapping
     - If DeleteX → Filter Mapping (by PK)
     - If UpdateX → Query + Filter + Data Mapping

For each Query:
  1. Extract entity name from query name
     - Remove prefixes: Get/Find/List
     - Remove suffixes: Query/ById/All
     - Singularize result
  
  2. Find matching domain entity
  
  3. Create Query Entity Action with Filter Mapping
```

**Circular Reference Handling:**
```typescript
function dataMapDtoToEntity(..., mappingChain: string[] = []) {
  if (mappingChain.includes(dto.id)) {
    // Already mapping this type - prevent infinite loop
    return;
  }
  
  // ... process fields ...
  
  // When recursing to nested objects:
  dataMapDtoToEntity(..., [...mappingChain, dto.id]);
}
```

---

## 6. DESIGNER CONFIGURATION (Module Builder)

### 6.1 Creating Mapping-Enabled Designers

**Tutorial Reference:** `tutorial-advanced-mapping.md`

#### Step 1: Designer Settings
Define custom designer components:
- Association Types (e.g., "Map to Element")
- Mapping Settings (e.g., "Element Mapping")
- Visual configuration (line styles, markers)

#### Step 2: Define Associations
```
Association: "Map to Element"
  ├─ Source End: Command (Display: "mapped by: Package.Command")
  └─ Target End: Class (Display: "[map] ClassName: Class(...): ReturnType")
```

#### Step 3: Define Mapping Settings
**Mappable Elements (Source):**
- Command (Represents: Data, Can Be Modified, Allow Multiple Mappings)
  - Field (Represents: Data, Traversable: DTO)
  - Collection Field (Represents: Data, Traversable: DTO)
- DTO (Represents: Data)

**Mappable Elements (Target):**
- Create Class (Represents: Invokable)
- Set Attribute (Represents: Data)
- Set Association Target End (Represents: Data, Traversable: Create Class)
- Set Association Source End (Represents: Data, Traversable: Create Class)

#### Step 4: Define Mapping Types
Three mapping types define transformation rules:
```
Invocation Mapping:
  Source: Command
  Target: Create Class
  Represents: Invokable
  Purpose: Trigger constructor or operation

Data Mapping:
  Source: DTO-Field, Collection Field
  Target: Attribute, Association Target End
  Represents: Data
  Purpose: Direct property assignment

Filter Mapping:
  Source: DTO-Field (typically ID)
  Target: Attribute (typically PK)
  Represents: Data
  Purpose: Query condition
```

### 6.2 Template Implementation

**ElementMappingTypeResolver** maps designer configuration to code generation:

```csharp
public class ElementMappingTypeResolver : IMappingTypeResolver {
  public ICSharpMapping ResolveMappings(MappingModel mappingModel) {
    // Identify mapping type by ID
    if (mappingModel.MappingTypeId == "Element Mapping ID") {
      // Route to appropriate mapping implementation
      if (model.SpecializationType == "Class") {
        return new ObjectInitializationMapping(mappingModel, template);
      }
      if (model.SpecializationType == "Association Target End" && isCollection) {
        return new SelectToListMapping(mappingModel, template);
      }
    }
  }
}
```

**Mapping Implementations:**
- `ObjectInitializationMapping` - `new Order { ... }`
- `SelectToListMapping` - `.Select(...).ToList()`
- Other implementations for specific patterns

---

## 7. KEY INSIGHTS AND PATTERNS

### 7.1 Traversable Mode

Enables drilling into nested structures:

```typescript
// Field can traverse into DTO
Field (Traversable Mode: Traverse Specific Types)
  ├─ Traversable Types: DTO
  └─ Can expand DTO.Field to access nested properties
```

**Visual Result:**
```
CreateOrderCommand
  └─ RefNo [Data Mapping] → Order.RefNo
  └─ OrderLines [Collection Field]
      └─ [can traverse into OrderLine DTO]
          └─ Description [Data Mapping] → OrderLine.Description
```

### 7.2 Use Child Mappings From

Reuse mapping structure without duplication:

```typescript
Command {
  Use Child Mappings From: DTO
  // Command inherits field structure from DTO definition
  // Avoids redefining mappable children twice
}
```

### 7.3 Filter and Create Functions

Control which elements are mappable:

```typescript
// Filter Function - hide certain elements
Filter: return !element.typeReference.getIsCollection();
// Only non-collection fields are mappable

// Is Mappable Function
Is Mappable: return element.hasStereotype("Aggregate Root");
// Only aggregate roots can be mapped to

// Create Name Function
Create Name Function: 
  return element.getParent('Command').getName() + element.getName() + 'Dto';
```

### 7.4 Aggregate Root Handling

Manages hierarchical entities:

```typescript
// EntityProjector identifies owning aggregate
getOwningAggregateRecursive(entity) {
  // Traverse composition associations up to find root

  // When creating commands/queries, include aggregate keys:
  Order (aggregate root)
    ├─ OrderLine (owned)
    └─ OrderLineStatus (owned by OrderLine)

  // Command needs: OrderId, OrderLineId, OrderLineStatusId
  // For querying nested entities
}
```

### 7.5 Primary Key Exclusion

PK fields excluded from Update Data Mapping:

```typescript
// In Update mappings, filter out PKs
let updateMappingEnds = projector.getMappings().filter(x => {
  const last = x.targetPath[x.targetPath.length - 1];
  return !this.primaryKeys.some(pk => pk.id == last)
});
// Prevents overwriting ID fields during updates
```

---

## 8. DEVELOPER EXPERIENCE FLOW

### 8.1 User (Developer) Workflow

**Scenario: Create CRUD operations with advanced mappings**

1. **Model Domain:**
   - Create Order class with attributes
   - Create OrderLine class
   - Create association: Order (1) -> OrderLine (*)

2. **Launch CRUD Accelerator:**
   - Open Services Designer
   - Right-click, select "Create CRUD Operations" or trigger via macro

3. **Configure in Dialog:**
   - Select Entity: Order
   - Check: Create ✓, Update ✓, Delete ✓, QueryById ✓, QueryAll ✓
   - Select Diagram: Create New Diagram

4. **Generated Artifacts:**
   - CreateOrderCommand (with Invocation + Data Mappings)
   - UpdateOrderCommand (with Query + Data Mappings)
   - DeleteOrderCommand (with Filter Mappings)
   - GetOrderByIdQuery (with Filter Mappings)
   - GetOrdersQuery (with Query Mapping)
   - All with advanced mappings configured

5. **Run Software Factory:**
   - Templates interpret advanced mappings
   - Generate mapping code: `MapToOrder()` extension method
   - Output: Ready-to-use mapping code in generated C#

### 8.2 Developer (Module Builder) Workflow

**Scenario: Create reusable mapping module**

1. **Define Designer:**
   - Create Designer Settings in Module Builder
   - Define "Map to Element" association type

2. **Configure Mappings:**
   - Create "Element Mapping" settings
   - Define mappable source/target elements
   - Create Invocation, Data, Filter mapping types

3. **Implement Template:**
   - Create C# template targeting Commands
   - Use `ElementMappingTypeResolver` to handle mapping types
   - Generate mapping code based on configured paths

4. **Deploy Module:**
   - Compile and package module
   - Users install and use in applications

---

## 9. TYPE SYSTEM AND API

### 9.1 Core API Interfaces

**IElementApi** - Element manipulation:
- `getName()`, `setName()`, `getId()`
- `getChildren(type)`, `getParents()`
- `getAssociations(type)`
- `typeReference.setType()`, `getTypeId()`
- `hasStereotype()`, `applyStereotype()`, `removeStereotype()`
- `getMetadata()`, `setMetadata()`
- `setMapping()` - For basic mapping

**IAssociationApi** - Association manipulation:
- `createAdvancedMapping(source, target, mappingTypeId?)`
- `typeReference.setIsCollection()`
- `getOtherEnd()`

**IElementToElementMappingApi** - Advanced mapping:
- `addMappedEnd(mappingTypeName, sourcePath[], targetPath[])`
- Maps specific data flow paths

**IDiagramApi** - Diagram operations:
- `layoutVisuals(elementIds, position)`
- `selectVisualsForElements()`
- `findEmptySpace()`
- `getOwner()`, `getVisual()`

### 9.2 Common Enums and Constants

**Mapping Types (String Identifiers):**
- "Invocation Mapping" - Trigger invocation
- "Data Mapping" - Property assignment
- "Filter Mapping" - Query conditions

**Association Types:**
- "Create Entity Action"
- "Update Entity Action"
- "Delete Entity Action"
- "Query Entity Action"

**Element Specialization Types:**
- "Class", "Attribute", "Association", "Constructor"
- "Command", "Query", "DTO", "DTO-Field"
- "Service", "Operation"

---

## 10. REAL-WORLD MAPPING EXAMPLE

### Scenario: CreateOrderCommand → Order Entity

**Domain Model:**
```
Order (Class)
  ├─ Id: Guid (Primary Key)
  ├─ RefNo: string
  ├─ CreatedDate: DateTime
  └─ OrderLines: OrderLine (1:* collection)

OrderLine (Class)
  ├─ Id: Guid (Primary Key)
  ├─ Description: string
  ├─ Amount: decimal
  ├─ Quantity: int
  └─ OrderId: Guid (Foreign Key)
```

**Services Model Created:**
```
CreateOrderCommand (Command)
  ├─ RefNo: string
  ├─ CreatedDate: DateTime
  └─ OrderLines: OrderLineDto (collection)

OrderLineDto (DTO)
  ├─ Id: Guid
  ├─ Description: string
  ├─ Amount: decimal
  ├─ Quantity: int
  └─ OrderId: Guid

OrderDto (DTO, result)
  ├─ Id: Guid
  ├─ RefNo: string
  ├─ CreatedDate: DateTime
  └─ OrderLines: OrderLineDto[]
```

**Advanced Mappings Configured:**

```
CreateOrderCommand --[Create Entity Action]--> Order
  └─ Mapping 1: "Invocation Mapping"
      └─ Source: CreateOrderCommand → Target: Order.Constructor
      
  └─ Mapping 2: "Data Mapping"
      ├─ Source: RefNo → Target: Order.RefNo
      ├─ Source: CreatedDate → Target: Order.CreatedDate
      ├─ Source: OrderLines → Target: Order.OrderLines
      │   └─ Traverse into OrderLines.OrderLineDto
      │       ├─ Source: Description → Target: OrderLine.Description
      │       ├─ Source: Amount → Target: OrderLine.Amount
      │       └─ Source: Quantity → Target: OrderLine.Quantity
      └─ [Aggregate Keys Auto-Added]
          └─ Source: OrderId → Target: OrderLine.OrderId
```

**Generated Code:**
```csharp
public static Order MapToOrder(this CreateOrderCommand source)
{
    var result = new Order
    {
        RefNo = source.RefNo,
        CreatedDate = source.CreatedDate,
        OrderLines = source.OrderLines
            .Select(ol => new OrderLine
            {
                Description = ol.Description,
                Amount = ol.Amount,
                Quantity = ol.Quantity,
                OrderId = ol.OrderId  // Aggregate key auto-added
            })
            .ToList()
    };
    return result;
}
```

---

## 11. LIMITATIONS AND CONSIDERATIONS

### 11.1 Current Limitations (From Code Analysis)

1. **Private Setters:** Commands/queries cannot be created if entity has private setters without a constructor
   - Workaround: Add constructor or disable private-setters setting

2. **Multiple Owners:** Compositional entities must have exactly one owner
   - Error state: Cannot generate CRUD for ambiguous ownership

3. **Circular References:** Must be detected to prevent infinite mapping loops
   - Tracked via `mappingChain` parameter

4. **Aggregate Keys:** Required for nested entities but can inflate DTO size
   - Always added to ensure queryability of nested entities

### 11.2 Designer Conventions

- Naming conventions critical for auto-mapping (Create/Update/Delete prefixes)
- Package organization influences folder structure
- Entity "specialization" types must match exactly

---

## 12. LEARNING PROGRESSION FOR DEVELOPERS

### Beginner
1. Understand basic designer scripting (createElement, associations)
2. Review CRUD dialog (what user selects)
3. Understand single-level mappings (DTO field → Entity attribute)

### Intermediate
1. Study strategy pattern (CQRSCrudStrategy, TraditionalServicesStrategy)
2. Understand EntityProjector and DTO creation
3. Learn path traversal for nested objects
4. Understand why different mapping types needed (Invocation, Data, Filter)

### Advanced
1. Study advanced mapping creation (`doAdvancedMapping*` methods)
2. Understand aggregate root handling and key chains
3. Learn module builder configuration
4. Study template implementation (mapping type resolution)
5. Create custom mapping strategies

---

## 13. DOCUMENTATION FOCUS AREAS

### High Priority (Core Concepts)
- [ ] What are advanced mappings and why they exist
- [ ] Three mapping types and their purposes (Invocation, Data, Filter)
- [ ] CRUD accelerator workflow (user and module builder perspective)
- [ ] Path traversal for nested objects
- [ ] Aggregate root handling

### Medium Priority (Usage Patterns)
- [ ] How to configure designer for mappings
- [ ] Writing mapping-aware templates
- [ ] Circular reference prevention
- [ ] Naming convention strategies

### Lower Priority (Advanced)
- [ ] Strategy pattern implementation details
- [ ] Custom mapping type creation
- [ ] Performance considerations
- [ ] Edge cases and workarounds

---

## 14. KEY FILES AND REFERENCE LOCATIONS

**Core Implementation:**
- `crud-api.ts` - Public API entry points
- `strategy-base.ts` - Abstract CRUD strategy
- `strategy-cqrs.ts` - CQRS-specific implementation
- `crud-dialog.ts` - User dialog and context creation
- `common.ts` - Shared utilities

**Ad Hoc Scripts:**
- `generate-cqrs-services-from-domain.ts` - Batch CRUD generation
- `generate-cqrs-to-domain-mappings.ts` - Auto-mapping by convention

**Documentation:**
- `designer-scripting.md` - Complete scripting API
- `tutorial-advanced-mapping.md` - Step-by-step tutorial
- `core.context.types.d.ts` - Type definitions

---

## 15. GLOSSARY

| Term | Definition |
|------|-----------|
| **Advanced Mapping** | Configuration object defining data transformation paths between elements |
| **Invocation Mapping** | Mapping type that triggers object creation (constructor) |
| **Data Mapping** | Mapping type for direct property-to-property assignment |
| **Filter Mapping** | Mapping type for query conditions (typically PK lookup) |
| **CRUD** | Create, Read (ById), Read (All), Update, Delete operations |
| **CQRS** | Command Query Responsibility Segregation pattern (separate write/read models) |
| **DTO** | Data Transfer Object - reduced representation of entity |
| **Entity Projector** | Helper that creates DTOs/Commands from domain entities |
| **Aggregate Root** | Entity that owns other entities in composition hierarchy |
| **Mapping Chain** | Stack tracking mapped types to prevent circular references |
| **Traversable Mode** | Ability to drill into nested structures in mapping UI |
| **Designer Settings** | Module builder component defining new designer elements |
| **Mapping Type** | Category of mapping (Invocation, Data, Filter) with specific semantics |

---

## 16. DOCUMENTATION PLAN

### Article Structure Decision

**ONE COMPREHENSIVE ARTICLE** at: `module-building/advanced-mappings/advanced-mappings-guide.md`

**Rationale:**
- Fills the gap between tutorial-advanced-mapping.md (HOW to configure) and designer-scripting.md (API reference)
- Provides the "WHAT and WHY" that's currently missing
- Complex topic benefits from cohesive reading experience
- Can be referenced in sections later

**Target Audience:**
- **Primary**: Module builder developers creating advanced mapping modules
- **Secondary**: Advanced end users who script automation
- **Prerequisites**: Intermediate scripting knowledge, understand CQRS patterns

**Article Coverage (7 main sections):**
1. Introduction & Problem Statement
2. Core Concepts (3 mapping types + architecture)
3. How It Works (the 3-step API flow)
4. Primary Use Case: CRUD Accelerators
5. Scripting Advanced Mappings (practical examples)
6. Key Patterns & Best Practices
7. Real-World Example (end-to-end)

**Cross-References:**
- Link to `tutorial-advanced-mapping.md` for Module Builder setup
- Link to `designer-scripting.md` for detailed API docs
- Link from both back to this guide for conceptual understanding

---

**END OF ANALYSIS DOCUMENT**

This document provides the foundation for creating comprehensive user-facing documentation on advanced mappings in Intent Architect's designer scripting.
