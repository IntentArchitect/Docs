---
uid: release-notes.intent-architect-v5.4
description: "Intent Architect 5.4 release notes: solution-wide find and replace; chat content search; a new Git Explorer tab, a Pull Requests board with editable pull request metadata and @mentions; an Explorer Diagram; an Application Overview tab; improved token efficiency for MCP, ACP and BYOK agents; collapsible tool groups in AI chat; test coverage in Changes Review; inline MDX editing, rendered markdown diffs, a document outline and document comments; an agent-drivable app preview; multi-solution folders; and Spec-Driven Development living specifications with test bindings, drift detection and spec reviews."
---

# Release notes: Intent Architect version 5.4

<!-- 5.4.1: covers publish/client/5.4.0..origin/release/5.4.x up to 05ba66a16f (2026-11-05). No 5.4.1 tag yet. Add later commits from 05ba66a16f onwards. -->

## Version 5.4.1

### Highlights in 5.4.1

#### A single Intent Architect instance can now be used to serve all MCP clients

Intent's MCP server no longer needs to have a different instance of Intent Architect open per solution it's working on, it can now use any currently open instance of Intent Architect to do any required work such as opening/updating designers and running the Software Factory.

Any work being done via the MCP server is now visible in "MCP session" rows in the the Manage Agents shell. It is also not necessary to have the Manage Agents shell open while work is in progress as it can still happen in the background, e.g. when on the Solution shell or Home Screen.

![An MCP session in Manage Agents](images/5.4.x/mcp-sessions.png)

> [!TIP]
> **Try it:** There's nothing to set up. With Intent Architect open on any shell, ask a connected MCP client to work on a solution, then look for the "MCP session" row in Manage Agents.

#### Child chats

To split larger work into focused sessions, agents can now start child chats with `start_child_chats`. The proposed chats appear on an approval card with Start sessions, Create sessions without starting and Cancel. Each child chat runs on its own and is grouped under its parent, and the parent can follow and steer them with `list_child_chats`, `message_child_chat` and `stop_child_chat`.

![The child chats approval card](images/5.4.x/child-chats.png)

> [!TIP]
> **Try it:** Ask an agent to "split this work into child chats", then review the approval card and choose Start sessions.

#### Spec Areas

To keep a growing set of Capabilities organised, the Specs panel can now group them into Areas. An Area is an overview spec, written with the new `sdd-area` skill, that rolls up the health of the Capabilities under it. Areas are created from the specs menu, and Capabilities are moved into them by dragging or with "Move to Area".

> [!TIP]
> **Try it:** Create an Area from the specs menu, then drag a Capability onto it or choose **Move to Area**.

#### Git compatibility and speed improvements

Intent Architect now exclusively uses your installed version of git instead of a built-in library ensuring complete compatibility even when using newer git features such as relative worktrees.

The git executable is also faster compared to the library, status is about three times faster, blame about twenty times and other many activities are noticeably faster such as committing and listing branches.

To make it clear which git is used, Settings has a Git Executable setting under Tools with a status line saying which git was found and where, and a warning for git older than 2.29. When git is missing, too old or the configured path doesn't run, Source Control shows a notice with Open Settings, Download Git and Retry.

![The Git Executable setting](images/5.4.x/git-executable.png)

> [!TIP]
> **Try it:** Open Settings and look under **Tools** for **Git Executable** to see which git was found.

#### Faster designers and startup

The home screen now shows sooner on startup and large designers are much more responsive. Switching diagrams, panning and scrolling the model tree do far less work, and the five most recently shown diagrams stay rendered, so switching back to one takes about 0.5s instead of 1.3s as measured for a large designer we use.

> [!TIP]
> **Try it:** It's always on. Open a large designer, then switch between a few diagrams and back.

### Improvements in 5.4.1

