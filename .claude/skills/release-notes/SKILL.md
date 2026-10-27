---
name: release-notes
description: "Use when adding or updating Intent Architect client release notes from source control — generating Improvements/Fixes bullets for a version by diffing two publish/client/* git tags in the client repo and writing them into src/release-notes/intent-architect-vX.Y.md."
---

# Release Notes Skill

Use this skill to add or update the Intent Architect **client** release notes under `src/release-notes/`, generated from the client product's git history between two `publish/client/*` tags.

## Scope

This skill is for:

- Adding a new version section to an existing `intent-architect-vX.Y.md` file from git changes between two client tags.
- Extending an in-progress (not-yet-final) version section with a newer pre-release's changes.
- Categorizing commits into Improvements vs Fixes and writing them in the house style.

This skill is **not** for:

- Monthly "What's New" articles (see the `whats-new-article` skill).
- Deep validation of feature claims beyond what commit messages state.

## Where the client repo lives

The release-notes content lives in this docs repo, but the **changes come from the Intent Architect client product repo**, which is a separate checkout. It is **not** under `d:\Dev` by the obvious name and has no `gh` CLI available.

- Default location: `D:\Dev\Intent\main`
- Confirm before use: `git -C <path> rev-parse --is-inside-work-tree`
- If it's not there, ask the user for the client repo path. Do not assume any repo under `d:\Dev\Intent.*`.

## Procedure

1. **Identify the two refs.** The user gives a "from" and "to" tag, e.g. `publish/client/5.1.2` → `publish/client/5.1.3-pre.0`. The range is *exclusive of "from", inclusive of "to"* (`from..to`).

2. **Fetch and verify both tags exist** in the client repo:

   ```bash
   git -C D:/Dev/Intent/main fetch --tags --quiet
   git -C D:/Dev/Intent/main log -1 --format='%H %ci' publish/client/<from>
   git -C D:/Dev/Intent/main log -1 --format='%H %ci' publish/client/<to>
   ```

   Fetching matters — local tags are often stale and won't include recent pre-releases.

3. **Read the full commit messages** (subjects *and* bodies — bodies carry the detail that makes a good bullet):

   ```bash
   git -C D:/Dev/Intent/main log --format='===%n%h%n%s%n%b' publish/client/<from>..publish/client/<to>
   ```

4. **Categorize** each commit (see rules below): Improvement, Fix, or skip.

5. **Edit** the matching `src/release-notes/intent-architect-vX.Y.md` file:
   - Re-read the top of the file first — it is frequently hand-edited between sessions (wording tightened, bullets dropped, sections renamed).
   - Add the new version section, or merge into an existing in-progress section (see "Section naming").

6. **Report** what you added and, explicitly, **which commits you skipped and why**, so the user can pull any back in.

## Section naming and placement

- One `intent-architect-vX.Y.md` file per **minor** version (e.g. `v5.1`), covering all its patch releases.
- Section heading is the **patch version with no `-pre` suffix**: `## Version 5.1.3` — *not* `## Version 5.1.3-pre.0`.
- **Accumulate pre-releases under one patch heading.** When later `X.Y.Z-pre.N` builds arrive before the final `X.Y.Z` release, merge their changes into the existing `## Version X.Y.Z` section rather than creating a new `-pre` section.
- **Newest version on top.** Insert the new section directly below the H1 (`# Release notes: ...`) and above the previously-latest `## Version` section.

## Required structure

```md
## Version 5.1.3

## Improvements in 5.1.3

- Improvement: <one-line, user-facing description>.
- Improvement: <...>.

## Fixes in 5.1.3

- Fixed: <one-line description of the problem that was resolved>.
- Fixed: <...>.
```

- Every improvement bullet starts with `Improvement: `; every fix bullet starts with `Fixed: `.
- If a version has no fixes (or no improvements), omit that empty subsection.

## New minor versions: the "new features" section

A new minor version's first release (`X.Y.0`) is not just Improvements and Fixes. Look at the older minor release notes (e.g. `intent-architect-v5.2.md`, `intent-architect-v5.3.md`, `## Version 5.3.0`) for the shape: an intro, then one `###` section per headline feature (a short description, screenshots where available), and only then the `### Improvements in X.Y.0` and `### Fixes in X.Y.0` lists.

When starting or extending an `X.Y.0` section, **always** work out which changes deserve to be promoted from Improvements bullets into headline "new features" sections:

