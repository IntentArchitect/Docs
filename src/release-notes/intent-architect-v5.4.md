---
uid: release-notes.intent-architect-v5.4
description: "Intent Architect 5.4 release notes: test coverage in Change Review, solution-wide search and replace, a Git Explorer tab and Pull Requests panel, an inline MDX editor with document comments, rendered markdown diffs, multi-solution folders, and commit, pull request and chat title generation through your own AI agent."
---
# Release notes: Intent Architect version 5.4

## Version 5.4.0

<!-- Release notes cover intent client repo origin/release/5.4.x up to b14921df1a (2026-09-28), excluding commits already on release/5.3.x. -->

> [!NOTE]
> These release notes are provisional and were AI generated from source control history. They will be reviewed and refined before the final 5.4.0 release.

### Highlights in 5.4.0

#### Test coverage in Change Review

Change Review now shows test coverage for the lines a change adds, as a coloured percentage pill on each file, requirement and spec, with shading in the diff. Mark a task in `tasks.json` with `producesTestCoverage` and the new Tests panel can run it straight from the review. For a pull request, the tests run in an isolated, reusable checkout of the pull request's head so your own working tree is left alone. Results are saved against the commit they measured, so they are still there after a restart. The Tests panel also lists the Cobertura reports it found and says plainly when a file was never measured, when it has no testable lines, or when a score is stale.

#### Solution-wide search and replace

A new Search panel searches file contents across the whole solution, with regex, flat or tree results, per-match or per-file replace, and "Find in Folder" from the Solution Explorer. The Agents window gets the same panel, scoped to the conversation's folder, on `Ctrl` + `Shift` + `F` / `Ctrl` + `Shift` + `H`. Your last query and replacement are remembered per solution.

#### Git Explorer and Pull Requests panel

The old Git tab is now two surfaces: a Pull Requests side panel, with one root per repository even when several checkouts share it, and a Git Explorer centre tab with branches, tags, worktrees and repository history. From Git Explorer you can list, create and remove linked worktrees.

#### Edit plans and specs in place, and comment on them

`.md` and `.mdx` documents can now be edited inline in a live-preview editor. The block you are editing shows its source, while the rest of the document stays rendered with the same spacing and highlighting as the read view. It has block-aware completions, formatting shortcuts and clickable task checkboxes. You can also select text in a plan or document, leave comments, and send them back to the agent as feedback. Comments are shown on the plan-approval card too.

#### Rendered markdown diffs

Diffs of markdown files can now be viewed rendered, with added, removed and modified blocks and words marked in place. A ticked task shows as one modified item, and a link whose target alone changed shows the old target on hover.

#### Folders with several `.isln` files

A folder that contains several solutions now opens as one workspace. The Solution Explorer shows it as a foldered tree, with solutions styled differently from plain directories. Modules are restored one solution at a time, with an "Awaiting restore…" / "Restoring modules…" status on each solution. AI agents see the applications of every solution in the folder. How deep Intent Architect searches for `.isln` files can be set in User Settings (default 3).

#### Commit messages, pull request descriptions and chat titles from your own AI agent

Commit message, pull request description and chat title generation now run through your connected ACP agent, so nothing leaves your machine through another provider. A new General tab in AI Configuration lets you pick the model with a searchable picker. "Recommended" picks the agent's suggested model, and Intent's own bundled key is offered only as an explicit opt-in. Generate buttons are disabled, with an explanation, when no agent is available.

### Improvements in 5.4.0

- Improvement: Chat list search now matches what rows show (title, branch, repository and solution), splits identifiers, highlights matches and can search the full content of conversations. When a search matches only archived conversations, a link at the end of the list reveals them.
- Improvement: A new find bar inside a chat searches and navigates its transcript.
- Improvement: The MCP designer query tools are replaced by `run_designer_query`, a single read-only script tool, and the new `run_solution_query` for module, architecture and application-settings reads.
- Improvement: `getDesignerModelStructure` now fits large models into a character budget breadth-first, takes an `elementId` to drill into one element, marks collapsed containers with their child counts, and reports what it left out. The `maxDepth` and `maxElements` options have been removed.
- Improvement: `getApplicationSettings` accepts a case-insensitive `search` filter.
- Improvement: Designer scripts now validate multiplicity strictly, and `run_designer_script` reports changes grouped by kind, including the ones that were committed before a script failed.
- Improvement: When a bare element name matches more than one element, the lookup reports it as ambiguous, and `prefer` can pick the intended one.
- Improvement: A failed terminal task now offers "Resolve with AI", which starts a fix chat using the task's output.
- Improvement: Terminal sub-tabs show a tooltip with the task, command, directory, dependencies and status, and can be scrolled horizontally with the mouse wheel.
- Improvement: A docked AI chat now shows where its conversation runs when that is outside the open solution, such as a worktree or another repository.
- Improvement: `ask_user_question` answers are shown inline in the tool-call row as soon as they are submitted, and long questions and answers now wrap cleanly with pending/answered styling.
- Improvement: A message can now carry up to 20 attachments.
- Improvement: Sending a turn from a document now brings the AI chat into view, so you can see the message arrive.
- Improvement: File tools add a `Spec:` hint when a change touches code traced by a spec, and the new `sdd-extract` and `sdd-sync` skills help keep specs up to date.
- Improvement: Advancing a spec phase now enforces that phase's approvals, and tasks files are treated as MD or MDX everywhere.
- Improvement: `[[wiki-links]]` and relative `.md` / `.mdx` paths in documents now resolve, including in wiki autocomplete.
- Improvement: A `<ModelRef>` chip now resolves against the workspace folder its document sits in, even when no solution or designer is loaded.
- Improvement: The Git Explorer header matches the Source Control history layout, with a ⋮ menu for Flat and Folder views.
- Improvement: Switching between repositories in the Git panels is faster, and bulk stage and discard wait until up-to-date status has loaded.

### Fixes in 5.4.0

- Fixed: An ACP turn could be left running indefinitely after the agent went silent following an autonomous result.
- Fixed: A chat parked waiting on you could keep the machine from sleeping.
- Fixed: A refused turn's error message named the wrong AI provider.
- Fixed: Re-opening the tab of a pull request whose range had not changed reloaded the whole review, losing scroll position, expanded files and anything half-typed.
- Fixed: Opening a solution while another was open did not add it to recently opened solutions.
- Fixed: Declining to delete a board left its custom group membership changed.
- Fixed: Ticking task `T1.1` in a spec could also toggle its parent `T1`.
- Fixed: The AI actions menu could be clipped off the left edge of its tab.
- Fixed: Retargeting Change Review to another solution or worktree refreshed its icons but not its summary.
