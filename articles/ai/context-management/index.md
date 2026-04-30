---
uid: ai.context-management
---
# Agent Context Loading

How Intent's AI agents discover the files that shape their behavior — agent definitions, instruction files, and skills — and where each type is loaded from at runtime.

## The two contexts: `coding` vs `modeling`

Every agent declares a `context` in its frontmatter (`coding`, `modeling`, or `both`). The context decides **which folders Intent searches** when assembling the agent's runtime context.

| Context    | Root folder for context files                                |
| ---------- | ------------------------------------------------------------ |
| `coding`   | The application's **output folder** — the codebase Intent has generated for it |
| `modeling` | The folder containing the **`.solution` file** — the modeling workspace |
| `both`     | Both roots are searched                                      |

Modeling-time files live alongside the solution. Code-time files live alongside the generated code. An agent only sees the files for its declared context — a modeling agent will never see files in the application's output folder, and vice versa.

---

## Folder Structure

The fastest way to understand context loading is to see the folder layouts for each context. Everything below is automatic — drop the right files in the right places and they're picked up.

### Modeling layout

A modeling agent running in the context of a solution at `~/MySolution/` will read context files in the following structure:

```
~/MySolution/intent
└── .agents/
│   ├── AGENTS.md                       ← always loaded into the system prompt
│   ├── INTENT.md                       ← always loaded into the system prompt
│   ├── agents/
│   │   └── reviewer.agent.md           ← appears in the agent dropdown
│   ├── instructions/
│   │   ├── style-guide.md              ← always loaded (no frontmatter)
│   │   └── api-rules.md                ← only loaded when an attachment matches its `applyTo`
│   └── skills/
│       └── data-modeling/
│           └── SKILL.md                ← listed for on-demand loading
└── MySolution.isln                     ← the `.isln` file for the solution
```

### Coding layout

A coding agent for the same solution, with the application's output at `~/MySolution/MyApp/`, will read as follows:

```
~/MySolution/MyApp/
├── CLAUDE.md                           ← always loaded
├── AGENTS.md                           ← always loaded
├── .cursorrules                        ← always loaded
├── .github/
│   ├── copilot-instructions.md         ← always loaded
│   └── instructions/
│       └── *.instructions.md           ← always loaded (or scoped by `applyTo`)
├── .claude/
│   ├── rules/*.md                      ← always loaded (or scoped)
│   └── skills/<skill>/SKILL.md         ← listed for on-demand loading
├── .cursor/
│   └── rules/*.md, *.mdc               ← always loaded (or scoped)
└── .agents/
    ├── instructions/*.md               ← always loaded (or scoped)
    └── skills/<skill>/SKILL.md         ← listed for on-demand loading
```

These coding-side conventions match the dotfile layouts used by Claude Code, GitHub Copilot, Cursor, and Intent — so existing repo-level guidance keeps working out of the box.

---

## 1. Agent definitions (`*.agent.md`)

These are the agents shown in the chat dropdown.

**Where they come from** (later wins on `id` collision):

1. **Built-ins** — shipped with Intent.
2. **Per-solution overrides** — `{solutionFolder}/.agents/agents/*.agent.md`.

The agent's `id` is the filename minus `.agent.md`. Drop a file with the same name into `.agents/agents/` to override a built-in (for example, drop `coding.agent.md` to override the built-in `Coding` agent for that solution).

### Frontmatter (YAML)

```yaml
---
name: My Agent
description: What this agent is for
icon: fa-magic                # optional Font Awesome icon for the dropdown
context: [modeling]           # "coding", "modeling", or both ["coding", "modeling"]
tools:
  - read_file
  - grep
maxIterations: 8              # how many tool-call rounds the agent may take
loopOnToolCalls: true         # whether the model is invoked again after each tool call
---
```

The markdown body becomes the agent's **system prompt** — write it as instructions for the model.

---

## 2. Instruction files

Plain markdown files (with optional YAML frontmatter) that get injected into every turn of the agent's system prompt under an `<instructions>` block.

