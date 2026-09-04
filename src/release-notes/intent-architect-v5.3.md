---
uid: release-notes.intent-architect-v5.3
description: "Intent Architect 5.3 release notes: on-device voice input for the AI chat; deviation classification and severity flags in Changes Review; AI-driven pull request review with inline comments and Azure DevOps support; Spec-Driven Development interoperability with BMAD, Spec Kit, Kiro and OpenSpec; a unified document viewer with MDX diagram blocks; and Codebase Explorer drag-and-drop."
---
# Release notes: Intent Architect version 5.3

## Version 5.3.0

> [!NOTE] These release notes are mostly AI generated and still need additional human review and updates prior to the final release.

5.3's two biggest changes are both about visibility: making sure the *model-aware* view of a change - the one Intent Architect can uniquely give you - stays in front of you at exactly the two moments an AI-native workflow depends on it most: reviewing a pull request, and reading a plan before it's built.

**Pull requests, reviewed with the model in view.** Once a change left Intent Architect as a pull request, reviewing it meant falling back to GitHub's or Azure DevOps's own web diff - raw XML and generated code, with none of Changes Review's model visuals, deviation classifications or severity flags. For a change an AI agent produced, that context is exactly what tells a reviewer what actually matters versus what's routine generated output - and it disappeared the moment the review left Intent Architect, pushing teams back toward reviewing code they couldn't fully judge. Pull requests can now be reviewed, discussed, and merged - including an AI review that posts real, validated findings as comments - directly inside Intent Architect, so that same model-aware review carries all the way through to the thing that actually gets merged, on both GitHub and Azure DevOps.

**MDX support, so a plan shows rather than tells.** An AI agent's plan for a change used to be prose, or at best a single generic diagram block - you read a description and found out whether the implementation matched it after the fact. Plans and specs can now carry purpose-built visual blocks - a real data model, an API surface, a wireframe, a model-change diagram - authored directly by the agent as part of the plan, giving you a way to see the actual shape of what's about to be built that reading text never could.

Alongside those two, this release also tightens up Spec-Driven Development's traceability (link-checking that no longer takes an agent's own word for it) and adds a one-click way to connect any supported AI agent to Intent Architect's MCP server - both covered below, along with the usual list of smaller fixes and improvements.

