---
uid: whats-new.2026.06
---
# What's new in Intent Architect (June 2026)

Welcome to the June edition of What's New in Intent Architect.

- Highlights
  - **[Generating and Augmenting Markdown Files](#generating-and-augmenting-markdown-files)** - New Markdown template support lets modules generate and augment Markdown files, including AI skill and instruction files.
  - **[AI Modelling Agent Improvements](#ai-modelling-agent-improvements)** - General improvements to the AI Modelling Agent for more accurate and reliable design modelling in Intent Architect.

## Update details

### Generating and Augmenting Markdown Files

Modules can now generate and augment Markdown files using the new `MarkdownFile` builder, available through the [Creating Markdown Templates](xref:module-building.templates-general.creating-markdown-templates) templating method. This opens up a new class of module capabilities, in particular generating AI context files such as agent skill definitions and coding instructions alongside your application's source code.

Key capabilities:

- **Seed from existing files** - bootstrap a Markdown file from an existing template and then add to it programmatically.
- **Structured section management** - add, update, and remove named sections containing text, lists, code blocks, and nested sub-lists.
- **Front matter support** - set and manage YAML front matter properties directly from the template.
- **Content hashing** - Intent Architect will continue to manage and update the file as long as its content has not been manually modified. Once a developer edits the file, Intent Architect stops overwriting it, respecting the custom changes.

Available from:

- Relevant Module(s) Latest

### AI Modelling Agent Improvements

The AI Modelling Agent has received a round of general improvements aimed at producing more accurate and consistent designs when modelling out application architecture in Intent Architect. These refinements improve how the agent interprets requirements, navigates designer contexts, and applies model changes — reducing the need for manual corrections after an agent run.

Available from:

- Various Module (esp. Designer Modules)
