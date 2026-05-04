# What's new in Intent Architect (May 2026)

Welcome to the May edition of What's New in Intent Architect. This month marks the release of **Intent Architect 5.0** — perhaps the most significant release in recent years, bringing the full power of AI into the heart of the platform for an end-to-end software development experience.

- Highlights
  - **[AI Coding Agents in the Software Factory](#ai-coding-agents-in-the-software-factory)** - Coding agents built into the Software Factory "colour in between the lines" of your architecture, delivering end-to-end working software from your designs.
  - **[Comprehensive AI Integration Upgrade](#comprehensive-ai-integration-upgrade)** - A massively upgraded AI Assistant with conversation history, file attachments, tool-call visualisation, custom agents, slash commands, and a rebuilt plan mode.
  - **[Intent Architect as an MCP Server](#intent-architect-as-an-mcp-server)** - Expose Intent Architect's designers to external agents (Claude Code, Copilot, etc.) via a built-in MCP server, eliminating friction when AI tools work alongside Intent Architect.
  - **[Software Factory Enhancements](#software-factory-enhancements)** - A redesigned Software Factory UI with a new sidebar, codebase explorer, per-file apply/undo, and deeper AI integration.
  - **[Terminal & Tasks](#terminal--tasks)** - A fully capable PTY terminal and task configuration system built directly into Intent Architect.
  - **[Pop-out Tabs](#pop-out-tabs)** - Detach any viewport tab into its own independent window for multi-monitor workflows.
  - **[Designer Improvements](#designer-improvements)** - View Code navigation, improved filtering, new visual indicators for unsaved elements, and more.
  - **[Updated Module Ecosystem](#updated-module-ecosystem)** - Core modules updated to take full advantage of 5.0 features across Blazor, Angular, Unit Testing, Entities, Domain Services, Domain Eventing, Validations, CQRS, and Traditional Services.

## Update details

### AI Coding Agents in the Software Factory

Intent Architect 5.0 introduces two distinct agentic contexts: `modeling` and `coding`. Coding agents are built into the Software Factory Execution and provide a foundational mechanism to realize the subtle and often sophisticated business logic that applications require. While deterministic code-generation handles the architecture, infrastructure, and boilerplate, coding agents fill in the implementation — resulting in end-to-end working software and massively accelerating feature delivery.

![AI Chat in the Software Factory](../../../release-notes/images/5.0/00/software-factory-ai-chat.png)

The golden path this enables: describe your system design, run the Software Factory, run the coding agents, and out the other side comes working, perfectly-architected software.

Key capabilities supporting this:

- **Auto-created AI Tasks** — an AI Tasks panel visualizes ongoing agent activity. Tasks can be auto-created by modules (e.g. when a `throw new NotImplementedException(...)` is detected), created manually, or created by coding agents themselves.
- **Optimized Context Engineering** — a sophisticated [context engineering system](xref:ai.context-management) informs coding agents how to handle specific files, ensuring they conform to your architecture, standards, and structure.
- **Comprehensive AI Tooling** — a [suite of tools](xref:ai.tooling) (grep, glob, read file, patch file, etc.) gives coding agents the capability to discover, analyze, and implement features across your codebase.
- **Standard context file support** — coding agents integrate with `CLAUDE.md`, `AGENTS.md`, `copilot-instructions.md`, and other context files your team already uses.

Available from:

- Intent Architect 5.0.0

### Comprehensive AI Integration Upgrade

The AI Assistant introduced in version 4.6 has been massively upgraded — more transparent, intuitive, and powerful. Tool calls are now interactive and color-coded to distinguish reads (blue), creates (green), updates (yellow), and deletes (red). Model changes remain in-memory and are never saved without your consent.

![AI Chat with Attachments](../../../release-notes/images/5.0/00/ai-chat-with-attachments2.png)

Key new features and enhancements:

- **Conversation history & persistence** — past conversations persist across sessions and can be deleted. The status of each task is visible in a history dropdown.

    ![Conversation history dropdown](../../../release-notes/images/5.0/00/ai-chat-conversation-history.png)

- **Model / File attachments** — drag-and-drop files and model elements, paste files (including images), or browse from disk directly into the chat. Pass PRDs, external code files, screenshots, and more straight to the LLM.

    ![Files attached to an AI chat message](../../../release-notes/images/5.0/00/ai-chat-attachments-input.png)

- **Tool-call visualisation** — interactive chips for each tool call, composite collapsing for multi-step operations, and "modifications" lists that make agent activity clear and navigable.

    ![Tool-call chips showing reads, creates, and updates](../../../release-notes/images/5.0/00/ai-chat-tool-calls.png)

- **Custom Agents** — author [Custom Agents](xref:ai.custom-agents) as `.agent.md` files in `~/intent/.agents/agents`, with frontmatter controlling context (`coding` or `modeling`) and available tooling.

    ![Custom Agents menu](../../../release-notes/images/5.0/00/custom-agents.png)

- **Slash Commands** — invoke agent switching and [skills](xref:ai.context-management#3-skills) directly from the chat input.

    ![Slash commands list](../../../release-notes/images/5.0/00/slash-commands.png)

- **AI Configuration dialog** — a dedicated [AI configuration dialog](xref:ai.configuration) (click the `cog` icon in the AI Assistant toolbar) lists compatible providers, manages API keys, and explains how to configure [MCP Servers](xref:ai.configuration#3-mcp-servers) and the [Intent MCP](xref:ai.configuration#2-intent-mcp).

    ![AI Configuration dialog](../../../release-notes/images/5.0/00/ai-configuration-dialog.png)

- **Rebuilt Plan mode** — plan mode has been rebuilt from scratch with new tools ("Ask User Question", "Implement Plan", "Update Todos"), giving LLMs the control they need to plan accurately. Plans are now presented as editable Markdown files inside an Intent Architect tab.

Available from:

- Intent Architect 5.0.0

### Intent Architect as an MCP Server

Intent Architect now exposes itself as an MCP server with a substantial tool suite, allowing external agents to "drive" the designers to meet your requirements. This solves a critical friction point: AI tools like Claude Code and GitHub Copilot could conflict with Intent Architect-managed code. The Intent MCP server gives external agents full power to update your designs rather than editing generated files directly.

![Intent MCP configuration](../../../release-notes/images/5.0/00/mcp-server-config.png)

Setup details and per-client configuration snippets (Claude Code, OpenAI Codex, Copilot, etc.) are available in the [AI Configuration dialog](xref:ai.configuration#2-intent-mcp) and the [Intent Architect MCP Server](xref:tools.mcp-server) reference.

Available from:

- Intent Architect 5.0.0

### Software Factory Enhancements

The Software Factory UI has been significantly redesigned to maximize space available for code diffs and AI conversations. A new left-hand sidebar with tabs provides access to:

- **Execution Output** — the Software Factory Execution process log for deterministic code generation.
- **Changes** — staged file changes awaiting confirmation (`Ctrl+Shift+C`).
- **Codebase Explorer** — a full view of the codebase rooted at the application's Output Location, with changes highlighted (`Ctrl+Shift+E`).
- **Customizations** — all deviations and their approval status (`Ctrl+Shift+D`).
- **Terminal** — create terminal processes and view task-created terminal output (`Ctrl+Shift+T`).

![Software Factory new UI layout](../../../release-notes/images/5.0/00/software-factory-ui.png)

Additional enhancements:

- **Apply / Undo** — undo applied files during the same Software Factory run.
- **Per-file Apply** — apply or undo individual files (`Ctrl+Shift+Y` to apply, `Ctrl+Shift+Z` to undo) or apply in bulk at the folder level via context menu.
- **View in Designer** — navigate from any generated file back to the designer element responsible for it.
- **Create AI Task** — create a new AI coding task with selected file(s) attached, directly from the Codebase Explorer.

    ![Codebase Explorer context menu](../../../release-notes/images/5.0/00/software-factory-context-menu.png)

Available from:

- Intent Architect 5.0.0

### Terminal & Tasks

A fully capable PTY terminal is now built into Intent Architect, alongside a flexible task configuration system. Define commonly used tasks — `dotnet build`, `dotnet test`, `dotnet run`, etc. — in a `tasks.json` file located alongside your `.application.config`.

![Integrated terminal running dotnet build](../../../release-notes/images/5.0/00/terminal-build.png)

Tasks support an option to automatically start a coding agent when errors are detected — seamless for build tasks where an agent can resolve compilation issues without manual intervention.

![Example tasks.json](../../../release-notes/images/5.0/00/tasks-json.png)

> [!NOTE]
> The `tasks.json` file must be located in the same folder as the `.application.config` file. It can also be installed automatically via an Architecture Template. Access the file from within Intent Architect by clicking the `cog` icon in the Tasks display in the top toolbar.

Available from:

- Intent Architect 5.0.0

### Pop-out Tabs

Any viewport tab can now be popped out into an independent window, making multi-monitor workflows and side-by-side comparisons much more practical:

- **Move to New Window** — moves the current tab (including unsaved changes) into its own window.
- **Copy into New Window** — opens a fresh copy of the tab in a new window (does not carry unsaved changes; saving in one window will prompt a reload in the other).

![Tab right-click menu with pop-out options](../../../release-notes/images/5.0/00/popout-tabs.png)

Available from:

- Intent Architect 5.0.0

### Designer Improvements

Several quality-of-life improvements have been made across all designers:

- **View Code** — a new context menu option on elements navigates directly to the corresponding generated file in the Software Factory, without requiring a full Software Factory startup.
- **Filtering performance** — improved responsiveness across all tree-views.
- **Filtering highlights matches** — search results are now highlighted in all tree-views.
- **Suggestions in context menu** — element and association context menus now surface relevant suggestions inline.
- **New element indicators** — newly added (unsaved) elements are shown with a subtle green background; modified/dirty elements remain yellow.
- **JS API** — new `createAICodingTask(...)` method for programmatically creating AI coding tasks from within the Software Factory.

Available from:

- Intent Architect 5.0.0

### Updated Module Ecosystem

A broad set of existing modules has been updated to take full advantage of the new features introduced in Intent Architect 5.0. These updates bring improved AI coding agent support across the following areas:

- **Angular**
- **Blazor**
- **CQRS Services**
- **Domain Services**
- **Domain Eventing**
- **Entities**
- **Traditional Services**
- **Unit Testing**
- **Fluent Validations**

Available from:

- Intent Architect 5.0.0
