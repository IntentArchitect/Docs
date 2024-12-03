---
uid: tools.module-server-client-cli
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

Latest Long Term Support (LTS) version of [.NET](https://dotnet.microsoft.com/download).

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

## Commands

|Command                                                                 |Description|
|------------------------------------------------------------------------|-----------|
|`upload-module <serverUrl> <apiKey> <path>`                             |Upload a module .imod file.|
|`upload-application-template <serverUrl> <apiKey> <path>`               |Upload an application template .iat file.|
|`list-module-version <serverUrl> <apiKey> <moduleId> <moduleVersion>`   |Updates a module to be listed (not hidden from searches). |
|`unlist-module-version <serverUrl> <apiKey> <moduleId> <moduleVersion>` |Updates a module version to be unlisted (hidden from searches).|

## upload-module command

Upload a module .imod file.

### upload-module usage

```bash
module-server-client-cli upload-module [<serverUrl> [<apiKey> [<path>]]] [options]
```

### upload-module arguments

|Argument    |Description|
|------------|-----------|
|`serverUrl` |The module server's https address.|
|`apiKey`    |The API key to use to authenticate the request.|
|`path`      |The path of the file to upload.|

### upload-module options

|Option           |Description|
|-----------------|-----------|
|`--force`        |If there is already an item with the same identifier and version then this option can be used force it to be overwritten.|
|`--unlisted`     |The module version should be unlisted (hidden from searches).|
|`-?, -h, --help` |Show help and usage information|

## upload-application-template command

Upload an application template .iat file.

### upload-application-template usage

```bash
module-server-client-cli upload-application-template [<serverUrl> [<apiKey> [<path>]]] [options]
```

### upload-application-template arguments

|Argument    |Description|
|------------|-----------|
|`serverUrl` |The module server's https address.|
|`apiKey`    |The API key to use to authenticate the request.|
|`path`      |The path of the file to upload.|

### upload-application-template options

|Option           |Description|
|-----------------|-----------|
|`--force`        |If there is already an item with the same identifier and version then this option can be used force it to be overwritten.|
|`-?, -h, --help` |Show help and usage information|

## list-module-version

Updates a module to be listed (not hidden from searches).

### list-module-version usage

```bash
module-server-client-cli list-module-version [<serverUrl> [<apiKey> [<moduleId> [<moduleVersion>]]]] [options]
```

### list-module-version arguments

|Argument        |Description|
|----------------|-----------|
|`serverUrl`     |The module server's https address.|
|`apiKey`        |The API key to use to authenticate the request.|
|`moduleId`      |The identifier or full name of the module.|
|`moduleVersion` |The version of the module.|

### list-module-version options

|Option           |Description|
|-----------------|-----------|
|`-?, -h, --help` |Show help and usage information|

## unlist-module-version

Updates a module version to be unlisted (hidden from searches).

### unlist-module-version usage

```bash
module-server-client-cli unlist-module-version [<serverUrl> [<apiKey> [<moduleId> [<moduleVersion>]]]] [options]
```

### unlist-module-version arguments

|Argument        |Description|
|----------------|-----------|
|`serverUrl`     |The module server's https address.|
|`apiKey`        |The API key to use to authenticate the request.|
|`moduleId`      |The identifier or full name of the module.|
|`moduleVersion` |The version of the module.|

### unlist-module-version options

|Option           |Description|
|-----------------|-----------|
|`-?, -h, --help` |Show help and usage information|
