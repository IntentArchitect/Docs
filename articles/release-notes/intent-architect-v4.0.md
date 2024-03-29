---
uid: release-notes.intent-architect-v4.0
---

# Release notes: Intent Architect version 4.0

## Version 4.0.6

### Issues fixed in 4.0.6

- Fixed: The [Software Factory CLI](xref:tools.software-factory-cli) would hang when generating diffs beyond a certain size.

## Version 4.0.5

### Improvements in 4.0.5

- Improved output of [Software Factory CLI](xref:tools.software-factory-cli) when there are outstanding changes to show details of what is outstanding.

### Issues fixed in 4.0.5

- Fixed: The Manage Modules screen would sometimes mix search results with that of previous searches which were still in progress.

## Version 4.0.4

### Improvements in 4.0.4

- Improved performance of change updates in and between designers.
- It is now possible to control whether or not hardware acceleration is enabled in the User Settings dialogue. Hardware acceleration was always enabled by default, but can now be disabled if needed.

### Issues fixed in 4.0.4

- Fixed: The Manage Repositories dialogue was not always able to correctly handle URLs for [self-hosted module servers](xref:tools.module-server).

## Version 4.0.3

### Improvements in 4.0.3

- Create Application wizard now shows total and selected number of modules per component in summary pane.
- SDK Update: OutputTransformers can now implement a `MustTransform` method where the transformer must run regardless of whether or not the template output was unchanged since the previous Software Factory execution. This is to cater for scenarios like the code management modules needing to run migrations.
- Implemented improved caching in the Software Factory Executions which leads to noticeable performance improvements.

### Issues fixed in 4.0.3

- Fixed: Stereotypes looking up their definition unnecessarily which can cause Software Factory exceptions.
- Fixed: When Intent Architect is opened by opening a `.isln` file, trying to run the Software Factory for any other solution fails with a `Failed to set up execution environment` error.
- Fixed: Software Factory Execution not searching package references tree deeper than the first level.
- Fixed: Styling issues on pre-release modules in the Create Application wizard.
- Fixed: Errors on copied Domain Classes intermittently not showing on package.
- Fixed: Copying and pasting elements multiple between designers can cause duplicate identifier issues.
- Fixed: Copy and paste of elements and associations between designers ignoring associations.
- Fixed: Dropping associations on diagram causing existing elements to be moved too.
- Fixed: Domain scripts can go into an infinite loop when a cyclic loop between associations and elements exists.
- Fixed: Dirty flag not appearing on the Services designer after running a CRUD script.

## Version 4.0.2

### Improvements in 4.0.2

- Upgraded Package Reference manager to show Package Icon, Type and Source. Also supports filtering and sorting.
- Trying to press "Save and Close" on User Settings will now show an error when either `Diff Tool Executable` or `Diff Tool Arguments` is set without the other also being set.
- Element extensions now add validations instead of override.
- Association Ends now support validations.
- Added "Need help? Have a question?" support links to home page and main toolbar.
- `Copy Application` feature (re)added to the application context menu in the Solution Explorer.
- Added user prompt on loading a designer if one or more settings could not be found.
- Mapping system will suffix the names of newly mapped types with the parent's name (when traversing types).

### Issues fixed in 4.0.2

- Fixed: Reloading of designers is triggered unnecessarily between designers.
- Fixed: Element Mappings created via scripts aren't able to resolve on path.
- Fixed: Module installation issues would sometimes occur when creating an additional Application to an already existing Solution.
- Fixed: Module installation wasn't respecting the `metadataOnly="true"` attribute on `<dependency />` elements in `.imodspec` files.

## Version 4.0.1

### Improvements in 4.0.1

- Module metadata installation will now occur only when a module is not currently installed, previously it would also occur when a module was being updated.

### Issues fixed in 4.0.1

- Fixed: Packages added to designers as part of metadata installation from modules or application templates would sometimes be added in an order which was different from the source.
- Fixed: Under certain circumstances Intent Architect wouldn't install the correct version a module dependency.
- Fixed: Repository watchers are not refreshed when a new repository is added while in the context of a Solution.
- Fixed: If you start creating an association in the diagram but don't connect the target end and then click on properties, it puts the diagram in a broken state. Now cancels the association creation.

## Version 4.0.0

We're proud to announce the release of Version 4 of intent Architect. This release has the result of many hours of effort and planning by the Intent Architect team. We're also pleased to say that the feedback we've received thus far from our beta testers has been incredibly positive.

Below is a link to a webinar that covers the major enhancements that are part of version 4, as well as some information on the backward compatibility and, of course, the highlights of the new release.

### Watch the webinar

