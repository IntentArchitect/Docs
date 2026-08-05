---
uid: key-concepts.non-deterministic-codegen
description: "How Intent Architect AI agents automate the development cycle, covering context engineering, custom agents, and the Intent MCP Server."
---

# AI Agents / Tools

Leverage your existing context engineering setup via the Intent MCP, or drive agents directly in the platform. Use any LLM or AI-coding harness and add the control you need to scale agentic development safely and reliably. Intent Architect allows teams to go from requirements to visual designs to working, production-ready code – with full traceability – developers focused on engineering decisions, AI agents handling implementation.

Intent Architect's own skills are bridged into each agent's native skill discovery – so your existing setup is respected rather than replaced. And the platform pre-engineers relevant context automatically, ensuring agents execute within the guardrails and in full conformance with your design and architecture, without complex setup or excessive validation.

Agents can work like a team rather than a single conversation, dispatching focused sub-agents for isolated pieces of work so a large feature gets implemented wave by wave. They can also run your build and test tasks, and self-correct when those report errors.

Teams choose how much they hand over – fully automated, developer-augmented, or manually driven.

---

## Key benefits

- **🚀 End-to-end automation**  
  Modeling agents handle design, coding agents handle implementation – together covering the full development cycle from concept to code.

- **🧠 Sophisticated, customizable context engine**  
  Intent Architect's context engineering is fully customizable to your domain and coding standards, and pre-engineered by default to ensure adherence to your visually defined design and architecture.

- **🤖 Fully customizable agents**  
  Author your own agents, connect your preferred LLM, and tailor agent behavior to your specific needs.

- **🔌 MCP Server for External AI Control**  
  The Intent MCP Server allows for a flexible tooling configuration. This means external AI coding tools, like Claude Code, GitHub Copilot etc., can also drive Intent Architect directly to manage your design and architecture visually.

---

## The AI-driven Development Workflow

The ultimate goal of Intent Architect is a development workflow we refer to as "The Golden Path", where the developer can focus almost entirely on engineering and design decisions, and the platform takes care of the rest.

Intent Architect's AI agent makes this possible by combining design and implementation in a single workflow. The agent helps you translate requirements into comprehensive system designs directly in the visual designers, faster and more accurately than working manually (all model changes are made in memory and never saved without your explicit approval). When implementation work is needed, the agent automatically delegates to the coding agent, which handles the hand-written code while the deterministic architecture enforcement system rolls out the architecture, infrastructure, and boilerplate to guarantee consistency at scale.

In practice, the workflow looks like this: describe your system's design visually with AI in a single chat interface, run the Software Factory Execution, and out the other side comes working, production-ready software. Well architected, consistent, and built to your standards, at any scale.

<br>

![Software Factory with AI coding agents](images/golden-path-v5.png)

---

## Context Engineering

The accuracy of Intent Architect's AI agents comes down to context and guardrails. Intent Architect derives this context directly from your structured visual models, giving agents precise knowledge of your design intent – automatically.

Behind every coding agent is a customizable and sophisticated context engineering system that determines exactly which code files, architecture descriptions, use case intentions, and Skills are relevant for each task. Agents also have full support for standard context files your team is already using – CLAUDE.md, AGENTS.md, copilot-instructions.md and others, as well as Instruction Files – so your existing conventions, standards and workflows are respected automatically.

The result is AI that executes accurately and in full conformance with your design and architecture – without excessive manual context setup or prompting.

<br>

![AI Modeling Assistant with context engineering](images/modeling-screen-ai-assistant-v2.png)

---

## Custom Agents

For teams that want to go further, Intent Architect supports fully custom agents. Authored as .agent.md markdown files, custom agents can be tailored to your domain, technology stack, or proprietary coding standards – and configured to appear in either the modeling or coding context.

---

## The Intent MCP Server

The Intent MCP Server gives teams complete flexibility in how they configure their AI tooling. Use Intent Architect's integrated agents, your own external AI coding tools, or any combination of both – all while keeping your design and architecture managed centrally and visually in Intent Architect.

This means teams can use whichever tools suit them best, without conflicts between external agents and Intent Architect-managed code.

Details on how to configure the Intent MCP can be found in the AI Configuration dialog (xref:ai.configuration).

---

## Connect Your Preferred Provider

Intent Architect is designed to work with the AI providers and models your team already uses. Connect to OpenAI, Azure OpenAI, Anthropic, or other compatible providers directly from the AI Configuration dialog – which also walks you through setting up the Intent MCP Server and any additional MCP servers your agents can use.

AI agents are pre-configured to work well for most use cases, with the flexibility to customize context engineering and agent behavior for specialized domains or proprietary coding styles.

<br>

![AI Configuration](images/ai-configuration.png)

---

## Learn More

- **[Authoritative Design Blueprints](xref:key-concepts.visual-modeling)**
- **[Architectural Guardrails](xref:key-concepts.deterministic-codegen)**
- **[Codebase Control](xref:key-concepts.codebase-integration)**
