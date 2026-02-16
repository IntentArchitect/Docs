---
uid: application-development.sdlc-best-practices
---

# Software Development Life Cycle (SDLC) Best Practices for Intent Architect Users

## Version Control

### Commit your Intent Architect design with the source code

When using Intent Architect, you are modeling your system design and applying that design to your codebase. This design evolves naturally over time alongside your codebase. In the same way we commit and version our code, we should also commit and version our design to ensure they remain aligned. For example, if you switch to a different branch or roll back to a previous version of the codebase, you want to be able to work with the corresponding version of the design.

The Intent Architect designs are stored in the **intent** folder. It is best practice to commit this **intent** folder into version control alongside the codebase.

This is the default folder layout for an Intent Architect solution with multiple .NET applications:

- 📁 `<root>` - The root folder which should be committed in your SCM (e.g. Git)
  - 📁 `intent` folder
    - 📁 `.intent` folder - Should not be committed and is added to `.gitignore` by default, contains cache of installed modules which Intent Architect will automatically download if it's missing.
    - 📁 `Application1` folder - Intent Architect data for Application1
      - 📁 `.intent` folder - Should not be committed and is added to `.gitignore` by default, contains cache of data from the last Software Factory execution to enable smarter code merging or knowing which files can have some of their processing skipped if they are unchanged since the previous execution.
      - 📁 `Intent.Metadata` folder - Metadata for the application
      - 📄 `Application1.application.config` file - Basic details of the Intent Architect application, such as its name, relative output location, etc.
      - 📄 `Application1.application.output.config.xml` file - Only created/updated by the Software Factory if it already existed or when it has one or more files it should not generate any reason, for example due to a file being ignored or being once-off generation only. If this file is not committed into source control, then other users and the [](xref:tools.software-factory-cli) will not be aware of which files should not be generated.
      - 📄 `Application1.application.output.log` - Obsolete. Prior to [version 4.5.22](xref:release-notes.intent-architect-v4.5#version-4522) of Intent Architect, was used to track aspects of Software Factory output. For backwards compatibility with older versions of Intent Architect, this file will still be updated by the Software Factory if it already exists, but if it's not present then it will not be created again. Provided that all users working on an Intent Architect application have updated to at least version 4.5.22, this file can be deleted.
      - 📄 `Application1.application.deviations.log.xml` file - Tracks code management [customizations](xref:application-development.software-factory.customizations-screen) for the application.
      - 📄 `modules.config file`
    - 📄 `.isln` file - The Intent Architect solution file containing basic data such as its name and the Intent Architect applications within it.
    - 📁 `Application2` folder - Intent Architect data for Application2
    - 📁 `[...]` folders - Intent Architect data for any additional applications
  - 📁 `Application1` folder - Output for Application1
    - 📁 `Project1` folder - For the `Project1` Visual Studio project
      - 📁 `[...]` - Any folders within the project
      - 📄 `Project1.csproj` file
      - 📄 `[...]` - Any other files within the project root
    - 📁 `Project2` folder - For the `Project2` Visual Studio project
    - 📁 `[...]` - Folders for any additional Visual Studio projects
    - 📄 `Application1.sln` file - Visual Studio solution file
  - 📁 `Application2` folder - Output for Application2
  - 📁 `[...]` - Output for any additional applications

### Merge Conflicts on Intent Architect Metadata Files

Everything you design within Intent Architect is persisted inside the `intent` folder as `.xml` files. As with any files stored in a repository, it's possible for the same file to be edited differently across branches or by multiple users. In that case you may encounter a **merge conflict** that must be resolved.

This is similar to resolving conflicts in a `.csproj` file. Resolving the conflicts is generally very straightforward once you understand the largely self-evident cleartext file format.

We strive to keep our metadata files human-readable and appropriately sized to minimize conflicts, in particular different concepts (e.g. `Class`, `DTO`, `Service`) each have separate files meaning that unless multiple developers are working on the exact same concept, they shouldn't interfere with each other at all.

To reduce the frequency and complexity of merge conflicts, apply standard development practices:

- **Pull frequently** – Regularly fetch and merge changes from the main branch to stay in sync.
- **Keep branches short-lived** – Work in small, focused branches and merge them quickly.
- **Communicate with your team** – Coordinate when multiple people are working on related areas.
- **Avoid large commits** – Make atomic commits that are easier to review and merge.
- **Rebase instead of merging (when appropriate)** – Keeps history clean and makes conflicts easier to manage.
- **Use tools for visual diffing** – Tools like Beyond Compare, Meld, or IDE-integrated tools help clarify changes.

For more details, read [Understanding and Resolving Merge Conflicts involving Intent Architect Metadata Files](xref:application-development.understanding-and-resolving-merge-conflicts)

### Working with Pull Requests

For teams using **Pull Requests (PRs)** as part of their SDLC, here are some key aspects to consider:

You typically do not need to review any of the Intent Architect metadata files—i.e., files located in the `intent` folder. These files serve as input to the code generation process, so reviewing the resulting codebase changes as you normally would is sufficient.

Since much of the code in a PR may be generated by Intent Architect, it's helpful to optimize your PR review process by focusing on:

- **Non-generated code** – such as business logic (e.g., service endpoint implementations or domain logic) and any custom code files added manually.
- **Customizations** – areas where **Code Management** instructions have been used to customize generated code.

As you become more familiar with the patterns being automated, you'll develop an intuition for which aspects of the PR require closer inspection.

Intent Architect also offers a **Customization Tracking** feature to support this process. It highlights areas of the codebase where Customizations exist, making them easy to identify and review to ensure nothing is overlooked. For more details on Customization Tracking, see [](xref:application-development.software-factory.customizations-screen).

> [!NOTE]  
> To use the Customization Tracking feature during PR reviews, you must have the PR checked out locally.
>
> ```bash
> git fetch origin pull/123/head:pr-123
> git checkout pr-123
> ```

## CI/CD Tooling

### Intent Architect design and codebase should be synchronized when committing to version control

Since you commit your Intent Architect design to version control alongside your codebase, it's best practice to ensure that your design work has been applied to the codebase **before committing**. Ultimately, you want the committed design and codebase to always be in sync.

Failing to do so is analogous to committing code that doesn't compile — something CI/CD processes aim to prevent.

You can use the `Software Factory CLI tool` with the `ensure-no-outstanding-changes` option as part of your CI/CD pipeline to enforce this behavior.

[Software Factory CLI tool documentation](xref:tools.software-factory-cli)

### Automate Governance of Architectural Customizations (Optional)

If you're using the [customizations tracking feature](xref:application-development.software-factory.customizations-screen) and its approval functionality, you can integrate governance checks into your CI/CD pipeline.

Run the `Software Factory CLI tool` with the `ensure-no-outstanding-changes` and `--check-for-unapproved-customizations` options. This will cause the build to break if there are any unapproved customizations.

[Software Factory CLI tool documentation](xref:tools.software-factory-cli)

There are multiple ways to configure this, but a popular and effective setup is:

- Allow customizations in a `development` branch.
- Enforce approval checks in a `release` branch.

This approach allows developers to work freely in development while ensuring that Customizations are reviewed before promotion.

## Upgrading and Installing Modules

Upgrading and installing modules can result in changes to your codebase. It is best practice to perform these operations on a **clean checkout** of your codebase - that is, all code committed or stashed (or the similar operation in your source control of choice). This helps isolate the impact of the upgrade and verify your codebase's readiness.

This is similar to manually upgrading NuGet packages — you'd typically do this from a clean state to ensure smooth upgrades.

On occasion, a module upgrade may result in many files being changed by the Software Factory, but you as the change in almost all the files are the exact same change to the pattern, typically the changes are incredibly quick to review.

Your codebase is a mix of Intent Architect–managed code and custom code. While the tool upgrades managed code automatically, some custom code may need manual adjustments. If you are not in a position to perform the manual adjustment at that time, you can easily roll back the modules / changes, and plan for when the upgrades should take place.

If you use pull requests as part of your SDLC, ensure that you do module upgrades as their own PR so as to not mix "functional" changes with regular module upgrade changes, this ensures that the work for reviewers is as easy as possible.

[Module Management documentation](xref:application-development.applications-and-solutions.about-modules)

## Have your team run the same version of Intent Architect

We recommend that all team members use the same version of Intent Architect. Most of our users are part of teams working on shared solutions, so it's ideal for all developers to use the same **major and minor** version (e.g., 4.4.x) to ensure a consistent and predictable experience.

Teams should coordinate when upgrading product versions to avoid compatibility issues.

## Custom Module deployment

If you build your own Intent Architect modules, you will need to consider how you deploy these modules so that your teams can discover and use your modules.

Module discovery is done through a Repository configuration which can be setup globally per Intent Architect solution. This can be particularly useful if you have custom modules which you want share / distribute either with-in your own development team or with external parties.

These repositories can be either:

- A URL to a module server, by default solution's are configured to point to the Intent Architect official module server and you can also host your own.
- A UNC Path, e.g. a local file folder or a mapped drive.

For more information on configuring Module Repositories, refer to the [](xref:application-development.applications-and-solutions.how-to-manage-repositories) article.

### Module Server

If you have custom modules which you wish to distribute and don't want to go the UNC Path route, you can host your own Module Server to distribute your modules, this is very analogous to setting up a custom NuGet hosting solution for distributing your own NuGet packages.

For more information on deploying a Module Server, refer to the [](xref:tools.module-server) article.

## Configure your Development Environment

When working with Intent Architect there are some best practices we recommend for configuring your development environment, these are detailed in the [](xref:application-development.development-environment-setup) article.

## General FAQ

### What does this installing this module / adjusting this setting / performing this modelling do?

If you are unsure what effect:

- installing a module
- adjusting an application setting
- performing modelling in one of the designers

The best approach is to perform these operations on a **clean checkout** of your codebase - that is, all code committed or stashed (or the similar operation in your source control of choice). This helps isolate the impact of performing the action on your code base.

Once you do one of the following, running the Software Factory and evaluating the changes, will allow you to draw a correlation between the changes you made in Intent Architect and the code generated.

As the action was performed on a clean checkout, if you do not require the changes made by performing the action:

- If the **Software Factory execution is applied**, as the operation was performed on a clean checkout, the code can be reverted using your source control tool of choice.
- If the **Software Factory execution is not applied**:
  - The Intent Architect metadata updates can reverted using your source control tool of choice
  - The module can be uninstalled
  - The setting can be reverted
  - The modelling can be undone using the `Undo` feature (`Ctrl-z`)
