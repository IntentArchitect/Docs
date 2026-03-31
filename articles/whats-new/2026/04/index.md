# What's new in Intent Architect (April 2026)

Welcome to the April edition of What's New in Intent Architect.

- Highlights
  - **[Angular Version Selection](#angular-version-selection)** - When creating an Angular application with the `Angular Web Application` template, you can now select the Angular version.
  - **[Enhanced Advanced Mapping Screen](#enhanced-advanced-mapping-screen)** - A number of improvements have been made to the `Advanced Mapping Screen`, making it easier to manage mappings, especially with large domain models.
  - **[Blazor AI Improvements and Template](#blazor-ai-improvements-and-template)** - The Blazor AI module has been updated to use easier-to-read, maintainable Markdown files, ensuring more accurate and consistent AI results when generating Blazor pages.
  - **[Domain Constraints for Entities](#domain-constraints-for-entities)** - Model reusable validation constraints directly on domain attributes so downstream modules can apply them consistently.
  - **[Importer upgrades](#importer-upgrades)** - The RDBMS and C# Importers have been enhanced to reduce manual work and maintain code fidelity, with smarter duplicate detection for associations, additional stored procedure mapping option, as well as async/sync method preservation.

## Update details

### Angular Version Selection

When creating a new Angular application with the `Angular Web Application` template, you can now choose which Angular version to use.

The correct package versions will be automatically referenced and the appropriate default configuration applied for your application.

![Angular Version Selection](images/angular-version-selection.png)

Available from:

- Intent Angular Web Application Template 5.0.4-pre.1

### Enhanced Advanced Mapping Screen

The `Advanced Mapping Screen` has been enhanced to streamline managing mappings, especially with large domain models, reducing navigation time and improving overall usability:

- **Filter by mapped/unmapped status** - Independently filter source and/or target side attributes by whether they are mapped or unmapped, helping you quickly focus on the mapped/unmapped items.
- **Filter by text** - Search and filter source and/or target attributes by text to rapidly locate specific attributes and their mappings.
- **Performance improvements** - Optimized rendering for large numbers of attributes and mappings, ensuring smooth operation with large models.

![Enhanced Advanced Mapping Screen](images/mapping-enhancements.png)

Available from:

- Intent Architect Client 4.6.2

### Blazor AI Improvements and Template

The Blazor AI module has been enhanced to improve maintainability and accuracy of AI-generated Blazor pages. General and template specific rules are now defined in readable Markdown files, making them easier to maintain while ensuring more consistent results. All rules and templates are fully customizable to suit your requirements and styling preferences.

**Key Enhancements:**

- **Readable Markdown-based rules** - Template and general rules are now defined in clear, maintainable Markdown format, reducing complexity and enabling easier customization.
- **Improved AI consistency** - The new rule structure ensures more accurate and consistent AI results when generating Blazor pages.
- **Sample Blazor Server Application** - A new sample application generated almost entirely using the enhanced AI improvements demonstrates the capabilities and quality of the updated system.

An example of the Markdown rules:

![Blazor AI Template Rules](images/markdown-rules.png)

The AI generated sample application:

![Blazor Sample Application](images/blazor-sample.png)

Available from:

- Intent.AI.Blazor 1.0.0-pre.0

### Domain Constraints for Entities

The new Domain Constraints module lets you model validation rules directly on domain entity attributes, centralizing validation intent in your domain model.

![Domain Constraints](images/domain-constraints.png)

Constraints such as `Required`, `Text Limits`, `Numeric Limits`, `Collection Limits`, `Regular Expression`, `Email`, `Url`, and `Base64` can be applied from the `Add Domain Constraint` menu and consumed by downstream modules.

When used with compatible FluentValidation modules, these constraints can be translated into generated validation rules, reducing duplicated validation setup and manual rework.

Visit the [documentation](https://docs.intentarchitect.com/articles/modules-common/intent-metadata-domain-constraints/intent-metadata-domain-constraints.html) to learn more.

Available from:

- Intent.Metadata.Domain.Constraints 1.0.0

### Importer upgrades

The RDBMS and C# Importers have been enhanced to streamline the import process and maintain code fidelity, reducing manual rework and ensuring your imported models accurately reflect your source systems and services.

**RDBMS Importer:**

- **Stored Procedure Operation mapping** - Now you can import stored procedures with explicit operation and stored procedure element creation, along with automatic mapping between the two.
- **Intelligent association detection** - Enhanced duplicate prevention logic that better identifies existing associations between entities, reducing manual cleanup and ensuring cleaner imports.
- **Stability improvements** - Various bug fixes and optimizations to enhance overall importer reliability.

![Stored Procedure Operation Mapping](images/sp-mapping.png)

**C# Importer:**

- **Preserve async/sync method definitions** - When importing services, you can now maintain the exact async/sync contract of your original methods, including cancellation token handling. This ensures your Intent models faithfully represent your source code's behavioral contracts.
- **Stability improvements** - Various bug fixes and optimizations to enhance overall importer reliability.

![C# Async Method Import](images/no-token-import.png)

Available from:

- Intent RDBMS Importer 1.0.13
- Intent C# Importer 1.0.7
