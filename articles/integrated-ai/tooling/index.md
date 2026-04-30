---
uid: ai.tooling
---
# Agent Tools

Tools are the actions an agent can take during a turn — reading files, querying the model, building a project, asking the user a question, and so on. An agent only sees the tools listed in its `tools:` frontmatter, plus the always-available `use_skill` tool.

This document lists every built-in tool, what it does, and where it makes sense to use it.

---

## Quick lookup by purpose

| Want to…                                  | Use                                                                                  |
| ----------------------------------------- | ------------------------------------------------------------------------------------ |
| Find files by name pattern                | [`glob`](#glob)                                                                      |
| Search file contents (regex)              | [`grep`](#grep), [`search_files`](#search_files)                                     |
| List a folder's contents                  | [`list_directory`](#list_directory)                                                  |
| Get a high-level project overview         | [`get_project_overview`](#get_project_overview)                                      |
| Read a source file                        | [`read_file`](#read_file)                                                            |
| Write a whole file                        | [`write_file`](#write_file)                                                          |
| Patch a block inside a file               | [`patch_file`](#patch_file)                                                          |
| Delete a file                             | [`delete_code_file`](#delete_code_file)                                              |
| Apply staged changes to disk              | [`apply_staged_file_changes`](#apply_staged_file_changes)                            |
| Build a .NET project                      | [`dotnet_build`](#dotnet_build)                                                      |
| Run .NET tests                            | [`dotnet_test`](#dotnet_test)                                                        |
| Run a configured task                     | [`run_task`](#run_task)                                                              |
| Read the Intent designer model            | [`get_designer_model_snapshot`](#get_designer_model_snapshot)                        |
| Read details for a model element          | [`get_designer_element_details`](#get_designer_element_details)                      |
| Read a designer diagram                   | [`get_designer_diagram_snapshot`](#get_designer_diagram_snapshot)                    |
| Search the model with regex               | [`find_designer_elements`](#find_designer_elements)                                  |
| Modify the designer model                 | [`apply_change_model_operations`](#apply_change_model_operations)                    |
| Modify a diagram's layout                 | [`apply_change_diagram_layout`](#apply_change_diagram_layout)                        |
| Run an existing designer action           | [`execute_designer_element_action`](#execute_designer_element_action)                |
| List a designer's package references      | [`get_designer_package_references`](#get_designer_package_references)                |
| Run the Software Factory and stage changes | [`run_software_factory`](#run_software_factory)                                     |
| Hand off work to a coding-agent task tab  | [`create_ai_task`](#create_ai_task)                                                  |
| Search Intent / org documentation         | [`search_docs`](#search_docs)                                                        |
| Ask the user a question (multi-choice)    | [`ask_user_question`](#ask_user_question)                                            |
| Track progress with a todo list           | [`todo_update`](#todo_update)                                                        |
| Iterate on a written plan                 | [`write_plan`](#write_plan)                                                          |
| Request approval to implement a plan      | [`implement_plan`](#implement_plan)                                                  |
| Load a skill on demand                    | [`use_skill`](#use_skill)                                                            |

---

## Notes on context

Tools aren't tied to a specific context — `coding` and `modeling` agents can pick from the same toolbox. In practice, certain tools only make sense in certain contexts:

- **Designer tools** (`get_designer_*`, `find_designer_elements`, `apply_change_*`, `execute_designer_element_action`, `run_software_factory`) work against the Intent model, so they belong in **modeling** agents.
- **File-mutation tools** (`write_file`, `patch_file`, `delete_code_file`, `apply_staged_file_changes`, `dotnet_build`, `dotnet_test`, `run_task`) operate on the application's output codebase, so they belong in **coding** agents.
- **File-search tools** (`grep`, `glob`, `read_file`, `list_directory`, `get_project_overview`, `search_files`) operate on the application's output codebase and work in both contexts.
- **Conversation tools** (`ask_user_question`, `todo_update`, `use_skill`) work in any context.
- **Plan-mode tools** (`write_plan`, `implement_plan`) are only meaningful for planning agents.

> A tool's "context" is determined by which agents you list it in — there's no automatic enforcement.

Most tools require an `applicationId` parameter to identify which application's output folder or designer model to act on. Most also require a short `intention` string explaining *why* the tool is being called — this is shown to the user as a one-line summary of the action.

---

## Adding tools to an agent

Tools are wired up in an agent definition's frontmatter. Only listed tools are available — and `use_skill` is always added on top:

```yaml
---
name: My Reviewer
context: modeling
tools:
  - search_docs
  - get_designer_model_snapshot
  - find_designer_elements
  - read_file
  - grep
  - ask_user_question
maxIterations: 8
---

You are a model reviewer…
```

If a tool name doesn't match a known tool, it's silently skipped at startup.
