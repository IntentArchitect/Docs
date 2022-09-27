---
uid: cli-tools.packager-cli
---
<!-- Workaround to align the column widths consistently -->
<style>
table th:first-of-type {
    width: 375px;
}
</style>

# Packager CLI

The packager CLI tool can be used for packaging Intent Architect artifacts.

## Pre-requisites

Latest Long Term Support (LTS) version of [.NET](https://dotnet.microsoft.com/download).

## Installation

The packager CLI tool is available as a [.NET Tool](https://docs.microsoft.com/dotnet/core/tools/global-tools) and can be installed with the following command:

```powershell
dotnet tool install Intent.Packager.CLI --global
```

> [!NOTE]
> If `dotnet tool install` fails with an error to the effect of `The required NuGet feed can't be accessed, perhaps because of an Internet connection problem.` and it shows a private NuGet feed URL, you can try add the `--ignore-failed-sources` command line option ([source](https://learn.microsoft.com/dotnet/core/tools/troubleshoot-usage-issues#nuget-feed-cant-be-accessed)).

You should see output to the effect of:

```text
You can invoke the tool using the following command: intent-packager
Tool 'intent.packager.cli' (version 'x.x.x') was successfully installed.
```

## Usage

`Intent.Packager.CLI [command] [options]`

## Options

|Option|Description|
|------|-----------|
|`--version`                                            |Show version information|
|`-?`, `-h`, `--help`                                   |Show help and usage information|
|`--warning-logging-command <warning-logging-command>`  |Command to use for logging a warning. Some continuous integration environments watch output for "commands" for logging of warnings. See the documentation on [Serilog.Expressions ExpressionTemplate](https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate) for formatting options.|
|`--error-logging-command <error-logging-command>`      |Command to use for logging an error. Some continuous integration environments watch output for "commands" for logging of errors. See the documentation on [Serilog.Expressions ExpressionTemplate](https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate) for formatting options.|

## Commands

|Command|Description|
|-------|-----------|
|`package-application <applicationPath> <destinationFolder>` |Package an application.|

## package-application command

Package an application.

### package-application arguments

|Argument|Description|
|--------|-----------|
|`<applicationPath>`   |Path to the `.application.config` file for the application.|
|`<destinationFolder>` |The destination folder in which to place the packaged module. The file will be named the same as the metadata file with a `.imod` extension.|

### package-application options

|Option|Description|
|------|-----------|
|`--version <version>`   |The version of the module.|
|`--authors <authors>`   |The authors of the module.|
|`--icon-url <icon-url>` |The icon to use for the module. The application's icon will be used by default.|
|`-?`, `-h`, `--help`    |Show help and usage information|

### package-application example

```bash
intent-packager package-application "./intent/intent-application/intent-application.application.config" "./Intent.Modules" --version "0.0.1" --authors "Intent Architect"
```
