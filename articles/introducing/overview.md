---
uid: introducing.overview
---

<style>
/* =============================================================================
   Intent Architect Overview — Final (DocFX 2.77+ compatible)
   ============================================================================= */

.ia-overview {
  --card-title-size: 1.6rem;
  --card-body-size: 1.6rem;
  --card-line-height: 1.55;
  --card-pad-y: 22px;
  --card-pad-x: 22px;
  --card-gap: 22px;
  --card-radius: 16px;

  --icon-box: 40px;
  --icon-font: 20px;

  --card-text: #334155;
  --card-title-color: #0f172a;
  --card-border: #cbd5e1;
  --card-bg-top: #ffffff;
  --card-bg-btm: #ffffff;
}

/* Responsive Grids */
.ia-overview .cards-grid { list-style: none; padding: 0; margin: 0; display: grid; gap: var(--card-gap); }
.ia-overview .cards-3 { grid-template-columns: 1fr; }
.ia-overview .cards-2x2 { grid-template-columns: 1fr; }
@media (min-width: 720px) {
  .ia-overview .cards-3 { grid-template-columns: repeat(3, minmax(0, 1fr)); }
  .ia-overview .cards-2x2 { grid-template-columns: repeat(2, minmax(0, 1fr)); }
}

/* Card Shell */
.ia-overview .card {
  position: relative;
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
.ia-overview .card:hover {
  transform: translateY(-2px);
  border-color: var(--card-title-color);
  box-shadow: 0 6px 16px rgba(0,0,0,.15);
}
.ia-overview .card > .content { flex: 1 1 auto; min-width: 0; }

/* Icons */
.ia-overview .icon {
  display: flex; align-items: center; justify-content: center;
  width: var(--icon-box); height: var(--icon-box);
  flex: 0 0 var(--icon-box); min-width: var(--icon-box); max-width: var(--icon-box);
  border-radius: 10px;
  background-clip: padding-box;
  color: #fff;
  font-size: var(--icon-font);
  font-family: "Segoe UI Emoji","Apple Color Emoji","Noto Color Emoji","Twemoji Mozilla",system-ui,sans-serif;
  box-sizing: content-box;
}

/* Icon Accent Colors */
.ia-overview .cards-grid > li:nth-child(6n+1) .icon { background: #2563eb; }
.ia-overview .cards-grid > li:nth-child(6n+2) .icon { background: #059669; }
.ia-overview .cards-grid > li:nth-child(6n+3) .icon { background: #7e22ce; }
.ia-overview .cards-grid > li:nth-child(6n+4) .icon { background: #be185d; }
.ia-overview .cards-grid > li:nth-child(6n+5) .icon { background: #0284c7; }
.ia-overview .cards-grid > li:nth-child(6n+6) .icon { background: #6d28d9; }

/* Typography */
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
  max-width: 68ch;
}

/* XREF-friendly clickable card overlay */
.ia-overview .xref-card strong.card-title a.xref {
  color: var(--card-title-color);
  text-decoration: none;
  position: relative;
  z-index: 1;
}
.ia-overview .xref-card strong.card-title a.xref::after {
  content: "";
  position: absolute;
  inset: 0;
  border-radius: inherit;
  z-index: 0;
}
.ia-overview .xref-card:hover strong.card-title a.xref {
  text-decoration: underline;
}

/* Hint Line */
.ia-overview h2 + blockquote {
  background: none !important;
  border: 0 !important;
  border-left: 3px solid var(--card-title-color) !important;
  padding: .6rem .75rem .6rem .9rem !important;
  margin: .5rem 0 1rem 0 !important;
  color: var(--card-text) !important;
  font-size: var(--card-body-size);
  line-height: var(--card-line-height);
}
.ia-overview h2 + blockquote p { margin: 0; }

/* Dark Mode */
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
html[data-bs-theme="dark"] .ia-overview .card,
html[data-theme="dark"] .ia-overview .card {
  box-shadow: 0 3px 8px rgba(0,0,0,.3);
}

/* Full-card clickable overlay for DocFX xrefs */
.ia-overview .card > a[href]{
  position: absolute;
  inset: 0;
  border-radius: inherit;
  text-decoration: none !important;
  z-index: 0; /* content stays above for selection */
}
.ia-overview .card:hover > a[href]{ cursor: pointer; }
.ia-overview .card > a[href]:focus-visible{
  outline: 2px solid var(--card-title-color);
  outline-offset: 2px;
}

/* Hide DocFX-inserted text inside the stretched overlay link */
.ia-overview .card > a[href]{
  position: absolute;
  inset: 0;
  border-radius: inherit;
  text-decoration: none !important;
  z-index: 0;
  /* hide any auto-inserted link text without breaking focusability */
  font-size: 0 !important;
  line-height: 0 !important;
  color: transparent !important;
}
.ia-overview .card:hover > a[href]{ cursor: pointer; }
.ia-overview .card > a[href]:focus-visible{
  outline: 2px solid var(--card-title-color);
  outline-offset: 2px;
}
</style>

<div class="ia-overview">

# Introduction to Intent Architect

Intent Architect is the first architecture-centric code automation platform for professional .NET developers.

It’s the platform leading .NET teams use to deliver 10X faster, standardize flawlessly at scale, and maintain systems with ease – using their preferred tech stack, IDE and LLM.

It combines cutting-edge code generation systems, such as Pattern Reuse and your favorite LLM, to continuously generate clean, production-ready code driven by your architectural intention and approved design — so your code stays standardized, consistent, and easy to maintain.

![Overview](images/ia-overview.png)

---

## Getting Started

> Install the app, build your first solution, then go deeper with tutorials.

<ul class="cards-grid cards-3">
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">⬇️</span>
      <div class="content">
        <strong class="card-title">Get Intent Architect</strong>
        <p class="card-text">Download and install the latest Intent Architect for your environment.</p>
      </div>
      <a href="xref:introducing.get-the-app" aria-label="Get Intent Architect"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">🚀</span>
      <div class="content">
        <strong class="card-title">Quick Start</strong>
        <p class="card-text">Generate a working .NET solution in minutes and learn the core workflow.</p>
      </div>
      <a href="xref:introducing.quickstart" aria-label="Quick Start"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">📚</span>
      <div class="content">
        <strong class="card-title">Tutorials</strong>
        <p class="card-text">Hands-on guides for domains, services, integrations, testing, and more.</p>
      </div>
      <a href="xref:introducing.tutorials" aria-label="Tutorials"></a>
    </div>
  </li>
</ul>

---

## What Intent Architect Does

> Intent Architect turns architectural design into concrete, automated development, so you can see, generate, and evolve your system with confidence.

<ul class="cards-grid cards-2x2">
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">🧩</span>
      <div class="content">
        <strong class="card-title">Model visually</strong>
        <p class="card-text">Design domains, services, and integrations through an intuitive visual interface.</p>
      </div>
      <a href="xref:introducing.modeling" aria-label="Model visually"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">⚙️</span>
      <div class="content">
        <strong class="card-title">Deterministic code generation</strong>
        <p class="card-text">Keep design and code continuously in sync with reliable, repeatable generation.</p>
      </div>
      <a href="xref:introducing.codegen" aria-label="Deterministic code generation"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">🤖</span>
      <div class="content">
        <strong class="card-title">AI-assisted generation</strong>
        <p class="card-text">Use architectural context to guide an LLM for prompt-light, developer-controlled changes.</p>
      </div>
      <a href="xref:introducing.ai-assisted" aria-label="AI-assisted generation"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">📏</span>
      <div class="content">
        <strong class="card-title">Enforce standards</strong>
        <p class="card-text">Apply consistent structure, naming, and patterns across your entire codebase by default.</p>
      </div>
      <a href="xref:introducing.standards" aria-label="Enforce standards"></a>
    </div>
  </li>
</ul>

---

## Next Steps

- Continue to **[Get Intent Architect](xref:introducing.get-the-app)**
- Jump to **[Quick Start](xref:introducing.quickstart)**
- Explore **[Tutorials](xref:introducing.tutorials)**

</div>
