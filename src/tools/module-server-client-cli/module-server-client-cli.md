---
uid: tools.module-server-client-cli
description: "Reference for the Module Server Client CLI .NET tool, used to upload modules and application templates to a Module Server and manage their listing status."
---
<!-- Workaround to align the column widths consistently -->
<style>
table th:first-of-type {
    width: 375px;
}
</style>

# Module Server Client CLI

The Module Server Client CLI tool can be used for interacting with an Intent Architect [](xref:tools.module-server) instance to perform tasks such as uploading artifacts.

## Pre-requisites

Latest release version of [.NET](https://dotnet.microsoft.com/download).

## Installation

This CLI tool is available as a [.NET Tool](https://docs.microsoft.com/dotnet/core/tools/global-tools) and can be installed with the following command:

```powershell
dotnet tool install Intent.ModuleServer.Client.CLI --global --prerelease
```

> [!NOTE]
> If `dotnet tool install` fails with an error to the effect of `The required NuGet feed can't be accessed, perhaps because of an Internet connection problem.` and it shows a private NuGet feed URL, you can try add the `--ignore-failed-sources` command line option ([source](https://learn.microsoft.com/dotnet/core/tools/troubleshoot-usage-issues#nuget-feed-cant-be-accessed)).

You should see output to the effect of:

```text
You can invoke the tool using the following command: module-server-client-cli
Tool 'intent.moduleserver.client.cli' (version 'x.x.x') was successfully installed.
```

## Usage

`module-server-client-cli [command] [options]`

## Options

|Option           |Description|
|-----------------|-----------|
|`--version`      |Show version information|
|`-?, -h, --help` |Show help and usage information|

## Authentication

Every command requires exactly one of the following authentication options to be specified:

|Option                          |Description|
|--------------------------------|-----------|
|`--api-key <apiKey>`            |The API key to use to authenticate the request.|
|`--access-token, --oat <token>` |The organization access token to use to authenticate the request.|

If neither option is specified, the tool exits with an error.

## Commands

|Command                                                        |Description|
|---------------------------------------------------------------|-----------|
|`upload-module <serverUrl> <path>`                             |Upload a module .imod file.|
|`upload-application-template <serverUrl> <path>`               |Upload an application template .iat file.|
|`list-module-version <serverUrl> <moduleId> <moduleVersion>`   |Updates a module to be listed (not hidden from searches).|
|`unlist-module-version <serverUrl> <moduleId> <moduleVersion>` |Updates a module version to be unlisted (hidden from searches).|

## upload-module command

Upload a module .imod file.

### upload-module usage

```bash
module-server-client-cli upload-module [<serverUrl> [<path>]] [options]
```

### upload-module arguments

|Argument    |Description|
|------------|-----------|
|`serverUrl` |The module server's https address.|
|`path`      |The path of the file to upload.|

### upload-module options

|Option                          |Description|
|--------------------------------|-----------|
|`--force`                       |If there is already an item with the same identifier and version then this option can be used force it to be overwritten.|
|`--unlisted`                    |The module version should be unlisted (hidden from searches).|
|`--api-key <apiKey>`            |The API key to use to authenticate the request.|
|`--access-token, --oat <token>` |The organization access token to use to authenticate the request.|
|`--organization-id <guid>`      |Organization id to which access will be restricted.|
|`-?, -h, --help`                |Show help and usage information|

## upload-application-template command

Upload an application template .iat file.

### upload-application-template usage

```bash
module-server-client-cli upload-application-template [<serverUrl> [<path>]] [options]
```

### upload-application-template arguments

|Argument    |Description|
|------------|-----------|
|`serverUrl` |The module server's https address.|
|`path`      |The path of the file to upload.|

### upload-application-template options

|Option                          |Description|
|--------------------------------|-----------|
|`--force`                       |If there is already an item with the same identifier and version then this option can be used force it to be overwritten.|
|`--api-key <apiKey>`            |The API key to use to authenticate the request.|
|`--access-token, --oat <token>` |The organization access token to use to authenticate the request.|
|`--organization-id <guid>`      |Organization id to which access will be restricted.|
|`-?, -h, --help`                |Show help and usage information|

## list-module-version command

Updates a module to be listed (not hidden from searches).

### list-module-version usage

```bash
module-server-client-cli list-module-version [<serverUrl> [<moduleId> [<moduleVersion>]]] [options]
```

### list-module-version arguments

|Argument        |Description|
|----------------|-----------|
|`serverUrl`     |The module server's https address.|
|`moduleId`      |The identifier or full name of the module.|
|`moduleVersion` |The version of the module.|

### list-module-version options

|Option                          |Description|
|--------------------------------|-----------|
|`--api-key <apiKey>`            |The API key to use to authenticate the request.|
|`--access-token, --oat <token>` |The organization access token to use to authenticate the request.|
|`-?, -h, --help`                |Show help and usage information|

## unlist-module-version command

Updates a module version to be unlisted (hidden from searches).

### unlist-module-version usage

```bash
module-server-client-cli unlist-module-version [<serverUrl> [<moduleId> [<moduleVersion>]]] [options]
```

### unlist-module-version arguments

|Argument        |Description|
|----------------|-----------|
|`serverUrl`     |The module server's https address.|
|`moduleId`      |The identifier or full name of the module.|
|`moduleVersion` |The version of the module.|

### unlist-module-version options

|Option                          |Description|
|--------------------------------|-----------|
|`--api-key <apiKey>`            |The API key to use to authenticate the request.|
|`--access-token, --oat <token>` |The organization access token to use to authenticate the request.|
|`-?, -h, --help`                |Show help and usage information|
