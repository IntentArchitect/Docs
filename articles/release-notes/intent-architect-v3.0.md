# Release notes: Intent Architect version 3.0

## Version 3.0.17

### Issues fixed in 3.0.17

- It was not possible to change names for generic types.

## Version 3.0.16

### New features added in 3.0.16

- Distributions now available for Linux, see our [downloads page](https://intentarchitect.com/#/downloads) for available packages.
- Clickable link to release notes added to the "About" dialogue.

### Issues fixed in 3.0.16

- Sorting could sometimes cause issues with associations.
- Sometimes when an exception occurred during Software Factory Execution, the generation of the stack trace for that exception would itself cause an exception and result in a complicated error message in the Software Factory Execution log. The Software Factory Execution log will now show the original exception with its full stack trace.