- Improvement: Codex, Copilot and OpenCode chats now show Intent's tool calls by name with their intentions and file chips, nest sub-agents under their dispatch card, and hold mid-turn messages until the running prompt settles.
- Improvement: Codex, Copilot and OpenCode now follow the chat's permission level and reasoning effort, and Plan mode uses each agent's own plan mode. Codex ACP 2.2.2 and Copilot CLI 1.0.103 are pinned, OpenCode 2.2.0 or later is required, and the usage popover shows the running connector version.
- Improvement: Edit automatically still asks before edits to `.git`, `.claude`, `.vscode` and `.idea`, plus the folders each agent protects itself.
- Improvement: AI Configuration has per-agent session settings, such as numeric limits and choices, that each ACP agent applies when it starts.
- Improvement: Custom agents can be created, generated with the new `create-agent` skill, and edited as `.agent.md` files from the Agents tab of AI Configuration.
- Improvement: The Coding persona has been retired, and agents and skills are no longer split into Modeling and Coding contexts.
- Improvement: Permission mode and reasoning effort are now kept for each chat instead of being shared by all chats.
- Improvement: Messages sent while a turn is running stay in the Queued strip until the agent reads them, and unread ones return to the message box after Stop. `Up Arrow` in an empty composer recalls earlier messages.
- Improvement: When a Claude Code process fails partway through a prompt, the session is resumed once, so a sub-agent's work and answered questions aren't lost.
- Improvement: Retry is no longer offered when an AI error reports a used-up spending limit or quota.
- Improvement: An AI chat can now be moved to any folder, including one in another repository or one picked with the file picker, and the folder picker shows more rows.
- Improvement: A chat's session branch can be an existing branch, and a worktree whose preferred folder holds another checkout is created in the next free folder (`<folder>-2`, `<folder>-3`) instead of failing.
- Improvement: Going to the Agents window from a solution now opens a chat in that solution's folder.
- Improvement: Agents use fewer tokens. Intent's Claude Code sessions start with a cached system prompt, skills load reference detail only when needed, `get_change_review` returns 50 rows by default with paging, `read_spec` can read a single section and returns only test counts for tested criteria, and a failed `patch_file` shows the nearby lines.
- Improvement: A done Change now always offers Fold, with re-verify options in its menu, shows as verified when only re-checks are pending, and `/sdd-fold` asks before creating a new Capability.
- Improvement: The `sdd-run`, `sdd-sync` and `sdd-heal` skills now track criteria that were verified by reading the code as "judged", and offer to write tests for them.
- Improvement: Changes Review shows each edited spec's kind, state and health, with per-requirement health, and loads specs faster.
- Improvement: Work Items can be stored in a folder set in Settings, can be `.md` as well as `.mdx` files, have a "Convert to Markdown" action, and can be linked to and unlinked from chats.
- Improvement: Pull request review comments can now cover a range of lines on every git host, selected by dragging over the line numbers.
- Improvement: Pull request assignee, reviewer and label pickers show changes immediately and undo them if the host refuses, and people search narrows its results while typing.
- Improvement: Pull request sign-in can use a token from the GitHub, GitLab or Azure DevOps CLI (`gh`, `glab`, `az`), and "Sign in with Azure DevOps" is offered on dev.azure.com.
- Improvement: When a clone is refused as not found or unauthenticated, the Clone dialog offers browser sign-in, token sign-in or another saved account.
- Improvement: File tabs can play video and audio files, with seeking.
- Improvement: The Software Factory CLI accepts a repeatable `--param name=value` option that modules can read with `GetParameter`. Implementers of `ISoftwareFactoryExecutionContext` need to add the new member.
- Improvement: Each end of a diagram association can be positioned on its own, and dragging a straight link moves both ends.
- Improvement: Element types can spread curved associations that meet the same edge with the new `anchorSpread` visual setting, and define their own anchor segments with `anchorSegmentsFunction`.
- Improvement: A new "Configuring Designers" skill helps module authors set up element and association types, diagram anchors, visuals, menus and scripts.
- Improvement: The `classify-codebase` skill now works for any language and prefers shorter classification names.
- Improvement: Running Software Factory process pills show an animated border.

### Fixes in 5.4.1

