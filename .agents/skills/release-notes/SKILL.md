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

## Writing style

Match the most recent version sections in the file — the style has evolved, so mirror what's currently there rather than older sections.

- **Plain text, no bold.** Recent sections do not bold the lead phrase. (Older 5.1.0/5.1.1 sections use `**bold**` leads and long prose — do not copy that; follow the newest sections.)
- **One line per bullet**, concise and user-facing. Lead with the value/behavior, not the implementation.
- **Backticks** for tool names, API methods, file names and code: `run_designer_script`, `.mcp.json`, `get_status`, `getBasicMapping()`.
- **"Fixed:" bullets describe the problem** that existed (what the user experienced), in past tense — e.g. "Fixed: Using Ctrl + T … wouldn't work from inside the AI Chat pane."
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

**Consolidate:** when several commits form one theme (e.g. multiple ACP-context or `.mcp.json`-configuration commits), write one bullet per distinct user-facing outcome rather than one per commit.

When in doubt about a borderline commit, lean toward **skipping** but list it in your final summary so the user can decide.

## Quality checklist

Before finishing:

- Both tags verified to exist (after a fetch).
- New section placed newest-first, heading uses the plain patch version (no `-pre`).
- Improvements and Fixes subsections present (non-empty ones only), correct prefixes.
- Bullets are plain-text, one line, backticked where appropriate, and read as user-facing.
- Internal/vague commits excluded — and reported to the user with reasons.
- Re-read the file top before editing to respect any hand-edits.
