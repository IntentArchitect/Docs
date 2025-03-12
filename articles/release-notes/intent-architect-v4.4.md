---
uid: release-notes.intent-architect-v4.4
---
# Release notes: Intent Architect version 4.4

## Version 4.4.2

### Issues fixed in 4.4.2

- Fixed: Module interop dependencies could cause those dependencies to have their module installation settings changed to enable module options when installing seemingly unrelated modules.
- Fixed: It was not possible to update `.application.config` files as part of a module migration as Intent Architect wouldn't save files them before migrations or re-read them afterwards.

## Version 4.4.1

### Improvements in 4.4.1

- Improvement: It is now possible to search by guid (id) in the fast search and tree view filters.
- Improvement: `copyToClipboard` added to JavaScript Macro API.
- Improvement: Improved errors are now shown when designer configuration issues are detected.
- Improvement: Stereotypes in lookup dropdowns now also show which elements they apply to allowing disambiguation when they have the same names.
- Improvement: Improved telemetry collection of [certain metrics of usage](xref:application-development.user-interface.telemetry-collection).

### Issues fixed in 4.4.1

- Fixed: Clicking on a task in the taskbar would minimize and then immediately reopen its window.
- Fixed: On every save of a designer the mapping Target TypeReference's id was being overwritten and causing unnecessary noise in the SCM commit change logs. The id is no longer persisted.
- Fixed: Deleting a mapping in the Advanced Mapping dialog would sometimes just recreate it.
- Fixed: Advanced Mappings would show errors when moving components around in the tree view.

## Version 4.4.0

Intent Architect v4.4.0 primarily brings features and functionality to improve product usability and feature discoverability. Some examples of this would include new Help system, and a new suggestion system. This version is fully backwards compatible.

The 4.4 beta is available as a side-by-side install, so you can keep your current version of Intent Architect running alongside the beta. The beta can be acquired from our [downloads page](https://intentarchitect.com/#/downloads) in the `Pre-Release(s)` section.

### Highlights in 4.4.0

#### Help Topics, in product

Intent Architect now includes built-in `Help`. Pressing `F1` within the context of a designer opens the `Help` dialog. The dialog provides help topics that can be further filtered using the search bar.

![Help Topics Sample](images/4.4/help-dialog.png)

The `Help` dialog is context-aware. For example:

- Pressing F1 in a designer displays help topics specific to that designer.
- Selecting an `Element` such as a domain `Class` or CQRS `Command` filters help topics relevant to the selected element.

#### Suggestions

`Suggestion`s are a new feature intended to give context-specific assistance to modelers. When hovering your mouse over an `Element` that has suggestions, you will see a Light Bulb icon, indicating that suggestions are available.

![Suggestions Sample](images/4.4/suggestions-command.png)

Suggestions aim to assist with the following:

- Quickly model common scenarios, for example:
  - Publishing an `Integration Event` from a CQRS Command.
  - Subscribing to an `Integration Event`.
  - Publishing a `Domain Event` from a domain behavior.
- Add related Elements/Associations for existing Diagram Elements.
- Discover modeling options.

#### Search Everywhere

The Search Everywhere dialog allows you to quickly find aspects of your design using a unified, incremental search box that also supports abbreviation matching.  
The search is performed across applications, and the search results provide full context to make it easy to identify the desired result.

![Search Everywhere Sample](images/4.4/search-everywhere.png)

You can access the Search Everywhere dialog using its shortcut (Ctrl+T).

### Find Usages

The `Find Usages` (Shift+F12) feature has been vastly improved, leveraging the new `Search Everywhere` feature.

![Find Usages Sample](images/4.4/find-usages.png)

Find usages will present you with a list of all references to the modeled element, including across applications.

Example use cases for this feature:

- Who is subscribing to this Integration Event?
- What would be affected if I change this domain attribute?

### Filtered searching

When searching in the `Solution Explorer` and `designer tree-view`, these trees now filter to only show matching search results.

![Filtered Search Sample](images/4.4/filter-search.png)

### Solution folders

You can now group applications together by adding folders to the solution explorer. This is particularly useful if you have:

- Many Microservices.
- Logically similar applications you'd like to group together.

![Solution explorer folders](images/4.4/solution-explorer-folders.png)

### Improvements in 4.4.0

- "Options" on the details pane of "Module Management" screen has been replaced with ["Installation Settings"](xref:application-development.applications-and-solutions.about-modules#installation-settings) which allows more granular control of which features of a module are installed.

### Issues fixed in 4.4.0

- "Too many changes at once in directory" errors which might occur during Software Factory execution when running multiple Software Factories at once will now show an informative warning instead.
- Made Module Tasks more robust by ensuring processes complete properly after each execution under Linux.
