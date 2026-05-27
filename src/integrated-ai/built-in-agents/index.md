---
uid: ai.built-in-agents
description: "Intent Architect's four built-in AI agents — Ask, Plan, Agent, and Coding — covering what each does, when to use it, and which tools it can access."
---
# Built-in Agents

Intent ships with four agents in the AI chat dropdown. Each one is purpose-built for a particular kind of work - read the table to pick the right one, then read the section below for details.

| Agent       | Context  | What it does                                                                 | When to pick it                                                       |
| ----------- | -------- | ---------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| **Ask**     | modeling | Read-only Q&A over the model and codebase                                    | "Explain this", "where is X used", "how does Y work"                  |
| **Plan**    | modeling | Iteratively writes a plan file, asks clarifying questions, requests approval | Larger or ambiguous changes you want reviewed before any work happens |
| **Agent**   | modeling | Designs and modifies the model directly via designer tools                   | Quick model edits where the change is clear                           |
| **Coding**  | coding   | Reads, writes, patches, and deletes source files                             | Hand-written code changes inside an application's output              |

> The first three are **modeling** agents - they operate on Intent designers (which are the source of truth). **Coding** operates on a generated application's source code. See [Agent Context Loading](xref:ai.context-management) for what that distinction means in practice.

---

## Ask

A read-only assistant for understanding the current solution. It can inspect designers, diagrams, and code, but it cannot change anything.

- **Use when:** you want to understand how something works, find where a concept is used, or get a written explanation. Quick orientation before deciding what to change.
- **Behavior:** answers from the **model first**; only reaches into code for questions about runtime behavior or implementation logic.
- **Tools:** model snapshots, element details, diagram snapshots, model search, plus `read_file`/`grep`/`glob` for code-level questions, plus `search_docs` for product docs.

---

## Plan

Plan mode is for changes large enough to want a written plan before anyone touches the model or the code. It runs in a strict read-only loop and writes a markdown plan file you can review (and edit) live.

- **Use when:** the change has architectural implications, has open questions, spans multiple designers, or you'd just like to think it through with the agent before committing.
- **Behavior:** explores the model and code, asks 1–4 multi-choice clarifying questions when judgement calls are needed, iteratively updates the plan file in a side panel, and finally calls `implement_plan` to request your approval. On approval, the plan is handed off to the implementation agent.
- **Plan template:** Context → Approach → Model changes → Code changes (if any) → Steps → Verification → Open questions resolved.
- **Tools:** all of Ask's read tools, plus `write_plan`, `ask_user_question`, and `implement_plan`.

---

## Agent

The default modeling agent for direct edits. It applies changes through designer tools - never by editing generated code by hand.

- **Use when:** the change is clear and you want to skip the planning step.
- **Workflow:** Analyze → Design → Apply → Verify. It groups related operations into a single batched call where possible, then verifies the designer is rule-clean afterwards.
- **Won't:** run the Software Factory unless you explicitly ask it to. (Use the Software Factory panel, or ask explicitly.)
- **Tools:** model and diagram inspection, model search, `apply_change_model_operations`, `apply_change_diagram_layout`, `execute_designer_element_action`, plus read-only code tools.

---

## Coding

The coding agent works inside an application's output folder - reading, writing, patching, and deleting source files. It runs against the generated codebase, not the designer model.

- **Use when:** you need hand-written code changes that aren't expressed in the model - a custom service implementation, a bug fix in a partial file, a refactor of generated extensions.
- **Behavior:** reads files before modifying them, prefers `patch_file` over full rewrites, preserves existing code style, and only invokes `run_task` / `apply_staged_file_changes` when explicitly asked to fix build/task errors.
- **Tools:** full file/codebase toolset (`read_file`, `write_file`, `patch_file`, `delete_code_file`, `grep`, `glob`, `list_directory`, `get_project_overview`), plus `run_task`, `apply_staged_file_changes`, and `create_ai_task` for spawning follow-up coding tasks.

---

## Customising or replacing built-ins

You can override any built-in by dropping a file with the same id (filename minus `.agent.md`) into your solution's `.agents/agents/` folder. For example, dropping a `coding.agent.md` there will replace the built-in **Coding** agent for that solution only.

You can also add brand-new agents the same way. See [Agent Context Loading](xref:ai.context-management#1-agent-definitions-agentmd) for the file format.

---

## See also

- [Agent Context Loading](xref:ai.context-management) - where Intent looks for agent definitions, instructions, and skills
- [Agent Tools](xref:ai.tooling) - the tools each agent can be configured with
- [AI Configuration](xref:ai.configuration) - providers, the Intent MCP server, and external MCP servers