- Fixed: Opening a large solution on macOS was slow, taking about 10s for a 178-application solution; it now takes about 0.6s.
- Fixed: Open Folder on a folder holding a single solution opened that solution instead of the folder itself as a workspace.
- Fixed: Cancelling a worktree's setup tasks didn't stop them, and a chat could hang on a setup task that was stopped before it started.
- Fixed: While a turn was stopping, the chat composer could show both Send and Stop, and pressing Enter repeatedly could send the same message more than once. It now shows Stop until the turn has stopped, and a second Stop press shows "Force stopping…".
- Fixed: The sticky prompt bar in AI chats pinned a message too late and couldn't reach earlier messages outside the rendered range. It now pins as soon as a message scrolls past the top, and has a history list for jumping to earlier messages.
- Fixed: Sub-agent cards could show a "missing intention" error when `create_sub_agent` or `dispatch_sub_agent` was called without an `intention`. It's now optional, and the card's subtitle comes from the instructions.
- Fixed: Markdown documents and diffs re-parsed on every re-render, and the Agents window lost their inline-edit and preview state when switching views.
- Fixed: Leaving a solution while its Software Factory was starting or restoring modules could fail with "solution path header is not set".
- Fixed: After a solution failed to open, opening another solution could fail with the first one's error.
- Fixed: Creating an application while modules were being restored could time out because the application lock was still held.
- Fixed: Restarting a Software Factory while it was starting could make the next run fail with "An invocation handler … has already been registered".
- Fixed: If a module task process exited unexpectedly, creating an application could wait indefinitely instead of failing.
- Fixed: Renaming an application could write its package files to the wrong folder and break other applications' references to its packages.
- Fixed: After uninstalling a module, an open designer could keep offering that module's element types.
- Fixed: Opening a diagram could still make a clean designer look dirty, so an external change raised "Underlying metadata files have changed" instead of reloading.
- Fixed: Saving a designer twice in quick succession could make it reload as if its files had changed outside Intent Architect.
- Fixed: Saving a designer didn't refresh Source Control.
- Fixed: Search Everywhere could stop finding unsaved designer elements after a file in the application changed, such as after a Software Factory run.
- Fixed: Drawing an association from an association end, such as a Perform Invocation from a Domain Event Handler's "handles event" end, failed with an error.
- Fixed: The Redo button could stay enabled after a new edit, and Undo after picking a diagram from the toolbar dropdown didn't return to the previous diagram.
- Fixed: A model tree suggestions popover stayed open, empty, when the pointer moved to a row without suggestions.
- Fixed: Diagrams expanded with "+" could forget the lines they revealed, and model diff tabs could stop showing as loading before their Changes diagram appeared.
- Fixed: Long type references overflowed their dropdown.
- Fixed: Long hints in generated module settings forms were clipped or overlapped.
- Fixed: Renamed files applied by the Software Factory could reappear as pending changes a few seconds later.
- Fixed: The Codebase Roots weren't refreshed when an application's output location changed, until the solution was reopened.
- Fixed: Revealing a file outside every codebase root did nothing, and files at a root's top level showed no containing folder.
- Fixed: A deleted worktree could cause errors in the Solution Explorer and in spec reads instead of showing "No folder".
- Fixed: Ticking Worktree in a repository with no commits failed after Send with git's "invalid reference: HEAD"; it's now refused up front with a clear message.
- Fixed: A terminal tab for a task run by an AI agent could open in whichever chat was on screen instead of the chat that ran it.
- Fixed: A designer or other tab opened by a sub-agent in the Agents window could close before it finished loading.
- Fixed: The Agents window's Context Panel badges could show another chat's numbers, and the Changes badge stopped updating while the panel was collapsed.
- Fixed: Typing in the AI chat composer could lag.
- Fixed: Opening a solution on a slow machine could replace a chat draft that was being typed with an empty one.
- Fixed: When an agent asked two questions or sought two approvals at the same time, the second could replace the first on screen, and a queued card could appear after Stop.
- Fixed: Text from parallel sub-agents could be mixed into the chat's own answer.
- Fixed: An ACP chat could wait indefinitely on a tool call after its connection to Intent's MCP server dropped; the call now fails with a message to start a new chat. Gathered diagnostics also keep logs past the chat's last saved message.
- Fixed: An AI agent answering a confirmation dialog on a tab that wasn't on screen could hang.
- Fixed: Skills auto sync updated skills for disabled AI providers.
- Fixed: Kiro's rate-limit errors weren't reported as a usage limit, and Kiro chats could fail when setting a mode or model Kiro didn't list. Kiro's models are now discovered from the agent.
- Fixed: An unnamed `create_application` in a folder holding several nested solutions reported that no solution was open instead of asking which one to use.
- Fixed: A spec task could be ticked even when saving its open designers failed.
- Fixed: A member added to a model element after its traceability link was recorded could show as traced by that older link.
- Fixed: Spec verdicts recorded on Windows could show as out-of-date on other platforms for elements with multi-line comments.
- Fixed: Links to a spec requirement (such as `#R18.3`) opened the spec file instead of the requirement, including for archived specs.
- Fixed: Stepping between changes in a rendered document diff could scroll to the wrong place when diagrams finished laying out late.
- Fixed: GitLab browser sign-in for pull requests failed with "requires higher privileges". It now signs in through GitLab CLI (`glab`).
- Fixed: Signing out of Bitbucket pull requests could silently sign back in.
- Fixed: Intent Architect could intermittently fail to connect to its backend at startup with a certificate error.
- Fixed: Intent's MCP server could fail to launch an installed Intent Architect when none was running.

<!-- 5.4.0: covers origin/release/5.3.x (a595670993)..origin/release/5.4.x. Extended to d1f965e5e2 (2026-10-27). Latest tag is publish/client/channel/beta/5.4.0-beta.2; no final 5.4.0 tag yet. Add later commits from d1f965e5e2 onwards. Commits also on release/5.3.x were excluded as they're covered by the 5.3.x notes. -->

## Version 5.4.0

_Released 2026-10-29._

We're very excited to announce the release of Intent Architect version 5.4. This version marks another massive milestone of innovation for the platform, offering many new capabilities and improvements, and effective solutions to problems that the industry is still wrestling with.

