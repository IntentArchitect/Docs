---
uid: release-notes.version-3-3
---
# Release notes: Intent Architect version 3.3

## Version 3.3.13

### Improvements added in 3.3.13

- Enhanced designer loading performance.
- SDK updates (requires version `3.3.2` or higher of the `Intent.SoftwareFactory.SDK` NuGet package):
  - `OverwriteBehaviour.OnceOff` is now truly "Once Off", even if the file is deleted it will not be generated again unless its template's entry is manually removed from the `<application name>.application.output.log` file.
  - Added `OverwriteBehaviour.OverwriteDisabled` which will never overwrite a file, but will re-generate it if it's deleted.
  - Detailed XML documentation applied to `OverwriteBehaviour` and its members.

### Issues fixed in 3.3.13

- Fixed: Undo / redo not working on stereotype multi-selects
- Fixed: Deleted items not being removed from stereotype property lookup options
- Fixed: Incorrect error message tooltip not showing on Stereotype Properties

## Version 3.3.12

### New features added in 3.3.12

- Support for Module release notes. See the `release-notes` tag in the [Module Manifest](xref:module-building.module-manifest) for more information on adding release notes to Modules.
- Extended JavaScript AssociationApi to have `isSourceEnd(): boolean` and `isTargetEnd(): boolean` methods.
- FileWatcher will focus now more on `*.xml` and `*.pkg.config` file changes instead of everything. Should reduce the amount of unnecessary file change popups.

### Issues fixed in 3.3.12

- Fixed: When `Metadata File Naming Convention` is set to `Use element name followed by unique identifier` and an element name was only different by casing, its file would be deleted during save.
- Fixed: JavaScript ElementApi not returning the correct association ends when calling `getAssociations(...)`.
- Fixed: Packages JavaScript API not showing stereotype functions.
- Fixed: Pixel misalignment on recent-applications in the recent solution list on the home page.
- Fixed: validations across sibling elements not showing and hiding errors as model changes.
- Fixed: Application Creation not using selected repository as preferred repository to install modules.
- Fixed: Dialog for unsaved changes pops up even when no changes made (in the case when associations span across more than one package).
- Fixed: The Software Factory would show a `More than one template registration is trying to output to the same path` exception for templates which were returning `false` for `CanRunTemplate()`.

## Version 3.3.11

### Issues fixed in 3.3.11

- Fixed: Software Factory does not restart on model save if completed (introduced in last build). Causes save button to become disabled and possible errors.

## Version 3.3.10

> [!NOTE]
> This build affects the way underlying Intent Architect model metadata is persisted. It is therefore highly recommended that users on a project all upgrade to this version together.

### New features added in 3.3.10

- Added `isTypeFound(): boolean` to TypeReference API in scripts.
- Added `isNullable` and `isCollection` to `IGenericTypeParameter` used to set the generic options for TypeReference in scripts.
- Application Templates now able to pre-configure module settings.
- Minor performance improvement applied to diagrams.
- Metadata File Naming Convention is now "Use element name followed by unique identifier" by default on all new apps.
- Metadata only stores `order` if necessary. This avoids unnecessary noise and clutter in version control when making changes to models.

   > [!WARNING]
   > Since metadata information may be removed when a model is saved this may cause some incompatibility (e.g. metadata ordering issues) with previous versions of Intent Architect.

### Issues fixed in 3.3.10

- Fixed: Mappings fail on first time creation when a package reference is missing
- Fixed: Stereotype TypeScript API intellisense not showing getProperty function (e.g. in `Is Active` and `Is Required` properties).
- Fixed: Diagram menu options not showing scripts that have been configured.
- Fixed: Designer Scripts starting with `const` failing to run.
- Fixed: Software Factory not discovering packages through references in certain circumstances.
- Fixed: Templates with `OverwriteBehaviour` as `OnceOff` being overwritten and renamed when Template Output location is changed.
- Fixed: Packages that come from installed Modules are incorrectly referenced in designers when the Module is updated.
- Fixed: Designer saves that fail showing a `Model saved successfully` toast.
- Fixed: Associations being able to connected diagrammatically to not allowed types.
- Fixed: When drag-copying an element to an another of same type, it would add the element as a child instead of to the parent.
- Fixed: Copy-dragging class attributes onto diagram background incorrectly creates and adds the attributes to the package.
- Fixed: Drag-copying classes and associations together loses associations and breaks undo/redo.
- Fixed: Shortcuts don't work after rubber-band selection in diagram
- Fixed: Classes in a folder are not deleted from diagram when the folder is deleted.
- Fixed: Associations could not connect from child visuals within diagrams, only from root visual elements.
- Fixed: Can't drag and drop stereotype definitions between folders/packages, but cut-paste works.
- Fixed: Copy-paste of Attributes using shortcuts places new copies above the selected element instead of below.
- Fixed: Run as debug doesn't pop-up if Software Factory is already running.
- Fixed: Underlying files changed prompt popping up for no reason during Software Factory executions.

