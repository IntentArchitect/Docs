---
uid: index
description: "Introduction to Intent Architect — the control plane for agentic .NET development — with links to getting started, key concepts, and a demo of the latest features."
---

<script>
  if (!window.location.pathname.endsWith('.html')) {
    var p = window.location.pathname.replace(/\/?$/, '/');
    history.replaceState(null, '', p + 'index.html' + window.location.search + window.location.hash);
  }
</script>

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
/* Equal-height cards: each row's cards match the tallest in that row */
.ia-overview .cards-grid > li { display: flex; }
.ia-overview .cards-grid > li > .card { width: 100%; height: 100%; }

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

Intent Architect is the first control plane for agentic .NET software development.

It's the platform .NET teams use to turn AI into a well-governed, repeatable, and enterprise-scale delivery system, using their preferred service providers and coding harnesses.

It brings reliable architectural guardrails, authoritative design blueprints, and advanced governance tools to agentic development – giving teams the control they need to scale AI-driven velocity, without compromising on quality and accountability.

![Overview](introducing/images/docs-landing-page-v1.png)

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
  <defs><linearGradient id="grad-mod" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient></defs>
  <rect x="8.4" y="2.4" width="7.2" height="7.2" rx="1.3" stroke="url(#grad-mod)" fill="none" stroke-width="1.5"/>
  <rect x="2.4" y="12.6" width="7.2" height="7.2" rx="1.3" stroke="url(#grad-mod)" fill="none" stroke-width="1.5"/>
  <rect x="14.4" y="12.6" width="7.2" height="7.2" rx="1.3" stroke="url(#grad-mod)" fill="none" stroke-width="1.5"/>
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Reliable Architectural Guardrails</strong>
        <p class="card-text">Safeguard codebase quality and maintainability. Intent Architect's advanced guardrail system combines both deterministic and probabilistic enforcement to ensure architectural adherence without adding to the validation burden, and scales across teams without developers having to internalize their standards and context files to validate agentic adherence.</p>
      </div>
      <a href="xref:key-concepts.deterministic-codegen" aria-label="Reliable Architectural Guardrails"></a>
    </div>
  </li>
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
        <strong class="card-title">Authoritative Design Blueprints</strong>
        <p class="card-text">Stay on top of your system's design and minimize technical and cognitive debt. Living blueprints give you an always-accurate visualisation of your design, making architectural decisions explicit and visible to the whole team. And provide an intuitive way to consistently confirm whether agents are meeting your specifications and making good design decisions.</p>
      </div>
      <a href="xref:key-concepts.visual-modeling" aria-label="Authoritative Design Blueprints"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <defs><linearGradient id="grad-rev" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient></defs>
  <path stroke="url(#grad-rev)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M20.5 12a8.5 8.5 0 0 1-14.2 6.3M3.5 12a8.5 8.5 0 0 1 14.2-6.3"/>
  <path stroke="url(#grad-rev)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M17.7 2.5v3.2h-3.2M6.3 21.5v-3.2h3.2"/>
  <path stroke="url(#grad-rev)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M8.8 12.2l2.2 2.2 4.2-4.6"/>
</svg>
      </span>
      <div class="content">
        <strong class="card-title">Advanced Validation Tools</strong>
        <p class="card-text">Streamline validation and alleviate delivery bottlenecks. Denoise the review process and focus on the things that matter most, e.g., design shifts, architectural shifts and high-risk changes. Teams aren't overwhelmed by large PRs, don't just rubberstamp code, and never push significant risk downstream.</p>
      </div>
      <a href="xref:key-concepts.codebase-integration" aria-label="Advanced Validation Tools"></a>
    </div>
  </li>
  <li>
    <div class="card">
      <span class="icon" aria-hidden="true">
<svg class="landing-svg" viewBox="0 0 24 24">
  <defs><linearGradient id="grad-sdd" x1="0" y1="0" x2="0" y2="1"><stop offset="0%" stop-color="#09C4FF"/><stop offset="100%" stop-color="#0070C0"/></linearGradient></defs>
  <path stroke="url(#grad-sdd)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M12 2l9 4.5-9 4.5-9-4.5 9-4.5z"/>
  <path stroke="url(#grad-sdd)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M3 11l9 4.5 9-4.5"/>
  <path stroke="url(#grad-sdd)" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" d="M3 16l9 4.5 9-4.5"/>
</svg>
      </span>
      <div class="content">
        <strong class="card-title">SDD with Traceability</strong>
        <p class="card-text">Go from requirements to production-ready code, step by step, with full traceability. Drive agentic development with high-quality specifications that are easier to comprehend and traceability features that answer the why – exactly which requirements drove which code, and vice versa. So you stay in control from requirements through to code.</p>
      </div>
      <a href="xref:key-concepts.non-deterministic-codegen" aria-label="SDD with Traceability"></a>
    </div>
  </li>
</ul>

---

## Watch a demo of the latest features

<div style="position: relative; width: 100%; aspect-ratio: 16 / 9;">
  <iframe style="width: 100%; height: 100%; border: 0" src="https://www.youtube.com/embed/bGofnbPQV8k?si=EAVqpiut4fVwkf_L" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
</div>

Watch the Intent Architect version 5.2 new-features demo.

Gareth Baars, founder and CEO of Intent Architect, shares some of the recent enhancements around validating, trusting, and managing changes in an agentic development workflow, and expands on how Intent Architect gives teams enhanced control in this evolving landscape.

What's covered in this demo:
- New traceability features for reviewing commits, giving teams visibility and clarity even as codebases become increasingly "black-boxed".
- Enhanced change-review features to better support agentic development, making it easy to prioritize and optimize code-review processes.
- Specification change tracking, surfacing exactly how your authoritative design specifications evolve over time.
- A simplified, unified UI that brings your model, your code, and your repository together in a single, streamlined workspace.
- A new Git Source Control panel and Changes Review tab, so you can see and review everything flowing through your solution without tabbing out.
- The new Specifications panel and Spec-Driven Development (SDD) system (Beta), turning design specifications into a control plane for fully agentic software development.

---

## Next Steps

- Continue to **[Get Intent Architect](xref:getting-started.get-the-application)**
- Jump to **[Quick start](xref:introducing.quickstart)**
- Explore **[Tutorials](xref:tutorials.fundamentals-landing-page)**

</div>
