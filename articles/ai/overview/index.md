---
uid: ai.overview
---
# Intent AI

Intent's built-in AI works in two **contexts**:

- **Modeling** — works against Intent designers (the source of truth) to plan, design, and modify the model.
- **Coding** — works inside an application's generated source code: reading, writing, patching, and refactoring files.

Each context has its own agents, its own folders for instructions and skills, and its own toolbox.

> **New here?** Start with [Built-in Agents](../built-in-agents/index.md) to see what ships out of the box, then connect a model in [AI Configuration](../configuration/index.md).

---

## Documentation

### Getting started
- **[AI Configuration](../configuration/index.md)** — connect to your AI provider (OpenAI, Anthropic, Azure OpenAI, Gemini, OpenRouter, Ollama, or any OpenAI-compatible endpoint), expose Intent as an MCP server, and add external MCP servers per solution.
- **[Built-in Agents](../built-in-agents/index.md)** — what **Ask**, **Plan**, **Agent**, and **Coding** each do, and when to pick which.

### Customising agents and context
- **[Agent Context Loading](../context-management/index.md)** — where Intent looks for agent definitions, instruction files, and skills. The `.agents/` folder under your solution and the dotfile conventions inside an application's output (`AGENTS.md`, `CLAUDE.md`, `.cursor/rules/`, `.github/instructions/`, etc.).
- **[Agent Tools](../tooling/index.md)** — every tool an agent can be wired up with: file ops, designer/model edits, build/test, planning, and conversation tools.

### Authoring (planned)
- **Authoring custom agents** *(coming soon)* — how to write a `.agent.md` file: choosing the context, picking tools, writing the system prompt, and iterating.
- **Writing skills** *(coming soon)* — `SKILL.md` format and conventions for reusable, on-demand instructions.
- **Writing instruction files** *(coming soon)* — how `AGENTS.md`, `INTENT.md`, `applyTo` patterns, and per-folder rules combine to shape every turn.

### Reference (planned)
- **Plan-mode workflow** *(coming soon)* — the iterative plan → review → implement loop in detail.
- **MCP integration** *(coming soon)* — how Intent exposes its own MCP server and how external MCP servers slot into coding-context agents.
- **Software Factory & staged changes** *(coming soon)* — how generation, staged file changes, and `apply_staged_file_changes` fit into the AI loop.

---

## At a glance

| You want to…                                          | Go to                                                                       |
| ----------------------------------------------------- | --------------------------------------------------------------------------- |
| Plug in your OpenAI / Anthropic / Azure key           | [AI Configuration → AI Providers](../configuration/index.md#1-ai-providers)        |
| Use Intent from Cursor / Claude Desktop / Copilot     | [AI Configuration → Intent MCP](../configuration/index.md#2-intent-mcp)            |
| Add an MCP server (filesystem, GitHub, etc.) for coding agents | [AI Configuration → MCP Servers](../configuration/index.md#3-mcp-servers)  |
| Pick the right agent for a task                       | [Built-in Agents](../built-in-agents/index.md)                                        |
| Drop a project-wide instruction file                   | [Agent Context Loading → Instruction files](../context-management/index.md#2-instruction-files) |
| Write a custom agent for this solution                 | [Agent Context Loading → Agent definitions](../context-management/index.md#1-agent-definitions-agentmd) |
| Understand what tools an agent has                    | [Agent Tools](../tooling/index.md)                                                |
