---
uid: module-building.templates-csharp.how-to-update-launchsettings-json-files
description: "How to add launch profiles and environment variables to launchSettings.json from a template by publishing events via IApplicationEventDispatcher."
---
# How to update `launchSettings.json` files

The `launchSettings.json` file is managed by the `LaunchSettingsJsonTemplate`. Template authors can influence its output by publishing events/requests via the `IApplicationEventDispatcher`. This document describes each available mechanism.

If you are looking for the Codebase Structure / Visual Studio modeling setup for environment-specific `appsettings` files, see [](xref:application-development.modelling.codebase-structure-designer).

---

## 1. Add a Launch Profile - `LaunchProfileRegistrationRequest`

Adds a new named profile to `launchSettings.json`.

**Namespace:** `Intent.Modules.Common.CSharp.Configuration`

### Properties

| Property | JSON field | Description |
|---|---|---|
| `Name` | _(profile key)_ | The profile name (required). |
| `CommandName` | `commandName` | e.g. `"Project"`, `"IISExpress"`, `"Executable"`. |
| `CommandLineArgs` | `commandLineArgs` | Arguments passed to the process. |
| `LaunchBrowser` | `launchBrowser` | Whether to open a browser on launch. |
| `LaunchUrl` | `launchUrl` | URL opened in the browser. Supports `{HttpPort}` and `{HttpsPort}` tokens. |
| `ApplicationUrl` | `applicationUrl` | Listening URL(s), semicolon-separated. Supports `{HttpPort}` and `{HttpsPort}` tokens. |
| `PublishAllPorts` | `publishAllPorts` | Defaults to `true` (omitted from JSON). |
| `UseSsl` | `useSSL` | Defaults to `true` (omitted from JSON). |
| `DotnetRunMessages` | `dotnetRunMessages` | Display build messages on run. |
| `InspectUri` | `inspectUri` | Debugging URI for Blazor WebAssembly. |
| `ExecutablePath` | `executablePath` | Path to executable (for `Executable` command). |
| `WorkingDirectory` | `workingDirectory` | Working directory for the process. |
| `EnvironmentVariables` | `environmentVariables` | Key/value pairs added to this profile's environment variables. |
| `ForProjectWithRole` | _(routing)_ | See [Targeting a Specific Project](#targeting-a-specific-project). |

### Notes

- If a profile with the same `Name` already exists in the file it is **not** overwritten (existing file entries take precedence).
- The `{HttpPort}` and `{HttpsPort}` tokens in `LaunchUrl` and `ApplicationUrl` are replaced with the actual randomly-assigned or persisted port numbers.

### Example

```csharp
public override void BeforeTemplateExecution()
{
    ExecutionContext.EventDispatcher.Publish(new LaunchProfileRegistrationRequest
    {
        Name = "Docker",
        CommandName = "Docker",
        LaunchBrowser = true,
        LaunchUrl = "https://localhost:{HttpsPort}/swagger",
        ApplicationUrl = "https://localhost:{HttpsPort};http://localhost:{HttpPort}",
        EnvironmentVariables = new Dictionary<string, string>
        {
            ["ASPNETCORE_ENVIRONMENT"] = "Development"
        }
    });
}
```

---

## 2. Add an Environment Variable - `EnvironmentVariableRegistrationRequest`

Adds a key/value environment variable to one or more launch profiles.

**Namespace:** `Intent.Modules.Common.CSharp.Configuration`

### Constructor

```csharp
new EnvironmentVariableRegistrationRequest(
    key: "MY_SETTING",
    value: "my-value",
    targetProfiles: new[] { "MyApp", "IIS Express" }, // null = all profiles
    forProjectWithRole: null)
```

| Parameter | Description |
|---|---|
| `key` | The environment variable name. |
| `value` | The environment variable value. |
| `targetProfiles` | Profile names to target. Pass `null` to apply to every profile. |
| `forProjectWithRole` | See [Targeting a Specific Project](#targeting-a-specific-project). |

### Notes

- A variable is only added if the profile doesn't already contain an entry for that key (first-write wins).
- The default `ASPNETCORE_ENVIRONMENT=Development` (or `DOTNET_ENVIRONMENT=Development` for Worker SDK projects) is injected automatically and will be skipped if you have already set it.

### Example

```csharp
ExecutionContext.EventDispatcher.Publish(
    new EnvironmentVariableRegistrationRequest(
        key: "ConnectionStrings__Default",
        value: "Server=localhost;Database=MyDb;",
        targetProfiles: new[] { "MyApp" }));
```

---

## 3. Set the Default Launch URL Path - `DefaultLaunchUrlPathRequest`

Sets the `launchUrl` path for the default project profiles (profiles whose name ends with `.Api`).

**Namespace:** `Intent.Modules.Common.CSharp.Configuration`

`DefaultLaunchUrlPathRequest` has an `internal` constructor; publish it via the provided extension methods.

### Extension methods

| Method | When to use |
|---|---|
| `template.PublishDefaultLaunchUrlPathRequest(urlPath, forProjectWithRole?)` | Use inside `BeforeTemplateExecution()`. Broadcasts globally and logs a warning if unhandled. |
| `outputTarget.EmitDefaultLaunchUrlPathRequest(urlPath)` | Use when you want the request automatically scoped to projects that reference your output target. |

### Notes

- Only one call may succeed per `launchSettings.json`; a second attempt throws `InvalidOperationException`.
- If the file already exists the path is **not** updated (only applied on first generation).
- The leading `/` is stripped automatically.

### Example

```csharp
public override void BeforeTemplateExecution()
{
    this.PublishDefaultLaunchUrlPathRequest("/swagger/index.html");
}
```

---

## 4. Require an HTTP Port in Application URLs - `LaunchProfileHttpPortRequired`

Publishing this event ensures every HTTPS-only profile gets an additional `http://localhost:{port}` entry appended to its `applicationUrl`.

**Namespace:** `Intent.Modules.Constants`

### Usage

```csharp
ExecutionContext.EventDispatcher.Publish(LaunchProfileHttpPortRequired.EventId);
```

This is useful for tooling (e.g. Docker, Aspire) that requires an explicit HTTP endpoint alongside HTTPS.

---

## 5. Suppress Generation - `AddProjectPropertyEvent` with `NoDefaultLaunchSettingsFile`

Setting the `NoDefaultLaunchSettingsFile` MSBuild property to `true` via `AddProjectPropertyEvent` causes the template to skip generation entirely for that project.

```csharp
ExecutionContext.EventDispatcher.Publish(new AddProjectPropertyEvent(
    target: outputTarget.GetProject(),
    propertyName: "NoDefaultLaunchSettingsFile",
    propertyValue: "true"));
```

---

## Targeting a Specific Project

When a solution contains multiple ASP.NET projects, each with its own `launchSettings.json`, you can route a request to the correct one by setting `ForProjectWithRole` to the name of a **Role** element defined under the target project in the Intent Architect Visual Studio designer.

```csharp
new LaunchProfileRegistrationRequest
{
    ForProjectWithRole = "API",
    Name = "MyProfile",
    // ...
}
```

If `ForProjectWithRole` is `null` or empty, the request is accepted by every `launchSettings.json` template that processes it.