1. Draft the Improvements/Fixes lists as normal.
2. Pick candidates: themes made of several related commits, brand-new surfaces (new tabs, panels, windows, tools), and anything a user would describe as "a new thing" rather than "a better thing".
3. **Use the `AskUserQuestion` tool to confirm** which candidates become new-features sections (multi-select, with a one-line description of each). Don't decide this alone, and don't skip the question because the list looks obvious. Re-ask only for candidates that appear in later pre-releases, not ones already decided.
4. **Confirm each feature's rationale with the user before writing it.** Each section should explain the reason the feature was added and the user problem it solves, without using the word "why". Commit messages rarely state this, so draft 2–3 candidate rationales per feature and use `AskUserQuestion` (up to 4 features per call) to let the user pick or rewrite one. Don't write a feature section until its rationale is confirmed. If the user says a feature is self-explanatory, leave the rationale out of that section.
5. For each confirmed feature, write a `###` section in the older style (a heading, the confirmed rationale stated plainly in a sentence or two, then a short description of what it does and how to use it, `![...](images/...)` placeholders if the user has screenshots to add), and remove its now-duplicated bullets from the Improvements list.
6. Don't invent the intro/summary prose or release date if the release isn't final: leave a short placeholder or ask the user.

Patch releases (`X.Y.Z` where `Z > 0`) don't get this treatment; they only use Improvements and Fixes (plus the occasional `### Highlights in X.Y.Z` the user asks for).

## Screenshots

Feature sections get screenshots saved to `src/release-notes/images/X.Y.x/<feature-name>.png` and referenced as `![...](images/X.Y.x/<feature-name>.png)`. Capture them from the running dev app using the `drive-intent-with-playwright` skill.

- **Use the demo solution** `../Sample.Demo.eShop/intent/Demo.isln` (relative to the parent folder of this docs repo) so the screenshots show realistic content.
- **Shell screenshots must include tab content.** The shell hosts designers, documents and other tab content in separate webviews, and a plain per-page capture (`browser_take_screenshot` on the shell page) shows those areas black. For any screenshot of the shell, use the composited capture (`captureAppScreenshot()` via `withIaMain`, in a spec) so webview content is included, and check the image shows the tab content before keeping it.
- **Maximise the app window** and bring it to the front before capturing (an OS-level capture of the window rectangle returns whatever window is on top, so check the image is the dev instance), so screenshots have the full-screen proportions of the existing ones.
- **Crop to the feature when the whole window makes it hard to see.** If the feature is one panel, tab, popup or list, crop to just that part of the UI (for example the document pane, the Solution Explorer tree or the AI chat pane) instead of the full window. Keep the full window only when the layout is the feature.
- **No blank panes.** Webview panes (the AI Assistant pane, designers) can capture empty. Re-capture, or crop them out, so no screenshot contains a blank pane. Check every image before keeping it.
- **Whole-window screenshots must not include the Windows title bar.** Capture the client area only, or crop the title bar (about 23px at 1920 wide) off.
- Match the existing screenshots (dark theme).
- When reviewing existing screenshots, apply all of the above to them too and re-crop or re-capture the ones that fail.

## Writing style

Match the most recent version sections in the file — the style has evolved, so mirror what's currently there rather than older sections.

- **Matter-of-fact prose.** Feature sections do give the rationale (the user problem the feature solves), but state it plainly as a fact rather than as a dramatic setup. Don't use a punchy narrative hook ("X used to mean Y", "No more Z"), marketing or conversational phrasing ("closes the loop", "as you'd expect", "rather than just claiming they work"), or the word "why".
  - Bad: "Searching a solution used to mean leaving Intent Architect for your editor. Find and Replace in Files now searches…"
  - Good: "It's now possible to search and replace across every file in a solution. In the Agents window, `Ctrl + Shift + F` opens the Search panel…"
- **Keep feature sections short.** Open with the rationale, then the headline capability and how to reach it, in one or two short paragraphs. Leave out secondary details (settings, defaults, menu items, tool names, edge cases); they can go in the Improvements list if they matter.
- **Natural but impersonal.** Write the way a person would describe the release, not like a list of spec facts, but don't address the reader directly. Prefer "It's now possible to…" or "X now does…" over "You can now…", and "a solution" over "your solution". Start with what the feature makes possible and how to get to it, and keep sentences short.
- **Lead the rationale with the capability, not a "used to" setup.** Don't open with "X meant doing Y", "Y was hard", or "A did not…" before the feature appears; it reads as AI-generated. State the capability first and fold the reason in as a purpose, e.g. "To catch up on an application after time away, a new Application Overview tab shows…" or "A pull request's assignees can now be set from Intent Architect… without going to the git host's website."
  - Bad: "Setting assignees or labels meant switching to the git host's website. These can now be done from a pull request."
  - Good: "A pull request's assignees, reviewers and labels can now be set from Intent Architect, without going to the git host's website."
