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

Intent Architect is the first architecture-centric code automation platform for professional .NET developers.

It’s the platform leading .NET teams use to deliver 10X faster, standardize flawlessly at scale, and maintain systems with ease – using their preferred tech stack, IDE and LLM.

It combines cutting-edge code generation systems, such as Pattern Reuse and your favorite LLM, to continuously generate clean, production-ready code driven by your architectural intention and approved design — so your code stays standardized, consistent, and easy to maintain.

![Overview](images/ia-overview.png)

---

## Getting started

<ul class="cards-grid cards-3">
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <path d="M19 18a3.5 3.5 0 0 0 0 -7h-1a5 4.5 0 0 0 -11 -2a4.6 4.4 0 0 0 -2.1 8.4" />
  <path d="M12 13l0 9" />
  <path d="M9 19l3 3l3 -3" />
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
  <path d="M4 13a8 8 0 0 1 7 7a6 6 0 0 0 3 -5a9 9 0 0 0 6 -8a3 3 0 0 0 -3 -3a9 9 0 0 0 -8 6a6 6 0 0 0 -5 3" />
  <path d="M7 14a6 6 0 0 0 -3 6a6 6 0 0 0 6 -3" />
  <path d="M15 9m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0" />
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
  <path d="M5 4m0 1a1 1 0 0 1 1 -1h2a1 1 0 0 1 1 1v14a1 1 0 0 1 -1 1h-2a1 1 0 0 1 -1 -1z" />
  <path d="M9 4m0 1a1 1 0 0 1 1 -1h2a1 1 0 0 1 1 1v14a1 1 0 0 1 -1 1h-2a1 1 0 0 1 -1 -1z" />
  <path d="M5 8h4" />
  <path d="M9 16h4" />
  <path d="M13.803 4.56l2.184 -.53c.562 -.135 1.133 .19 1.282 .732l3.695 13.418a1.02 1.02 0 0 1 -.634 1.219l-.133 .041l-2.184 .53c-.562 .135 -1.133 -.19 -1.282 -.732l-3.695 -13.418a1.02 1.02 0 0 1 .634 -1.219l.133 -.041z" />
  <path d="M14 9l4 -1" />
  <path d="M16 16l3.923 -.98" />
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

## How It Works

<ul class="cards-grid cards-2x2">
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <path d="M11.933 5h-6.933v16h13v-8" />
  <path d="M14 17h-5" />
  <path d="M9 13h5v-4h-5z" />
  <path d="M15 5v-2" />
  <path d="M18 6l2 -2" />
  <path d="M19 9h2" />
</svg>
      </span>
<!--      <span class="icon" aria-hidden="true">🧩</span>-->
      <div class="content">
        <strong class="card-title">Visual Modeling</strong>
        <p class="card-text">Design your systems visually. Intuitive designers make complex architectures easy to understand, turning models into living blueprints that help teams collaborate, validate, and evolve applications with confidence.</p>
      </div>
      <a href="xref:how-it-works.visual-modeling" aria-label="Visual Modeling"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <path d="M20 11a8.1 8.1 0 0 0 -6.986 -6.918a8.095 8.095 0 0 0 -8.019 3.918" />
  <path d="M4 13a8.1 8.1 0 0 0 15 3" />
  <path d="M19 16m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0" />
  <path d="M5 8m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0" />
  <path d="M12 12m-3 0a3 3 0 1 0 6 0a3 3 0 1 0 -6 0" />
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Pattern-Based Code Generation</strong>
        <p class="card-text">Pattern-based code generation automates the predictable parts of your system, up to 85% of your codebase. Each pattern applies proven practices, ensuring code is clean, consistent, and production-ready.</p>
      </div>
      <a href="xref:how-it-works.deterministic-codegen" aria-label="Pattern-Based Code Generation"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <path d="M6 4m0 2a2 2 0 0 1 2 -2h8a2 2 0 0 1 2 2v4a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2 -2z" />
  <path d="M12 2v2" />
  <path d="M9 12v9" />
  <path d="M15 12v9" />
  <path d="M5 16l4 -2" />
  <path d="M15 14l4 2" />
  <path d="M9 18h6" />
  <path d="M10 8v.01" />
  <path d="M14 8v.01" />
</svg>
      </span>
      <div class="content">
        <strong class="card-title">AI-Assisted Code Generation</strong>
        <p class="card-text">Intent Architect includes AI accelerators that automate parts of development which can't be predefined. Performing all the necessary context engineering automatically, Intent Architect integrates with LLMs providing a prompt-less, predictable AI experience.</p>
      </div>
      <a href="xref:how-it-works.non-deterministic-codegen" aria-label="AI-Assisted Code Generation"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <path d="M12.5 16h-8.5a1 1 0 0 1 -1 -1v-10a1 1 0 0 1 1 -1h16a1 1 0 0 1 1 1v8" />
  <path d="M7 20h4" />
  <path d="M9 16v4" />
  <path d="M20 21l2 -2l-2 -2" />
  <path d="M17 17l-2 2l2 2" />
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Codebase Integration</strong>
        <p class="card-text">Intent Architect works side-by-side with your existing IDE, continuously integrating your design into your codebase, via a review process. Advanced Code Integration systems keep developers in control of the code, with full transparency. </p>
      </div>
      <a href="xref:how-it-works.codebase-integration" aria-label="Codebase Integration"></a>
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
      <a href="xref:how-it-works.extensible-platform" aria-label="Extensible Platform"></a>
    </div>
  </li>-->
</ul>

---

## Watch a demo

<div class="video-16x9"><iframe src="https://intentarchitect.com/#/redirect/?category=docs-embedded&subCategory=intro-and-demo" title="Video" allowfullscreen></iframe></div>

If you're new to Intent Architect, the best way to understand the platform is to watch a demo. Watch this recent webinar where Gareth Baars — founder of Intent Architect — walks you through how to build enterprise-grade C# / .NET applications in a fraction of the time with Intent Architect.

What's covered in this demo:

- What is "Pattern Reuse" actually?
- A comprehensive introduction & demo of the platform, Intent Architect
- Building a working, high-quality .NET application in minutes following a Clean Architecture
- A sneak peek at how Intent Architect can leverage generative-AI to push productivity even further.

---

## Next Steps

- Continue to **[Get Intent Architect](xref:getting-started.get-the-application)**
- Jump to **[Quick start](xref:introducing.quickstart)**
- Explore **[Tutorials](xref:tutorials.fundamentals-landing-page)**

</div>
