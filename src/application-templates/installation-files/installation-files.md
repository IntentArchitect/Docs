---
uid: module-building.application-templates.installation-files
description: "How Application Templates copy files to a target location using File Installation Rules, including available target options and template string substitution."
---
# Installation files

## Overview

Application Templates can specify files to be copied to a target location as part of application creation. This is done using **File Installation Rules** configured in the Application Template designer under the `[installation settings]` node.

## How it works

Each File Installation Rule has the following properties:

| Property | Description |
|-|-|
| **Name** | A display name for the rule, typically the filename being installed. |
| **Match Files** | The filename (or glob pattern) used to locate the source file in the `resources` folder of the Application Template package. |
| **Target** | The destination directory — either `Output Directory` or `Application Config Directory`. |
| **Relative Output Folder** | *(Optional)* A subfolder path within the target directory where the file will be placed. |

For a file to be installed, a file whose name matches the **Match Files** pattern must be present in the `resources` folder of the Application Template.

## Target options

| Target | Description |
|-|-|
| `Output Directory` | The root output directory of the created Application, where generated code is placed. |
| `Application Config Directory` | The Intent Architect configuration directory for the Application. |

## Template string substitution

The content of installation files supports [template string substitution](xref:module-building.application-templates.template-string-substitution), allowing dynamic values such as the application name to be embedded in the file at installation time.
