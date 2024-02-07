---
uid: release-notes.intent-architect-v4.2
---

# Release notes: Intent Architect version 4.2

## Version 4.2.0

Intent Architect V4.2 comes with several highly anticipated features, many of which are direct requests from yourselves, the users. This release also comes with several "groundwork" features that we've added to support future enhancements and capabilities. Please share your thoughts and feedback on this release with our team.

### Highlights in 4.2.0

#### C# code management instruction deviation tracking

The Software Factory now tracks code management instruction deviations, any found are visible on the new _Deviations_ tab:

![The deviations tab on the Software Factory](images/4.2/deviations.png)

Double-clicking a deviation will open a diff comparing the unmerged template output (left) with the current file (right):

![Diff of a deviation](images/4.2/deviation-diff.png)

Editing and saving the file in the right pane will trigger re-running the code merging for that particular file, for example to remove instruction deviations:

![Deviation removed](images/4.2/remove-deviation.png)

Deviations can be approved by right-clicking it and selecting "Approve deviation":

![Approve deviation](images/4.2/approve-deviation.png)

Approving a deviation records the person who performed the deviation and when they did so:

![Approved deviation details](images/4.2/approved-deviation-detail.png)

If the particular deviation(s) for the file changes, the approval is automatically revoked, approvals can also be manually revoked using the context menu.

Also available through the context menu is the ability to update "Notes" on the deviation:

![Notes dialogue](images/4.2/deviation-notes-dialog.png)

![Notes applied](images/4.2/deviation-notes-applied.png)

Finally, the [Software Factory CLI tool](xref:tools.software-factory-cli)'s `ensure-no-outstanding-changes` command now has a `--check-deviations` option that when applied will cause the tool to also "break the build" when any unapproved deviations are detected.

#### Edits to staged changes will now be applied

When looking at a diff a staged file change, it is now possible to edit and save the right-pane. When any edit is saved, the Software Factory will re-apply code merging and save the updated staged changes when the pending Software Factory changes are applied with the "Apply" button.

#### Syntax Highlighting and `Ctrl + Click` Navigation

As part of our strategy to continuously enhance the designers into highly efficient and productive modeling systems, we've enabled syntax highlighting of the display text for each element in the tree-view designers. User's can navigate to types directly by using the `Ctrl + Click` shortcut.

![Example Syntax Highlighting](images/4.2/intent-architect-syntax-highlighting.png)
Above: Example syntax highlighting in dark mode.

For those who are interested in the configurability of the syntax highlighting as part of Module Building, the `Display Text Function` of Element Settings now also allows the return of an object array with the display parts and their configuration. It's also worth noting that there is a default mode which will highlight type-reference in cases where the `Display Text Function` has not been set.

```javascript
const result = [{ text: `${ name }${ genericTypes }`, cssClass: "muted" } ];
result.push({ text: ': ', cssClass: "annotation" });
result.push({ text: typeReference.display, cssClass: "typeref", targetId: typeReference.typeId }); // navigable through Ctrl + Click
return result;
```
Above: An example `Display Text Function` implementation.

The currently available `cssClass` options are `keyword`, `typeref`, `muted` and `annotation`. Users can also simply set a `color` field if they wish to customize the color completely.

#### Triggerable Module Tasks

The Module Tasks feature aims to lay the groundwork for a whole avenue of powerful new features and capabilities in the platform. Simply put, Module Tasks are discoverable execution points that can be created inside of the .NET DLL of a Module. These executables can then be triggered via JavaScript in the Designer Scripting. For example, the following Module Task class can be created in a Module. 

To give a simple example:

```csharp
public class ExampleModuleTask : IModuleTask
{
    public string TaskTypeId { get; } = "Example Task Id";

    public string TaskTypeName { get; } = "Example Task Name";

    public int Order { get; } = 0;

    public string Execute(params string[] args)
    {
        foreach (var arg in args)
        {
            Logging.Log.Info("ARG: " + arg);
        }

        return JsonSerializer.Serialize(new[] { "Response Example 1", "Response Example 2" });
    }
}
```

This Module Task can then be triggered via a JS Designer Script (e.g. from a context menu option):

```javascript
const result = await executeModuleTask("Example Task Id", "Example Arg 1", "Example Arg 2");
console.warn(result);
```

When called, this will lead to the following output in the Task Output Console:

![Module Task Output Example](images/4.2/module-task-output-example.png)
Above: The script causes the _Module Task Agent_ to initialize and then execute the `Example Task Id` Module Task inside the module, returning our response from above and logging it to the console as a warning.

Where can this be used? Module Tasks allow developers to plugin all forms of functionality with the ability to leverage the full power of .NET. Example Module Tasks that are being planned range from Domain imports from databases, Service imports from Open API documents, and integration with AI services.

### Improvements in 4.2.0

- [C# code management instruction deviation tracking](#c-code-management-instruction-deviation-tracking)
- Intent Architect will now give the option to save any unsaved Designer changes when trying to close it or return to the home screen from a Solution.
- Intent Architect upgraded to internally run using .NET 8. This allows the Software Factory to now support modules which are compiled to target any framework supported by .NET 8.
- The module installation and upgrade system will now only check the dependency graph for modules or dependencies of modules being installed, whereas before it would also check the dependency graph of all already installed modules.
- On create Application screens you can now click anywhere on a component "tile" to check/uncheck it whereas before you would have have to click on the checkbox itself.
- Added Cut / Copy / Paste shortcuts to element context menus. The shortcuts `Ctrl + X`, `Ctrl + C` and `Ctrl + V` also apply.
- Added a `Ctrl + H` shortcut to hide elements and associations from within the diagrams.

### Issues fixed in 4.2.0

- Tab order would be reversed when re-opening a solution which had open tabs when it was closed.
