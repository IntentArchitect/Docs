---
uid: tools.software-factory-cli
---
<!-- Workaround to align the column widths consistently -->
<style>
table th:first-of-type {
    width: 375px;
}
</style>

# Software Factory CLI

A CLI (command line interface) version of the Intent Architect Software Factory.

## Why use this tool?

This tool can easily be configured as part of your CI/CD pipeline to ensure your Intent Architect design and actual solution codebase are in sync.  This is  analogous to ensuring your codebase compiles and all tests pass when committing code, and is one of the major benefits of a CI/CD pipeline. The intention is to extend the CI/CD pipeline checks and balances to include that all Intent Architect designs are in sync with the underlying codebase. This tool allows developers to apply the same rigor to Intent Architect changes as they do to codebase changes, ensuring a more consistent and reliable codebase. This practice is particularly important when you have a team of developers collaborating on a shared repository.

## Pre-requisites

Latest Long Term Support (LTS) version of [.NET](https://dotnet.microsoft.com/download).

### Additional considerations when running custom modules

If your Intent Architect applications are running custom modules (i.e. modules which are not available at the `https://intentarchitect.com/` repository), you will need to ensure the following:

- The repository location containing your custom modules will need to be [added as a repository with its Context set to `Current Solution`](xref:application-development.applications-and-solutions.how-to-manage-repositories#repository-context).
- The operating system instance running the Software Factory CLI will need access to the location of the `.imod` files in order for it to be able to restore them during execution.

> [!TIP]
> The [](xref:tools.module-server) can be used for self-hosting custom modules to make them available over HTTP.

## Installation

This CLI tool is available as a [.NET Tool](https://docs.microsoft.com/dotnet/core/tools/global-tools) and can be installed with the following command:

```bash
dotnet tool install Intent.SoftwareFactory.CLI --global
```

> [!NOTE]
> If `dotnet tool install` fails with an error to the effect of `The required NuGet feed can't be accessed, perhaps because of an Internet connection problem.` and it shows a private NuGet feed URL, you can try add the `--ignore-failed-sources` command line option ([source](https://learn.microsoft.com/dotnet/core/tools/troubleshoot-usage-issues#nuget-feed-cant-be-accessed)).

You should see output to the effect of:

```text
You can invoke the tool using the following command: intent-cli
Tool 'intent.softwarefactory.cli' (version 'x.x.x') was successfully installed.
```

## Updating

A new version of the Software Factory CLI tool is also built and published as part of the automated build process which builds and publishes the Intent Architect desktop application. The version of the tool will always correspond with the version of the desktop application.

The same command for installation (`dotnet tool install Intent.SoftwareFactory.CLI --global`) will update the tool if an update is available and if none is available it reinstalls it making it safe to run the command as often as desired to ensure the tool is up to date.

## Usage

`intent-cli [command] [options]`

## Options

|Option|Description|
|------|-----------|
|`--version`                                           |Show version information|
|`-?, -h, --help`                                      |Show help and usage information|
|`--error-logging-command <error-logging-command>`     |Command to use for logging an error. Some continuous integration environments watch output for "commands" for logging of errors. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br />- Azure Pipelines: By default applies `"##vso[task.logissue type=error;]{@m} {@x}\n"` (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br /><br />See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>|
|`--warning-logging-command <warning-logging-command>` |Command to use for logging a warning. Some continuous integration environments watch output for "commands" for logging of errors. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br />- Azure Pipelines: By default applies `"##vso[task.logissue type=warning;]{@m} {@x}\n"` (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br /><br />See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>|

## Commands

|Command|Description|
|-------|-----------|
|`ensure-no-outstanding-changes <username> <password> <isln-path>` |Runs the Software Factory and if there are any outstanding changes it prints out an error and exits with a non-zero return code.|
|`apply-pending-changes <username> <password> <isln-path>` |Runs the Software Factory and applies any outstanding changes.|

## ensure-no-outstanding-changes command

Runs the Software Factory and if there are any outstanding changes it prints out an error and exits with a non-zero return code.

### ensure-no-outstanding-changes usage

```bash
intent-cli ensure-no-outstanding-changes <username> <password> <isln-path> [options]
```

### ensure-no-outstanding-changes arguments

|Argument|Description|
|--------|-----------|
|`<username>`  |Username for an active Intent Architect account.|
|`<password>`  |Password for the Intent Architect account.|
|`<isln-path>` |Path to the Intent Architect solution (.isln) file or folder containing a single .isln file.|

### ensure-no-outstanding-changes options

|Option|Description|
|------------------------------------------------------|-----------|
|`--check-deviations`                                  |Whether to also check for unapproved deviations.|
|`--application-id <application-id>`                   |The Id of the Intent Architect application. If unspecified then all applications found in the .isln will be run.|
|`--attach-debugger`                                   |The Software Factory will pause at startup giving you chance to attach a .NET debugger.|
|`-?, -h, --help`                                      |Show help and usage information|
|`--error-logging-command <error-logging-command>`     |Command to use for logging an error. Some continuous integration environments watch output for "commands" for logging of errors. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br />- Azure Pipelines: By default applies `"##vso[task.logissue type=error;]{@m} {@x}\n"` (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br /><br />See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>|
|`--warning-logging-command <warning-logging-command>` |Command to use for logging a warning. Some continuous integration environments watch output for "commands" for logging of errors. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br />- Azure Pipelines: By default applies `"##vso[task.logissue type=warning;]{@m} {@x}\n"` (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br /><br />See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>|

## apply-pending-changes command

Runs the Software Factory and applies any outstanding changes.

### apply-pending-changes usage

```bash
intent-cli apply-pending-changes <username> <password> <isln-path> [options]
```

### apply-pending-changes arguments

|Argument|Description|
|--------|-----------|
|`<username>`  |Username for an active Intent Architect account.|
|`<password>`  |Password for the Intent Architect account.|
|`<isln-path>` |Path to the Intent Architect solution (.isln) file or folder containing a single .isln file.|

### apply-pending-changes options

|Option|Description|
|------|-----------|
|`--application-id <application-id>`                   |The Id of the Intent Architect application. If unspecified then all applications found in the .isln will be run.|
|`--attach-debugger`                                   |The Software Factory will pause at startup giving you chance to attach a .NET debugger.|
|`-?, -h, --help`                                      |Show help and usage information|
|`--error-logging-command <error-logging-command>`     |Command to use for logging an error. Some continuous integration environments watch output for "commands" for logging of errors. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br />- Azure Pipelines: By default applies `"##vso[task.logissue type=error;]{@m} {@x}\n"` (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br /><br />See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>|
|`--warning-logging-command <warning-logging-command>` |Command to use for logging a warning. Some continuous integration environments watch output for "commands" for logging of errors. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br />- Azure Pipelines: By default applies `"##vso[task.logissue type=warning;]{@m} {@x}\n"` (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br /><br />See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>|

## Example: Azure Pipelines

> [!TIP]
> Install the `Intent.ContinuousIntegration.AzurePipelines` module into your Intent Architect application to have it automatically generate an `azure-pipelines.yml` file for you, refer its [readme](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.ContinuousIntegration.AzurePipelines/README.md) for more information.

### Create a variable group with the Intent Architect account details

[Create a variable group](https://docs.microsoft.com/azure/devops/pipelines/library/variable-groups#create-a-variable-group) with the Intent Architect account details, for example:

![Variable group with Intent Architect account details](images/create-variable-group.png)

### Link the variable group to the pipeline you want to use it in

Variable groups are defined globally for an Azure DevOps project, to be able to access a variable group for a particular pipeline, it needs to be [linked to it](https://docs.microsoft.com/azure/devops/pipelines/library/variable-groups#use-a-variable-group).

### Add the variable group and other variables to the pipeline YAML file

To make the variable group available to a stage within your pipeline, it will need to be added to its variables. You may also want to define variables for the other command line arguments and options:

```yml
variables:
- group: 'Intent Architect Credentials'
- name: 'intentSolutionPath'
  value: 'intent'
```

### Create a step to install the CLI

```yml
- task: PowerShell@2
  displayName: 'Install Intent Architect Software Factory CLI'
  inputs:
    targetType: 'inline'
    pwsh: true
    script: 'dotnet tool install Intent.SoftwareFactory.CLI --global'
```

### Create a step to run the CLI

```yml
- task: PowerShell@2
  displayName: 'run intent cli'
  env:
    INTENT_USER: $(intent-architect-user)
    INTENT_PASS: $(intent-architect-password)
    INTENT_SOLUTION_PATH: $(intentSolutionPath)
  inputs:
    targetType: 'inline'
    pwsh: true
    script: |
      intent-cli ensure-no-outstanding-changes "$Env:INTENT_USER" "$Env:INTENT_PASS" "$Env:INTENT_SOLUTION_PATH"
```

### A complete YAML file

```yml
trigger:
  batch: 'true'
  branches:
    include:
    - '*'

pool:
  vmImage: 'ubuntu-latest'

variables:
- group: 'Intent Architect Credentials'
- name: 'intentSolutionPath'
  value: 'intent'

steps:

- task: PowerShell@2
  displayName: 'Install Intent Architect Software Factory CLI'
  inputs:
    targetType: 'inline'
    pwsh: true
    script: 'dotnet tool install Intent.SoftwareFactory.CLI --global'

- task: PowerShell@2
  displayName: 'run intent cli'
  env:
    INTENT_USER: $(intent-architect-user)
    INTENT_PASS: $(intent-architect-password)
    INTENT_SOLUTION_PATH: $(intentSolutionPath)
  inputs:
    targetType: 'inline'
    pwsh: true
    script: |
      intent-cli ensure-no-outstanding-changes "$Env:INTENT_USER" "$Env:INTENT_PASS" "$Env:INTENT_SOLUTION_PATH"
```

### Run the pipeline

When you run the pipeline, it should now install the CLI and run it.
