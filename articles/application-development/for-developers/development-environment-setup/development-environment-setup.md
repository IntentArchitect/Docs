---
uid: application-development.development-environment-setup
---

# Intent Architect Development Environment Setup

## Enable Long Name Paths (Windows Only)

Enabling long path support in Windows is recommended for software development. Descriptive file and folder names often result in deep directory structures, which can exceed the default 260-character limit and cause build or runtime errors.

For more information on configuring Long Name Paths, read further [here](xref:application-development.getting-started.long-path-support-windows-only).

## Anti-Virus Whitelisting

To avoid negatively affecting developer productivity, we take the performance of the Software Factory very seriously. Over time, we have applied many optimizations and continue to identify new areas for improvement.

However, we have found that on some developer machines, environmental factors or configurations can significantly impact Software Factory execution speed.

For more information on environmental factors that can slow down Software Factory execution, read further [here](xref:application-development.software-factory.environmental-factors-which-can-slow-down-software-factory-execution).

## Default Diff Tool

Reviewing changes in Intent Architect is done through a third-party diff tool. We recommend using [Visual Studio Code](https://code.visualstudio.com/download) because it is lightweight, fast, and works directly with the underlying files—allowing for interactive editing in diff windows.

## User Settings

The `User Settings` section of the application allows you to configure various preferences, such as:

- Theming
- Default `Solution Location`
- Default IDE
- Default Diff Tool

For more information on configuring user settings, read further [here](xref:application-development.user-interface.how-to-change-user-settings).
