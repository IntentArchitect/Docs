# What's new in Intent Architect (November 2025)

Welcome to the November edition of What’s New in Intent Architect.

- Highlights
  - **[Mapperly Module](#mapperly-module)** – Mapperly is a .NET source generator that automatically creates efficient object mappings between different data models at compile time.
  - **[Open in IDE enhancements](#open-in-ide-enhancements)** – Several enhancements tightening up the IDE integration and improved quality oif life.
  - **[JSON Importer enhancements](#json-importer-enhancements)** – A guided experience for turning JSON files into rich Domain, Services, or Eventing models in just a few clicks.

## Update details

### Mapperly Module

To Do

### Open in IDE enhancements

To Do

### JSON Importer enhancements

The new JSON Importer Module makes it easier to integrate existing codebases by reverse-engineering model metadata directly from your JSON files representing payload structures.

#### Guided import wizard
- Set the `Source Folder` and optional `File Pattern` (defaults to `**/*.json`) so the importer scopes exactly the files you need.
- Review a tree of discovered files and include or exclude specific items with a single click, ensuring clean inputs before generating metadata.

#### Profiles that match your design surface
- **DomainDocumentDB**: Converts each JSON file into a Domain Entity, automatically splitting nested objects into their own entities and wiring up composite relationships.
- **EventingMessages**: Produces Eventing Messages and supporting DTOs ready for your Services designer.
- **ServicesDtos**: Builds DTOs (with `Dto` naming conventions) and references that align with service-facing contracts.

#### Smarter type inference
The importer recognises sentinel values such as `"guid"` and `"datetime"`, infers decimals, booleans, and arrays, and defaults unknown values to objects—making the generated models immediately usable.

```json
{
  "id": "guid",
  "firstName": "John",
  "orders": [
    {
      "orderId": "guid",
      "total": 99.99
    }
  ]
}
```

To learn more you can visit the [documentation](https://docs.intentarchitect.com/articles/modules-importers/intent-json-importer/intent-json-importer.html).

Available from:

- Intent.Json.Importer 1.0.0
