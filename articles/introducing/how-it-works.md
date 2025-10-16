---
uid: introducing.how-it-works
---
# How Intent Architect Works

Intent Architect unifies **visual modeling**, **deterministic and LLM‑assisted generation**, and **human‑approved synchronization** into a continuous architecture pipeline.

---

## The Three Layers

### 1) Design Layer
Visual designers for **Domain**, **Service**, and **Integration** modeling. Designs are stored **locally** as human‑readable XML and checked into version control alongside your code.

### 2) Composition Layer
**Modules** and **Architecture Templates** define implementation patterns (e.g., EF Core, CQRS). Everything is **module‑driven** and extensible; ~**95%** of modules are open source.

### 3) Generation Layer
The **Software Factory** compares your design intent with the current codebase and stages **proposed changes** (adds/edits/deletes) for your approval.

```mermaid
flowchart LR
A[Design Models] --> B[Modules & Templates]
A --> C[IA Context Engineering (LLM)]
B --> D[Deterministic Output]
C --> D
D --> E[Software Factory (Diffs)]
E --> F[Developer Approval]
F --> G[Codebase]
```

---

## Deterministic Generation

Template/module‑based generation that is **predictable, repeatable, and versioned**. Ideal for architectural scaffolding, conventions, and upgrades.

## Non‑Deterministic (LLM‑Assisted) Generation

**IA Context Engineering** constructs architecture‑aware prompts from your current models, modules, and conventions. The LLM’s suggestions are **presented as code diffs** through the Software Factory — *never applied automatically*.

> Think of this as **AI pair‑programming that respects your architecture**.

---

## Code Management & Governance

- Generated and handwritten code **co‑exist** via a merge‑aware engine.  
- Developers can **opt in/out** per file/region.  
- **Customization tracking** highlights intentional deviations for transparency.  
- Enables **sweeping refactors** (e.g., replace a mapping framework via module swap).

---

## Living Documentation

Your models and visualizations are a **true reflection** of the code (when the factory is applied). This improves collaboration, onboarding, and design reviews.

---

## Next Steps

- **[Quick Start](xref:introducing.quickstart)**
- **[Get Intent Architect](xref:introducing.get-the-app)**
