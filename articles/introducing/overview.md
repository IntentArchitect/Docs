---
uid: introducing.overview
---

<style>
/* =============================================================================
   Intent Architect Overview - Final (DocFX 2.77+ compatible)
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
/*
.ia-overview .cards-grid > li:nth-child(6n+1) .icon { background: #2563eb; }
.ia-overview .cards-grid > li:nth-child(6n+2) .icon { background: #059669; }
.ia-overview .cards-grid > li:nth-child(6n+3) .icon { background: #7e22ce; }
.ia-overview .cards-grid > li:nth-child(6n+4) .icon { background: #be185d; }
.ia-overview .cards-grid > li:nth-child(6n+5) .icon { background: #0284c7; }
.ia-overview .cards-grid > li:nth-child(6n+6) .icon { background: #6d28d9; }*/

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

Intent Architect is the first architecture-centric AI code automation platform for .NET developers.

It’s the platform that delivers AI-driven development speed, with built-in guardrails and uncompromised quality, at any scale.

It brings design and architectural visibility to your software development processes and unlocks a single cohesive workflow to go from specification to production-ready code up to 10X faster. Architectural adherence enforced by default. Technical and cognitive debt minimized by design.

![Overview](images/Docs-v1.png)

---

## Getting started

<ul class="cards-grid cards-3">
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <defs><linearGradient id="grad-get" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient></defs>
  <path stroke="url(#grad-get)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M12 3v12"/>
  <path stroke="url(#grad-get)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M8 11l4 4 4-4"/>
  <path stroke="url(#grad-get)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M4 17v1a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2v-1"/>
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Get Intent Architect</strong>
        <p class="card-text">Download and install the latest Intent Architect for your environment.</p>
      </div>
      <a href="xref:getting-started.get-the-application" aria-label="Get Intent Architect"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <defs><linearGradient id="grad-qs" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient></defs>
  <path stroke="url(#grad-qs)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M13 3L4 14h7l-1 7 9-11h-7l1-7z"/>
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Quick Start</strong>
        <p class="card-text">Generate a working .NET solution in minutes and learn the core workflow.</p>
      </div>
      <a href="xref:introducing.quickstart" aria-label="Quick Start"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <defs><linearGradient id="grad-tut" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient></defs>
  <path stroke="url(#grad-tut)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M3 19a9 9 0 0 1 9 0 9 9 0 0 1 9 0M3 6a9 9 0 0 1 9 0 9 9 0 0 1 9 0M3 6v13M12 6v13M21 6v13"/>
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Tutorials</strong>
        <p class="card-text">Hands-on guides to learn the fundamentals and more.</p>
      </div>
      <a href="xref:tutorials.fundamentals-landing-page" aria-label="Tutorials"></a>
    </div>
  </li>
</ul>

---

## Key Concepts

<ul class="cards-grid cards-2x2">
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <defs><linearGradient id="grad-vdt" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient></defs>
  <rect x="2" y="3" width="8" height="5" rx="1" stroke="url(#grad-vdt)" fill="none" stroke-width="1.5"/>
  <rect x="14" y="3" width="8" height="5" rx="1" stroke="url(#grad-vdt)" fill="none" stroke-width="1.5"/>
  <rect x="8" y="16" width="8" height="5" rx="1" stroke="url(#grad-vdt)" fill="none" stroke-width="1.5"/>
  <path stroke="url(#grad-vdt)" fill="none" stroke-width="1.5" stroke-linecap="round" d="M6 8v4h12V8M12 12v4"/>
</svg>
      </span>
