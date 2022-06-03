---
uid: user-interface.how-to-manage-repositories
---
# How to manage Repositories

Asset Repositories manages the repository locations that are searched when discovering Modules and Application Templates. The official Intent Architect server `https://intentarchitect.com/` is available as a repository hosting all the official (and largely Open Source) Modules for use. Additional sources can be added too which can point to a physical drive or remote/network locations.

## Locate the Manage Repositories dialog

There are a few ways to locate the Repository Management dialog.

### Profile Menu

From any screen within Intent Architect, click on the top right Profile menu and select `Repository Management`.

![Profile Menu](images/menu-manage-repositories.png)

### Solution Settings

Within the Intent Architect solution settings locate the `Manage Repositories` button like below.

![Solution Settings](images/solution-manage-repositories.png)

### Modules

Within any Modules view, locate the gear icon at the top right of the screen.

![Modules](images/modules-manage-repositories.png)

## Repository Management layout

![Default Layout](images/repository-management-diaglog-default.png)

At the very least you will always see the Intent Architect repository listed here, it's built-in and cannot be modified or removed on this screen.

A new Repository can be added by clicking on the `Add New` button, and one can browse to the desired location by clicking on the Browse button in order to set the Repository location. This location can be any valid path for your operating system, including relative (for application or solution level repositories), fully qualified and UNC paths.

The `Context` dropdown has the following options:

| Name | Description |
|-|-|
| Global | Intent Architect will search this Repository from any Intent Architect Solution. |
| Current Solution | Intent Architect will search this Repository only in the current Solution across all its Applications. |
| Current Application | Intent Architect will search this Repository only in the current Application and nothing more. |

The arrow buttons allow you to adjust the order in which Intent Architect searches in each Repository. The top most Repository will be visited first and the bottom most Repository will be visited last.

![Location and Status](images/repository-location-and-status.png)

Each Repository has a hyperlink (clicking on it opens up your File explorer on that location) and a counter badge next to it (indicating how many modules it detected at that location).
