---
uid: introducing.overview
---
<style>
/* ==========================================================================
   Intent Architect Overview — Final Card Design (light default + dark override)
   ========================================================================== */

.ia-overview {
  /* Your original large sizing */
  --card-title-size: 1.6rem;
  --card-body-size: 1.6rem;
  --card-line-height: 1.55;
  --card-pad-y: 22px;
  --card-pad-x: 22px;
  --card-gap: 22px;
  --card-radius: 16px;

  /* Icon sizes (original) */
  --icon-box: 40px;   /* cards-2 */
  --icon-font: 20px;

  /* LIGHT defaults (readable on white) */
  --card-text: #334155;        /* slate-700 */
  --card-title-color: #0f172a; /* slate-900 */
  --card-border: #cbd5e1;      /* slate-300 */
  --card-bg-top: #ffffff;
  --card-bg-btm: #ffffff;
}

/* ==========================================================================
   2-column responsive grid
   ========================================================================== */
.ia-overview .cards-2 > ul {
  display: grid;
  gap: var(--card-gap);
  list-style: none;
  padding: 0;
  margin: 0;
}
@media (min-width: 900px) {
  .ia-overview .cards-2 > ul { grid-template-columns: repeat(2, minmax(0, 1fr)); }
}

/* ==========================================================================
   Card Shell
   ========================================================================== */
.ia-overview .cards-2 > ul > li {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  padding: var(--card-pad-y) var(--card-pad-x);
  border: 1px solid var(--card-border);
  border-radius: var(--card-radius);
  background: linear-gradient(180deg, var(--card-bg-top), var(--card-bg-btm));
  box-shadow: 0 2px 8px rgba(15,23,42,.08);
  transition: transform .2s ease, box-shadow .25s ease, border-color .25s ease;
}
.ia-overview .cards-2 > ul > li:hover {
  transform: translateY(-2px);
  border-color: var(--card-title-color);
  box-shadow: 0 6px 16px rgba(0,0,0,.15);
}

/* Let the text area grow; don't squeeze icons */
.ia-overview .cards-2 > ul > li > div,
.ia-overview .ps-card > div { flex: 1 1 auto; min-width: 0; }

/* ==========================================================================
   ICONS — make them unsqueezable (explicit width/height/flex-basis)
   ========================================================================== */

/* Two-column cards icon — target the direct child for max specificity */
.ia-overview .cards-2 > ul > li > .icon {
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  line-height: 1 !important;
  border-radius: 10px !important;
  background-clip: padding-box !important;
  color: #fff !important;
  font-family: "Segoe UI Emoji","Apple Color Emoji","Noto Color Emoji","Twemoji Mozilla",system-ui,sans-serif !important;

  width: var(--icon-box) !important;
  height: var(--icon-box) !important;
  font-size: var(--icon-font) !important;

  /* The fixes that stop shrinking */
  flex: 0 0 var(--icon-box) !important;
  min-width: var(--icon-box) !important;
  max-width: var(--icon-box) !important;
  box-sizing: content-box !important;
}

/* Problems We Solve icons (44/22) */
.ia-overview .ps-icon {
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  line-height: 1 !important;
  border-radius: 10px !important;
  background-clip: padding-box !important;
  color: #fff !important;
  font-family: "Segoe UI Emoji","Apple Color Emoji","Noto Color Emoji","Twemoji Mozilla",system-ui,sans-serif !important;

  width: 44px !important;
  height: 44px !important;
  font-size: 22px !important;

  /* The fixes that stop shrinking */
  flex: 0 0 44px !important;
  min-width: 44px !important;
  max-width: 44px !important;
  box-sizing: content-box !important;
}

/* ==========================================================================
   Titles & body text
   ========================================================================== */
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
  max-width: 68ch; /* comfy width on 2-col cards */
}

