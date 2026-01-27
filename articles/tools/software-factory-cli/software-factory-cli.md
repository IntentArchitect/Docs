---
uid: tools.software-factory-cli
---
<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD060 -->
# Software Factory CLI

<!-- Workaround to align the column widths consistently -->
<style>
table th:first-of-type {
    width: 375px;
}
</style>

A CLI (command line interface) version of the Intent Architect Software Factory.

## Why use this tool?

This tool can easily be configured as part of your CI/CD pipeline to ensure your Intent Architect design and actual solution codebase are in sync.  This is  analogous to ensuring your codebase compiles and all tests pass when committing code, and is one of the major benefits of a CI/CD pipeline. The intention is to extend the CI/CD pipeline checks and balances to include that all Intent Architect designs are in sync with the underlying codebase. This tool allows developers to apply the same rigor to Intent Architect changes as they do to codebase changes, ensuring a more consistent and reliable codebase. This practice is particularly important when you have a team of developers collaborating on a shared repository.

## Pre-requisites

Latest release version of [.NET](https://dotnet.microsoft.com/download).

> [!NOTE]
> To take advantage of the latest performance improvements available in .NET, newer versions Intent Architect (and subsequently its Software Factory) are upgraded as soon as possible to the latest release of .NET regardless of whether it is an STS or LTS version. While Intent Architect itself ships with the runtime it requires, as the Software Factory CLI is a .NET tool, it will require that you have the latest .NET version installed.

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

You should see output to the effect of:

```text
You can invoke the tool using the following command: intent-cli
Tool 'intent.softwarefactory.cli' (version 'x.x.x') was successfully installed.
```

### Common installation errors

#### The required NuGet feed can't be accessed, perhaps because of an Internet connection problem

If `dotnet tool install` fails with an error to the effect of `The required NuGet feed can't be accessed, perhaps because of an Internet connection problem` and it shows a private NuGet feed URL, you can try add the `--ignore-failed-sources` command line option ([source](https://learn.microsoft.com/dotnet/core/tools/troubleshoot-usage-issues#nuget-feed-cant-be-accessed)).

#### The settings file in the tool's NuGet package is invalid: Settings file 'DotnetToolSetting.xml' was not found in the package

If `dotnet tool install` fails with an error to the effect of `The settings file in the tool's NuGet package is invalid: Settings file 'DotnetToolSetting.xml' was not found in the package`, this is a [known misleading error by dotnet when you don't have the tool's target framework installed](https://github.com/dotnet/sdk/issues/38172).

If you're seeing this error on a build server you will need to ensure it has the latest .NET SDK installed, for example on Azure Pipelines you can add the following task to the `.yml` file to install a version of .NET, replacing `<major-version>` with the major version of .NET which should be installed:

```yaml
- task: UseDotNet@2
  displayName: 'Install latest .NET <major-version> SDK'
  inputs:
    version: '<major-version>.x'
```

This task can be used multiple times on the same Pipeline if you need to have multiple .NET SDK versions available, for example if the latest version of .NET is 10 and your code is targeting .NET 8 you can add the following two tasks:

```yaml
- task: UseDotNet@2
  displayName: 'Install latest .NET 8 SDK'
  inputs:
    version: '8.x'

- task: UseDotNet@2
  displayName: 'Install latest .NET 10 SDK'
  inputs:
    version: '10.x'
```

## Updating

A new version of the Software Factory CLI tool is also built and published as part of the automated build process which builds and publishes the Intent Architect desktop application. The version of the tool will always correspond with the version of the desktop application.

The same command for installation (`dotnet tool install Intent.SoftwareFactory.CLI --global`) will update the tool if an update is available and if none is available it reinstalls it making it safe to run the command as often as desired to ensure the tool is up to date.

## Usage

`intent-cli [command] [options]`

## Options

|Option          |Description|
|----------------|-----------|
|`-?, -h, --help`|Show help and usage information|
|`--version`     |Show version information|

## Commands

|Command                                                           |Description|
|------------------------------------------------------------------|-----------|
|`apply-pending-changes <username> <password> <isln-path>`         |Runs the Software Factory and applies any outstanding changes.|
|`ensure-no-outstanding-changes <username> <password> <isln-path>` |Runs the Software Factory and if there are any outstanding changes it prints out an error and exits with a non-zero return code.|

## apply-pending-changes command

Runs the Software Factory and applies any outstanding changes.

### apply-pending-changes usage

```bash
intent-cli apply-pending-changes <username> <password> <isln-path> [options]
```

### apply-pending-changes arguments

|Argument      |Description|
|--------------|-----------|
|`<username>`  |Username for an active Intent Architect account. If you're using an Organization Access Token (OAT), use "token", see [below](#do-i-have-to-use-the-credentials-of-a-user-license) for more information.|
|`<password>`  |Password for the Intent Architect account. If a password is causing a "response file not found" error see [below](#the-command-fails-with-a-response-file-not-found-value-error) for more information and a workaround.|
|`<isln-path>` |Path to the Intent Architect solution (.isln) file or folder containing a single .isln file.|

### apply-pending-changes options

|Option                                                |Description|
|------------------------------------------------------|-----------|
|`--application-id <application-id>`                   |The Id of the Intent Architect application. If unspecified then all applications found in the .isln will be run.|
|`--attach-debugger`                                   |The Software Factory will pause at startup giving you chance to attach a .NET debugger.|
|`--error-logging-command <error-logging-command>`     |Command to use for logging an error. Some continuous integration environments watch output for \"commands\" for logging of errors. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br/>- Azure Pipelines: By default applies \"{GetErrorLoggingCommand(CiType.AzurePipelines)}\" (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br/><br/>See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>"|
|`--warning-logging-command <warning-logging-command>` |Command to use for logging a warning. Some continuous integration environments watch output for \"commands\" for logging of warnings. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br/>- Azure Pipelines: By default applies \"{GetWarningLoggingCommand(CiType.AzurePipelines)}\" (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br/><br/>See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>"|
|`-?, -h, --help`                                      |Show help and usage information|

## ensure-no-outstanding-changes command

Runs the Software Factory and if there are any outstanding changes it prints out an error and exits with a non-zero return code.

### ensure-no-outstanding-changes usage

```bash
intent-cli ensure-no-outstanding-changes <username> <password> <isln-path> [options]
```

### ensure-no-outstanding-changes arguments

|Argument      |Description|
|--------------|-----------|
|`<username>`  |Username for an active Intent Architect account. If you're using an Organization Access Token (OAT), use "token", see [below](#do-i-have-to-use-the-credentials-of-a-user-license) for more information.|
|`<password>`  |Password for the Intent Architect account. If a password is causing a "response file not found" error see [below](#the-command-fails-with-a-response-file-not-found-value-error) for more information and a workaround.|
|`<isln-path>` |Path to the Intent Architect solution (.isln) file or folder containing a single .isln file.|

### ensure-no-outstanding-changes options

|Option                                                      |Description|
|------------------------------------------------------------|-----------|
|`--application-id <application-id>`                         |The Id of the Intent Architect application. If unspecified then all applications found in the .isln will be run.|
|`--attach-debugger`                                         |The Software Factory will pause at startup giving you chance to attach a .NET debugger.|
|`--check-deviations, --check-for-unapproved-customizations` |Whether to also check for any unapproved [customizations](xref:application-development.software-factory.customizations-screen).|
|`--continue-on-error`                                       |Whether Software Factory execution should continue to run for other applications when an error is encountered.|
|`--error-logging-command <error-logging-command>`           |Command to use for logging an error. Some continuous integration environments watch output for \"commands\" for logging of errors. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br/>- Azure Pipelines: By default applies \"{GetErrorLoggingCommand(CiType.AzurePipelines)}\" (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br/><br/>See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>"|
|`--warning-logging-command <warning-logging-command>`       |Command to use for logging a warning. Some continuous integration environments watch output for \"commands\" for logging of warnings. Will be automatically configured when the process is detected to be running on the following kinds of build servers:<br/>- Azure Pipelines: By default applies \"{GetWarningLoggingCommand(CiType.AzurePipelines)}\" (see <https://learn.microsoft.com/azure/devops/pipelines/scripts/logging-commands#logissue-log-an-error-or-warning>)<br/><br/>See the documentation on Serilog.Expressions ExpressionTemplate for formatting options: <https://github.com/serilog/serilog-expressions#formatting-with-expressiontemplate>"|
|`-?, -h, --help`                                            |Show help and usage information|

## FAQ

### The command fails with a "Response file not found '\<value\>'" error

This error will show if a provided argument (typically a password) starts with an `@` character and is due to it being attempted to be parsed as a [response file](https://learn.microsoft.com/dotnet/standard/commandline/syntax#response-files).

To prevent an argument being interpreted as a response file it must be preceded (not necessarily immediately) by an `--` argument, for example:

```bash
intent-cli ensure-no-outstanding-changes -- "user@example.com" "@Password1" "./intent-solution.isln"
```

Be aware that any optional arguments will need to be specified before the `--` argument, for example:

```bash
intent-cli ensure-no-outstanding-changes --application-id "db9e35a9-c663-478a-93cb-ba7c0fffee43" --check-for-unapproved-customizations -- "user@example.com" "@Password1" "./intent-solution.isln"
```

### Do I have to use the credentials of a user license?

To avoid having to store or use a specific user's credentials on environments like a continuous integration server, an Organization Access Token (OAT) can be used instead.

Please contact us and we will create and provide you an OAT for your organization, you can request as many as needed and optionally specify expiry times.

To use the OAT, use `token` as the username argument and the OAT as the password.

### The Software Factory on the CI server is showing pending changes which I can't see on my local machine

If the Software Factory CLI fails when run on a CI server due to pending changes which don't show on your local machine, here are some troubleshooting steps.

#### Git reset and clean

The simplest thing to try first on your own machine is to do a Git [`reset`](https://git-scm.com/docs/git-reset) and [`clean`](https://git-scm.com/docs/git-clean) which will reset the Git repository to as if it has been freshly cloned and checked out, which is what CI servers typically do.

> [!WARNING]
>
> Running Git `reset` and `clean` will remove any changes in your working directory that are not committed, make sure you stash or commit any changes first.

Close any IDEs or other tools that may hold file locks (including Intent Architect). If in doubt, exit them completely.

Run the following in your terminal in the repository folder (or alternatively using your preferred Git client):

```bash
git reset --hard
git clean -fdx
```

Open Intent Architect, open the Solution, wait for the module restoration to complete and finally run the Software Factory on your machine to see if it still wants to remove any changes.

#### Why can "resetting" everything fix the problem?

From Intent Architect's side, any [`.intent` folders should always be ignored by source control management](application-development.applications-and-solutions.git-and-scm-guidance). These folders contain the following data which under specific scenarios can affect the Software Factory output, in particular:

- `.intent/previous_output` - The contents of this folder should _not_ result in the Software Factory output differences on a fresh checkout.

  These contain snapshots of generated (but not merged) output of the previous software factory run. This previous output is used by the merging algorithms to determine which lines in merged sections can be removed. If these files are missing the merging algorithm will safely assume that all content in the file was user added and will not remove it.

- `.intent/output.cache` - The contents of this folder should _not_ result in the Software Factory output differences on a fresh checkout.

  These files store hashes of the contents of files managed by the Software Factory for performance reasons so that it can skip processing files which it can see have not changed since the previous execution. If this file is causing differences between your local machine and the CI server, it may indicate a cache invalidation bug in Intent Architect, please do [report any such issues to us](xref:getting-help#contact-support).

- `.intent/Intent.Modules` - Unless you are using custom modules, the contents of this folder should _not_ result in the Software Factory output differences on a fresh checkout.

  These contain a cache of installed modules after they have been downloaded from the official Intent Architect repository or from your own organization's internal repository if you are using custom modules.

  If somehow the content of the module cached on your local machine is different to the content of the module which is restored on your CI server, then this can be the cause of differences in Software Factory output, for example due to having different compiled code which outputs different template content. This can never happen from modules restored from the official Intent Architect repository as they are immutable, but it could happen if you're using a directory folder as a module repository and a particular `.imod` in the folder was overwritten with different content by your organization's module author(s). As a module author, this issue can be avoided by ensuring a version of the module in use by end users should never be modified and instead a new version should be created.

- `bin` and `obj` folders for .NET `.csproj` files - If you're using [global usings](https://learn.microsoft.com/dotnet/csharp/language-reference/keywords/using-directive#the-global-modifier), these folders _may_ result in software factory output differences compared to a fresh checkout.

  These folders are managed entirely by .NET and, amongst other data around building .NET assemblies, may contain a `.cs` file containing global usings generated by .NET based on `.csproj` content such as `<Using />` elements or enablement of [implicit using directives](https://learn.microsoft.com/dotnet/core/project-sdk/overview#implicit-using-directives).

  Intent Architect's `Intent.OutputManager.RoslynWeaver` module is able to automatically remove redundant using directives from files that it manages when it sees there is a global using for it.

  We have observed situations where somehow the global usings managed by .NET itself inside `.cs` files inside of the `bin` and/or `obj` folders are somehow out of date and the `Intent.OutputManager.RoslynWeaver` module will incorrectly remove usings from files. The exact circumstances leading to such a scenario are not clear to us, but clearing all `bin` and `obj` has been found to fix such issues.

#### Differences between different operating systems

A common scenario for development teams is having their CI servers running on Linux while developers do their work on other operating systems such as Windows or macOS.

##### File name case sensitivity differences

Linux has case-sensitive file and folder names while macOS and Windows do not. If a file was initially created by Intent Architect and committed into a Git repository and then later had only its casing changed (e.g. `Clientinvoice.cs` is renamed to `ClientInvoice.cs`), Intent Architect and Git on Windows and/or macOS will generally not pick up this file name casing change.

However, the Software Factory CLI on the CI server running Linux will show that this file needs to be created.

To resolve this issue, firstly ensure that the file/folder name casing is correct on the Windows file system. As Git on Windows tends not to pick up casing differences, you will need to use either of the following manual steps afterwards:

1. [The `git mv` command](https://git-scm.com/docs/git-mv) - This will explicitly have Git update its name of the file or folder to the new casing.
2. Temporarily rename the file or folder to a completely different name (not just casing) and commit to force Git to pick up the file name changes, then name it back and commit it again:

  a. Rename to `Temp1`
  b. Commit the changes to Git. A commit message such as "Fix file casing on Windows (commit 1 of 2)" might be appropriate.
  c. Rename to the desired name in the correct casing.
  d. Commit the changes to Git. A commit message such as "Fix file casing on Windows (commit 2 of 2)" might be appropriate.

If there are multiple files and/or folders with incorrect casing an easy solution would be to use technique #2 above by either temporarily changing the name of a parent folder within the Git repository or alternatively moving all files and folders in the root of the repository to temporary and then out again afterwards.

##### Line ending differences

For line endings in files, Windows operating systems use `CRLF` (`\r\n`) while Linux and macOS simply use `LF` (`\n`).

Intent Architect (as of version 4.4.0 release February 2025) should ignore all whitespace differences including line endings. If the Software Factory CLI is showing pending changes which seem to only be whitespace differences, please [report any such issues to us](xref:getting-help#contact-support) so that we can investigate further.

##### Local Linux testing suggestions

If the Software Factory on your CI server running Linux is still failing due to pending changes, a good way to troubleshoot the issue more easily is by running Linux through a Virtual Machine or WSL (Windows Subsystem for Linux) on your local machine.

Based on our own experience, we strongly recommend WSL for Windows users as it even allows almost seamless [debugging of custom modules from a Visual Studio instance on your Windows desktop to a Linux process running under WSL](https://learn.microsoft.com/visualstudio/debugger/debug-dotnet-core-in-wsl-2).

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
      intent-cli ensure-no-outstanding-changes -- "$Env:INTENT_USER" "$Env:INTENT_PASS" "$Env:INTENT_SOLUTION_PATH"
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
      intent-cli ensure-no-outstanding-changes -- "$Env:INTENT_USER" "$Env:INTENT_PASS" "$Env:INTENT_SOLUTION_PATH"
```

### Run the pipeline

When you run the pipeline, it should now install the CLI and run it.
