---
uid: application-development.applications-and-solutions.about-modules
---
# About Modules

## What is a Module

Modules are the _building blocks_ and artifacts of pattern reuse in Intent Architect.

Typically, the purpose of a Module is to generate and manage a set of code files in a codebase, usually around a particula-r architectural pattern. This could for example be the entities in a domain, simple bootstrapping files, ORM mappings, controllers in an Api, etc.

Modules have similarities with package systems such as NuGet, NPM, and Maven. However, where the primary objective of these system is to make code-reuse easier, the primary objective of Modules is _pattern-reuse_.

Modules have versions and dependencies, and don't directly introduce any runtime dependencies. They can, however, be configured to introduce package dependencies if the designer of the Module so chooses.

![Application Modules](images/application-modules-installed.png)
_An example showing the list of Installed Modules in a sample application. The `Intent.Application.MediatR` module has been selected, with its details displayed in the pane on the right._

> [!NOTE]
> When you select an installed Module, Intent Architect gives a view into the internals of that module (i.e. the Templates, Decorators, and Factory Extensions it is made up of).

## Installation Settings

When (re)installing a module you can expand the "Installation Settings" drop down.

![The installation settings dropdown](images/options-drop-down.png)

![The installation settings dropdown expanded](images/options-drop-down-expanded.png)

These settings are generally only of interest to those [building modules](xref:module-building.module-installation) who may want modules installed without all their capabilities enabled.

- **Enable Factory Extensions** - Controls whether the Software Factory will load any kind of extensions (templates, factory extensions, etc) from the module to execute.
- **Install Application Settings** - Controls whether settings from the module should be added to the [](xref:module-building.application-settings) screen.
- **Install Designer Metadata** - Controls whether [designer metadata embedded in the module](xref:module-building.application-templates.metadata-installation) is installed into designers on the initial installation of the module.
- **Install Designers** - Controls whether [designers](xref:application-development.modelling.about-designers) are installed into the application.
- **Install Template Outputs** - Controls whether [template outputs](xref:application-development.code-weaving-and-generation.about-template-output-targeting) are installed.
