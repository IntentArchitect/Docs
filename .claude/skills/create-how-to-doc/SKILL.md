---
name: create-how-to-doc
description: "Use when asked to write, create or plan a new How-to guide for the Intent Architect docs (src/how-to-guides/), or when /create-how-to-doc is run. Interviews the developer about what the guide is for, researches the product code and the existing docs, writes a plan, gets the scope and opening approved at one gate, then builds the guide end to end: sample setup, driving the dev Intent Architect instance, screenshots, writing, build and verification, and a report. Not for release notes, What's New articles or editing an existing guide."
---

# Create a How-to guide

This skill produces one How-to guide for `src/how-to-guides/`, from a one-line idea to a built, verified page. Any small reference or concept pages the guide needs come with it.

It runs in five phases with **one approval gate**:

1. Interview → 2. Research and plan → **gate** → 3. Build → 4. Report → 5. Revision rounds.

**Read `references/house-rules.md` before Phase 2. It's binding.** It covers terminology, what goes in a guide, the opening method, screenshots and privacy, evidence, Git and the report format. Each rule there exists because something went wrong in an earlier run.

Use whichever ask-question tool you have for structured questions: Intent Architect's `ask_user_question`, or Claude Code's `AskUserQuestion`. Use plain chat only for open questions with no set of answers.

## Phase 1: Interview the developer

Find out what the guide is for before you research anything.

**If the developer passed a topics document** (a list of planned guides with notes), find the matching entry and treat its notes as the starting point. Confirm what it already answers rather than asking again.

1. **Open question, in chat, if the invocation didn't already say it:** "What should a reader be able to do after reading this guide, and in what situation would they look for it?" Also ask for any terms they use for the feature, and anything they know must or mustn't be in it.
2. **Then one structured question round:**

   | Question | Options |
   |----------|---------|
   | **Who reads it** | Developers new to Intent Architect · Experienced users · Both (recommended unless the topic says otherwise) |
   | **How to run** | Plan, then build after my approval (recommended) · Plan only · Build straight through (no gate) |
   | **Working folder** for the plan, claims checklist and raw screenshots, outside the docs repo | OS temp `how-to-docs/<slug>/` (recommended) · A folder I'll name |
   | **Sample** | Reuse the existing sample (default `D:\DocSource\Acme`) (recommended) · Create a fresh one · Use a folder I'll name |

3. **Ask which folders on this machine are off-limits** for opening and screenshots, such as customer work. **Never assume none.** Note the answer in the plan's privacy section.

## Phase 2: Research and write the plan

Do this read-only, then write `plan.md` in the working folder from `references/plan-template.md`.

1. **Find the product code.**
   - The docs solution `intent/Intent.Docs.isln` usually has the Intent Architect product repository added as a workspace folder. It's the `<folder path=…>` entry that contains `Intent.IntentArchitect`.
   - If it isn't there, ask the developer for the product repository path.
   - The product repo is **read-only** for this whole skill.
2. **Map the feature.** Spend 20–40 minutes, and use read-only sub-agents for broad searches. Collect:
   - verbatim UI labels and where they appear;
   - which shell the feature lives in;
   - what the agent can and can't do with it;
   - the real blockers a reader will hit.
   - Record everything as **leads to confirm**, with `file:line`, never as facts.
3. **Map the existing docs.**
   - Which pages already cover this, and what they say.
   - Statements the code contradicts, with `file:line`.
   - Which concepts the guide leans on that have no page (concept gaps).
4. **Work out the opening first.** Follow house rules §2a: the reader's job, research three comparable products, five openings, the checklist, three title options. Work out the description and the `index.md` link line to match.
5. **Write the plan,** from `references/plan-template.md`:
   - the reader's job and the uses to cover;
   - an outline (H2s, one line each);
   - in and out of scope, with a "probably left out" list;
   - deliverables, including any supporting or concept pages, and line-level fixes to existing pages;
   - the leads;
   - the sample and flow;
   - the shot list, marking any native-menu shots that need a human to capture them;
   - privacy specifics;
   - topic pitfalls.

### The approval gate

Unless the developer chose "Build straight through", stop here:

1. Give a short summary in chat: the reader's job, the outline, what's left out, deliverables, the time estimate (usually 1–2 hours, mostly the app run), and the plan's path.
2. Ask **one** structured question round:

   | Question | Options |
   |----------|---------|
   | **Opening** | Your top four of the five openings (put all five in the plan) |
   | **Title** | The three title options |
   | **Scope** | Build as planned (recommended) · Change something first |
   | **Supporting pages** | Write the proposed pages (recommended if they're concept gaps the guide relies on) · Skip them for now |

3. If they chose "Plan only", stop after the gate. The plan is the deliverable.

## Phase 3: Build

Work autonomously from here. Ask nothing more unless a house rule says to.

1. **Branch.** Create `feature/how-to-<slug>` in the docs repo (house rules §8 says which base to use). **Never commit, amend, squash or push** unless the developer asks.
2. **Dev instance.**
   - Build the product's Electron client from the latest stable release branch, following `references/driving-the-app.md`. That file points at the product repo's `drive-intent-with-playwright` skill.
   - Launch it with `--docs-mode` and the inspector port.
   - Turn on presentation mode in every renderer.
   - Drive it with `scripts/ia.cjs`.
3. **Sample.** Set up or reuse it as the plan says, naming every chat `Acme · <what it does>`. Run the flow the way a user would, and confirm every lead in the app as you go. Keep the claims checklist in the working folder.
4. **Screenshots.**
   - Capture to the working folder.
   - Check each one for privacy against the plan's off-limits list, the Home recent list, the Agents board, chat history and user paths.
   - Annotate with `.agents/skills/annotate-screenshot`.
   - Only then copy it into the page's `images/`.
   - Native OS menus and dialogs go on the human-capture list. Carry on without them.
5. **Write.** Write the guide with the approved opening and title, then any approved supporting pages and line-level fixes. Update `src/how-to-guides/toc.yml` (alphabetical) and `src/how-to-guides/index.md` (one link line in the agreed pattern).
6. **Verify** (house rules §9):
   - `_build.ps1` with no new warnings;
   - every `xref:` resolves;
   - the agent-markdown export includes the pages;
   - a check on the served page at widths 1100 and 390;
   - markdownlint on the files you touched;
   - the retrieval self-test (each H2 read on its own);
   - every claim backed by the claims checklist.
7. **Leave things running:** the dev instance and the docs server.

## Phase 4: Report

Use the format in house rules §10: short and scannable. It includes the "Left out" list and the human-capture steps.

## Phase 5: Revision rounds

Follow house rules §11:
- change only what the feedback names;
- for tone or framing, rerun §2a and offer options;
- one change at a time;
- short replies;
- no commits.