## Version 3.3.9

### Issues fixed in 3.3.9

- Fixed: Multi-select type for Module Settings not working.
- Fixed: Software Factory failing when running non-C# modules that use the `Intent.RoslynWeaver.Attributes 1.1.3` NuGet package.
- Fixed: Error on save in designers (e.g. Domain) after copying an element with an association

## Version 3.3.8

### New features added in 3.3.8

- A new `setParent(...)` method has been added to elements for the macros and scripting API.

### Issues fixed in 3.3.8

- Fixed: Scripting errors would occur when accessing stereotypes on mapped associations.
- Fixed: It was not possible to move projects to different folders / packages in the Visual Studio designer.
- Fixed: If an element was renamed and a file already existed for the new generated file name, an error would occur during the software factory execution immediately after.
- Fixed: It was not possible to re-order packages in designers.
- Fixed: On file changes detected, if the dialog asking to reload the designer was declined, then a task would remain forever in a "processing" state in the output log.
- Fixed: On deleting an element, the parent was would be selected after instead of an adjacent element.
- Fixed: When selecting multiple elements and editing a "multi value" stereotype property, the selected values would not be applied.
- Fixed: "Include prerelease" was selected by default on the Modules screen.
- Fixed: The dialog asking whether or not to rename underlying files was not being presented after changing a package's name in from the tree view.
- Fixed: Auto reinstallation of modules from watched repositories wouldn't work for modules with a `pre-release` component in their version.
- Fixed: An error would show when there was more than one designer association extension even though only one would be changing the setting.

## Version 3.3.7

### Issues fixed in 3.3.7

- Fixed: (macOS) When a template's output file extension was an empty string the output file would have have a trailing period.

## Version 3.3.6

### Issues fixed in 3.3.6

- Fixed: `Allow Multiple Applies` for Stereotypes was not exposed through the SDK. It can now be accessed through the `AllowMultipleApplies` property on `IStereotypeDefinition` provided that version `3.1.1` or higher of the `Intent.SoftwareFactory.SDK` NuGet package is being used.
- Fixed: (macOS) The Software Factory execution would sometimes get "stuck" such that a restart of Intent Architect would be required before being able to run the Software Factory again.

## Version 3.3.5

### Issues fixed in 3.3.5

- Fixed: Repeated reads of the execution log during Software Factory execution would result in a significant increase in the total execution time.

## Version 3.3.4

_Released 2022/05/16._

### New features added in 3.3.4

- Bulk editor for multiple selected elements (i.e. can bulk change `Name`, `Type`, `Value`, `Is Nullable`, `Is Collection` and `Comment` across a set of selected Elements or Associations).

### Issues fixed in 3.3.4

- Fixed: Under certain circumstances, loading of packages in Designers would take a very long time.
- Fixed: When copying and pasting multiple elements at once, references to other copied elements would still point to the copied element rather than the new copies of them. This applies to Elements, Associations and their applied Stereotypes.
- Fixed: API metadata changes (e.g. `setMetadata("<key>", "<value>")` in a macro / script) not changing with undo/redo.

## Version 3.3.3

_Released 2022/05/11._

### Issues fixed in 3.3.3

- Fixed: When deleting an element, any associations of it weren't being deleted automatically.
- Fixed: (macOS) The shortcut key for delete was forward delete (⌦) instead of backwards delete (⌫).
- Fixed: (macOS) If Intent Architect was closed without the Software Factory being closed first, then the Software Factory process would get stuck in a high CPU usage state.

## Version 3.3.2

_Released 2022/05/01._

### Issues fixed in 3.3.2

- Fixed: Styling issue with statistics in light mode
- Fixed: Module settings not being displayed in some circumstances.

## Version 3.3.1

_Released 2022/04/28._

### Issues fixed in 3.3.1

- Fixed: Script API throwing errors when accessing parent elements on deleted elements.
- Fixed: Setting a stereotype value to its existing value still triggering an on-changed event.
- Fixed: Diagram Loaded logic getting called in certain edge cases where packages have not all finished loading.

## Version 3.3.0

_Released 2022/04/26._

### New features added in 3.3.0

