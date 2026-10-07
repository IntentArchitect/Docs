---
uid: release-notes.intent-architect-v5.4
description: "Intent Architect 5.4 release notes: solution-wide find and replace; chat content search; a new Git Explorer tab and Pull Requests panel; test coverage in Changes Review; inline MDX editing, rendered markdown diffs and document comments; an agent-drivable app preview; multi-solution folders; and Spec-Driven Development test bindings and spec reviews."
---
# Release notes: Intent Architect version 5.4

<!-- 5.4.0: covers origin/release/5.3.x (a595670993)..origin/release/5.4.x (b5fcb7964d, 2026-10-07). Latest tag is publish/client/channel/beta/5.4.0-beta.2; no final 5.4.0 tag yet. Add later commits from b5fcb7964d onwards. Commits also on release/5.3.x were excluded as they're covered by the 5.3.x notes. -->

> [!NOTE]
> These release notes are AI generated and are still pending human review.

## Version 5.4.0

### Improvements in 5.4.0

- Improvement: New solution-wide Find and Replace in Files, with flat or tree results, replace per match, per file or all at once, "Find in Folder" from the results tree, and your last query and replacement remembered per solution. In the Agents window it's available as a Search panel, opened with `Ctrl + Shift + F` and `Ctrl + Shift + H`.
- Improvement: Chats can now be searched by their content as well as their title, branch, repository and solution, with quoted-phrase search, highlighted matches and a link to reveal matching archived chats. A find bar inside a chat steps through matches.
- Improvement: Pull requests now have their own Pull Requests side panel, which groups checkouts of the same repository together, while branches, tags, worktrees and history move to a new Git Explorer tab.
- Improvement: From Git Explorer you can create, reveal and remove worktrees, push, pull, fetch and rename branches, and start a new chat on a branch or worktree.
- Improvement: A new "Merge current into branch" action merges into another branch without checking it out, and refuses up front if the merge would conflict.
- Improvement: Pull requests have a "New chat on this pull request" menu item, and AI work on a pull request runs in an isolated worktree at the reviewed commit.
- Improvement: Hovering a ref pill in the Source Control history now shows it in full in the commit popover.
- Improvement: When a git operation is blocked by a stale `index.lock` file, Intent Architect now offers to remove it.
- Improvement: Picking a named session branch that is already checked out in another worktree is now refused up front.
- Improvement: Changes Review now shows test coverage for the lines a change added, read from Cobertura reports, as per-file and overall pills, with a Tests panel listing the reports found and flagging stale results.
- Improvement: Tasks in `tasks.json` marked with `producesTestCoverage` can be run from Changes Review. For a pull request, the tests run in an isolated, reusable worktree at the reviewed commit, so your own checkout isn't touched, and "Clear test worktrees" in User Settings reclaims their disk space.
- Improvement: Changes Review can also fetch coverage for a commit from its Azure Pipelines build, including for GitHub-hosted repositories, instead of running the tests locally.
- Improvement: Markdown and MDX files can now be edited inline in a live preview, where only the block you're editing shows its source, with formatting shortcuts, block completions and clickable task checkboxes.
- Improvement: Markdown diffs can be shown as a rendered preview that marks added, removed and changed blocks, words and table cells, with an overview ruler beside the scrollbar. Diffs can be edited in place, a block at a time from the preview or in the raw editor, and open in the mode you last used.
- Improvement: You can now comment on text in plans and other documents and send those comments back to the agent as feedback, including from the plan approval card.
- Improvement: Document headings can be folded, `[[wiki-links]]` and relative `.md`/`.mdx` links are resolved, and `<ModelRef>` links resolve even when no designer or solution is open.
- Improvement: New app preview: an embedded browser for your running application that AI agents can drive to check their changes in the live app, using `run_preview_script` to navigate, click and type, `preview_look` to read the page and its console, and screenshots.
- Improvement: Tasks in `tasks.json` can declare `previewUrl` or `urlPattern` so the app preview opens on the port the dev server actually bound, and `run_task` and `kill_command` are now available to ACP agents.
- Improvement: Opening a folder containing several `.isln` files now opens them together as one workspace, shown as a foldered tree in Solution Explorer, with modules restored one solution at a time. A new user setting controls how deep to search for `.isln` files (default 3).
- Improvement: Agents board groups can now be pinned above the rest.
- Improvement: In the Agents window, `Left Arrow` or `Escape` in an empty composer moves focus to the board, and focus returns to the chat afterwards.
- Improvement: The chat context popover now shows when a chat started, its last message time and its duration.
- Improvement: Finished activity rows in a chat now fold behind an "N finished" toggle, and sub-agent rows are titled from what they were asked to do.
- Improvement: Answers to `ask_user_question` prompts are now shown inline in the tool call row, with questions and answers stacked so long text wraps.
- Improvement: Failed terminal tasks now offer "Resolve with AI", which starts a fix chat with the task's output.
- Improvement: Terminal sub-tabs show a tooltip with the task, command, directory, dependencies and status, and the sub-tab bar scrolls horizontally with the mouse wheel.
- Improvement: A docked AI chat whose conversation runs outside the open solution, such as in another worktree or repository, now shows where it runs.
- Improvement: The AI chat composer now accepts up to 20 attachments per message.
- Improvement: ACP agents that need Node.js now explain when it's missing, with a Download Node.js link, instead of a bare "failed to start" error.
- Improvement: The AI summaries model picker offers every bundled Intent Architect model, and shows which model is actually used.
- Improvement: The Agents window stays more responsive with many conversations, switching between repositories, worktrees and chats does less git work, and Source Control refreshes on the first click after the window regains focus.
- Improvement: Diagrams opened by drilling into an element now show breadcrumbs, and opening an element with no diagram of its own drills into its owning type.
- Improvement: The MCP designer read tools are consolidated into the read-only `run_designer_query` and `run_solution_query` scripts, and `getDesignerModelStructure` supports drilling in by `elementId` and reports what was left out when a large model is truncated.
- Improvement: Designer scripting adds `createPackage`, a search filter for `getApplicationSettings`, warnings for designer rules and inactive properties, and a report of new diagram elements left unplaced after applying a layout. `run_designer_script` now reports its changes grouped by kind, even when a script fails part-way.
- Improvement: Spec-Driven Development: the new `request_spec_review` step lets you approve or comment on each changed block of a spec before its phase advances.
- Improvement: Spec-Driven Development: acceptance criteria show their test status as chips, bound live from tests that cite `[spec:<slug> R1.4]` in their names, and collapsed spec cards show a Health summary of verdict gaps and drift since the last verify.
- Improvement: Spec-Driven Development: verdicts now record what they judged, so requirements whose code moved since review are flagged, and re-verifies only re-judge what changed.
- Improvement: Spec-Driven Development: a new `/sdd-run` skill takes a spec through to verification in one chat, `sdd-extract` and `sdd-sync` skills keep specs in step with traced code changes, and a spec advances to done after a clean verification.
- Improvement: Requirement ids and `Table N.N` citations in documents and AI questions now link to the matching section, landing on the exact acceptance criterion.
- Improvement: Spec documents now refresh when their sibling files change, and have a manual refresh action.

