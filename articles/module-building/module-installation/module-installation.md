---
uid: module-building.module-installation
---
# Module Installation

## Introduction

Installing modules in the context of module building within Intent Architect is a crucial step for referencing existing metadata from other modules that would act as dependencies. This allows you to add script hooks, extend designer elements, and make use of other components like Stereotypes. This document guides you through the process of installing modules from a module builder perspective, ensuring that only the necessary metadata is referenced without inadvertently installing components that are not needed.

## Installing a Dependency Module

Installing dependent modules follows the same steps in general:

1. **Open "Manage Modules..."**:
   - Open your Intent Architect solution.
   - Right-click on the application.
   - Select **Manage Modules** from the context menu.

2. **Selecting a Module to Install**:
   - In the Manage Modules window, search for the module you wish to install.
   - Click on the module to view its details.

3. **Expand Options Section**:
   - By default, Intent Architect will install all components of the module, including designers, templates, etc.
   - To avoid this (especially for building custom modules), expand the **Options** section.

4. **Install Metadata Only**:
   - Within the Options section, you will find a checkbox labeled **Install metadata only**.
   - Check this box to ensure that only the metadata is installed.
   - Proceed to click **Install**.

5. **Dependencies and References**:
   - Installing the module will introduce dependencies in your `imodspec` file.
   - It may also add NuGet references in your Visual Studio `.csproj` file related to your module project.

## Dependency Version Override Behavior

There is a setting in the **Settings** page under **Module Builder Settings** called **Dependency version override behavior**. This setting controls how dependency versions are introduced in the `imodspec` and `.csproj` files. The available options are:

- **Always**: Always override the dependency versions.
- **If newer**: Only override if the new version is more recent than the current version.
- **Never**: Do not override dependency versions (doesn't prevent dependencies being introduced).

### Configuring Dependency Override Behavior

1. Navigate to the **Settings** page in Intent Architect.
2. Under **Module Builder Settings**, locate **Dependency version override behavior**.
3. Choose the appropriate option based on your project requirements.