[![Incompatible module warning](images/4.0.0/intent-architect-v4-webinar-cover-page.png)](https://intentarchitect.com/#/redirect/?category=resources&subCategory=webinar-introduction-to-intent-architect-v4)

To watch the webinar, `middle-click` on the image above or use the following link: [Introduction to Intent Architect V4](https://intentarchitect.com/#/redirect/?category=resources&subCategory=webinar-introduction-to-intent-architect-v4)

Please share your feedback on this version (and the webinar) by filling in this 1 min survey: [Share your feedback](https://intentarchitect.com/#/redirect/?category=resources&subCategory=Webinar-Feedback-Survey)

### Backward Compatibility

This release of Intent Architect is fully backward compatible with V3.4.x. It does simultaneously come with functionality that is not available in V3.4.x that, if used, would require other team members working on that application to upgrade to V4.0.x or higher.

The installation of this version is done alongside previous major version of Intent Architect, which means that both V3.x and V4.x can be installed at the same time. This should make it much easier to adopt without risk of disrupting team deadlines.

### Highlights in 4.0.0

#### New splash screen

- Shows the version
- New background image to make it distinguishable from V3.x

#### Home page

- New background and layout to make it distinguishable from V3.x
- Tightened up recent solutions view
- Increased max number of most recent solutions to 25
- Application version is visible in the bottom right
- User settings access in the top right

#### New solution layout

- Solution Explorer for easier multi-application accessibility
  - Tree-view component for expanding and collapsing visibility on applications and their designers.
  - Toolbar to create new applications, add existing applications to solution, expand all applications, and collapse all.
  - Search bar to quickly find an application with shortcut (`Ctrl/Cmd + F`)
  - Context menus on each node in the Solution Explorer with relevant actions.
  - Tree-view remembers which application nodes were the solution was closed and re-expands these when being reopened.
  - Allows multiple Software Factory Executions to be launched simultaneously.
- [Tab Management System](#tab-management-system) to allow multiple designers (and other views) to be worked on simultaneously - not possible in V3.x.
- Toolbar tightened up and extended with common actions that can be applied across various tabs. The toolbar offers the following standard options:
  - [Navigation system](#navigation-system) buttons
  - Save button: Saves changes in the active tab.
  - Save All button: Saves changes across all open tabs.
  - Undo / Redo buttons: Applies undo / redo to the active tab.
  - Export Model button: Exports the model in the active tab as an XML file (designer only).
  - Open Execute Script Dialog button: Opens the scripting dialog for the active tab (designer only).
  - Run Software Factory button: Launches the [Software Factory Execution](#software-factory-executions) for the application associated with the active tab. The `F5` shortcut can be used to do this automatically. This button also has a drop-down option for launching the Software Factory Execution in debugging mode.

#### Tab Management System

- Each tab runs as a separate processes. This improves performance of the application as different the different processes are more light-weight and can take advantage of multi-core CPUs.
- Each tab is kept in memory while it is open, so unsaved changes are not lost if a different tab is opened.
- Each tab has a context menu to perform common actions (e.g. Close all other tabs, etc.)
- Tabs can be reordered by dragging them.
- Tabs remember their state if (i.e. which tree node elements were expanded and selected) and reload to this state when being reopened.
- A solution remembers which tabs were opened and reopens them on opening the solution.
- Tabs indicate visually which one is currently being viewed and if the focus moves away from that tab.
- A tab list can be brought up to quickly flick between the different open tabs using the `Ctrl/Cmd + Tab` and `Ctrl/Cmd + Shift + Tab` shortcuts.
- Package changes on saving in one tab automatically triggers a reload of that package if it's a reference in another open tab.
- Overflowed tabs can be found by clicking the dropdown on the right of the tab bar.

#### Modules Manager

- Tightened up visual layout.
- Muted author text to make it easier to see the name of the module.

#### Designers

- Tracks dirty changes.
- Automatically reload packages packages that have changed from external sources (e.g. other open tabs, when they save).
- Improved error tracking system. Errors now only show on the element that has the error and on its owning package. By clicking on the red error warning icon, the selection in the model will automatically be set to all elements that have errors. This makes it much easier to see who the culprits are when an error is occurring.
- Stereotype Definitions can now use the `Filter by Function` option from the `Target Mode` which allows the user to specify a JavaScript function for whether the Stereotype can be applied to an element or not.
- Several minor bug fixes.

#### Navigation System

- Movement and selections in and between designers is tracked.
- The user can navigate back and forth using these buttons and the shortcuts (`Alt + Left Arrow` and `Alt + Right Arrow`)

#### Software Factory Executions

- Is also launched as a separate process in a modal window. This means that it can be moved and resized and that it improves performance of Software Factory Executions as the process is not dependent on refreshing the rest of the application while the SF updates.
- A link now exists at the bottom of the window which can be used to open the root location of the output.
- All changes listed in the Software Factory Execution are displayed as a path relative to the output location.
- Changes and analytics around those changes now remain visible after the SF has finished executing.
- A Unsaved Changes dialog will prompt if a Software Factory Execution is triggered while there are outstanding changes that have not been saved.
- Changed window frame style.