> [!TIP]
>
> Ready to get started? **Head to [our website](https://intentarchitect.com) and login to download it**.

---

## Pull requests, without leaving Intent Architect

Neither Git source control (5.1) nor Changes Review (5.2) covered what happens once a change becomes a pull request - that step still meant switching to a browser. 5.3 extends the same review experience out to the pull request itself, across both GitHub and Azure DevOps.

<!-- image: The Pull Requests list in the Git tab, showing state glyphs and host branding -->

### AI review, posted to the pull request itself

An AI review can now be run directly on a pull request. It reuses the same review engine as Changes Review, over the pull request's actual merge-base...head range, and posts confirmed findings back to the host as one inline comment per finding plus a summary. Findings are validated before they're posted rather than posted raw, and a re-run skips anything already flagged, including on threads that have since been resolved - repeated reviews turning into a pile of duplicate comments is the reason this kind of feature usually gets turned off, so avoiding that was a deliberate constraint, not an afterthought. AI can also draft the pull request's title and description, in a short "simple" style or a longer, diagram-capable "rich" one; descriptions and comments are written and previewed through the same document viewer covered below.

<!-- image: AI review posting inline findings on a pull request, with the summary verdict -->

### Conflicts and keeping branches in sync

Pull request conflicts can now be resolved in an isolated, throwaway worktree instead of your own checkout, with resolved files reflected live in Changes Review as they're written. An "Update branch" action on the pull request merges or rebases in the base branch first when that's needed, switching between "Update branch from `<base>`" and "Resolve conflicts" depending on which state it's actually in. Inline comment threads can now also be anchored to a file line or a model element directly inside Changes Review, with reply, resolve and nested-thread rollups.

<!-- image: Resolving pull request conflicts in an isolated worktree -->

### Finding your way around pull requests

The Pull Requests list now refreshes automatically when a pull request is created, merged or closed, rather than only on first load; each row leads with a state glyph (open/merged/closed/draft) and its title, with view options moved into a trailing menu. A "New pull request" button opens the create-PR page for the current repository and branch, repositories nested inside a folder or workspace are now discovered rather than only ones containing it, and "follow" tracks the active tab rather than the active application. A merged pull request with no resulting code difference shows a notice instead of an empty review, review verdicts with no comment text no longer show as empty entries, and switching between pull requests and refs is faster due to caching of recently viewed panes.

---

## Spec-Driven Development: traceability you can trust

Spec-Driven Development links requirements to the model elements and files that implement them. Until this release, that link was largely self-reported: `record_spec_traceability` accepted whatever operation (created/updated/deleted) the agent claimed to have performed, and a task could be marked complete even when its recorded link pointed at a file that didn't actually exist at that path.

Traceability links are now checked against git-classified file operations and canonicalized file paths, using the same classification logic Changes Review itself uses. Recording a link now fails outright - rather than being "recorded but broken" - when its target doesn't resolve, and completing a spec task is blocked while it still has unresolved or empty links. A new deterministic Changes Review report (the `get_change_review` MCP tool) gives an agent the same git-verified summary of what changed, including per-element and parent/child rollups, that a human reviewer sees in the UI - so verification runs against the same facts, rather than the agent's own account of its work.

Spec-Driven Development can now also detect, import and stay in sync with specs authored in other frameworks - BMAD (including multi-file PRDs), Spec Kit, Kiro and OpenSpec - and offers an "Un-adopt" option to hand ownership back to the original framework without deleting its documents. Separately, the Specs panel's requirement-traceability display is now a single fixed-width "linked requirements" chip with a popover, instead of a row of chips that could crowd out an element's own pill; reopening a solution re-reads spec document bodies from disk so live checklists reflect changes made outside Intent Architect, and clicking a spec's busy status pill now opens its live AI conversation.

---

## MDX support: plans and specs that can show, not just tell

Plans, specs and pull request descriptions previously rendered as plain Markdown, with a single `<ModelDiagram>` block standing in for any kind of visual content, regardless of what it was actually meant to show. It's been replaced with purpose-built MDX blocks - DataModel, ApiEndpoint, Wireframe, Canvas and ModelChanges - alongside the existing Mermaid diagrams, so an agent writing a plan can show a concrete data model or API surface directly instead of describing one in prose.

<!-- image: A DataModel block rendered inline in a plan document -->

The document viewer itself, now shared by plans, specs and pull request content, also gained split and word-level diffs, adjustable zoom, image rendering, blockquotes styled as info callouts, and an inline error message when a Mermaid diagram fails to parse instead of a silent blank. Any Mermaid, Wireframe, Canvas or Diagram block can be maximized into a full-pane, pan-and-zoom overlay at its own true size, independent of the document's font zoom - zooming the surrounding text doesn't make a dense diagram any more legible, so the diagram now scales on its own.

<!-- image: A maximized diagram in the document viewer's pan-and-zoom overlay -->

---

## One-click setup for your AI agent of choice

Connecting an AI agent to Intent Architect's MCP server used to mean a single, generic prompt about a missing or misconfigured `.mcp.json` file - the same message regardless of which agent you were using, with no way to tell what was actually connected. The Intent MCP tab in AI Configuration replaces that with one row per supported agent (Claude Code, Codex, GitHub Copilot CLI, Cursor, Kiro, OpenCode), grouped by whether it's detected on your machine, each with a live Repo/User connection status and a one-click Connect (or Connect all). Preferences for dismissed notifications now persist through the shell, so the dialog won't keep reopening about an agent you've already told it to leave alone.

<!-- image: The Intent MCP tab listing per-agent connection rows -->

---

## Improvements in 5.3.0

- Improvement: The AI chat composer now supports on-device streaming voice input - press the mic button or `Ctrl + I` (`Cmd + I` on macOS) to dictate, with live interim transcription and automatic punctuation/casing restoration; recording stops automatically when you send.
- Improvement: Deviations and custom files can now be tagged with one or more colour-coded File Classification elements (module-defined, auto-created on module install), plus a severity flag (low/medium/high, shown yellow/orange/red) on the Changes Review screen.
- Improvement: Approving or revoking a deviation in Changes Review is now a single toggle glyph (grey when pending, solid green when approved) instead of a separate status pill plus hover-revealed buttons.
- Improvement: Hovering a change pill in Changes Review now shows a popover with the field-level before/after values for the element or association, without leaving the tab.
- Improvement: Renamed files in Changes Review now show their previous path in a tooltip, and diffs carry the pre-rename path.
- Improvement: Changes Review pills for individual model elements (not just whole files) can now be dragged into the AI chat as attachments, carrying their content directly.
- Improvement: The Codebase Explorer now supports dragging files and folders - both moving/copying within the tree and dropping in files from the OS file explorer - with move/copy cursors and Ctrl/Meta modifier support.
- Improvement: You can now drop a file from outside Intent Architect anywhere onto the app window to open it, or attach it to the AI chat.
- Improvement: The diff view now detects when a change is only a line-ending (CRLF/LF) or BOM difference and labels it "only line endings changed" instead of showing a full rewrite.
- Improvement: Pushing or pulling a branch that has diverged from its upstream now shows a diagnostic strip explaining why, with a one-click remedial action (e.g. fetch & rebase).
- Improvement: "Resolve with AI" on a merge/rebase conflict bar now has a caret to prepare the conflict-resolution conversation - prompt composed, files attached - without sending it; conflict resolution also now remembers its own last-used AI model, separately from your regular chat model.
- Improvement: Multiple `create_sub_agent` calls can now run concurrently instead of one at a time, and Claude Code's own native sub-agent dispatch (Agent/Task) is now permitted to run in parallel too.
- Improvement: AI agents now have a shell tool to run ad-hoc bash/PowerShell commands, with output streamed to a terminal and persisted, and the ability to background or kill a running command.
- Improvement: AI code-search tools can now browse the whole workspace unfiltered (newest files first) alongside the existing gitignore-aware search, and report how many files/folders were skipped by ignore rules.
- Improvement: Manually triggering `/compact` mid-turn now queues the compaction to run once the turn finishes, instead of being sent as literal chat input.
- Improvement: `Shift + Tab` now only toggles Plan mode before a conversation has started, rather than at any point.
- Improvement: A reopened AI conversation now resumes with the same agent persona it was using before.
- Improvement: Intent Architect now prevents the system from sleeping while an AI conversation is actively running.
- Improvement: AI agents are now blocked from writing to Intent's own protected files (`.intent`, `Intent.Metadata`, `.application.config`) and are warned before hand-patching a spec/plan sidecar file instead of using the write tools.
- Improvement: The "Implement with"/"Execute with" model choice on a plan-approval card is now remembered and reused for future plan hand-offs.
- Improvement: SVG diffs and reference-based Markdown diffs can now render as an in-place rendered preview instead of only opening in a separate tab.
- Improvement: The tab strip now scrolls horizontally with fade indicators at the cut-off edge instead of hiding overflowing tabs.
- Improvement: OpenCode's todo-list tool calls are now recognised and rendered as a proper todo list in the AI chat instead of a generic tool call.
- Improvement: `CLAUDE.md`/`AGENTS.md` instruction files are now discovered by walking up from an application's output folder toward the repository root, so root-level conventions are no longer missed during coding turns.
- Improvement: The AI file-patching tool now only accepts literal search/replace blocks; unified-diff-style patches are no longer supported.
- Improvement: Sticky ancestor-row breadcrumbs in tree views are no longer capped to a fixed count - they're now limited by height (up to 25% of the panel), so deep folder structures can pin more ancestors.
- Improvement: Commit-message popovers in Git history now render the subject and body as Markdown (lists, code spans, emphasis) instead of plain text.
- Improvement: The AI chat model picker now disables provider-crossing choices while a turn is running (with a short explanatory hint) instead of allowing a mid-turn switch that could fail, and live-applies ACP agent configuration changes mid-session.

## Fixes in 5.3.0

- Fixed: Merging or rebasing onto a commit from the history view could show a raw commit SHA in the confirmation toast instead of the branch name.
- Fixed: File chips for a tool call could be missing when an ACP agent (e.g. OpenCode) only reported file locations partway through the call.
- Fixed: A sub-agent run truncated by a length limit could be reported back to the dispatching agent as a completed, successful result instead of a truncated one.
- Fixed: Reapplying the same AI configuration value mid-turn (e.g. re-selecting the model already in use) could fail with a `-32603` error.
- Fixed: A designer script could stall for tens of seconds to minutes after an `await` if the window was unfocused or in the background.
- Fixed: AI read tools' background designer loads could repeatedly time out while Intent Architect was minimized or its window was occluded.
- Fixed: Global (user-wide) preferences edited outside the app - by hand, another window, or an external tool - weren't picked up until Intent Architect was restarted.
- Fixed: A plan chip could disappear from the conversation after a reload or an abandoned turn.
- Fixed: The AI chat panel could occasionally open blank due to a startup timing race in a child window.
- Fixed: Opening a solution could occasionally fail with a "Registration already exists for OpenSolutionRequest" error.
