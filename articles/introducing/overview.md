---
uid: introducing.overview
---
<style>
/* ===== Intent Architect Overview — Final Card Design ===== */
.ia-overview {
  /* Typography & layout scale */
  --card-title-size: 1.6rem;
  --card-body-size: 1.6rem;
  --card-line-height: 1.55;
  --card-pad-y: 22px;
  --card-pad-x: 22px;
  --card-gap: 22px;
  --icon-box: 40px; /* tightened for balance */
  --icon-font: 20px;
  --card-radius: 16px;

  /* Color tokens */
  --card-border: rgba(148, 163, 184, 0.28);
  --card-bg-top: rgba(255, 255, 255, 0.05);
  --card-bg-btm: rgba(255, 255, 255, 0.02);
  --card-title-color: #fff;
  --card-text: #cfd6e3;
}

/* 2-column responsive grid */
.ia-overview .cards-2 > ul {
  display: grid;
  gap: var(--card-gap);
  list-style: none;
  padding: 0;
  margin: 0;
}
@media (min-width: 900px) {
  .ia-overview .cards-2 > ul {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

/* Card shell */
.ia-overview .cards-2 > ul > li {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  padding: var(--card-pad-y) var(--card-pad-x);
  border: 1px solid var(--card-border);
  border-radius: var(--card-radius);
  background: linear-gradient(180deg, var(--card-bg-top), var(--card-bg-btm));
  box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
  transition: transform 0.2s ease, box-shadow 0.25s ease, border-color 0.25s ease;
}

/* Hover feedback (subtle but crisp) */
.ia-overview .cards-2 > ul > li:hover {
  transform: translateY(-3px);
  border-color: var(--card-title-color);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.25);
}

/* Icon styling */
.ia-overview .cards-2 .icon {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  width: var(--icon-box);
  height: var(--icon-box);
  font-size: var(--icon-font);
  border-radius: 10px;
  color: #fff;
  margin-top: 4px; /* visually centers with text */
}

/* Title & text */
.ia-overview .card-title {
  font-size: var(--card-title-size);
  font-weight: 650;
  margin: 0 0 8px;
  color: var(--card-title-color);
  line-height: 1.3;
}
.ia-overview .card-text {
  font-size: var(--card-body-size);
  color: var(--card-text);
  line-height: var(--card-line-height);
  margin: 0;
  max-width: 68ch; /* ideal reading width */
}

/* Icon accent colors (looping pattern of 6) */
.ia-overview .cards-2 > ul > li:nth-child(6n+1) .icon { background: #2563eb; }
.ia-overview .cards-2 > ul > li:nth-child(6n+2) .icon { background: #059669; }
.ia-overview .cards-2 > ul > li:nth-child(6n+3) .icon { background: #7e22ce; }
.ia-overview .cards-2 > ul > li:nth-child(6n+4) .icon { background: #be185d; }
.ia-overview .cards-2 > ul > li:nth-child(6n+5) .icon { background: #0284c7; }
.ia-overview .cards-2 > ul > li:nth-child(6n+6) .icon { background: #6d28d9; }

/* Light theme adaptation */
@media (prefers-color-scheme: light) {
  .ia-overview {
    --card-text: #334155;
    --card-title-color: #0f172a;
    --card-border: #e2e8f0;
    --card-bg-top: #fff;
    --card-bg-btm: #fff;
  }
}

/* ===== Problems We Solve — single column cards ===== */
.ia-overview .ps-grid {
  display: grid;
  gap: var(--card-gap, 22px);
  margin: 0;
  padding: 0;
  grid-template-columns: 1fr; /* single column */
  max-width: 1000px; /* keeps line length elegant */
  margin-inline: auto; /* centers the column */
}

/* Card look, same DNA as IA cards */
.ia-overview .ps-card {
  list-style: none;
  display: flex;
  align-items: flex-start;
  gap: 18px;
  padding: var(--card-pad-y, 22px) var(--card-pad-x, 22px);
  border: 1px solid var(--card-border, rgba(148,163,184,.28));
  border-radius: var(--card-radius, 16px);
  background: linear-gradient(180deg, var(--card-bg-top, rgba(255,255,255,.05)), var(--card-bg-btm, rgba(255,255,255,.02)));
  box-shadow: 0 3px 8px rgba(0,0,0,.15);
  transition: transform .2s ease, box-shadow .25s ease, border-color .25s ease;
}
.ia-overview .ps-card:hover {
  transform: translateY(-3px);
  border-color: var(--card-title-color, #fff);
  box-shadow: 0 6px 16px rgba(0,0,0,.25);
}

/* Icon and typography (reuse your variables) */
.ia-overview .ps-icon {
  flex-shrink: 0;
  width: 44px;
  height: 44px;
  font-size: 22px;
  border-radius: 10px;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 6px;
}

.ia-overview .ps-title {
  font-size: var(--card-title-size, 1.6rem);
  font-weight: 650;
  margin: 0 0 8px;
  color: var(--card-title-color, #fff);
  line-height: 1.3;
}

.ia-overview .ps-text {
  font-size: var(--card-body-size, 1.6rem);
  line-height: var(--card-line-height, 1.55);
  color: var(--card-text, #cfd6e3);
  margin: 0;
}

/* Icon accent colors */
.ia-overview .ps-grid > li:nth-child(6n+1) .ps-icon{ background:#2563eb; }
.ia-overview .ps-grid > li:nth-child(6n+2) .ps-icon{ background:#059669; }
.ia-overview .ps-grid > li:nth-child(6n+3) .ps-icon{ background:#7e22ce; }
.ia-overview .ps-grid > li:nth-child(6n+4) .ps-icon{ background:#be185d; }
.ia-overview .ps-grid > li:nth-child(6n+5) .ps-icon{ background:#0284c7; }
.ia-overview .ps-grid > li:nth-child(6n+6) .ps-icon{ background:#6d28d9; }

</style>

<div class="ia-overview">

# Introduction to Intent Architect

**Intent Architect** is an extensible **IDE for software architecture**, a *design-time* tool that lets you visually model your systems while continuously integrating that design into your **.NET source code**.

It’s **developer-centric** and proudly **High-Code**: you work in your IDE (Visual Studio, Rider, etc.) as usual, while Intent Architect automates the predictable parts, enforces architectural consistency, and provides transparent governance and control.

---

## What Intent Architect Does

>Intent Architect turns architectural design into concrete, automated development, so you can see, generate, and evolve your system with confidence.

<div class="cards-2">
  <ul>
    <li>
      <span class="icon">🧩</span>
      <div>
        <strong class="card-title">Model visually</strong>
        <p class="card-text">Design domains, services, and integrations through an intuitive visual interface.</p>
      </div>
    </li>
    <li>
      <span class="icon">⚙️</span>
      <div>
        <strong class="card-title">Deterministic code generation</strong>
        <p class="card-text">Intent Architect writes and maintains your system’s boilerplate and architectural patterns automatically, keeping design and code continuously in sync.</p>
      </div>
    </li>
    <li>
      <span class="icon">🤖</span>
      <div>
        <strong class="card-title">Non-deterministic (AI-assisted) code generation</strong>
        <p class="card-text">Intent Architect can use architectural context to guide an LLM for “prompt-less” AI interactions.</p>
      </div>
    </li>
    <li>
      <span class="icon">📏</span>
      <div>
        <strong class="card-title">Enforces consistency and standards</strong>
        <p class="card-text">With up to 85% of your solution is generated, Intent Architect automatically applies consistent structure, naming, and practices across your entire codebase.</p>
      </div>
    </li>
    <li>
      <span class="icon">🧑‍💻</span>
      <div>
        <strong class="card-title">Developer-in-the-loop</strong>
        <p class="card-text">Every proposed change is presented as a diff for review and approval before it touches your source.</p>
      </div>
    </li>
    <li>
      <span class="icon">🔄</span>
      <div>
        <strong class="card-title">Architectural refactoring</strong>
        <p class="card-text">Make broad, pattern-level changes across your solution in a single controlled action.</p>
      </div>
    </li>
    <li>
      <span class="icon">🗺️</span>
      <div>
        <strong class="card-title">Visualize your design</strong>
        <p class="card-text">Architecture diagrams always reflect the actual code, creating living documentation you can trust.</p>
      </div>
    </li>
    <li>
      <span class="icon">🧰</span>
      <div>
        <strong class="card-title">Extensible platform for code automation</strong>
        <p class="card-text">Extend Intent Architect with your own modules or templates, or extend existing ones,  most are open source.</p>
      </div>
    </li>
  </ul>
</div>

---

## Problems We Solve

>Intent Architect was built to fix the everyday challenges that slow down teams and erode code quality over time.

<ul class="ps-grid">

  <li class="ps-card">
    <div class="ps-icon">⚡</div>
    <div>
      <h3 class="ps-title">Faster Delivery</h3>
      <p class="ps-text">A large portion of development time goes into writing and maintaining repetitive, mechanical code — services, DTOs, controllers, and mappings. <strong>Intent Architect automates up to 85% of that code deterministically</strong>, so teams can focus on meaningful logic and features instead of boilerplate.</p>
    </div>
  </li>

  <li class="ps-card">
    <div class="ps-icon">✅</div>
    <div>
      <h3 class="ps-title">Consistent, High-Quality Code</h3>
      <p class="ps-text">As teams grow, small inconsistencies in structure, naming, and layering compound into major maintenance issues. <strong>Intent Architect enforces standards automatically</strong> through code automation, producing clean, uniform code across projects by default.</p>
    </div>
  </li>

  <li class="ps-card">
    <div class="ps-icon">🤝</div>
    <div>
      <h3 class="ps-title">Better Collaboration</h3>
      <p class="ps-text">Architectural intent often gets lost between architects, developers, and leads, trapped in outdated documents, tribal knowledge, or code that must be painstakingly reverse-engineered to understand. <strong>Intent Architect makes design explicit, visible, and collaborative</strong>, everyone works from the same living architecture model, which ultimately is the code.</p>
    </div>
  </li>

  <li class="ps-card">
    <div class="ps-icon">🧭</div>
    <div>
      <h3 class="ps-title">Better Understanding of Complex Systems</h3>
      <p class="ps-text"><strong>Intent Architect’s living diagrams</strong> visualize domains, services, and integrations directly from the source code, allowing new (and existing) developers to explore and understand a system in minutes.</p>
    </div>
  </li>

  <li class="ps-card">
    <div class="ps-icon">🔁</div>
    <div>
      <h3 class="ps-title">Agile Architecture</h3>
      <p class="ps-text">Architecture is traditionally rigid — once it’s coded, it’s hard to evolve safely. <strong>Intent Architect turns architecture into something adaptable</strong>, enabling sweeping, pattern-level refactors or upgrades across large systems in a single controlled action.</p>
    </div>
  </li>

  <li class="ps-card">
    <div class="ps-icon">🧹</div>
    <div>
      <h3 class="ps-title">Reduced Technical Debt</h3>
      <p class="ps-text">Code drift, duplicated patterns, and inconsistent practices accumulate debt fast. <strong>IA prevents drift before it starts</strong> by continuously synchronizing architecture and source, and lets teams retroactively realign existing systems without rewrites.</p>
    </div>
  </li>

  <li class="ps-card">
    <div class="ps-icon">🏗️</div>
    <div>
      <h3 class="ps-title">Better Standardization</h3>
      <p class="ps-text">Keeping standards aligned across teams and projects is nearly impossible manually. <strong>IA centralizes patterns in modules</strong>, so every generated component adheres to the same conventions by default.</p>
    </div>
  </li>

  <li class="ps-card">
    <div class="ps-icon">🛡️</div>
    <div>
      <h3 class="ps-title">Deterministic AI</h3>
      <p class="ps-text">AI tools can be unpredictable and prompt-heavy. <strong>Intent Architect integrates AI with guardrails</strong>, constructs architectural context automatically, and converts results into reviewable diffs,  enabling deterministic, repeatable, prompt-less generation that’s developer-controlled.</p>
    </div>
  </li>

</ul>


</div>
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

### Faster Delivery

A large portion of development time goes into writing and maintaining repetitive, mechanical code — services, DTOs, controllers, and mappings.
**Intent Architect automates up to 85% of that code deterministically**, so teams can focus on meaningful logic and features instead of boilerplate.

### Consistent, High-Quality Code

As teams grow, small inconsistencies in structure, naming, and layering compound into major maintenance issues.  
**Intent Architect enforces standards automatically** through code automation, producing clean, uniform code across projects by default.

### Better Collaboration

Architectural intent often gets lost between architects, developers, and leads, trapped in outdated documents, tribal knowledge, or code that must be painstakingly reverse-engineered to understand.
**Intent Architect makes design explicit, visible, and collaborative**  developers, architects, and leads all work from the same living architecture model, which ultimately is the code.

### Better Understanding of Complex Systems

As projects grow and inconsistencies creep in, systems become harder to understand and  reason about.  
**Intent Architect’s living diagrams** visualize domains, services, and integrations directly from the source code, allowing new (and existing) developers to explore and understand a system in minutes.

### Agile Architecture

Architecture is traditionally one of the most rigid parts of software — once it’s coded, it’s hard to evolve safely.
**Intent Architect turns architecture into something adaptable**, enabling sweeping, pattern-level refactors or upgrades across large systems in a single controlled action.

### Reduced Technical Debt

Code drift, duplicated patterns, and inconsistent practices accumulate debt fast.  
**IA prevents drift before it starts** by continuously synchronizing architecture and source, and allows teams to retroactively realign existing systems without rewrites.

### Better Standardization

Keeping standards aligned across teams and projects is nearly impossible manually.  
**IA centralizes patterns in modules**, so every generated component across your organization adheres to the same design and coding conventions by default.

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