### Modeling context — under `{solutionFolder}/.agents/`

| Path                  | Glob              |
| --------------------- | ----------------- |
| `instructions/`       | `*.md`            |
| `AGENTS.md`           | *(single file)*   |
| `INTENT.md`           | *(single file)*   |

### Coding context — under the application's output folder

| Path                                  | Glob                  |
| ------------------------------------- | --------------------- |
| `.github/instructions/`               | `*.instructions.md`   |
| `.claude/rules/`                      | `*.md`                |
| `.agents/instructions/`               | `*.md`                |
| `.cursor/rules/`                      | `*.md` and `*.mdc`    |
| `CLAUDE.md`                           | *(single file)*       |
| `.github/copilot-instructions.md`     | *(single file)*       |
| `.cursorrules`                        | *(single file)*       |
| `AGENTS.md`                           | *(single file)*       |

### Optional frontmatter

```yaml
---
description: One-line summary
alwaysApply: false
applyTo:
  - "**/*.cs"
  - "src/api/**"
---
```

| Field                                          | Meaning                                                                |
| ---------------------------------------------- | ---------------------------------------------------------------------- |
| `description`                                  | Human-readable summary                                                 |
| `alwaysApply`                                  | If `true`, included regardless of patterns or attachments              |
| `applyTo` / `appliesTo` / `globs` / `paths`    | Glob list — only included when a chat attachment matches one of these   |

**Glob behavior:**

- `**` — any characters, including `/`
- `*` — any characters except `/`
- `?` — single character except `/`

**Applicability rules**, in order:

1. `alwaysApply: true` → included.
2. No patterns set → included (frontmatter is optional).
3. Patterns set → included only if at least one of the chat's attachments matches.

> **Files without frontmatter are always included.** That's why `AGENTS.md`, `INTENT.md`, `CLAUDE.md`, and similar are reliably picked up on every turn.

---

## 3. Skills

Skills are bundles of focused, reusable instructions invoked on demand — for example, "use the `database-migration` skill to plan this change." Each skill lives in its own folder containing a `SKILL.md`:

```
.agents/skills/
└── database-migration/
    ├── SKILL.md          ← required, with frontmatter
    └── …support files
```

**`SKILL.md` frontmatter:**

```yaml
---
name: database-migration
description: Plan and execute a safe DB migration with rollback
---
```

The markdown body is the instruction content that gets loaded when the skill is activated.

### Where skills are searched

| Context    | Folders searched (first hit per skill `name` wins)                                          |
| ---------- | ------------------------------------------------------------------------------------------- |
| `modeling` | `{solutionFolder}/.agents/skills/`                                                          |
| `coding`   | `{appOutputFolder}/.claude/skills/`, `.github/skills/`, `.agents/skills/`                    |

If the same skill name exists in multiple folders, the first one wins — so a skill in `.claude/skills/foo/` shadows one in `.agents/skills/foo/` for coding agents.

### How a skill ends up in the prompt

There are three ways a skill becomes active for a turn:

1. **Manifest only** — every discovered skill is listed (name + description) in the system prompt, telling the agent it *could* request the skill.
2. **`use_skill` tool call** — the agent calls the always-available `use_skill` tool with the skill's name. The skill body (i.e. the `SKILL.md` file excluding its frontmatter) is loaded and included in the next turn.
3. **Slash command** — if the user's chat message contains `/skill-name` (matching a discovered skill), that skill is auto-loaded for the turn — no tool call needed.

---

## Summary

- **Modeling files** live under `{solutionFolder}/.agents/` — agent definitions, instructions, skills, and the always-loaded `AGENTS.md`/`INTENT.md`.
- **Coding files** live under each application's output folder, using the dotfile conventions of Claude Code, GitHub Copilot, Cursor, and Intent.
- **Instructions without frontmatter are always loaded.** Use `applyTo` patterns when you want to scope an instruction file to particular file attachments.
- **Skills are opt-in.** They're advertised in the prompt but only loaded when the agent explicitly requests them or the user invokes them with `/skill-name`.
