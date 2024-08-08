---
uid: release-notes.intent-architect-v4.3
---
# Release notes: Intent Architect version 4.3

## Version 4.3.0

Intent Architect V4.3.0 primarily brings features and functionality to support the designing and automating of front-end user interfaces. This is new territory for our team and we're very excited to get your thoughts and feedback. In addition to back-end, our vision is to fully support the design and development of user interfaces in the various modern technologies (e.g. Blazor, Angular, etc.). This release is our first focused step along this journey, and one of many more to come. We'd like to thank all of our users for their support in helping us evolve Intent Architect to this point.

In conjunction with this release, our team has developed a set of UI Modules that focus on automating a Blazor UI using MudBlazor components. As of this writing, these modules are still in `alpha` release stages, but can be used to explore the new capabilities that 4.3.0 has to offer.

> [!NOTE]
> The `4.3.0-beta.x` release has been configured to run side-by-side with the stable version of Intent Architect. This makes it easy to try out the new release without having to downgrade afterwards.

> [!WARNING]
> It is worth keeping in mind that using this release on existing projects may make that project incompatible with the previous versions. We would therefore recommend that teams wait until the stable release before committing to using V4.3.0 on their existing "production" projects.

### Download Intent Architect 4.3.0-beta
The `4.3.0-beta.x` is available as a side-by-side install, so you can keep your current version of Intent Architect running along side. The beta can be acquired from our [downloads page](https://intentarchitect.com/#/downloads) in the `Pre-Release(s)` section.

### Highlights in 4.3.0

#### New Advanced Mapping Features

A key aspect of designing UI pages and components is the ability to bind the view to the backing view-model. The advanced mapping system introduced in V4.1.0 provides the perfect foundation for this capability. However, several new features and enhancements were needed to support this better.

##### Static Mappable Child Elements

This feature gives the ability to configure "static" mappable elements that will appear as children of actual elements. In other words, these mappable elements don't exist outside of the Advanced Mapping dialog, but play a crucial role in capturing all of the different bindings that are required by various UI components.

![Advanced Mapping Static Elements](images/4.3/advanced-mapping-static-elements.png)
_The screenshot above illustrates this with several examples such as the `On Click` mappable elements on the `Save` and `Cancel` buttons._

##### Scripting Options on Mappable Elements

A key paradigm in designing front-end components with Intent Architect in V4.3.0 is that the view-model metadata can be used to project out view components, and vice versa. To enable this, the Advanced Mapping system exposes a JavaScript API that can be used to automate these projections.

![Advanced Mapping Scripting Options Example](images/4.3/advanced-mapping-scripting-options.png)
_An example of two scripting options available for the `Model: PageResult<CustomerDto>?` property. These scripts are configured in the relevant Modules._

##### Other enhancements

- Access to underlying elements' creation and scripting context-menu options, allowing the user to add elements and associations on the fly directly inside of the Advanced Mapping dialog.
- Hiding of unusable mapping elements by default (hold down `alt` key to view all elements. Debug information is also made available). This helps de-clutter the Advanced Mapping dialog tree-views.
- `Ctrl + Enter` shortcut working inside of Advanced Mapping dialog.

#### Tiles control type in Dynamic Forms

Front-end views are made up of many different types of UI components, often including custom components. To facilitate an easy way to visually find the appropriate UI component, a `Tiles` control type has been added to the Dynamic Forms feature. This feature allows Module Builders to configure any array of options to be displayed as tiles with icons for the user to select. It supports filtering and the `tab` and `enter` keyboard shortcuts.

![Dynamic Form Tiles Control Type Example](images/4.3/dynamic-form-tiles-control-type-example.png)

#### Unique Name Validations and Auto-Naming

This feature ensures that names of adjacent elements are unique (where configured to be in the Designer Settings) by showing errors on adjacent elements that share the same name. In addition to this, Intent Architect will also append an auto-incrementing number to elements that are created or pasted that would otherwise end up with the same name as an existing adjacent element.

#### Traits System

This feature is "under the hood" of Intent Architect and perhaps interesting to developers that are configuring Designers through the Module Building ecosystem. The Traits system allows Elements and Associations can now be configured to implement Traits, which can be used to generically configure the constraints of other Elements and Associations.

A simple of example of how this is being used with the new front-end features, is in all the different Element types that represent standard UI components (e.g. Text Input, Button, Form, Table, etc.). All of these Element types implement the same Trait (`[Component]`) which can be accepted as children under the `Component View` Element type. This is key to the extensibility of the systems, and ensures that Designer configuration stays simple and manageable.

#### Task Output Console

Various improvements have been made the Task Output Console:

- The Task Output Console can be shown and hidden using the tilde (`~`) / back quote (`` ` ``) key (often below `Esc` on keyboards).
- Messages can now be filtered by text and source:

  ![Updated Task Output Console](images/4.3/task-output-console.png)

  "Source" refers to the designer tab from which the message originated:

  - **(all sources)** - No filtering by source occurs, all messages will be show.
  - **(no source)** - Only messages which do not originate from a particular designer tab will be shown.
  - **\<tab name\>** - When a designer tab is selected here (e.g. "Domain - MudBlazor.ExampleApp from above), then only messages originating from that tab will be shown.### Other Improvements in 4.3.0

### Other Improvements in 4.3.0

- Added better handling of unreachable HTTP(S) module server(s) when searching/restoring/installing/updating Modules and Application Templates. Previously, any request would take 60 seconds to timeout which could result in very slow restorations if a single custom HTTP(S) module repository was inaccessible for any reason. Now the timeout is just 3 seconds and if a failure occurs it will be instantly presumed to still be offline for at least 30 seconds making checks against other servers faster.
- Added `On Applied`, `On Changed` and `On Removed` scripting hook points to stereotypes.
- Searchable dropdowns now prioritize equal and startsWith filter matches in the list ordering.
- Added `toSentenceCase(word: string): string` and `toTitleCase(word: string): string` functions to all Designer Scripting JavaScript execution contexts.
- Designers will now display warnings, in addition to errors, in the toolbar and on-click navigates to elements that have the warnings.
- Dynamic Form supports `minWidth`, `maxWidth` and `height` configurations.
- Package Reference now exclude module packages by default. This should help simplify the process of adding package references.
- For Solutions with many applications, Intent Architect can now better handle running many Software Factories at once without any getting stuck.
- Pressing ALT-F4 on modal windows will no longer cause Intent Architect to get into an unrecoverable broken state of showing errors.
- The help icon now shows a menu with options to request help or open our Docs website:
- Warnings shown on Advanced Mappings that have unmapped required fields.

  ![Updated Help Menu](images/4.3/updated-help-icon.png)

### Issues fixed in 4.3.0

- Fixed: Sometimes when minimizing the Software Factory Execution window, Windows would jump to a different application.
- Fixed: Undo/redo when creating and altering associations would not work correctly in certain circumstances.
- Fixed: Different package types could not be reordered within the designers.
- Fixed: Drag and drop of mapped elements in the Advanced Mapping dialog leads to mapping errors in many scenarios. 
- Fixed: HTML flicker on editing elements.
- Fixed: Unexpected errors on elements with Advanced Mappings after altering connected elements.