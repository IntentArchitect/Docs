---
uid: key-concepts.codebase-integration
description: "How Intent Architect keeps developers in control through Software Factory diff review, Code Management, and Customization Tracking for deviations."
---

# Codebase Control

No matter the configuration you choose, you stay in full control with complete visibility and direct access to the entire codebase. Developers always work in an integrated way with their existing IDE / coding harness.

Intent Architect is built on a simple principle: developers stay in control, no matter how much is handed to agents. As agents write more of the codebase, control shifts from writing code to governing what gets written – and that is what these systems are built for.

Changes Review surfaces everything that touched the codebase – generated output, agent- and developer-written code, and deviations from the architecture – and flags exactly what needs your attention. Inline diffs show what changed in the code, model-centric diffs show what it means for the design, and each change is attributed to whoever made it. Where a change traces back to a requirement, that link is surfaced too, so reviewers can see why it exists.

---

## Key Benefits

- **🔍 Full Visibility and Developer Control**

  Every change proposed by the architecture enforcement system or an AI coding agent is surfaced as a diff before anything is applied to the codebase. Developers review, adjust, or reject every modification, and can view or edit any part of the managed codebase at any time. Automation never acts without explicit developer approval.

- **🎚️ Fine-Grained Code Management**

  Developers decide what is automated and what they manage themselves, from entire files down to individual methods, and that decision can be changed at any time. The system respects those boundaries completely, so automation and manual development coexist without conflict, at whatever ratio suits the task.

- **📋 Architectural Adherence and Customizations**

  When developers deviate from a generated pattern, those changes are tracked, attributed, and visible across the system, giving teams a clear picture of where and why the codebase diverges from the standard, as the system grows.

---

## The Software Factory

Every change Intent Architect proposes, whether from the architecture enforcement system or an AI coding agent, passes through the Software Factory before touching your codebase. Changes are surfaced as clear diffs, giving developers the opportunity to review, adjust, or reject any modification before it is applied.

This is what keeps developers fully in control. No automation, deterministic or AI-driven, applies anything to the codebase without explicit developer approval.

<br>

![Software Factory](images/software-factory-ai-chat.png)

---

## Code Management

Intent Architect's Code Management system uses abstract syntax tree parsing and intelligent merge algorithms to combine developer-written code with automatically generated code, without conflict. Developers can configure any file so that they own the implementation of specific methods while the system manages the rest, or take full control of a file entirely, or hand it back to automation. Configuration is always in the developer's hands and can be changed at any time.

This is what makes continuous code generation practical at scale: automation never touches code the developer has claimed, and developers are never forced into a level of automation they did not choose.

<br>

![Code Management](images/customization-tracking.png)

For more information, read [](xref:application-development.code-management.about-code-management).

---

## Customization Tracking

When developers intentionally deviate from a generated pattern, those changes are captured and surfaced across the system. Customization Tracking shows what was changed, by whom, and how it diverges from the reference pattern, creating an audit trail of architectural decisions that stays useful as the system and team scale.

<br>

![Customization Tracking](images/customizations.png)

For more information, read [](xref:application-development.software-factory.customizations-screen).

---

## Learn More

- **[Authoritative Design Blueprints](xref:key-concepts.visual-modeling)**
- **[Architectural Guardrails](xref:key-concepts.deterministic-codegen)**
- **[AI Agents / Tools](xref:key-concepts.non-deterministic-codegen)**
