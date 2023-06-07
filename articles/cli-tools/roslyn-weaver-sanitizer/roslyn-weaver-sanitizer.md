---
uid: cli-tools.roslyn-weaver-sanitizer
---
<!-- Workaround to align the column widths consistently -->
<style>
table th:first-of-type {
    width: 375px;
}
</style>

# RoslynWeaver Sanitizer

The RoslynWeaver Sanitizer CLI tool can be used to remove all references of Intent code management attributes and NuGet packages from a Visual Studio solution.

Removing code management attributes and NuGet references may be needed for situations where a deployment policy prevents inclusion of unapproved/non-essential NuGet packages.

> [!NOTE]
> Intent code management attributes are passive and contain no processing logic, additionally, because all the attributes have `[Conditional("INTENT_ROSLYN_WEAVER_ATTRIBUTES")]` applied to them, the C# compiler code does not include them in the generated [CIL](https://en.wikipedia.org/wiki/Common_Intermediate_Language). The source code for the `Intent.RoslynWeaver.Attributes` NuGet package is available on [GitHub](https://github.com/IntentArchitect/Intent.RoslynWeaver.Attributes) for review.

## Pre-requisites

Latest Long Term Support (LTS) version of [.NET](https://dotnet.microsoft.com/download).

## Installation

The tool is available as a [.NET Tool](https://docs.microsoft.com/dotnet/core/tools/global-tools) and can be installed with the following command:

```powershell
dotnet tool install Intent.RoslynWeaverSanitizer.CLI --global
```

> [!NOTE]
> If `dotnet tool install` fails with an error to the effect of `The required NuGet feed can't be accessed, perhaps because of an Internet connection problem.` and it shows a private NuGet feed URL, you can try add the `--ignore-failed-sources` command line option ([source](https://learn.microsoft.com/dotnet/core/tools/troubleshoot-usage-issues#nuget-feed-cant-be-accessed)).

You should see output to the effect of:

```text
You can invoke the tool using the following command: intent-csharp-code-management-sanitizer
Tool 'intent.roslynweaversanitizer.cli' (version 'x.x.x') was successfully installed.
```

## Usage

`intent-csharp-code-management-sanitizer <sln-path> [options]`

### Arguments

|Argument|Description|
|-|-|
|`<sln-path>`         |The path of the .sln file of the solution to sanitize.|

### Options

|Option|Description|
|-|-|
|`--version`          |Show version information|
|`-?`, `-h`, `--help` |Show help and usage information|

## Example: Azure Pipelines

### Create a step to install the tool

```yml
- task: PowerShell@2
  displayName: 'Install the Intent RoslynWeaver Sanitizer'
  inputs:
    targetType: 'inline'
    pwsh: true
    script: 'dotnet tool install Intent.RoslynWeaverSanitizer.CLI --global'
```

### Create a step to run the tool

```yml
- task: PowerShell@2
  displayName: 'Run the Intent RoslynWeaver Sanitizer'
  inputs:
    targetType: 'inline'
    pwsh: true
    script: 'intent-csharp-code-management-sanitizer src/Solution.sln'
```

> [!IMPORTANT]
> The above two tasks must happen in your pipeline before the task which compiles the Visual Studio solution.

### A complete YAML file

```yml
trigger:
  batch: 'true'
  branches:
    include:
    - '*'

pool:
  vmImage: 'ubuntu-latest'

steps:

- task: PowerShell@2
  displayName: 'Install the Intent RoslynWeaver Sanitizer'
  inputs:
    targetType: 'inline'
    pwsh: true
    script: 'dotnet tool install Intent.RoslynWeaverSanitizer.CLI --global'

- task: PowerShell@2
  displayName: 'Run the Intent RoslynWeaver Sanitizer'
  inputs:
    targetType: 'inline'
    pwsh: true
    script: 'intent-csharp-code-management-sanitizer src/Solution.sln'

- task: DotNetCoreCLI@2
  displayName: 'dotnet publish'
  inputs:
    command: 'publish'
```

### Run the pipeline

When you run the pipeline, it will install the tool, run it and then compile the solution without any Intent dependencies.
