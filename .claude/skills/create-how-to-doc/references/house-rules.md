# How-to guides: house rules

These rules bind every guide written with the `create-how-to-doc` skill. They come from the first guide, "Work across related codebases". That plan was executed faithfully, but it pushed the writing agent towards content and habits that took about fifteen rounds of review to unpick. Each rule below exists because of something that happened in that run. Where the topic's plan and these rules disagree, the plan wins for that topic only.

## 1. Terminology

- **Solution Shell** and **Agents Shell**. Never "Solution window" or "Agents window". **Manage Agents** is the button that opens the Agents Shell. The concept page is `xref:application-development.user-interface.agents-shell-and-solution-shell`; link to it rather than re-explaining the shells.
- The Solution Shell is **workspace-oriented**: one solution, its folders and the Git repositories they're in. The Agents Shell is **repository-oriented**: each conversation runs in one folder of one Git repository, or a worktree of it.
- Use the pane names **Codebase** and **Source Control**, and say **Git repository**, never a bare "repository". The docs already use "Repositories" for Asset Repositories (module feeds).
- Use the exact UI label, in **bold**, for anything the reader clicks.

## 2. What goes in a guide

- **Write as a developer using AI, not as Intent Architect describing itself,** throughout the guide, not just in the opening.
- **The opening has its own method: see §2a.** It was the hardest part of the first guide, so do it before anything else.
- **Relevance filter.** Include a fact only if a typical reader doing this task would act differently because of it. Leave out internal mechanics, discovery rules, rare edge cases and design trivia. When in doubt, leave it out and list it under "Left out" in the report. Adding something back is cheap; deleting irrelevant content cost several review rounds.
- **No "Before you start" section.** If something genuinely blocks the reader, put a `> [!NOTE]` at the step where they'd hit it.
- **Limitations: only limits a reader will actually hit while doing this task.** At most about three, each saying what to do instead. Don't dress design facts up as limitations. If there are none, there's no section.
- **No version numbers anywhere.** The docs assume the latest stable release. Ignore the "introduced in" notes you'll see on some older pages.
- **Put a nuanced scenario in one place only.** It belongs in the guide that's about it. Anywhere else, use a `> [!TIP]` with a link.
- **Explain an unfamiliar concept in a sentence or two where it's first needed,** then link out. Many users new to AI don't know what a Git worktree is, for example.
- **Every prompt shown must have been run.** Say what actually happened.
- **Shape:**
  - Headings are statements, never questions (`guidelines.md`).
  - Use a few substantial sections. No one-line sections, and no tables listing menu items or toolbar buttons.
  - Each H2 names its feature and shell so it makes sense when the in-app agent retrieves it alone. That's no reason to pad.
- **Length:** a guide is about 500–900 words; a concept or reference page about 300–700.
- **Existing pages:** don't restructure or rename terms in them. If the plan allows fixes, make line-level fixes only, and list each one in the report.

## 2a. The opening (work it out before writing anything else)

The opening is the hook. It decides whether the reader carries on, and it's the paragraph Customer Success pastes into emails.

### Method

1. **Write the reader's job in one sentence, in their words.**
   - List every way the feature serves that job. In the first guide that was reading code for context **and** changing it.
   - List every setup it works in. In the first guide, any folder, not only another Git repository.
2. **Research how three comparable products describe their equivalent feature,** for example the VS Code, Claude Code, GitHub Copilot or Cursor docs. Add Diátaxis for how-to intros. Note how they phrase what's in it for the reader, and keep the links.
3. **Write five candidate openings in different styles:**
   - "If you want X, do Y";
   - a developer scenario;
   - a plain feature plus benefit;
   - goal-first ("This guide shows you how to…");
   - a short AI-tool style.
4. **Check each against the checklist below,** rank them, and take them to the approval gate (or, with no gate, use the best one). Keep all five in the plan and the report.
5. **Derive everything else from the chosen opening.** The title, the front-matter `description` and the `src/how-to-guides/index.md` link line must describe the same scope in the same voice. In the first guide they drifted apart, and the landing page had to be redone.

### Checklist

The opening must:
- start from the reader's goal or situation, in words a developer who uses VS Code or Claude Code would recognise;
- say what's in it for them in the first sentence;
- cover every way the feature serves this job, and assume no particular setup;
- contain no Intent internals (the model, the Software Factory, generated code, designers) unless the guide is about them;
- not present an exception as the norm, and contain no hype words ("rarely", "seamlessly", "powerful", "supercharge");
- be 1–2 sentences, plus an optional roadmap line ("This guide shows how to…");
- work on its own as an email blurb.

### Openings rejected for the first guide

> ❌ When your system is split across Git repositories, such as an API in one, a web frontend in another and a shared library in a third, you can still work on all of it from one Intent Architect solution.

It assumes a setup the feature doesn't need (several Git repositories) and leads with Intent Architect.

> ❌ A change rarely stops at your Intent Architect solution. Adding a field to an API usually means updating the frontend that calls it…

It presents the exception the guide is about as the usual case.

> ❌ Sometimes a change reaches past your Intent Architect solution: … The AI agent can then make the whole change in one conversation, across your model, your generated code and the related code…

It uses Intent internals (model, generated code) and only covers changing code, not reading it for context.

### The opening accepted for the first guide

> ✅ If the agent needs code that isn't part of your solution, such as a frontend, a shared library or another service, add its folder to your workspace. The agent can then read it for context or change it as part of the same task, and you review and commit everything from the same place.

It puts the reader's need first, covers both uses, assumes no setup, and has no internals.

