---
uid: application-development.software-factory.synchronize-code-to-design
---
# Synchronize code to design

Intent Architect is able to take changes manually made to code files and apply them back to your design in Intent Architect designers.

Synchronization supports structural aspects of source code files, here are some (non-exhaustive) examples:

- Added/removed/updated properties on domain entities can add/remove/update attributes in the Domain Designer.
- Added/removed/updated methods on domain entities can add/remove/update operations, including parameters, in the Domain Designer.
- Added/removed/updated properties on DTOs can add/remove/update attributes in the Services Designer.

> [!NOTE]
>
> Only templates which have implemented the required synchronization logic will offer this capability. We are progressively applying this logic to additional templates, in the meantime please reach out to our support team if there are particular templates you are looking to have this supported on sooner rather than later.

## Using the feature

For example a `Notes` property has been added to an entity in your IDE and when running the Software Factory it wants to remove it:

![Diff showing software factory trying to remove items](images/synchronize-code-to-design-diff.png)

Intent Architect will show a "Synchronize code to design" icon next to such files:

![Code to design synchronization available](images/synchronize-code-to-design-available.png)

> [!NOTE]
>
> Only templates which have implemented the required synchronization logic will show this icon. We are progressively applying this logic to additional templates, in the meantime please reach out to our support team if there are particular templates you are looking to have this supported on sooner rather than later.

On clicking the icon the Software Factory minimizes, the relevant designer will be opened, focussed and the changes applied. In the following screenshot notice the dirty indicator on the `Notes` attribute:

![Designer with code synchronized into it](images/synchronize-code-to-design-applied.png)

You can then save and the Software Factory will no longer want to remove those changes from the file.

## See also

- [For Module authors: Implementing reverse synchronization for C# templates](xref:module-building.templates-csharp.synchronize-code-to-design)