Where 5.3 was about _seeing_ what your agents are doing, 5.4 is about _proving_ that what they've done is right. When agents write most of the code, reading every line stops being a review. As Addy Osmani puts it, "The bottleneck has moved from writing code to knowing it's correct." So 5.4 moves the review to **intent and proof**: what a change was meant to do, and the evidence that it does.

A big game changer in this release is the [**living specifications**](#spec-driven-development-living-specifications). This new capability solves one of the biggest critiques of SDD (Spec-Driven Development) - that specs become stale almost immediately after the next change lands (aka "spec drift"). The system uses tests as proof of that requirements are implemented, and quickly detects gaps - plus a CI command to scale it across teams.

This release also takes big strides in supporting the shift to reviewing "intent" and proof / evidence as the primary way to determine if code is correct. The enhanced PR and Change Review system now allows agents to create PRs with images and snapshots taken while [**it drives the app**](#agent-drivable-application-previews), users can explore the design changes more easily with the new [**Explorer Diagrams**](#explorer-diagram), spec changes are now rendered in rich [**Markdown and MDX diffs**](#rendered-markdown-diffs-and-inline-editing), and [**Test coverage for the PR's changed files**](#test-coverage-in-changes-review) are just some of the highlights that 5.4 brings to the table in this regard.

For teams running many agents, the Agent Manager has undergone a step-wise upgrade, bringing `.worktreeinclude` support and the ability to trigger CLI commands (e.g. `npm i`) on creation. In addition, 5.4 introduces [**Work Items**](#work-items), which group sessions and provide a markdown "scratch pad" to track work, context, information, and whatever else you want 🙂. The upgrades aim to ensure that users running high volumes of parallel agents have a smooth experience with more control.

Agents are also more efficient: when [**building with Intent**](#improved-token-efficiency-for-mcp-acp-and-byok-agents) over MCP, ACP or with your own API key, token efficiency has improved by more than 20% in most use cases.

As always, there's a long list of improvements and fixes below, including the updated [**Application Overview**](#application-overview), the [solution-wide find and replace](#solution-wide-find-and-replace) and support for working within [folders that contain several Intent Architect solutions](#folders-with-several-solutions).

We hope you enjoy this version. Thank you for your continued support and feedback as we pioneer the future of agentic software engineering with you 🚀

> [!TIP]
>
> Ready to get started? **Head to [our website](https://intentarchitect.com) and login to download it**.

---

### Spec-Driven Development: living specifications

A completed spec is only useful to us if the code still meets it, otherwise it's stale and can't be trusted. Until now there was no way to tell which requirements were implemented as expressed, or which had drifted since they were last checked. 5.4 makes specs living: they make behavioural changes explicit to the team and hold agents accountable to them. This solves one of the biggest challenges and critiques of SDD and opens the door to true "intent" based review of our system's rules. It also avoids the "I could swear it used to work like this" experience we all have had as our systems evolve.

Acceptance criteria now show the status of tests that cite them, and spec cards summarise verdict gaps and drift since the last verification. Re-verification only re-judges what changed, which keeps token usage efficient. A `verify-sdd` Software Factory CLI command also checks spec health in CI without AI, failing for out-of-date specs and specs with gaps.

![Acceptance criteria with test status](images/5.4.x/spec-test-status.png)

A Spec Review step allows each changed block of a spec to be approved or commented on by the user before its phase advances. Importantly, this helps catch misalignments between the user and agents before tokens have been spent on implementations. The spec panel keeps things simple with a single call-to-action button to move specs forward or address issues. The final piece is the new `/sdd-run` skill, which is able to take a spec through to verification in a single chat.

![Reviewing a spec before it advances](images/5.4.x/spec-review.png)

> [!TIP]
> **Try it:** In an AI chat, type `/sdd-extract` followed by the capability name or folder you want to turn into a living spec.

---

### Improved token efficiency for MCP, ACP and BYOK agents

Agents building with Intent Architect, whether through the [Intent MCP server](xref:ai.intent-mcp-server), as a [CLI agent connected over ACP](xref:ai.cli-agents), or as a built-in agent using [your own API key](xref:ai.configuration) (BYOK), are now more efficient from modelling through to code generation. We streamlined what Intent Architect's tools exchange with the agent, so agents get straight to the work, and we've improved token efficiency by more than 20% in most use cases.

> [!TIP]
> **Try it:** There's nothing to set up. Keep building with Intent Architect over MCP, ACP or your own API key as before.

---

### Test coverage in Changes Review

When reviewing a change, especially one written by an AI agent, it's hard to tell whether the new code is actually covered by tests, so the Changes Review tab now shows test coverage of the added lines, per file and overall, read from Cobertura reports. Although this is heuristic, it bolsters confidence, especially when paired with specs that make rule changes crystal clear.

![Test coverage in Changes Review](images/5.4.x/changes-review-coverage.png)

> [!TIP]
> **Try it:** Ask an agent to "add tests for this change and run them with Cobertura coverage" (for .NET, `dotnet test --collect:"XPlat Code Coverage"`), then open Changes Review. Coverage is read from the newest Cobertura report in any `TestResults` folder, so there's nothing to configure. To read coverage from your CI builds instead (currently Azure Pipelines), see [Coverage from CI](xref:application-development.change-review#coverage-from-ci).

---

### Rendered Markdown diffs and inline editing

Raw Markdown diffs can be hard to read, particularly for prose and tables, so Intent Architect's Markdown diffs can now be shown rendered, with added, removed and changed blocks, words and table cells highlighted, along with changed list numbers and front matter.

![A rendered Markdown diff](images/5.4.x/markdown-rendered-diff.png)

Markdown and MDX files can also be edited in a live preview, where only the block being edited shows its "source". Plain Markdown documents get the same links, references and inline editing as `.mdx`, and pasted Markdown is escaped in `.mdx` prose so braces and `<` are not read as code.

![Editing Markdown in a live preview](images/5.4.x/markdown-inline-editing.png)

> [!TIP]
> **Try it:** Ask an agent to update a `README.md`, open the file's diff and click **Preview** in the diff toolbar. Click **Edit** to edit the rendered view in place.

---

### Users and agents can now post images to PRs

Agents can now open pull requests themselves with the new `create_pull_request` tool, and embed the screenshots they captured while verifying their work, such as the running app in light and dark themes. By default the Create Pull Request tab opens prefilled for you to review and submit, and the new "Let agents create pull requests directly" setting lets an agent open the pull request without that step.

![An agent's pull request description with the screenshots it captured, beside the chat that wrote it](images/5.4.x/agent-pull-request-screenshots.png)

Pull requests also now have their own side panel, so the number of open pull requests that are assigned to you is shown as a badge. It now indicates the CI check status, whether it can be merged, who created it, who is assigned to it, the branch, etc.

![The Pull Requests panel with its open pull request badge](images/5.4.x/pull-requests-panel.png)

A pull request's assignees, reviewers, labels and draft status can now also be set from Intent Architect on GitHub, GitLab, Azure DevOps and Bitbucket, and a review can be re-requested, without going to the git host's website. Typing `@` in a pull request comment or description also allows tagging of people on the pull request and its changed files.

> [!TIP]
> **Try it:** After an agent finishes a UI change, ask it to "Open a pull request for this change." It captures screenshots and fills in the New pull request tab for you to submit.

---

### Explorer Diagram

Explorer Diagrams show design changes in context, whether an agent's model changes or a pull request's, along with the related elements and any deleted ones drawn as ghosts. The `+` button on any element adds its neighbours, filtered by association type, so you can follow relationships and explore the system's design and architecture without being overwhelmed, and `Keep Diagram` saves the result as a normal diagram. This way, when you review a PR, you can quickly check that the design change is what was intended before reading hundreds of lines of generated code.

![Show in Explorer Diagram on an entity, the diagram with its + button, and the diagram after adding neighbours](images/5.4.x/explorer-diagram.png)

> [!TIP]
> **Try it:** Right-click one or more elements in a designer's tree and choose **Show in Explorer Diagram**.

---

### Application Overview

The Application Overview tab has been completely overhauled, now showing the number of elements in each designer, recent designer activity, spec activity and commits, with links to drill deeper as desired.

![The Application Overview tab](images/5.4.x/application-overview.png)

> [!TIP]
> **Try it:** Right-click an application in Solution Explorer and choose **Overview...**.

---

### Collapsible tool groups in AI chat

Agent turns with many tool calls are now much easier to follow in AI Chats. Two or more consecutive tool calls are always folded into one group with a summary such as "Ran 12 commands, read 3 files", and sub-agent rows now nest under their own dispatch card and are titled from what they were asked to do.

![Consecutive tool calls folded into one group in AI Chat](images/5.4.x/ai-chat-tool-groups.png)

> [!TIP]
> **Try it:** It's always on. Ask an agent to "summarise how this solution is structured", then click a group's header to expand it.

---

### Document outline

Long plans and specs can now be navigated with an "On this page" outline panel, which lists a document's headings and follows the scroll position.

![The "On this page" outline beside a document](images/5.4.x/document-outline.png)

> [!TIP]
> **Try it:** Ask the Plan agent for a plan, open it and click the **Show outline** button in the top right. The outline needs at least three headings.

---

### Comment on documents and send feedback to the agent

Reviewing a plan usually turns up several points at once, which were awkward to collect into a single chat message. You can now simply comment on as many pieces of selected text as you want in a plan or other document and then send all the comments to the agent as feedback in one go along with answers to question forms.

![Comments on a plan, ready to send to the agent](images/5.4.x/document-comments.png)

> [!TIP]
> **Try it:** Ask the Plan agent for a plan, select some text in it and click **Add Comment**, type your comments, then click **Send N comments**.

---

### Agent-drivable application previews

A productivity multiplier in agentic development is letting agents spot and fix their own mistakes, in a loop if needed, without waiting on you. Agent-drivable app previews make this possible: an agent can start your app's dev server, open it in an embedded browser, then click through it, read the page and console, and take screenshots to verify its work. Those screenshots can go straight into the [pull request it opens](#users-and-agents-can-now-post-images-to-prs), so you see the change working before you read the code behind it.

![An agent checking its changes in the app preview](images/5.4.x/app-preview.png)

> [!TIP]
> **Try it:** Ask an agent to "start the app, open it in the preview, check the home page loads and take a screenshot".

---

### Work Items

Even when using a ticketing system to track tasks for a project, every developer invariably has lots of informal tasks to keep track of as part of their day-to-day work, or maybe they just need a "scratch pad" to write down _stuff_. If agents can _also_ see and update these, this opens enormous automation possibilities.

The Work Items tab in Intent Architect allows creation of informal (or any) tasks or a "scratch pad" while also exposing tools to agents for creating, reading and updating them. It also offers a one-click button to create a new chat to take on a work item, pre-filled with appropriate context and a pre-canned worktree name. You can ask a chat to create a new work item or to add itself to an existing one.

![The Work Items tab](images/5.4.x/work-items.png)

![The Work Items tab, additional screenshot](images/5.4.x/work-items-alternate.png)

> [!TIP]
> **Try it:** Ask an agent to "create a work item for the follow-ups from this chat". Then open **Work Items** from the Agents window's left-hand bar and click **Start chat** on the item.

---

### Solution-wide Find and Replace

It's now possible to search and replace across every file in a solution. In the Agents window, `Ctrl + Shift + F` opens the Search panel and `Ctrl + Shift + H` goes straight to Replace. Replacements can be made one match at a time, per file or across all results, and only the listed matches are changed.

> [!TIP]
> **Try it:** Press `Ctrl + Shift + F` in the Agents window and search for any word.

---

### Folders with several solutions

Opening a folder that contains several `.isln` files now opens them together as one workspace, shown as a tree in Solution Explorer.

![Several solutions opened from one folder](images/5.4.x/multi-solution-folder.png)

> [!TIP]
> **Try it:** On the Home screen, click **Open a folder** and pick a folder that contains two or more `.isln` files.

---

### Improvements in 5.4.0

- Improvement: Chats can now be searched by their content as well as their title, branch, repository and solution, with quoted-phrase search, highlighted matches and a link to reveal matching archived chats. A find bar inside a chat steps through matches.
- Improvement: Hovering a ref pill in the Source Control history now shows it in full in the commit popover.
- Improvement: When a git operation is blocked by a stale `index.lock` file, Intent Architect now offers to remove it.
- Improvement: Branches, tags, worktrees and history have moved into a new Git Explorer tab, where worktrees and branches can be managed and new chats started on them.
- Improvement: A new File History view searches a file's commits and can restore an earlier revision, and the file view now has a Git Blame gutter. Git Blame works on files larger than 2 MB, and "Annotate Current File with Git Blame" is offered from Git History commit rows.
- Improvement: Agents board groups can now be pinned above the rest.
- Improvement: In the Agents window, `Left Arrow` or `Escape` in an empty composer moves focus to the board, and focus returns to the chat afterwards.
- Improvement: The chat context popover now shows when a chat started, its last message time and its duration.
- Improvement: Answers to `ask_user_question` prompts are now shown inline in the tool call row, with questions and answers stacked so long text wraps.
- Improvement: Failed terminal tasks now offer "Resolve with AI", which starts a fix chat with the task's output.
- Improvement: Terminal sub-tabs show a tooltip with the task, command, directory, dependencies and status, and the sub-tab bar scrolls horizontally with the mouse wheel.
- Improvement: A docked AI chat whose conversation runs outside the open solution, such as in another worktree or repository, now shows where it runs.
- Improvement: The AI chat composer now accepts up to 20 attachments per message.
- Improvement: The AI summaries model picker offers every bundled Intent Architect model, and shows which model is actually used.
- Improvement: The Agents window stays more responsive with many conversations, switching between repositories, worktrees and chats does less git work, and Source Control refreshes on the first click after the window regains focus.
- Improvement: The MCP designer read tools are consolidated into the read-only `run_designer_query` and `run_solution_query` scripts, and `getDesignerModelStructure` supports drilling in by `elementId` and reports what was left out when a large model is truncated.
- Improvement: Designer scripting adds `createPackage`, `getUnloadedPackages()`, `loadPackage()` and `unloadPackage()` (asking before discarding unsaved changes), a search filter for `getApplicationSettings`, warnings for designer rules and inactive properties, and a report of new diagram elements left unplaced after applying a layout. `run_designer_script` now reports its changes grouped by kind, even when a script fails part-way.
- Improvement: The Agents window's Sessions tab shows a badge counting chats that need attention.
- Improvement: "Resolve with AI" can now optionally complete the merge or rebase once all conflicts are staged, and explains "ours" and "theirs" correctly during a rebase. Your choice is remembered in Source Control preferences.
- Improvement: A new "Shut Down All" item in the taskbar's Software Factory menu stops every running Software Factory after confirming.
- Improvement: Claude Code chats now load your own Claude Code MCP configuration, so claude.ai connectors, user-level servers, project `.mcp.json` and plugins are available in Intent Architect chats.
- Improvement: Claude Code's reasoning effort can be set to None on models that allow thinking to be turned off, such as Haiku.
- Improvement: Connecting OpenCode now updates an existing `opencode.jsonc`, keeping its comments, instead of creating `opencode.json` beside it.
- Improvement: Intent's MCP server now works the same way for ACP and plain MCP clients, with the model-first rules delivered through the `intent-architect-mcp` skill and `get_full_instructions` removed.
- Improvement: Refreshing a pull request review after its head moves now shows files changed since they were approved as stale, and the review keeps unsent comment text when its tab is reopened.
- Improvement: "Rebase with AI" is offered when a host refuses a rebase merge, and "Update branch" starts an update-branch chat on a `pr/<id>` session branch.
- Improvement: New chats are saved as drafts as soon as they have text, an attachment or an open tab, and survive navigation and restarts. "Create now" cuts the worktree early, and "Apply now" or "Cancel" changes a chat's location without sending.
- Improvement: AI Configuration is now a tab, opening on General and remembering the last tab used. Its Skills pane groups the built-in skills and rules, with per-agent install and update, and "Reset to bundled".
- Improvement: Built-in skills and rules are only written to agent folders when auto sync is on or when asked for. An "Enable auto sync" banner in chat offers to turn it on, and System Suggestions are reachable from the user menu.
- Improvement: A team setting in `.agents/team-settings.json` and a user default now decide whether plans and specs are `.md` or `.mdx`.
- Improvement: AI summaries have a per-model "Thinking Levels" picker and run in stripped-down agent sessions that use far fewer tokens.
- Fixed: Claude Code can stay in Auto permission mode instead of falling back to Edit automatically.
- Improvement: Sub-agents that run in the background, are nested, or are resumed with `SendMessage` now appear under "Background agents and tasks", and several sub-agents can run in parallel.
- Improvement: Messages sent mid-turn now reach the chat's own agent rather than being forwarded to sub-agents.
- Improvement: Escape anywhere in the AI chat cancels the active question, approval or spec gate, and clicking the transcript lets the arrow and page keys scroll it.
- Improvement: Folders named in AI replies, and `file:` links, now open in the Codebase Explorer or the OS file manager.
- Improvement: Files dropped from the OS onto either shell, a chat's messages or a tab open as file tabs, and only the chat composer attaches them.
- Improvement: The Agents window can move a tab to a new window, collapses its left panel by dragging past a threshold or clicking the active tab, and remembers each chat's open tabs and Solution Explorer expansion when switching between chats and shells.
- Improvement: Zoom now offers 50% to 200% in 5% steps.
- Improvement: During a rebase, Source Control shows the branch being rebased and the step progress.
- Improvement: The Task Console raises a dismissible error toast when it gets errors while hidden.
- Improvement: ACP connectors can be installed on machines without Node.js, using the npm bundled with Intent Architect, and CLI locations are found after installs made following logon on Windows.
- Improvement: Files can be classified from a popover in Changes Review, and Template Outputs can carry File Classification entries so files from one template are classified differently. "Severity" is now "review importance", and the Root Folder can carry entries on Codebase Structure 1.3.0-pre.0 or later.
- Improvement: Association ends can have labels, with `getLabel()` and `setLabel()` in the macro API and a visual setting to hide them, and diagram element text and popover comments can be Markdown.
- Improvement: Association lines now route around boxes in the way.
- Improvement: Specs are named by title in tabs and diffs, and the Specs panel shows a task progress bar while implementing.
- Improvement: New MCP tools `run_instance_query`, `close_instance` and `stop_software_factory`, `resolve_designer_dialog` for the "Underlying metadata files have changed" prompt, `forceReinstall` on `install_or_update_modules`, and `location` on `create_solution` to add a separate solution in a repository subfolder.
- Improvement: `run_software_factory` applies its own output in Staging mode unless a change is destructive, and agents' file edits are written straight to disk. Designer schema, script and search payloads are more compact to use fewer tokens.
- Improvement: An agent must read a designer's rules before changing it, and rules from an application's `.agents/instructions` are included in agent prompts.
- Improvement: Software Factory errors that are logged now show the same typed error cards as thrown ones.
- Improvement: Module install, update, uninstall and restore are queued one at a time per Intent Architect instance.

### Fixes in 5.4.0

- Fixed: Failed solution-level tasks now start an AI fix chat when auto-fix is on, instead of being skipped silently.
- Fixed: AI turns are no longer ended or flagged as unresponsive because of silence, and now run until the agent finishes, errors or you press Stop.
- Fixed: Picking a named session branch that is already checked out in another worktree is now refused up front.
- Fixed: Re-opening a pull request review whose tab was already open always reloaded it, losing scroll position, expanded files and unsaved text.
- Fixed: MCP designer calls could time out, or report that the solution was no longer open, on large solutions.
- Fixed: Chats waiting on your input could keep the machine awake.
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
- Fixed: AI designer tools could be refused on a tab after a module install, and renaming a package from an AI script could raise a "Rename underlying file?" prompt that blocked it.
- Fixed: An AI designer save could report success while the designer was still loading and save nothing.
- Fixed: A chat's turn could read another chat's solution, including one from a deleted worktree.
- Fixed: Moving a chat into an existing worktree could refuse its first turn.
- Fixed: Deleting a chat could remove a worktree that another chat was still working in.
- Fixed: Opening plan, spec or review views from a chat that wasn't on screen could steal focus or switch your active tab.
- Fixed: A Module Task dialog could fail to complete or close after a transient error.
- Fixed: Un-ignoring a deleted file in Source Control gave an error.
- Fixed: Single-file diff tabs showed the wrong file-type icon.
- Fixed: A chat busy in another folder could make a spec show as busy.
- Fixed: Opening Codebase Structure or another designer could leave its tab marked as having unsaved changes, so a later external change raised "Underlying metadata files have changed" instead of reloading.
- Fixed: A module install or update could leave a clean designer tab marked dirty, or raise a false "unsaved changes" prompt that blocked every AI designer tool.
- Fixed: Changing application settings from an agent only reached open designers after they were closed and reopened, and could re-save every package.
- Fixed: Saving a designer for the first time rewrote files written by a module install.
- Fixed: Opening a diagram could mark it as edited, and diagram boxes could be lost when a referenced package reloaded.
- Fixed: Package references added by path from a script could adopt another package's model.
- Fixed: After a module update, designer settings and scripts stayed those of the old module until Intent Architect restarted.
- Fixed: An AI script could leave a designer unresponsive so that saves never finished and the next chat message never started.
- Fixed: A failed Software Factory run kept its lock, so later module installs for that application timed out.
- Fixed: Save All could hang when it restarted the Software Factory during staging.
- Fixed: Software Factory runs could use another application's older stereotype definitions for a shared module package.
- Fixed: A template's relative output location could be placed outside the repository when the `.isln` had no `<workspaceRoot>`.
- Fixed: A chat docked in a window for one solution could be pinned to another solution under the same repository root, and every tool call was then refused.
- Fixed: Approving a plan could overwrite the agent's current plan, or save a rich plan as plain Markdown after a refused skill load.
- Fixed: Skills present in both `.agents/skills` and an agent's own folder couldn't be loaded natively by that agent.
- Fixed: A follow-up round of a question form showed the previous round's answers and no Send button.
- Fixed: AI summaries could fail for Cursor models, and abandoned summary sessions left `claude` processes running that delayed later summaries.
- Fixed: Intent AI models and the Providers section were shown for accounts without an Intent AI key.
- Fixed: `grep` and Search over folders containing packages and DLLs could run for minutes.
- Fixed: Opening a file diff straight after an agent wrote to it could show the plain file, and diffs could fail while an agent was rewriting files.
- Fixed: Remote and tracking branch reads could fail for repositories with negative refspecs, and stash and notes refs could appear as branches in Source Control history.
- Fixed: Commit could be triggered twice by a double-click while Source Control re-checked what to commit.
- Fixed: "Resolve with AI" could leave the previous tab's view drawn over the new chat.
- Fixed: Staged pull request comments with a path and no line weren't treated as file-level comments.
- Fixed: Saved files in Windows folders could fail to write or be locked when another program, such as the Doc Viewer, was reading them.
- Fixed: On macOS, a dock click during startup could open a second main window and leave a splash screen running indefinitely.
- Fixed: On macOS, own-window dialogs could resize as they appeared or never return their result.
- Fixed: The Codebase Explorer could hide every folder on Linux and macOS once indexing finished.
- Fixed: Tool call results from Kiro could show the wrong text, and failed tool calls were not always shown as failed.
- Fixed: The Template Manager threw an error for a template with no published version; it now shows a clear message.