<!--      <span class="icon" aria-hidden="true">🧩</span>-->
      <div class="content">
        <strong class="card-title">Visual Design Tools</strong>
        <p class="card-text">Software development is going visual. Intent Architect's visual design tools let you create living blueprints of your system that realize directly as code, creating a powerful context engine to minimize technical and cognitive debt by design.</p>
      </div>
      <a href="xref:key-concepts.visual-modeling" aria-label="Visual Modeling"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <defs><linearGradient id="grad-ae" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient></defs>
  <path stroke="url(#grad-ae)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M12 2l9 4.5-9 4.5-9-4.5 9-4.5z"/>
  <path stroke="url(#grad-ae)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M3 11l9 4.5 9-4.5"/>
  <path stroke="url(#grad-ae)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M3 16l9 4.5 9-4.5"/>
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Architecture Enforcement</strong>
        <p class="card-text">Guaranteed consistency and standardization, by default. Deterministic architecture enforcement systems provide strong guardrails, ensuring a consistent implementation of your design and architecture at any scale, with zero drift.</p>
      </div>
      <a href="xref:key-concepts.deterministic-codegen" aria-label="Pattern-Based Code Generation"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <defs>
    <linearGradient id="grad-ai" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient>
    <linearGradient id="grad-ai-h" x1="0" y1="0" x2="1" y2="0"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient>
  </defs>
  <rect x="3" y="6" width="18" height="14" rx="2" stroke="url(#grad-ai)" fill="none" stroke-width="1.5"/>
  <line x1="12" y1="2" x2="12" y2="6" stroke="url(#grad-ai)" stroke-width="1.5" stroke-linecap="round"/>
  <circle cx="12" cy="2" r="1.2" fill="url(#grad-ai)"/>
  <circle cx="8.5" cy="11" r="2" stroke="url(#grad-ai)" fill="none" stroke-width="1.5"/>
  <circle cx="15.5" cy="11" r="2" stroke="url(#grad-ai)" fill="none" stroke-width="1.5"/>
  <path stroke="url(#grad-ai-h)" fill="none" stroke-width="1.1" stroke-linecap="round" d="M7 15.95 L17 16.05"/>
</svg>
      </span>
      <div class="content">
        <strong class="card-title">AI Agents</strong>
        <p class="card-text">Maximize the power of AI-driven development at scale. Intent Architect's customizable context engineering systems ensure your agents execute accurately and in full conformance with your design and architecture, out-the-box. No complex setup. Just focused AI.</p>
      </div>
      <a href="xref:key-concepts.non-deterministic-codegen" aria-label="AI-Assisted Code Generation"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <defs><linearGradient id="grad-cc" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient></defs>
  <path stroke="url(#grad-cc)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M7 8l-4 4 4 4M17 8l4 4-4 4M14 4l-4 16"/>
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Codebase Control</strong>
        <p class="card-text">Intent Architect works in an integrated way with your existing IDE, continuously realizing your design as code through a transparent review process. Developers stay in full control, with complete visibility and the freedom to customize any generated code.</p>
      </div>
      <a href="xref:key-concepts.codebase-integration" aria-label="Codebase Control"></a>
    </div>
  </li>
<!--  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <path d="M4 4m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v4a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" />
  <path d="M4 14m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v4a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" />
  <path d="M14 14m0 1a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v4a1 1 0 0 1 -1 1h-4a1 1 0 0 1 -1 -1z" />
  <path d="M14 7l6 0" />
  <path d="M17 4l0 6" />
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Extensible Platform</strong>
        <p class="card-text">Intent Architect is fully modular. Every behavior,  from code generation to design tooling, is driven by open-source modules. Build your own or extend ours to automate your proprietary patterns, endlessly customizable, entirely under your control.</p>
      </div>
      <a href="xref:key-concepts.extensible-platform" aria-label="Extensible Platform"></a>
    </div>
  </li>-->
</ul>

---

## Watch a demo of the latest features

<div class="video-16x9"><iframe src="https://www.youtube.com/embed/vlEwOM8nRXo?si=QOiR0tkncDYgKxEh&rel=0" title="Video" allowfullscreen></iframe></div>

Watch the Intent Architect version 5.0 new features demo, a focused walkthrough of what's new in perhaps the most significant release in recent years. Gareth Baars, founder of Intent Architect, walks you through the upgraded AI-powered capabilities that bring visual modeling, deterministic generation, and customizable coding agents together in one platform.

What's covered in this demo:

- AI Coding Agents in the Software Factory, automatically implementing code within the guardrails of your architecture and design.
- A full upgrade to the AI Modeling Assistant, with file attachments, conversation history, and tool-call visualization.
- The Intent Architect MCP Server, letting external AI tools drive Intent Architect directly.
- The integrated Terminal & Tasks system with automatic AI error fixing.
- A world-class Software Factory experience with a redesigned UI and per-file control.

---

## Next Steps

- Continue to **[Get Intent Architect](xref:getting-started.get-the-application)**
- Jump to **[Quick start](xref:introducing.quickstart)**
- Explore **[Tutorials](xref:tutorials.fundamentals-landing-page)**

</div>