### Fixes in 5.4.0

- Fixed: Re-opening a pull request review whose tab was already open always reloaded it, losing scroll position, expanded files and unsaved text.
- Fixed: MCP designer calls could time out, or report that the solution was no longer open, on large solutions.
- Fixed: An AI turn could keep showing as running indefinitely after the agent went silent, and chats waiting on your input kept the machine awake.
- Fixed: Quitting Intent Architect while an AI question was waiting for an answer lost the question on reopen.
- Fixed: Software Factory "Fix" and "Create AI task" actions didn't open a tab in the Agents window.
- Fixed: The `/` command picker in the Agents window could miss repository skills when the solution was in a nested folder.
- Fixed: For repositories reached through a symlink, including macOS temp folders, solution search, worktree reuse, `.gitattributes` line endings and moving a chat between checkouts could fail.
- Fixed: Spec documents in the Agents window only showed their status chips and trace overlays when the selected conversation owned the spec's workspace.
- Fixed: Ticking a spec task such as `T1.1` could also match its parent `T1`.
- Fixed: Spec Kit imports didn't pick up task ticks from the framework's own `tasks.md`.
- Fixed: Opening a file diff from a Changes Review started from Pull Requests did nothing when Source Control hadn't been shown yet.
- Fixed: The chat and Git panels reloaded every time the window regained focus.
- Fixed: Source Control commit drafts and in-progress state could carry over between worktrees.
- Fixed: Source Control history could stop loading further pages after a background refresh.
- Fixed: Live sub-agent and background task pills could remain after reloading a chat.
- Fixed: Retrying a dispatch could keep showing "Creating worktree" after the worktree was already created.
- Fixed: Declining to delete a conversation from the board could still remove it from its custom group.
- Fixed: The AI actions menu could be clipped off the left edge of its tab.
- Fixed: Unordered tree nodes could have their sibling order reversed.
