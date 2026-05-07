---
uid: ai.intent-mcp-server
---
# Intent MCP Server

Intent Architect exposes an MCP (Model Context Protocol) server that lets external AI coding agents - Claude Code, GitHub Copilot, VS Code Chat, Cursor, and others - connect to Intent Architect and take over the parts of the codebase that Intent manages, while the agent continues handling the rest of the code as normal.

For instructions on how to connect your AI client, see [](xref:ai.configuration).

## How it works

When an MCP-aware agent starts a session in a repository that contains an Intent Architect solution (`.isln` file), the Intent MCP server automatically provides the agent with full instructions for how to use Intent Architect. The agent then:

- Uses Intent Architect's designers for anything that must be modelled - API contracts, domain entities, service interfaces, persistence schema, and so on.
- Writes bespoke code directly for everything else - business logic, custom queries, integration glue.

The agent handles the coordination between these two modes automatically. You give it a single instruction describing what you want; it decides what to model and what to code.

## Usage notes

The Intent MCP server instructions tell MCP clients that they must check for the existence of a `.isln` file and if found the client must use an MCP server tool to get full Intent Architect usage instructions. This means that MCP clients should automatically get all the guidance they need to be able to effectively use Intent Architect with no additional instructions needed.

## Example: Building a feature with Claude Code

Suppose you are working on a .NET solution managed by Intent Architect and you ask Claude Code:

> "Make this a basic online ordering system with typical endpoints, also include an endpoint to get basic stats of orders for a customer."

Claude Code, connected to the Intent MCP server, will:

1. **Detect the Intent solution** and load the full Intent Architect working instructions.
2. **Model the domain** - create `Order`, `OrderItem`, and related entities in the Domain designer, setting up persistence mappings and relationships.
3. **Define the API surface** - add commands and queries in the Services designer: `CreateOrder`, `GetOrderById`, `GetOrdersByCustomer`, `GetOrderStatsForCustomer`, and so on, with appropriate DTOs.
4. **Run the Software Factory** - Intent generates controllers, handlers, repositories, migrations, and all the surrounding infrastructure code.
5. **Implement business logic** - write the handler bodies for commands and queries (the parts Intent intentionally leaves for you), protected with `[IntentIgnoreBody]` so regeneration never overwrites them.
6. **Verify the build** - confirm the solution compiles and tests pass before reporting completion.

The result is a fully working feature: the structural and architectural parts are correct by construction (Intent managed), and the business logic is implemented by the agent. You never had to manually wire up routing, DTOs, persistence, or DI - and the agent never had to guess at your architectural conventions.
