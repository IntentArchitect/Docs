---
uid: release-notes.version-3-4
---
# Release notes: Intent Architect version 3.4

## Version 3.4.0

### Improvements added in 3.4.0

- `<dependency />` elements in `.imodspec` files now allow a `metadataOnly` attribute. When set with a value of `true` the dependency will be installed as if `Install metadata only` option was checked in the `Modules` screen. Version `3.3.3` of the `Intent.Packager` NuGet package will need to be installed for the module being packed.
- Modules installed with with `Install metadata only` (either through the UI option or due to the `metadataOnly` attribute having a value of `true`) will now also install their dependencies with the `Install metadata only` option set. Any dependencies that were already installed without `Install metadata only` being set will not have the option changed.

### Issues fixed in 3.4.0

- Fixed: (Windows) When adding an existing Package to a Designer, saving the Designer would delete the existing Package and its metadata from the file system.
- Fixed: Module release notes would render incorrectly for some markdown text.
- Fixed: Attempting to use an Element Type named `Constructor` in Designers would cause errors to occur.
- Fixed: Metadata installation would not update IDs for types selected in Stereotype properties.
- Fixed (Linux and macOS): `Critical error: system call interrupted` error would sometimes show when running the Software Factory.
- Fixed (Linux and macOS): If a change comparison tool (such as Visual Studio Code) was still open, it would sometimes prevent the Software Factory from being able to finish or restart.
