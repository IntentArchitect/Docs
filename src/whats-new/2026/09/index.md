---
uid: whats-new.2026.09
---
# What's new in Intent Architect (September 2026)

Welcome to the September edition of What's New in Intent Architect.

- Highlights
  - **[Module Builder AI Skills](#module-builder-ai-skills)** – Bundles a curated set of AI agent skills and instructions into your repo so an AI assistant can build Intent Architect modules correctly.
  - **[Wolverine Eventing Module](#wolverine-eventing-module)** – Adds Wolverine as a message broker option for publishing and subscribing to integration events and commands, with a guided MassTransit migration path.

## Update details

### Module Builder AI Skills

The `Intent.ModuleBuilder.AI.Skills` module drops a curated, always-up-to-date set of AI agent skill and instruction files into a `.agents/` folder in the repo it's installed in, so an AI assistant working in that repo has the knowledge it needs to build Intent Architect modules correctly. It generates no C# and has no designer model dependency — install it once in a dedicated application and control where the files land via that application's Output Location setting.

**Key features:**

- Skill files covering module-building end to end: `file-builder-expert`, `intent-mapping-architect`, `intent-metadata-consumer`, `intent-domain-interactions-expert`, `intent-module-orchestrator`, `add-association-type`, `add-designer-extension`, `add-module-migration`, `architecture-templates`, `module-building-strategies`, `module-debugging`, `module-docs`, `module-versioning`, `module-svg-icon`, and `module-element-icons`
- Instruction files for choosing the right exception type and for recurring template-authoring pitfalls (NuGet dependency registration, filename stability, naming conflicts, package version drift)
- Bundled content is always overwritten on install or update, so every consuming repo stays standardized on the same skill set

Available from:

- Intent.ModuleBuilder.AI.Skills 1.0.2-pre.1

### Wolverine Eventing Module

The `Intent.Eventing.Wolverine` module integrates [WolverineFx](https://wolverine.netlify.app/) as a message broker for publishing and subscribing to integration events and commands in .NET applications — a fully MIT-licensed option for teams migrating off a commercially licensed bus such as MassTransit. This is distinct from the Wolverine CQRS Dispatcher introduced in August — that module wires Wolverine as your in-process command/query dispatcher, while this one handles eventing across process boundaries; the two share a single `UseWolverine` registration and are commonly installed together.

**Key features:**

- Modeling Integration Events and Integration Commands via the shared `Intent.Modelers.Eventing` designer
- Multiple transport options: Local (in-process), RabbitMQ, Azure Service Bus, and Amazon SQS
- Transactional Outbox support (SQL Server / PostgreSQL) for exactly-once-processing guarantees
- Configurable Error Handling Policies (`Retry`, `RetryWithCooldown`, `ScheduleRetry`) with automatic dead-lettering
- A dedicated MassTransit-to-Wolverine migration guide, including a setting-equivalence table and a staged, side-by-side migration path for large applications

Available from:

- Intent.Eventing.Wolverine 1.0.0-pre.1
