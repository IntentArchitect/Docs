---
uid: application-development.sdlc-best-practices.sdlc-best-practices
---

# SDLC Best Practices for Intent Architect Users

## Version Control

### Commit your Intent Architect design with the source code

When using Intent Architect you are modeling out your system design, and then applying that design to your codebase. This design evolves over time naturally along side with your codebase.In the same way that we want to commit and version our codebase, we also want to commit and version our design together with the codebase, so that if we swap version our design and codebase are aligned. e.g. If you swap to a different branch or roll back to a historic version of the codebase you want to be able to work with the design at that version.

The Intent Architect designs are stored in the **intent** folder.
To this end it is best practice to commit the **intent** folder into version control along with the codebase.

The image below show a default solution structure, with the various components

- **Intent Architect Solution Folder**, in this case C:\Docs\MySolution,
- **Design Folder**, the `intent` in the solution folder.
- **Application Codebase Folder**, the `MySolution.SampleApplication` in the solution folder, which contains my codebase for the application.

![Folder Structure](./images/design-codebase-files.png)

### Merge Conflicts on Intent Architect Metadata files

Everything you design within Intent Architect is persisted as `xml` files inside the **intent** folder. As with any file stored in a repository, it's possible for the same file to be edited differently across branches or by multiple users. In that case, you'll end up with a **merge conflict** that needs to be resolved.  

This is similar to resolving merge conflicts in a **.csproj** file. It can be intimidating to merge a file you're not familiar with, but once you understand its contents, it's straightforward.

We endeavour to make our metadata files human-readable and appropriately sized to minimize conflicts.

You can apply standard development practices to reduce the frequency and complexity of merge conflicts. For example:

- **Pull frequently** – Regularly fetch and merge changes from the main branch to stay in sync.
- **Keep branches short-lived** – Work in small, focused branches and merge them quickly.
- **Communicate with your team** – Coordinate when multiple people are working on related areas.
- **Avoid large commits** – Make atomic commits that are easier to review and merge.
- **Rebase instead of merging (when appropriate)** – Keeps history clean and makes conflicts easier to manage.
- **Use tools for visual diffing** – Tools like Beyond Compare, Meld, or built-in IDE tools help clarify changes.

For more details read [Understanding and Resolving Merge Conflicts involving Intent Architect Metadata Files](xref:application-development.applications-and-solutions.understanding-and-resolving-merge-conflicts)

## CI/CD Tooling

### Intent Architect design and code base should be synchronized when committing to version control

Because you are committing your Intent Architect design into version control along side the source code, it is best practice to ensure that your design work is applied to the codebase before committing. Ultimately you want to be in a position where the design reflects the codebase and vice versa.

Failing to do this is analogous to committing non-compiling code, it just something you should not do and one of the main reasons we have CI/CD today.

To this end, you can run the `Software Factory CLI tool` with the `ensure-no-outstanding-changes` option as part of your CI/CD pipeline to ensure this behaviour.

[Software Factory CLI tool documentation](xref:tools.software-factory-cli)

### Automate Governance of Architectural Deviations (Optional)

If you are using the [Deviation Tracking feature](xref:application-development.software-factory.about-software-factory-execution#the-deviations-screen) and using the Deviation approval feature you can use the `Software Factory CLI tool` to ensure Deviations are reviewed and approved.

To this end as part of your CI/CD pipeline, you can run the `Software Factory CLI tool` with the `ensure-no-outstanding-changes` and the `--check-deviations` option which will automatically break on unapproved deviations.

[Software Factory CLI tool documentation](xref:tools.software-factory-cli)

There are many ways you can set this up, the recommended approach would be to allow deviations in a `development` branch, and configure your `release` branch to break on unapproved deviations. This setup allows developers to commit deviations in `development`, so as not to slow down development while not allowing the deviations to be promoted without review and approval.

## Upgrading and Installing Modules

Upgrading and installing modules, as you would expect, often result in changes to your codebase. It is best practice to do these kind of operations on a clean check out of your codebase. This allows you to evaluate these changes in isolation and ensure that your codebase ready for these changes. This is not unlike manually upgrading NuGet packages, again you would typically do this on a clean check out and evaluate that your codebase is well positioned to receive the update or not.

Remember that your codebase is a mix of Intent Architect managed code and custom code, while Intent Architect will upgrade the managed code, it is entirely possible that some of the custom code may need to be updated. If you find yourself is this situation can either update the codebase as required or roll back the update, either

- Simply reverting the changes through version control.
- Module Management, uninstall or down grade the module

[Module Management documentation](xref:application-development.applications-and-solutions.about-modules)

## Have your team run the same version of Intent Architect

It is recommended that teams work on the same version of Intent Architect. Most of our users are teams of developers working on shared solution, ideally developers should all be on the same and minor version number. e.g. 4.4.x for the best experience, and teams should co-ordinate upgrading product versions.

## Working with Pull Requests
