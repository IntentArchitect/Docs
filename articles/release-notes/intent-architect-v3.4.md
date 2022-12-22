---
uid: release-notes.version-3-4
---
# Release notes: Intent Architect version 3.4

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
