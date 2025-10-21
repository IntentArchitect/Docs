# What's new in Intent Architect (November 2025)

Welcome to the November edition of What’s New in Intent Architect.

- Highlights
  - **[Mapperly Module](#mapperly-module)** – Mapperly is a .NET source generator that automatically creates efficient object mappings between different data models at compile time.
  - **[Open in IDE enhancements](#open-in-ide-enhancements)** – Several enhancements tightening up the IDE integration and improved quality oif life.
  - **[JSON Importer enhancements](#json-importer-enhancements)** – A guided experience for turning JSON files into rich Domain, Services, or Eventing models in just a few clicks.
  - **[AI modules multi-provider support](#ai-modules-multi-provider-support)** – Configure multiple AI providers, pick them per workflow, and dial in the thinking level that best fits each model.

## Update details

### Mapperly Module

To Do

### Open in IDE enhancements

To Do

### AI modules multi-provider support

Intent Architect’s AI tooling now understands that one size does not fit all. You can register several AI providers side-by-side and switch between them whenever you invoke Auto Implementation, Blazor page generation, or AI-powered unit tests.

#### Configure multiple providers once
- Head to **User Settings → AI Settings** and add as many provider/model combinations as you need (OpenAI, Azure OpenAI, Anthropic, OpenRouter, Google Gemini, OpenAI-compatible services, or Ollama).
- Each selection keeps its own API keys, endpoints, and token limits so you can swap without re-entering credentials.

#### Choose the right model per workflow
- When you run **Implement with AI**, **Generate Blazor UI with AI**, or **Generate Unit Tests with AI**, Intent now surfaces a provider dropdown so you can select the exact model for that run.
- The last-used choice is remembered per module, making it easy to rely on a fast local model for drafts and a premium model for production-ready outputs.

#### Tune the thinking effort
- Every provider-aware dialog exposes a **Thinking Level** control that maps to the underlying model’s reasoning or thinking configuration.
- You can nudge the control higher for deeper reasoning or lower to prioritise speed, and Intent automatically translates that preference into the right provider-specific settings.

Available from:

- Intent.AI.AutoImplementation 1.0.0-beta.15
- Intent.AI.Blazor 1.0.0-beta.17
- Intent.AI.UnitTests 1.0.0-beta.13
- Intent Architect 4.5.18

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