/* Icon accent colors (looping 6) */
.ia-overview .cards-2 > ul > li:nth-child(6n+1) > .icon { background: #2563eb; }
.ia-overview .cards-2 > ul > li:nth-child(6n+2) > .icon { background: #059669; }
.ia-overview .cards-2 > ul > li:nth-child(6n+3) > .icon { background: #7e22ce; }
.ia-overview .cards-2 > ul > li:nth-child(6n+4) > .icon { background: #be185d; }
.ia-overview .cards-2 > ul > li:nth-child(6n+5) > .icon { background: #0284c7; }
.ia-overview .cards-2 > ul > li:nth-child(6n+6) > .icon { background: #6d28d9; }

/* ==========================================================================
   Problems We Solve — single column cards
   ========================================================================== */
.ia-overview .ps-grid {
  display: grid;
  gap: var(--card-gap);
  margin: 0;
  padding: 0;
  grid-template-columns: 1fr;
  max-width: 1000px;
  margin-inline: auto;
}
.ia-overview .ps-card {
  list-style: none;
  display: flex;
  align-items: flex-start;
  gap: 18px;
  padding: var(--card-pad-y) var(--card-pad-x);
  border: 1px solid var(--card-border);
  border-radius: var(--card-radius);
  background: linear-gradient(180deg, var(--card-bg-top), var(--card-bg-btm));
  box-shadow: 0 2px 8px rgba(15,23,42,.08);
  transition: transform .2s ease, box-shadow .25s ease, border-color .25s ease;
}
.ia-overview .ps-card:hover {
  transform: translateY(-2px);
  border-color: var(--card-title-color);
  box-shadow: 0 6px 16px rgba(0,0,0,.15);
}
.ia-overview .ps-title {
  font-size: var(--card-title-size);
  font-weight: 650;
  margin: 0 0 8px;
  color: var(--card-title-color);
  line-height: 1.3;
}
.ia-overview .ps-text {
  font-size: var(--card-body-size);
  line-height: var(--card-line-height);
  color: var(--card-text);
  margin: 0;
  max-width: none; /* full width on single-column cards */
}

/* Accent colors for ps icons */
.ia-overview .ps-grid > li:nth-child(6n+1) .ps-icon{ background:#2563eb; }
.ia-overview .ps-grid > li:nth-child(6n+2) .ps-icon{ background:#059669; }
.ia-overview .ps-grid > li:nth-child(6n+3) .ps-icon{ background:#7e22ce; }
.ia-overview .ps-grid > li:nth-child(6n+4) .ps-icon{ background:#be185d; }
.ia-overview .ps-grid > li:nth-child(6n+5) .ps-icon{ background:#0284c7; }
.ia-overview .ps-grid > li:nth-child(6n+6) .ps-icon{ background:#6d28d9; }

/* ==========================================================================
   Hint line (blockquote under each H2)
   ========================================================================== */
.ia-overview h2 + blockquote{
  background: none !important;
  border: 0 !important;
  border-radius: 0 !important;
  border-left: 3px solid var(--card-title-color) !important;
  padding: .6rem .75rem .6rem .9rem !important;
  margin: .5rem 0 1rem 0 !important;
  color: var(--card-text) !important;
  font-size: var(--card-body-size);
  line-height: var(--card-line-height);
}
.ia-overview h2 + blockquote p{ margin:0 }

/* ==========================================================================
   DARK MODE overrides (DocFX/Bootstrap flags)
   ========================================================================== */
html[data-theme="dark"] .ia-overview,
body[data-theme="dark"] .ia-overview,
html[data-bs-theme="dark"] .ia-overview,
body[data-bs-theme="dark"] .ia-overview,
body.theme-dark .ia-overview,
html.theme-dark .ia-overview {
  --card-text: #cfd6e3;
  --card-title-color: #ffffff;
  --card-border: rgba(148,163,184,.28);
  --card-bg-top: rgba(255,255,255,.05);
  --card-bg-btm: rgba(255,255,255,.02);
}

/* Slightly stronger shadow in dark mode */
html[data-bs-theme="dark"] .ia-overview .cards-2 > ul > li,
html[data-theme="dark"] .ia-overview .cards-2 > ul > li,
html[data-bs-theme="dark"] .ia-overview .ps-card,
html[data-theme="dark"] .ia-overview .ps-card {
  box-shadow: 0 3px 8px rgba(0,0,0,.3);
}
</style>

<div class="ia-overview">

# Introduction to Intent Architect

**Intent Architect** is an **extensible IDE for software architecture** — a *design-time* tool that lets you visually model your systems and continuously integrate that design into your **.NET source code**.

Built for professional developers, it works **side-by-side with your favourite IDE** (Visual Studio, Rider, etc.), automating predictable code, enforcing architectural consistency, and maintaining clean, standardized solutions at scale.

By combing visual modeling and cutting-edge code generation systems, Intent Architect keeps your code **standardized, maintainable, and architecture-driven**.

![Overview](images/ia-overview.png)

---

## What Intent Architect Does

> Intent Architect turns architectural design into concrete, automated development, so you can see, generate, and evolve your system with confidence.

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

> Intent Architect was built to fix the everyday challenges that slow down teams and erode code quality over time.

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

---

## Why It’s Different

> Intent Architect is just different, there is no other tool quiet like it.

<div class="cards-2">
  <ul>
    <li>
      <span class="icon" aria-hidden="true">🧱</span>
      <div>
        <strong class="card-title">No Lock-in</strong>
        <p class="card-text">Runs entirely at design time. You can stop using it anytime—your code keeps running. No runtime lock-in or hidden frameworks.</p>
      </div>
    </li>
    <li>
      <span class="icon" aria-hidden="true">💻</span>
      <div>
        <strong class="card-title">Developer-centric</strong>
        <p class="card-text">Unlike low-code platforms, Intent Architect empowers developers, not replaces them. All generated code is standard and maintainable.</p>
      </div>
    </li>
    <li>
      <span class="icon" aria-hidden="true">♾️</span>
      <div>
        <strong class="card-title">Continuous code automation</strong>
        <p class="card-text">Architecture and code evolve together continuously, not as one-off scaffolding.</p>
      </div>
    </li>
    <li>
      <span class="icon" aria-hidden="true">🚦</span>
      <div>
        <strong class="card-title">Architecture opt-out model</strong>
        <p class="card-text">Standards are enforced by default; deviations are intentional, visible, and tracked.</p>
      </div>
    </li>
    <li>
      <span class="icon" aria-hidden="true">✅</span>
      <div>
        <strong class="card-title">Change Transparency</strong>
        <p class="card-text">Every change is proposed as a diff for developer approval before applying—automation with full control.</p>
      </div>
    </li>
    <li>
      <span class="icon" aria-hidden="true">🧠</span>
      <div>
        <strong class="card-title">Deterministic & Non-Deterministic Code Generation</strong>
        <p class="card-text">Combines pattern re-use with AI-assisted generation, both governed and traceable within the same pipeline.</p>
      </div>
    </li>
    <li>
      <span class="icon" aria-hidden="true">🛡️</span>
      <div>
        <strong class="card-title">Deterministic AI</strong>
        <p class="card-text">AI assistance with guardrails—Intent Architect constructs full architectural context for the LLM, producing repeatable, reviewable diffs you can trust.</p>
      </div>
    </li>
    <li>
      <span class="icon" aria-hidden="true">🧩</span>
      <div>
        <strong class="card-title">Code Automation Platform</strong>
        <p class="card-text">Every behavior is modular and extensible. Our modules are open source, allowing teams to customize and evolve patterns transparently.</p>
      </div>
    </li>
    <li>
      <span class="icon" aria-hidden="true">🗺️</span>
      <div>
        <strong class="card-title">Living documentation</strong>
        <p class="card-text">Architecture remains visible, accurate, and collaborative, always reflecting the real system.</p>
      </div>
    </li>
    <li>
      <span class="icon" aria-hidden="true">🧰</span>
      <div>
        <strong class="card-title">Augments your Favourite IDE</strong>
        <p class="card-text">Works seamlessly alongside Visual Studio or Rider, complementing your existing workflow.</p>
      </div>
    </li>
  </ul>
</div>

## Next Steps

- Jump to **[Installation](installation.md)**
- Continue to **[Quick Start](quickstart.md)**

</div>