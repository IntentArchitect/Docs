---
uid: release-notes.version-3-4
---
# Release notes: Intent Architect version 3.4

## Version 3.4.3

### Issues fixed in 3.4.5

- Fixed: Output Location path was being computed incorrectly when creating a new application for an existing solution.

### New features in 3.4.4

- The `Intent.SoftwareFactory.CLI` `dotnet tool` will now always output its version when starting.
- Added the Intent Architect version to the warning message which is displayed when the current version of Intent Architect is out of range of a module's supported client version.

### New features in 3.4.3

- The following Application Template settings now respect defaults as defined in Application Templates:
  - `Place solution and application in the same directory`
  - `Store Intent Architect files separate to codebase`
  - `Set .gitignore entries`
  - `Relative Output Location`

  Use version `3.4.3-pre.0` of the `Intent.ApplicationTemplate.Builder` to be able to set these default values.
- For new Applications, the `Relative Output Location` text field has been replaced with an `Output Location` text field which is used to specify the absolute output location and a `Browse` button has been added for convenience. A preview of the `Relative Output Location` which will ultimately be saved to the `.application.config` file is computed in real time and displayed beneath the `Output Location` text field.  

### Issues fixed in 3.4.3

- Fixed: When copying elements between packages, element metadata information, associations and diagrams would not always copy correctly for certain scenarios.
- Fixed: When copying elements, the value for `externalReference` was copied over to the new element.
- Fixed: When there were duplicate values for `externalReference`s an exception would occur when installing modules with metadata installation. A warning will now instead be shown when a duplicate is detected.

## Version 3.4.2

### Issues fixed in 3.4.2

- Fixed: Search criteria would sometimes go out of sync between the "Browse", "Installed" and "Updates" tabs under "Modules".

## Version 3.4.1

### Improvements in 3.4.1
- Extended Designer Scripting API to support diagram control (e.g. adding and removing visual elements). The currently active diagram can be accessed through the `currentDiagram` property.
- Type References dropdown clears when focused which allows the user to start typing without first pressing backspacing.
- Now routing all designer scripting `console.<log|warn|error>(...)` outputs to the IA console (instead of the electron devtools).

### Issues fixed in 3.4.1

- Intent will now log a debug level message instead of throwing error when creating an Application with unresolved `${...}` entries in any of its installation metadata.
- Fixed: Child Elements of Associations unable to resolve type references after save and reload.
- Fixed: `ITypeReference` JavaScript API returning incorrect values from `getIsNullable()` function.
- Fixed: `setMapping(elementId, mappingSettingsId)` on `IElement` JavaScript API not finding correct mapping-settings when passing in a `mappingSettingsId`.
- Fixed: Elements with generic type parameters would always be expanded to during loading of the designer.
- Fixed: Clicking links in module release notes would open them within the Intent Architect application instead of the default system web browser.
- Fixed: Domain Class names not updating when Generalization association's generic type is changed.

### Other changes in 3.4.1

- Software Factory Executable skips running git diff if more than 50 file overwrites/renames occur. This prevents performance delays on large change sets.

## Version 3.4.0

### New features in 3.4.0

- Snap to grid and display grid toggle
- SVG symbols display
- Adjustable navigation panel
- Icons of Elements and Associations can now be configured and dynamically controlled through JavaScript functions.
- Auto-layout of elements and associations in diagrams (Dagre algorithm) on drag-drop from the Model.
- Find usages context menu option for elements - highlights references to the type within the model view.
- Stereotype display icon function - allows logic around whether to display the applied stereotypes icon and can be used to configure the display of different icons
- Configurable default Package names using JavaScript function.
- Support for adding child elements to associations.

### Improvements in 3.4.0

- Association can be created from both their target-end or source-end from a menu-context option.
- Diagram anchors converted to SVG icons, improving sharpness of diagrams
- Module dependencies can now specify `metadataOnly` to denote that only the metadata of the dependency should be installed.
- Added TemplateExists methods to ExecutionContext in SDK.
- Associations now only add other end to target class when the association is bidirectional. This will allow for better support for associations between elements in different packages.
- Type References are no longer added as children of the Element or Association. Generic Arguments are still added as children.
- Generic Types and Generic Arguments now support undo/redo.
- Debounce on element selection to display properties, to improve responsiveness when navigating the tree model.
- Find in Diagram can be done across multiple elements / associations.
- Application Templates now support MetadataOnly installations, and configuration of module isRequired and includedByDefault.
- All designer script execution tasks are logged to the Console along with the script and any errors that occurred. Errors will cause the icon to stay in the error state and linger instead of popping up the dialog.
- `<dependency />` elements in `.imodspec` files now allow a `metadataOnly` attribute. When set with a value of `true` the dependency will be installed as if `Install metadata only` option was checked in the `Modules` screen. Version `3.3.3` of the `Intent.Packager` NuGet package will need to be installed for the module being packed.
- Modules installed with with `Install metadata only` (either through the UI option or due to the `metadataOnly` attribute having a value of `true`) will now also install their dependencies with the `Install metadata only` option set. Any dependencies that were already installed without `Install metadata only` being set will not have the option changed.


### Fixes in 3.4.0

- Fixed: Markdown in Module release notes not rendering correctly in some circumstances
- Fixed: When adding an existing Package to a Designer, saving the Designer would delete the existing Package and its metadata from the file system (Windows).
- Fixed: Operation to Query mappings are offering the referenced type's (e.g. DTO) fields as options to be mapped.
- Fixed: Element Types named `Constructor` in Designer Settings cause exceptions thrown when used in designers.
- Fixed: Some UI elements, such as visuals, not reacting to the OS switching between light and dark mode.
- Fixed: When editing an element's name and type, clicking outside on certain parts of the UI causes changes to be lost.
- Fixed: Multiple error dialogs show up when dragging and dropping associations that don't have visuals onto a diagram
- Fixed: AssociationEnd Settings could not be found in the diagrams, specifically when the AssociationEnds are not named starting with Association's name.
- Fixed: Domain designer can get into a frozen / unworkable state after hiding an element.
- Fixed: Unexpected Error dialog with "Cannot read properties of null (reading 'children')" pops up after saving when there is an unresolved error in the designer.
- Fixed: (Windows) When adding an existing Package to a Designer, saving the Designer would delete the existing Package and its metadata from the file system.
- Fixed: Module release notes would render incorrectly for some markdown text.
- Fixed: Attempting to use an Element Type named `Constructor` in Designers would cause errors to occur.
- Fixed: Metadata installation would not update IDs for types selected in Stereotype properties.
- Fixed (Linux and macOS): `Critical error: system call interrupted` error would sometimes show when running the Software Factory.
- Fixed (Linux and macOS): If a change comparison tool (such as Visual Studio Code) was still open, it would sometimes prevent the Software Factory from being able to finish or restart.
