---
uid: key-concepts.codebase-integration
description: "How Intent Architect keeps developers in control through Software Factory diff review, Code Management, and Customization Tracking for deviations."
---

# Codebase Control

No matter how you incorporate Intent Architect into your agentic development workflow, you stay in full control with complete visibility and direct access to the entire codebase.

Teams always work in an integrated way with their existing coding tools and have full control over the boundaries of the architectural guardrails or what gets generated deterministically. And manage adherence by exception rather than through constant review.

In addition, Change Review features help teams quickly understand what changed – whether it was deterministically generated or agent/developer written – and flag exactly what needs your attention. Inline diffs show what changed in the code, model-centric diffs show what it means for the design, and each change is attributed to whoever made it. Where a change traces back to a requirement, that link is surfaced too, so reviewers can see why it exists.

---

## Key benefits

- **🔍 Streamline code reviews and stay in control as review volume grows**

  Code reviews stay effective and manageable as the volume of agent-written code grows. Changes Review raises Requires Attention flags, prioritizes files for review, and presents inline diffs alongside model-centric diffs, so developers see code change in conjunction with its effect on the design. Teams sustain review discipline and accountability at scale.

- **🎚️ Precise control over the architectural boundaries for agentic development**

  Architectural adherence remains easy to enforce as teams scale up agentic coding. Code Management systems give developers full control over the boundaries between the guardrails and agent- or developer-managed code, from entire files down to individual methods. Agents always stay within these boundaries so teams can scale agentic development without giving up structure, consistency and quality.

- **🛡️ Architectural governance by exception, not constant review**

  Guardrails scale better as they are managed by exception rather than constant review. Architectural deviations or customizations are flagged for approval directly in Changes Review. Customization Tracking captures what was changed, by whom, and how it diverges from the guardrails, giving teams a clear record of where and why the codebase departs from the standard as the system scales.

---

## The Software Factory

Every change, whether Module or agent driven, passes through the Software Factory before touching your codebase. Changes are surfaced as clear diffs, giving developers the opportunity to review, adjust, or reject any modification before it is applied.

This helps to keep developers in control. By default, no code gets written without explicit developer approval. However, developers can optionally enable "Bypass all permissions" mode to allow AI agents to run the Software Factory and apply changes automatically if they prefer a fully autonomous workflow. The choice is always yours – configure the level of control that suits your team and task.

<br>

![Software Factory](images/software-factory-ai-chat.png)

---

## Code Management

Intent Architect uses abstract syntax tree parsing and intelligent merge algorithms to combine agent- or developer-written code with Module generated code, without conflict. Developers can configure what code is managed by Modules at any granularity, from a single method implementation up to an entire file. Configuration is always in the developer's hands and can be changed at any time.

This is part of what makes the architectural guardrails work at scale: developers are in full control of the architectural boundaries and what code is managed by the Modules, agents or themselves.

<br>

![Code Management](images/customization-tracking.png)

For more information, read [](xref:application-development.code-management.about-code-management).

---

## Customization Tracking

When developers or agents intentionally deviate from a generated pattern, i.e., the architectural guardrails or Module managed code, those changes are captured and surfaced across the system. Customization Tracking shows what was changed, by whom, and how it diverges from the reference pattern or Module, creating an audit trail of architectural decisions that remain valuable as the system and team scale.

<br>

![Customization Tracking](images/customizations.png)

For more information, read [](xref:application-development.software-factory.customizations-screen).

---

## Learn More

- **[Authoritative Design Blueprints](xref:key-concepts.visual-modeling)**
- **[Architectural Guardrails](xref:key-concepts.deterministic-codegen)**
- **[AI Agents / Tools](xref:key-concepts.non-deterministic-codegen)**