**Landing page:** the intro is "Each guide here shows you how to do one thing in Intent Architect, in a short set of steps." Each guide's link line follows the pattern `- [Title](xref:…) - <what the reader gets, in the opening's voice>`.

## 3. Reference and concept pages

- **Explain what the thing is for and the main jobs it supports,** in 3–5 sections. Don't inventory every control. The first reference drafts had context-menu and toolbar tables, and were rejected.
- **Concept gaps:** if a guide leans on a concept with no page, propose one at the approval gate as a three-line outline. Write it only if it's approved.
- **Put supporting pages where the topic belongs** (for UI panes and shells, `src/application-development/user-interface/`), keep that TOC alphabetical, and link both ways with the guide.

## 4. Screenshots

- **Capture setup:** `--docs-mode` and presentation mode (`guidelines.md`). Match the theme of recent release-note images. Annotate with `.agents/skills/annotate-screenshot` in Azure Blue `#06C4FF`.
- **4–6 shots per guide.** Each must show something the text tells the reader to find.
- **Navigation shot:** if the task starts somewhere the reader has to find (a shell, a pane, the Home screen), include a shot of where to click, or link to a page that has one.
- **Privacy: the dev instance runs on the developer's real profile.**
  - It shows their real Home recent list, Agents board, chat history, and user or worktree paths with their name in them.
  - Before every capture, filter lists to the sample with the app's own search boxes, crop, and check every pixel against the off-limits list from the interview.
  - Never change a user setting to hide something.
  - Customer names must never appear.
- **Native OS menus and dialogs can't be automated.** List them as human-capture shots with exact steps in the report, and carry on with the rest.

## 5. Sample

- **Default sample: `D:\DocSource\Acme`** (ask if it's somewhere else).
  - `acme-api`: a Git repository holding `intent\Acme.isln`, a .NET Clean Architecture app with `Customer` and `Order`.
  - `acme-web`: a separate Git repository holding a small frontend, added to the solution as a workspace folder.
- **If it doesn't exist, create it:**
  1. Create the solution in the dev instance's UI.
  2. Have the dev instance's own agent model the two entities, then run the Software Factory and apply.
  3. `git init` and commit both repositories.
- **You may commit in the sample repositories** when the flow needs it. The no-commit rule (§8) is about the docs repo.
- **Name every chat you create `Acme · <what it does>`,** so it's easy to find and filter.

## 6. Facts and evidence

- **The plan's facts are leads.** In the first guide about ten of them were wrong.
- **Confirm every claim** in the product code (`file:line`) and, for anything a user sees, in the running app.
- **Keep a claims checklist** in the working folder: claim → evidence.
- **If you can't confirm something, leave it out.** Release notes are leads, not sources.

## 7. Session and tooling

- **Root the session in the docs repo.** Its Playwright MCP drives Edge, which you use to check the docs site.
- **Drive the dev Intent Architect instance with `scripts/ia.cjs`.** See `references/driving-the-app.md`.
- **The product repo is read-only:** read and build only.
  - Build from the latest stable release branch (`release/<major.minor>.x`).
  - If the checkout is on another branch or has uncommitted source changes, build in a separate worktree.
- **When you finish, leave the dev instance and the docs server running.**

## 8. Git

- **Never commit, amend, squash or push unless the developer asks.** Leave every change uncommitted in the working tree. Committing after every review round, while the developer was still reviewing, was the most irritating habit in the first run.
- **Create the topic branch `feature/how-to-<slug>` before you start.**
  - Base it on `master` if `src/how-to-guides/` is already there.
  - Otherwise base it on the newest unmerged `feature/how-to-*` branch, so the section exists.
- **Don't commit stray `grep.exe.stackdump` files.**

## 9. Build and verify

1. Run `.\_build.ps1`. There must be no new warnings for your files and every `xref:` must resolve. Local `modules-*` TOC errors are expected.
2. Run `.\_build_agent_markdown.ps1` and check that your pages appear in `_site/docs-md/`.
3. Serve the site (`.\_build_and_serve.ps1`, in the background) and check the pages with the docs Playwright MCP at widths 1100 and 390.
4. Run markdownlint on the files you touched only.
5. Retrieval self-test: read each H2 on its own, as the in-app agent would, and fix any that don't stand alone.

## 10. Report

Keep the report short and scannable:

1. **Files** created or changed (uncommitted), and the branch.
2. **Product build** used: branch and commit.
3. **Opening:** the five candidates with their sources, the one used, and the matching title, description and landing-page line.
4. **Left out:** facts you confirmed but deliberately left out, one line each, so the developer can add any back.
5. **Claims checklist** path, plus claims dropped for lack of evidence.
6. **Screenshots:** the final images, plus human-capture shots with exact steps.
7. **Concept gaps** and **outdated statements** in existing pages, with `file:line`.
8. **Product feedback** found on the way: bugs, stale code comments, missing automation facades.
9. **Where the plan was wrong.**
10. **Side effects:** chats created, recent solutions added, anything still running.

## 11. Revision rounds

- **Change only what the feedback names.** Don't broaden it or reinterpret it. In the first guide, "it's not just multi-repo" became monorepo framing throughout, and that was rejected too.
- **For tone and framing feedback** (opening, hook, landing-page blurb), don't rewrite on your own guess. Rerun the §2a method and offer options before editing. Once one is picked, update the description and landing-page line to match in the same change.
- **One change at a time.** Don't make a second edit while the developer is still reviewing the first. If you have to, show the net diff of both.
- **Keep revision replies short:** what changed and where. No commits.
