---
uid: module-building.application-templates.template-string-substitution
---
# Template string substitution

Template strings of the form `${...}` are substituted with dynamic values during installation of Application Templates. They can be used in:

- Metadata `.installation.config` files
- [Installation file](xref:module-building.application-templates.installation-files) contents.

## Built-in values

The following template strings are always available:

| Template String | Description |
|-|-|
| `${solution.name}` | The Intent Architect Solution name. |
| `${application.name}` | The Intent Architect Application name. |
| `${mcpServer.executable}` | The path to the Intent Architect MCP server executable. |
| `${mcpServer.executableArguments}` | The arguments to pass to the Intent Architect MCP server executable. |

## Field Configuration values

All [Field Configuration](xref:module-building.application-templates.how-to-create-application-templates#field-configurations) values are available as template strings. Use a Field Configuration's `Value` with the `${<value>}` format and it will be substituted with the user-captured (or default) value.

For example, for a Field Configuration with a `Value` of `custom-field`, use `${custom-field}` in installation files to have the captured value substituted.

## Case conversion functions

The following functions can be applied to any substitutable value by wrapping it in a function call:

| Function | Description | Example |
|-|-|-|
| `camelCase(...)` | Converts the value to camelCase. | `${camelCase(application.name)}` |
| `pascalCase(...)` | Converts the value to PascalCase. | `${pascalCase(application.name)}` |
| `kebabCase(...)` | Converts the value to kebab-case. | `${kebabCase(application.name)}` |

## Common usage

Template strings are commonly used in Visual Studio designer metadata where the root element has a name of `${solution.name}` and projects have names like `${application.name}.Data.Entities`.
