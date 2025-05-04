---
uid: application-development.development-environment-setup.development-environment-setup
---

# Intent Architect Development Environment Setup

## Enable Long Name Paths (Windows Only)

Enabling long path support in Windows is good practice for software development because user-friendly and descriptive file and folder names often lead to deep directory structures, quickly exceeding the default 260-character limit and causing build or runtime errors.

For more information on configuring Long Name Paths, read further [here](xref:application-development.getting-started.long-path-support-windows-only).

## Anti Virus White Listing

So as to avoid negatively affecting developer productivity, we take the performance of the Software Factory very seriously. Over time we have applied many optimizations to the Software Factory and continue to do so as we find areas where it's possible.

However, we have found that on some developer machines, environmental factors / configurations can negatively impact the Software Factory execution speed.

For more information on Environmental factors which can slow down Software Factory execution, read further [here](xref:application-development.software-factory.environmental-factors-which-can-slow-down-software-factory-execution).

## Default Diff Tool

Reviewing changes in Intent Architect is done through a 3rd party diff tool, we recommend using [Visual Studio Code](https://code.visualstudio.com/download), because its lightweight, fast and it work with the actual underlying files, which allows for interactive editing in diff windows.

## User Settings

Check out the `User Setting, this section of the application allows you configure various preferences, for example:

- Theming
- Default `Solution Location`
- Default IDE
- Default Diff Tool

For more information on configuring Long Name Paths, read further [here](xref:application-development.user-interface.how-to-change-user-settings).
