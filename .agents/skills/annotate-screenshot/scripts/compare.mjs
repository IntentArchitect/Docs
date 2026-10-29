#!/usr/bin/env node
// Write a before/after HTML page so the user can review annotated screenshot samples side by side.
// Zero dependencies (Node >= 18); image paths become file:// URLs, so it works on every OS.
//
//   node compare.mjs <out.html> [--title "Page title"] --pair <before.png> <after.png> [--note "What changed"] ...
//
// Repeat --pair (with an optional --note after it) once per screenshot.

import { writeFileSync, existsSync } from "node:fs";
import { resolve } from "node:path";
import { pathToFileURL } from "node:url";

const esc = (s) => String(s).replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" })[c]);
const fail = (msg) => { console.error(`compare: ${msg}`); process.exit(1); };

const args = process.argv.slice(2);
if (!args[0] || args[0].startsWith("--")) fail('usage: node compare.mjs <out.html> [--title "..."] --pair <before.png> <after.png> [--note "..."] ...');
const out = args[0];
let title = "Screenshot samples";
const pairs = [];
for (let i = 1; i < args.length; i++) {
  const a = args[i];
  if (a === "--title") title = args[++i];
  else if (a === "--pair") {
    const before = args[++i], after = args[++i];
    if (!before || !after) fail("--pair needs a before and an after path.");
    for (const p of [before, after]) if (!existsSync(p)) fail(`file not found: ${p}`);
    pairs.push({ before, after, note: "" });
  } else if (a === "--note") {
    if (!pairs.length) fail("--note must follow a --pair.");
    pairs[pairs.length - 1].note = args[++i] ?? "";
  } else fail(`unknown option ${a}`);
}
if (!pairs.length) fail("add at least one --pair.");

const name = (p) => p.split(/[\\/]/).pop().replace(/\.png$/i, "");
const img = (p) => pathToFileURL(resolve(p)).href;
const today = new Date().toISOString().slice(0, 10);

const sections = pairs.map((p, i) => `
<h2>${i + 1}. ${esc(name(p.before))}</h2>
${p.note ? `<p>${esc(p.note)}</p>` : ""}
<div class="row">
<figure><figcaption>Before</figcaption><img src="${img(p.before)}"></figure>
<figure><figcaption>After (sample)</figcaption><img src="${img(p.after)}"></figure>
</div>`).join("\n");

writeFileSync(out, `<!doctype html>
<html><head><meta charset="utf-8"><title>${esc(title)}</title>
<style>
 body{font-family:Segoe UI,system-ui,sans-serif;background:#111;color:#ddd;margin:24px;max-width:1500px}
 h1{margin:0 0 4px} .created{color:#888;margin-bottom:24px}
 h2{margin-top:40px;border-top:1px solid #333;padding-top:16px}
 .row{display:grid;grid-template-columns:1fr 1fr;gap:16px} figure{margin:0}
 figcaption{color:#06C4FF;font-weight:600;margin-bottom:6px} img{width:100%;border:1px solid #333}
 p{max-width:900px}
</style></head><body>
<h1>${esc(title)}</h1>
<div class="created">Created ${today}</div>
${sections}
</body></html>
`);
console.log(`Wrote ${out} (${pairs.length} pair${pairs.length === 1 ? "" : "s"})`);
