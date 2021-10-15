# Release notes: Intent Architect version 3.1

## Version 3.1.2

### New features added in 3.1.2

- The during the "Preparing Changes" phase of Software Factory, it will skip running Output Transformers when all the following are true since the previous Software Factory execution:
  - The module for the Output Transformer has not been re-installed or upgraded.
  - The Template Output hash is the same.
  - The existing file on your disk drive has the same hash.

  This significantly speeds up the Software Factory Execution time when you have a lot of files and there are very few changes since the previous execution. For the Software Factory to compare the current Software Execution to the previous one, at the end of each execution a `.intent/output.cache` is written/updated. This file is placed in an `.intent` folder as folders of this name should be ignored in your Source Code Management, this also means that the first run of the Software Factory on a particular machine will be slower, but subsequent runs will have the `output.cache` pre-populated and thus be faster.

## Version 3.1.1

## Issues fixed in 3.1.1

- For accounts which already had Professional licenses and had not re-logged in some time, this fixes "no permission" errors from showing until you log out and then back in again.

## Version 3.1.0

### New features added in 3.1.0

- [Overhauled the Software Factory Execution functionality](#software-factory-execution-functionality-overhaul) so that it supports a host of great new features including, but not limited to:
  - Can now be minimized and run in the background.
  - You can now run multiple Software Factory Executions for different Applications at the same time.
  - If a change to a Module on your file system is detected, or designer is saved, the Software Factory will automatically re-run itself.
- [Automatic re-installation of rebuilt Modules](#automatic-re-installation-of-rebuilt-modules).
- [Specify application wide configuration for a Module](#specify-application-wide-configuration-for-a-module).
- [Overhauled the Application Installer window](#overhauled-the-application-installer-window).
- [Keyboard shortcut for the "Define Mapping" screen](#keyboard-shortcut-for-the-define-mapping-screen).
- [Keep mapped member types in sync](#keep-mapped-member-types-in-sync).
- ["Contact Support" option now available to live chat with Intent Architect staff](#contact-support).
- [JavaScript macros](#javascript-macros).
- [Intent Architect now runs on .NET 5.0](#intent-architect-now-runs-on-net-50).
- ["Hints" can now be added to Stereotype Definitions and their Properties](#hints-can-now-be-added-to-stereotype-definitions-and-their-properties).
- [The display name of Type Reference selection fields can now be customized through the Module Builder](#the-display-name-of-type-reference-selection-fields-can-now-be-customized-through-the-module-builder).

### Issues fixed in 3.1.0

- Some "Browse" dialogues would open at an expected path.
- Keyboard shortcuts wouldn't work when used from the visual designer.
- When removing a mapping from a type, errors regarding unmapped paths would still show on the element.

### Software Factory Execution functionality overhaul

The Software Factory execution functionality has been overhauled.

#### Minimize the window

The window can now be minimized:

![The minimize button on the Software Factory Execution window](images/3.1.0/sf-minimize-button.png)

You can see its status at a glance in the status bar area, click on it to re-open it or right-click on it for additional options:

![The Software Factory Execution window minimized](images/3.1.0/sf-minimized.png)

#### Running multiple instances of the Software Factory at the same time

While a Software Factory Execution window is minimized, you can start additional instances:

![Multiple simultaneous Software Factory Executions](images/3.1.0/sf-multiple-instances.png)

#### Automatically re-run Software Factory when module updated

Intent Architect looks at your configured module repositories, watches all those paths for file system changes and will automatically restart the Software Factory when a change to a module is detected:

<p><video style="max-width: 100%" muted="true" loop="true" autoplay="true" src="videos/3.1.0/sf-auto-restart.mp4"></video></p>

### Automatic re-installation of rebuilt Modules

Intent Architect looks at your configured module repositories, watches all those paths for file system changes and will automatically re-install a module of the same version if a change to it is detected.

### Specify application wide configuration for a Module

When a Module is installed which specifies application wide configuration settings, these settings will be visible under the "Settings" section of an application:

![Application wide settings](images/3.1.0/application-wide-settings.png)

Any template within the module is then able to use this setting to control its behaviour.

### Overhauled the Application Installer window

The application installer window now provides detailed and structured information when creating a new application. It can also be minimized to and restored from the feedback bar in the bottom left corner of the UI.

![The updated application installer window](images/3.1.0/application-installer-window.png)

### Keyboard shortcut for the "Define Mapping" screen

The "Define Mapping" dialogue now has keyboard shortcuts for common actions such as selecting tree nodes.

### Keep mapped member types in sync

For a mapped property, there is now an option selected by default for the type reference to be kept in sync. For example, if you change an attribute in the domain from a `string` to an `int`, a field mapped from that attribute will have its type updated also with no intervention required.

### Contact Support

There is now a "Contact Support" option available to be able to live chat with Intent Architect support from directly from within the application.

### JavaScript macros

Intent Architect now supports JavaScript macros for automating certain kinds of tasks. We will be releasing more documentation on this soon.

### Intent Architect now runs on .NET 5.0

By having upgraded Intent Architect to .NET 5.0 it is now possible to create and use modules compiled for any .NET target compatible with the .NET 5.0 runtime.

### "Hints" can now be added to Stereotype Definitions and their Properties

You can now add a "Hint" to Stereotype Definitions and their Properties. These "Hints" can be used to better explain the intended purpose of Stereotype's or properties for users applying them to elements. A subset of markdown is also supported in these hints, namely \*\*bold\*\*, \_italics\_ and \[hyperlinks](https://intentarchitect.com/).

![The Stereotype "Hints" feature in action](images/3.1.0/stereotype-hints.png)

### The display name of Type Reference selection fields can now be customized through the Module Builder

Prior to this feature, when an element could reference another element, the label for this field was hard-coded as "Type".

![The "type" label in the properties pane](images/3.1.0/type-reference-type-label-customization-before.png)

It's now possible to customize this label and provide hint text (which works the same as [hints for stereotypes](#hints-can-now-be-added-to-stereotype-definitions-and-their-properties)) for it. In the module builder set the "Display Name" and "Hint" property values:

![Customizing type and hint for an element in the module builder](images/3.1.0/type-reference-type-label-customization-configuring.png)

Then when using the designer it will show the label customization and hint:

![Type label customization and hint text applied](images/3.1.0/type-reference-type-label-customization-applied.png)