- [Repository management enhancements](#repository-management-enhancements).
- [Software Factory Execution: Quickly navigate to errors or warnings](#software-factory-execution-quickly-navigate-to-errors-or-warnings).
- [Software Factory Execution: Code management statistics](#software-factory-execution-code-management-statistics).
- [Designer ad-hoc script execution](#designer-ad-hoc-script-execution)
- [Metadata File Naming Conventions](#metadata-file-naming-conventions).
- [Extensive Shortcut System Upgrade](#extensive-shortcut-system-upgrade).
- [Additional Application Template options](#additional-application-template-options).
- [Additional Event Hooks for Scripts](#additional-event-hooks-for-scripts).
- [Role-based Template Resolution](#role-based-template-resolution)
- Intent Architect upgraded to internally run using .NET 6. This allows the Software Factory to now support modules which are compiled to target any framework supported by .NET 6.
- Elements now allow specifying a custom validation function. This allows Designer authors to specify additional validation rules for their element types which make elements in the tree view highlight in red when any validation fails.
- Elements and Associations created from shortcuts pressed in the diagram context will automatically be added to the diagram.
- When a module is re-installed, unassigned `Template Output` elements will now be removed and re-added to Designers. This means that if a template did not initially have a Role in the Template Builder and one was applied later, on re-install of the module, the `Template Output` will be "moved" to the correct place.
- Module Settings are now available in scripts. For example, a script could access some setting in the following way: `let yourField = application.getSettings("Your Settings").getField("Your Field").value;`. This provides a mechanism for configuring scripts to behave differently based on settings for a particular application.
- Module Settings from one module can be extended by another. This prevents fragmentation of a cohesive set of options.
- Metadata key-value pairs to all elements and associations. These can be accessed by scripts on the element and associations API and via the SDK. These can be very useful for tracking information between scripts or setting hidden values that Templates may use.
- When creating a new application from within a solution, Intent Architect will now select the last used application template.
- Stereotype Definitions now have a setting to specify whether they can be added more than once (`Allow Multiple Applies`).

### Issues fixed in 3.3.0

- Fixed: It was not possible to select multiple mapped members with the same name in the mapping dialogue.
- Fixed: `ApplicationEvent` was not triggering handlers subscribed to them by event type and would only work by `EventIdentifier`. Both methods of subscribing now work.
- Fixed: Intent Architect would automatically upgrade modules to the "highest available version" of when a specific version could not be restored which could result in incompatible modules being installed. Intent will now just show an error that the module could not be restored.
- Fixed: When editing Stereotype property definitions, changes in text inputs wouldn't "apply" until focus was moved off the text input which could cause "pending" changes to not be included when using Ctrl+S to save the Designer.
- Fixed: Diagram context menu not showing options from Designer Extensions
- Fixed: Diagram context menu shortcuts not working.
- Fixed: Editing mapping paths on elements automatically removes a trailing period character if not typed quickly enough (due to the debounce).
- Fixed: Mapping errors not explicit or clear.
- Fixed: `Ctrl + S` not saving in designers after an element has been dragged.
- Fixed: Created associations would jump to the top of the class when the user clicks on an attribute within the target class.
- Fixed: Rename being reverted when clicking on the background of a diagram.
- Fixed: Attach Debugger dialog popping up multiple times in certain circumstances.

### Repository management enhancements

The `Asset Repository` dialogue available when pressing the "cog" icon from the Modules screens has been updated.

![Repository management enhancements](images/3.3.0/repository-management-enhancements.png)

1. The number of modules in the repository (file system based repositories only).
2. Launches your operating system's file browser which you can use to select the path.
3. Can be used to specify if the repository is:
   - Global: Saved to the user's computer and available to all Solutions and Applications.
   - Current Solution: Saved in the same folder as the Intent Architect Solution and is available to the Solution and any Applications within it.
   - Current Application: Saved in the same folder as the current Intent Architect Application and is only available to the Application.

   When changed, it will automatically update the `Address` to/from being fully qualified or update its relative location accordingly.
4. The link can be clicked on to open the location in your operating system's file browser.

### Software Factory Execution: Quickly navigate to errors or warnings

The Software Factory Execution now allows you to quickly navigate between errors and warnings by clicking on the relevant buttons:

![Navigate to errors or warnings](images/3.3.0/software-factory-execution-navigate-to-errors-and-warnings.png)

### Software Factory Execution: Code management statistics

The Software Factory Execution Changes dialogue now shows statistics on the number of lines and files being managed and affected by the current execution:

![Code management statistics](images/3.3.0/software-factory-execution-code-management-statistics.png)

### Designer ad-hoc script execution

You can now perform ad-hoc script executions in all Designers using the `Open Execute script dialog` button on the toolbar.

![Open Execute script dialog button](images/3.3.0/script-execution-button.png)

![Open Execute script dialog](images/3.3.0/script-execution-dialogue.png)

### Metadata File Naming Conventions

You can now select how metadata should be saved for an applications. Where previously, metadata files were saved as `${id}.xml` (e.g. `1391e9e0-b257-443a-bfe2-bbaea44aa0b8.xml`), using the setting as show below, the same metadata will be saved as `${name}__{unique-characters}.xml` (e.g. `User__hjw1hjyr.xml`). This has the advantage of making the files more human readable and easier to manage in version control.

![Open Execute script dialog](images/3.3.0/application-settings-metadata-file-naming-conventions.png)

### Extensive Shortcut System Upgrade

In line with our vision to eventually be able to interact entirely with Intent Architect solely through the keyboard, this version offers a substantial upgrade to the shortcuts system in the designers. It's also now possible to  view the shortcuts in any particular context by pressing `ctrl + .` to launch the `Keyboard Shortcuts` dialog, as shown below. The available shortcuts will change as the focus and context changes.

![Open Execute script dialog](images/3.3.0/keyboard-shortcuts.png)
This dialog is also available in the dropdown menu for the user at the top right-hand of the screen.

New keyboard shortcuts are also available from the Apply Stereotype dialog and Mapping dialog.

### Additional Application template options

- It is now possible to specify between "Multiple" or "Single Only" selection of components within a component group. When the "Single Only" option is selected, then when selecting a checkbox within a component group, any other selected checkbox within the same component group will be automatically deselected.

![Control selection of components within a component group](images/3.3.0/application-templates-control-component-selection.png)

- It is now possible to specify dependencies between components. When selecting the checkbox of a component which has dependencies, all the dependencies checkboxes are also automatically selected. When deselecting a checkbox, any other components which are dependent on it are also automatically deselected.

- It is now possible to make a component "Is Required". When a component "Is Required", then it cannot be deselected.

![Specify component dependencies and is required](images/3.3.0/application-templates-component-dependencies-and-is-required.png)

- It is now possible to specify settings for an application template which can be used to set different values during [metadata installation](xref:module-building.application-templates.metadata-installation).

![Specify application template settings](images/3.3.0/application-templates-settings-define.png)

![Application template with settings](images/3.3.0/application-templates-settings-preview.png)

### Additional Event Hooks for Scripts

These event hooks allow scripts to be executed whenever a particular change is detected on an Element / Association. Note that some script (e.g. `On Changed`) must be idempotent so as not to cause an infinite execution loop.

The following event hooks are now available:

- `On Loaded` - executed once when the diagram is loaded.
- `On Created` - executed on a newly created Element / Associations.
- `On Changed` - executed whenever a change related to the Element / Association occurs. It is important that this script is idempotent.
- `On Name Changed` - executed whenever the Element's / Association's name is changed. It is important that this script is idempotent.
- `On Type Changed` - executed whenever the Element's / Association's type reference is changed. It is important that this script is idempotent.
- `On Deleted` - executed when am Element / Associations is deleted.

Below illustrates how the new Intent.Metadata.RDBMS module is taking advantage of these event hooks to allow Intent Architect to create and maintain PKs and FKs automatically:

![module-builder-event-hooks](images/3.3.0/module-builder-event-hooks.png)

### Role-based Template Resolution

Up until this release, Modules would resolve other templates based on their identifier using the [`GetTypeName(...)`](xref:module-building.templates.resolving-type-names) system (e.g. `GetTypeName("<template-id>")`). This would couple modules together making it very difficult to swap out / replace a single module. Typically, if a developer would like to swap out a particular Module from the stack, they would have to fork all other modules too.

Now in Intent Architect 3.3, Modules can resolve templates in an additional way - by their roles. This is done in exactly the same way as resolving by identifier (e.g. `GetTypeName("<template-role>")` for a single template, `GetTypeName("<template-role">", "<model-id>")` for a template per model).  This allows modules to be _decoupled_ from each other but still be able to operate interdependently.

Under the hood, Intent Architect will fist attempt to resolve the template by assuming the first parameter is the identifier. If no template is found it will then attempt to resolve it based on its role.

[Roles](xref:application-development.code-weaving-and-generation.about-template-output-targeting) are defined in the Module Builder designer, under the properties of a template. It is worth noting that a template can fulfill more than one role. This can be indicated by separating each role by a comma (`,`), semicolon (`;`) or pipe (`|`) delimiter (e.g. a template with a role of `Domain.Entity; Domain.EntityInterface` can be discovered by either the `Domain.Entity` or `Domain.EntityInterface` role).