- **Plain text, no bold.** Recent sections do not bold the lead phrase. (Older 5.1.0/5.1.1 sections use `**bold**` leads and long prose — do not copy that; follow the newest sections.)
- **One line per bullet**, concise and user-facing. Lead with the value/behavior, not the implementation.
- **Backticks** for tool names, API methods, file names and code: `run_designer_script`, `.mcp.json`, `get_status`, `getBasicMapping()`.
- **"Fixed:" bullets describe the problem** that existed (what the user experienced), in past tense — e.g. "Fixed: Using Ctrl + T … wouldn't work from inside the AI Chat pane."
- **No root causes or implementation reasons.** Commit bodies love "...because X", "...due to Y", "...since the code did Z instead of W" — that's for the commit, not the release note. State the observable symptom and, where it helps a reader recognize the situation, the relevant repro conditions (when it happened, what triggered it) — never the internal mechanism that caused it.
  - Bad: "Fixed: The panel showed stale data for 2 seconds after a git operation, because most handlers never invalidated the status cache."
  - Good: "Fixed: The panel could show stale data for up to two seconds after most git operations."
  - Bad: "Fixed: A turn could be reported as completed early due to the heartbeat watchdog sealing it prematurely while the LLM client was still awaiting a cancellation token it didn't recognize."
  - Good: "Fixed: An AI turn could be reported as "Completed" while it was still actually running."
  - Repro conditions are fine to keep when they're user-observable, not internal: "...when focus was inside a diff editor" or "...when both a home-screen instance and a solution-open instance were running" describe *when a user would see it*, not *why the code did it*.
- Keep product, tool and module names accurate. Preserve existing capitalization (e.g. "Software Factory", "Solution Explorer", "ACP", "MCP").
- Rewrite raw commit subjects into reader-facing prose. Don't paste a commit subject verbatim if it reads like a developer note.

## Categorization rules

**Include (user-facing):**

- Anything a user, module author, or connected AI agent would notice: UI changes, new/changed MCP or ACP tools, scripting/macro API changes (even backward-compatible renames), new features, model-catalog changes, diagnostics that aid support.
- Commits already prefixed `Improvement:` or `Fixed:` — these are authored to be release-note-ready; trust the category but still tighten the wording.

**Skip (internal / not user-facing):**

- Pure refactors and code moves ("Move tool names into referencing assembly", "Update class name to align with tool name").
- Build/compile fixes with no runtime effect ("AttachmentMaterializer did not compile").
- Dev-mode-only or worktree-only changes ("Log to local … folder when in dev", "show current repository in dev mode").
- Internal AI **prompt/steering** tweaks that don't change a user-visible capability ("Further steering around creating new applications", "Update GetFullInstructions …").
- Vague or cosmetic one-liners with no discernible user impact ("Fix this.", "Fix this colour.", "Apply outstanding changes.", "Small tweak to display", "More apt emoji for branch").
- ILMerge/assembly-isolation and other packaging plumbing.
- **Fixes for bugs introduced by a feature added in the same tag range.** If a "Fixed:" commit resolves a regression in code that a different commit *within this same `from..to` range* introduced (check the feature commit's message/diff, not just chronological order — a fix can land before or after the feature commit in `git log`, and squashed/rebased history can reorder them), no shipped version ever had the bug, so it isn't user-facing. Don't add a separate Fixed bullet for it. Fold the fix silently into the feature's Improvement description only if it materially changes what to say the feature does; otherwise just drop it. Still report it in your skip summary, with the feature commit it belongs to.
  - Example: a commit adds a new sticky tree-view header, and a later commit in the same range fixes that header's right-click handling — skip the fix, keep only the Improvement bullet for the header.
  - Contrast with a fix that touches code from a *previous* release (i.e. code not introduced within this range) — that's a real user-facing Fixed bullet even if it happens to land in a commit next to a new feature.

- **Fixes for features or improvements that didn't exist before this minor version.** A fix is only user-facing if a shipped version had the bug. In a new minor version (`X.Y.0`), check whether the affected feature (a headline section or an Improvement bullet) is itself new in `X.Y`; if so, no earlier release had the bug, so drop the Fixed bullet and report it in the skip summary. Check this against the feature's introduction in git history or the previous minor's release notes, not just the same tag range.

**Fold improvements to featured items into the feature section.** An improvement to something that is a headline feature of this version (or was added in this version) is not a separate Improvements bullet. Work it into that feature's `###` section (a clause or short sentence) or leave it out. Only improvements to things that existed in a previous release get an `Improvement:` bullet. Check each candidate Improvement against the list of this version's features before adding it.

**Consolidate:** when several commits form one theme (e.g. multiple ACP-context or `.mcp.json`-configuration commits), write one bullet per distinct user-facing outcome rather than one per commit.

When in doubt about a borderline commit, lean toward **skipping** but list it in your final summary so the user can decide.

## Quality checklist

Before finishing:

- Both tags verified to exist (after a fetch).
- New section placed newest-first, heading uses the plain patch version (no `-pre`).
- Improvements and Fixes subsections present (non-empty ones only), correct prefixes.
- Bullets are plain-text, one line, backticked where appropriate, and read as user-facing.
- No bullet explains *why* the bug happened (no "because...", "due to...", "since the code...") — only the symptom and, if useful, the user-observable conditions that triggered it.
- No Improvement bullet for a featured item (folded into its section instead), and no Fixed bullet for a feature that is new in this minor version.
- Internal/vague commits excluded — and reported to the user with reasons.
- Re-read the file top before editing to respect any hand-edits.
