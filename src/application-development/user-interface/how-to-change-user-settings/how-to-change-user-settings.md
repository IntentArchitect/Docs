---
uid: application-development.user-interface.how-to-change-user-settings
description: "How to access and configure user settings in Intent Architect: theme, update preferences, notifications, default application location, worktree location, diff tool, and preferred IDE."
---
# How to change user settings

To access the user settings:

1. Click your user Display Name dropdown at the top right-hand corner of the screen.
2. Click on `Settings`

![User Settings](images/user-settings.png)

## Theme

Choose between dark theme or light. By default Intent Architect will use your operating systems' theme settings.

## Updates

From time to time, Intent Architect may release pre-release versions of the product. To be notified and able to update to a new pre-release, enable the `Enable updating to pre-release versions` toggle. It is recommended that you keep this setting disabled as pre-releases can be less stable than official ones.

## Notifications

Two switches for AI chats that finish or need your input while Intent Architect is in the background: an OS notification, and a badge on the Intent Architect taskbar icon. The taskbar badge isn't available on Linux. Both are on by default.

## Default Application locations

This is the default location that Intent Architect will use when creating a new Application from the home view.

## Worktree Location

The folder Intent Architect creates Git worktrees in, for chats in the Agents Shell that run in a worktree of their own. Each worktree goes in a `<repository>/<branch>` folder under it. Leave it blank to use the default, `~/.worktrees`. See [](xref:how-to.run-several-agents-at-once).

## Diff Tools

Intent Architect supports the use of any Diff tool that can be executed from the CLI. By default (if blank), Intent Architect will use Visual Studio Code if it has been installed. It will fall back to using Visual Studio, and finally, if neither can be found, a Diff tool will need to be specified manually here.

## Preferred IDE

The IDE to use when using the [Open in IDE](xref:application-development.modelling.viewing-code) context menu option from within designers.
