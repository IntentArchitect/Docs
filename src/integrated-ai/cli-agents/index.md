---
uid: ai.cli-agents
description: "Use Claude Code, Codex, GitHub Copilot CLI, Kiro, Cursor CLI or OpenCode as the AI provider behind Intent Architect's chat, over the Agent Client Protocol (ACP)."
---
# CLI Agents as AI Providers

Intent Architect can use a CLI coding agent you already have as the AI harness behind its chat. The agent runs locally under your own subscription and sign-in, and Intent Architect talks to it over the [Agent Client Protocol (ACP)](https://agentclientprotocol.com/), supplying its designers, Software Factory, agents and skills as tools and context.

This lets teams keep the harness and subscription they already use. The agent does the work, and Intent Architect's control framework (architectural guardrails, design blueprints, validation tools and traceability) applies to it exactly as it does to Intent Architect's own agents.

> [!TIP]
> To drive Intent Architect from your own terminal or IDE instead, see [Intent MCP Server](xref:ai.intent-mcp-server).

## Supported agents

- [Claude Code](#claude-code)
- [Codex](#codex)
- [GitHub Copilot CLI](#github-copilot-cli)
- [Kiro](#kiro)
- [Cursor CLI](#cursor-cli)
- [OpenCode](#opencode)

Claude Code, Codex and GitHub Copilot CLI connect through an ACP adapter (the *connector*) that Intent Architect installs with npm on first use, so they also need [Node.js](https://nodejs.org/en/download).

---

## Installing an agent

Install the agent, sign in from a new terminal and check that it responds before enabling it in Intent Architect.

### Claude Code

[Setup guide](https://code.claude.com/docs/en/setup) · Requires Node.js

```bash
curl -fsSL https://claude.ai/install.sh | bash     # macOS, Linux, WSL
irm https://claude.ai/install.ps1 | iex            # Windows PowerShell
```

**Sign in:** run `claude` and follow the prompts.

> [!NOTE]
> Claude Code can also sign in with **Amazon Bedrock**: choose **3rd-party platform** > **Amazon Bedrock** at the login prompt, or run `/setup-bedrock`. Keep the Bedrock settings in `~/.claude/settings.json` rather than exporting them in your shell, as Intent Architect won't see variables exported in a terminal. See [Claude Code on Amazon Bedrock](https://code.claude.com/docs/en/amazon-bedrock).

### Codex

[Setup guide](https://github.com/openai/codex) · Requires Node.js

```bash
npm install -g @openai/codex
```

**Sign in:** run `codex` and choose **Sign in with ChatGPT**, or set `OPENAI_API_KEY`.

### GitHub Copilot CLI

[Setup guide](https://docs.github.com/en/copilot/how-tos/set-up/install-copilot-cli) · Requires Node.js and a GitHub Copilot subscription

```bash
npm install -g @github/copilot
```

**Sign in:** run `copilot`, then `/login`.

> [!NOTE]
> GitHub Copilot CLI is separate from the **GitHub Copilot** API provider, which you sign in to from the AI Providers tab.

### Kiro

[Setup guide](https://kiro.dev/docs/getting-started/installation/)

```bash
curl -fsSL https://cli.kiro.dev/install | bash     # macOS, Linux
irm 'https://cli.kiro.dev/install.ps1' | iex       # Windows PowerShell
```

**Sign in:** the installer opens a browser to sign in. To sign in again, run `kiro-cli login`.

### Cursor CLI

[Setup guide](https://cursor.com/docs/cli/installation)

```bash
curl https://cursor.com/install -fsS | bash                 # macOS, Linux, WSL
irm 'https://cursor.com/install?win32=true' | iex           # Windows PowerShell
```

**Sign in:** run `cursor-agent login`, or set `CURSOR_API_KEY`.

### OpenCode

[Setup guide](https://opencode.ai/docs/)

```bash
curl -fsSL https://opencode.ai/install | bash      # macOS, Linux
npm install -g opencode-ai                         # any platform
```

**Sign in:** run `opencode auth login` and choose the model provider OpenCode should use.

---

## Enabling an agent

1. **Restart Intent Architect** - installed agents are only detected at startup.
2. Open **AI Configuration** (type `/config` in the chat) and go to **AI Providers**.
3. Check the agent's card shows **Installed**. Use its power button to enable or disable it.

<!-- TODO: screenshot of the CLI agent cards on the AI Providers tab -->

No credentials are entered here - sign-in is handled by the agent itself. The card's **Models** section controls which of the agent's models appear in the chat.

## Selecting an agent in the chat

Choose a model under the agent's group in the chat's model picker. The first chat with Claude Code, Codex or GitHub Copilot CLI installs its connector, which can take a minute.

<!-- TODO: screenshot of the model picker with a CLI agent group -->

---

## Agent settings

The **Agent settings** chip in the chat composer (or `/settings`) sets the permission mode and reasoning effort for the conversation.

| Agent              | Permission modes                                         | Reasoning effort                         |
| ------------------ | -------------------------------------------------------- | ---------------------------------------- |
| Claude Code        | Ask before edits, Edit automatically, Auto, Bypass       | None, Low, Medium, High, Extra High, Max |
| Codex              | Ask before edits, Edit automatically, Bypass             | Low, Medium, High, Max                   |
| GitHub Copilot CLI | Edit automatically, Bypass                               | None, Low, Medium, High                  |
| Kiro               | Ask before edits, Edit automatically, Bypass             | Low, Medium, High                        |
| Cursor CLI         | Ask before edits, Edit automatically                     | -                                        |
| OpenCode           | Ask before edits, Edit automatically, Bypass             | -                                        |

- **Ask before edits** - asks for approval before editing files or running commands.
- **Edit automatically** - applies changes without asking.
- **Auto** - Claude Code chooses the mode for each task.
- **Bypass all permissions** - runs everything without approval. Best used in a separate worktree.

When approval is needed, the chat shows **Allow**, **Allow all** (switches the conversation to Bypass) or **Deny** (stops the turn).

---

## What the agent receives

- Intent Architect's [agent tools](xref:ai.tooling), through an MCP server named `intent_architect_acp`.
- The instructions of the selected [built-in](xref:ai.built-in-agents) or [custom](xref:ai.custom-agents) agent, plus applicable [instruction files](xref:ai.context-management#2-instruction-files).
- Enabled `stdio` servers from [MCP Servers](xref:ai.configuration#3-mcp-servers) that are available to **Coding**.

The first time an agent is used in a repository, the chat offers to **Add** Intent Architect's built-in skills and rules to that agent's native folders (`.claude/skills`, `.github/skills`, `.kiro/steering`, etc.). Commit them to share them with your team.

---

## Advanced

**Connector package** - the Claude Code, Codex and GitHub Copilot CLI cards let you pin a different connector version: untick **Use default** and edit the npm package spec. Takes effect on your next chat.

**Executable override** - to use a specific executable instead of the one Intent Architect finds, set one of these environment variables to its full path before starting Intent Architect: `INTENT_CLAUDE_CODE_ACP`, `INTENT_CODEX_ACP`, `INTENT_COPILOT_ACP`, `INTENT_KIRO_ACP`, `INTENT_CURSOR_ACP`, `INTENT_OPENCODE_ACP`.

---

## Troubleshooting

| Problem                                    | Solution                                                                                                                                       |
| ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Card shows **Not installed**               | Restart Intent Architect. Check the executable runs from a new terminal, or set the [executable override](#advanced).                          |
| "…needs Node.js, which isn't installed"    | Install [Node.js](https://nodejs.org/en/download) and restart Intent Architect.                                                               |
| "{agent} is not signed in…"                | Sign in again from a terminal, then click **Retry**. The conversation isn't lost.                                                             |
| "ACP agent process exited unexpectedly…"   | Choose **Restart ACP host** from the conversation menu. History is kept.                                                                      |

The agent's error output is written to Intent Architect's agent log. Use **Open Logs Folder** on the Home screen, or `/diagnostics` in the chat to gather a bundle for [support](xref:getting-help).
