---
uid: introducing.extending
title: Extending & Integrating Intent Architect
---

# Extending & Integrating Intent Architect

Intent Architect is **module‑driven** — nearly everything can be extended, replaced, or customized. ~**95%** of modules are open source.

---

## Modules & Templates

- **Modules** are like NuGet for **architecture patterns** (but they merge **source code**).  
- **Templates** preconfigure IA for common styles (Clean Architecture, CQRS, DDD).  
- Install/upgrade/swap modules to evolve your stack.

> Example: Replace a mapping framework by uninstalling one module and installing another.

---

## Creating Custom Modules

Capture proprietary conventions and boilerplate as reusable modules for massive ROI. Publish internally or contribute to the community.

---

## Accelerators

UI “macros” that automate modeling tasks:
- Generate CRUD services from a domain entity.  
- Add paging/filtering to a service contract.  
- Bootstrap DTOs from domain models.

---

## Code Management & Governance

- Generated and handwritten code co‑exist (merge‑aware).  
- Intentional **architectural deviations** are supported and **tracked**.  
- **Customization tracking** gives visibility into where patterns were modified.  
- Enforces **architecture opt‑out** behavior for consistency and readability.

---

## CI/CD & Source Control

Designs are **local files** checked into your repo. Works with any CI/CD; merges naturally. Keep your **living diagrams** in sync by applying the Software Factory.

---

## Next Steps

- **[Learn the Fundamentals](learn-fundamentals.md)**  
- **[Reference & Resources](reference.md)**
