# Release notes: Intent Architect version 4.0

## Version 4.0.1

- Fixed: Under certain circumstances Intent Architect wouldn't install the correct version a module dependency.
- Module metadata installation will now occur only when a module is not currently installed, previously it would also occur when a module was being updated.
- Fixed: Packages added to designers as part of metadata installation from modules or application templates would sometimes be added in an order which was different from the source.

## Version 4.0.0

We're proud to announce the release of Version 4 of intent Architect. This release has the result of many hours of effort and planning by the Intent Architect team. We're also pleased to say that the feedback we've received thus far from our beta testers has been incredibly positive.

Below is a link to a webinar that covers the major enhancements that are part of version 4, as well as some information on the backward compatibility and, of course, the highlights of the new release.

### Watch the webinar

[![Incompatible module warning](images/4.0.0/intent-architect-v4-webinar-cover-page.png)](https://intentarchitect.com/#/redirect/?category=resources&subCategory=webinar-introduction-to-intent-architect-v4)

To watch the webinar, `middle-click` on the image above or use the following link: [Introduction to Intent Architect V4](https://intentarchitect.com/#/redirect/?category=resources&subCategory=webinar-introduction-to-intent-architect-v4)

Please share your feedback on this version (and the webinar) by filling in this 1 min survey: [Share your feedback](https://intentarchitect.com/#/redirect/?category=resources&subCategory=webinar-introduction-to-intent-architect-v4-feedback-survey)

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
