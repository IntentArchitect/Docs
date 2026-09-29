---
uid: ai.built-in-agents
description: "Intent Architect's built-in AI agents: Agent, Ask and Plan for modeling work, plus the Coding, Discovery and Spec Worker agents dispatched automatically."
---
# Built-in Agents

Intent Architect comes with a set of built-in agents. Some are selectable in the AI chat dropdown; the others are dispatched automatically by other agents and are never selected directly.

## Selectable in the chat

| Agent     | What it does                                                                 | When to select it                                                     |
| --------- | ---------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| **Agent** | Designs and modifies the model directly via designer tools                   | Quick model edits where the change is clear                           |
| **Ask**   | Read-only Q&A over the model and codebase                                    | "Explain this", "where is X used", "how does Y work"                  |
| **Plan**  | Iteratively writes a plan file, asks clarifying questions, requests approval | Larger or ambiguous changes you want reviewed before any work happens |

## Dispatched automatically

| Agent           | Context  | What it does                                                                  |
| --------------- | -------- | ----------------------------------------------------------------------------- |
| **Coding**      | Coding   | Reads, writes and modifies code in the current solution                       |
| **Discovery**   | None     | Read-only explorer - maps a model or codebase area and reports its findings   |
| **Spec Worker** | None     | Runs one phase of the guided spec flow by following the matching rules        |

These are invoked through `create_sub_agent` when an agent delegates a piece of work, so they carry out focused tasks without cluttering the main conversation. See [Agent Context Loading](xref:ai.context-management) for how modeling and coding contexts work behind the scenes.

---

## Agent

The default modeling agent for direct edits. It applies changes through designer tools - never by editing generated code by hand.

- **Use when:** the change is clear and you want to skip the planning step.
- **Workflow:** Analyze → Design → Apply → Verify. It groups related operations into a single batched call where possible, then verifies the designer is rule-clean afterwards.
- **Software Factory:** can run the Software Factory when needed. In "Bypass all permissions" mode it will run directly; otherwise it will ask for permission before running.
- **Tools:** model and diagram inspection, model search, `apply_change_model_operations`, `apply_change_diagram_layout`, `execute_designer_element_action`, plus read-only code tools.

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

## Coding (sub-agent)

The Coding agent is a sub-agent that the Agent can delegate to when implementation work is needed. It works inside an application's output folder - reading, writing, patching, and deleting source files. You don't select it directly; it's invoked automatically when coding tasks are delegated.

- **What it does:** handles hand-written code changes that aren't expressed in the model - custom service implementations, bug fixes in partial files, refactors of generated extensions, and other implementation work.
- **Behavior:** reads files before modifying them, prefers `patch_file` over full rewrites, preserves existing code style, and only invokes `run_task` / `apply_staged_file_changes` when explicitly asked to fix build/task errors.
- **Tools:** full file/codebase toolset (`read_file`, `write_file`, `patch_file`, `delete_code_file`, `grep`, `glob`, `list_directory`, `get_project_overview`), plus `run_task`, `apply_staged_file_changes`, and `create_ai_task` for spawning follow-up coding tasks.

---

## Discovery (sub-agent)

A read-only explorer dispatched when an agent needs to understand an unfamiliar area before acting on it. It maps the relevant part of the model or codebase and reports its findings back to the agent that dispatched it, without making any changes.

- **What it does:** surveys a specified area and returns a written summary, keeping exploration out of the main conversation.
- **Behavior:** read-only throughout. It cannot modify the model or the codebase.

---

## Spec Worker (sub-agent)

Runs a single phase of the guided spec flow - requirements, design, tasks, implementation, or verification - by following the rules that apply to that phase. The Specs panel dispatches it as work moves through each phase.

- **What it does:** executes one phase of a spec at a time, so a large feature is implemented in discrete, checkpointed steps rather than one long conversation.
- **See also:** [Spec-Driven Development](xref:application-development.spec-driven-development).

---

## Customising or replacing built-ins

You can override any built-in by dropping a file with the same id (filename minus `.agent.md`) into your solution's `.agents/agents/` folder. For example, dropping a `coding.agent.md` there will replace the built-in **Coding** agent for that solution only.

You can also add brand-new agents the same way. See [Agent Context Loading](xref:ai.context-management#1-agent-definitions-agentmd) for the file format.

---

## See also

- [Agent Context Loading](xref:ai.context-management) - where Intent looks for agent definitions, instructions, and skills
- [Agent Tools](xref:ai.tooling) - the tools each agent can be configured with
- [AI Configuration](xref:ai.configuration) - providers, the Intent MCP server, and external MCP servers
