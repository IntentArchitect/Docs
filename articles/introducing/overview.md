---
uid: introducing.overview
---
# Introduction to Intent Architect

**Intent Architect** is an extensible **IDE for software architecture**, a *design-time* tool that lets you visually model your systems while continuously integrating that design into your **.NET source code**.

It’s **developer-centric** and proudly **High-Code**: you work in your IDE (Visual Studio, Rider, etc.) as usual, while Intent Architect automates the predictable parts, enforces architectural consistency, and provides transparent governance and control.

---

## What Intent Architect Does

- **Model visually** — design domains, services, and integrations through an intuitive visual interface.  
- **Deterministic code generation** — Intent Architect writes and maintains your system’s boilerplate and architectural patterns automatically, keeping design and code continuously in sync.  
- **Non-deterministic (AI-assisted) code generation** — Intent Architect can use architectural context to guide an LLM for “prompt-less” AI interactions.  
- **Enforces consistency and standards** — because up to 85% of your solution is generated, Intent Architect automatically applies consistent structure, naming, and practices across your entire codebase.  
- **Developer-in-the-loop** — every proposed change is presented as a diff for review and approval before it touches your source.  
- **Architectural refactoring** — make broad, pattern-level changes across your solution in a single controlled action.  
- **Visualize your design** — architecture diagrams always reflect the actual code, creating living documentation you can trust.  
- **Extensible platform for code automation** — extend Intent Architect with your own modules or templates, or customize existing ones — most are open source.

---

## Problems We Solve

Intent Architect was built to fix the everyday challenges that slow down teams and erode code quality over time.

---

### Faster Delivery

A large portion of development time goes into writing and maintaining repetitive, mechanical code — services, DTOs, controllers, and mappings.
**Intent Architect automates up to 85% of that code deterministically**, so teams can focus on meaningful logic and features instead of boilerplate.

---

### Consistent, High-Quality Code

As teams grow, small inconsistencies in structure, naming, and layering compound into major maintenance issues.  
**Intent Architect enforces standards automatically** through code automation, producing clean, uniform code across projects by default.

---

### Better Collaboration

Architectural intent often gets lost between architects, developers, and leads, trapped in outdated documents, tribal knowledge, or code that must be painstakingly reverse-engineered to understand.
**Intent Architect makes design explicit, visible, and collaborative**  developers, architects, and leads all work from the same living architecture model, which ultimately is the code.

---

### Better Understanding of Complex Systems

As projects grow and inconsistencies creep in, systems become harder to understand and  reason about.  
**Intent Architect’s living diagrams** visualize domains, services, and integrations directly from the source code, allowing new (and existing) developers to explore and understand a system in minutes.

---

### Agile Architecture

Architecture is traditionally one of the most rigid parts of software — once it’s coded, it’s hard to evolve safely.
**Intent Architect turns architecture into something adaptable**, enabling sweeping, pattern-level refactors or upgrades across large systems in a single controlled action.

---

### Reduced Technical Debt

Code drift, duplicated patterns, and inconsistent practices accumulate debt fast.  
**IA prevents drift before it starts** by continuously synchronizing architecture and source, and allows teams to retroactively realign existing systems without rewrites.

---

### Better Standardization

Keeping standards aligned across teams and projects is nearly impossible manually.  
**IA centralizes patterns in modules**, so every generated component across your organization adheres to the same design and coding conventions by default.

---

### Deterministic AI

AI tools accelerate development, but in practice, results are unpredictable, unrepeatable, and often require tedious prompt crafting.  
**Intent Architect integrates AI with guardrails** — it automatically constructs architectural context for the LLM of your choice and converts results into reviewable diffs. The result is **deterministic, safe, repeatable AI-assisted generation** that’s prompt-less and developer-controlled.

---

## Why It’s Different

| Differentiator | What It Means |
|----------------|---------------|
| **Design-time only** | Runs entirely at design time. You can stop using it anytime, your code keeps running. No runtime lock-in or hidden frameworks. |
| **High-Code / Developer-centric** | Unlike low-code platforms, Intent Architect empowers developers, not replaces them. All generated code is standard, maintainable. |
| **Continuous code automation** | Architecture and code evolve together continuously, not one-off scaffolding. |
| **Architecture opt-out model** | Standards are enforced by default; deviations are intentional, visible, and tracked. |
| **Staging & review (Software Factory)** | Every change is proposed as a diff for developer approval before applying, automation with full control. |
| **Deterministic and Non-Deterministic Generation** | Combines versioned, repeatable templates with AI-assisted generation, both governed and traceable within the same pipeline. |
| **Deterministic AI** | AI assistance with guardrails — Intent Architect constructs full architectural context for the LLM, producing repeatable, reviewable diffs you can trust. |
| **Module-driven** | Every behavior is modular and extensible. Most modules are open source, allowing teams to customize and evolve patterns transparently. |
| **Living diagrams** | Architecture remains visible, accurate, and collaborative, always reflecting the real system. |
| **Augments your IDE** | Works seamlessly alongside Visual Studio or Rider, complementing your existing workflow. |


---

## Next Steps

- Learn **[How It Works](how-it-works.md)**  
- Jump to **[Installation](installation.md)**
