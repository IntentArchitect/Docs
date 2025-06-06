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
      - 📄 `Application1.application.deviations.log.xml` file - Used to track any [deviations](xref:application-development.software-factory.about-software-factory-execution#the-deviations-screen) for the application.
      - 📄 `Application1.application.output.log` file - Used to track which file paths were output to during the last run Software Factory execution, used to determine possible file renames and deletions.
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
- **Deviations** – areas where **Code Management** instructions have been used to customize generated code.

As you become more familiar with the patterns being automated, you'll develop an intuition for which aspects of the PR require closer inspection.

Intent Architect also offers a **Deviation Tracking** feature to support this process. It highlights areas of the codebase where Deviations exist, making them easy to identify and review to ensure nothing is overlooked. For more details on Deviation Tracking, read further [here](xref:application-development.software-factory.about-software-factory-execution#the-deviations-screen).

> [!NOTE]  
> To use the Deviation Tracking feature during PR reviews, you must have the PR checked out locally.
>
> ```cmd
> git fetch origin pull/123/head:pr-123
> git checkout pr-123
> ```

## CI/CD Tooling

### Intent Architect design and codebase should be synchronized when committing to version control

Since you commit your Intent Architect design to version control alongside your codebase, it's best practice to ensure that your design work has been applied to the codebase **before committing**. Ultimately, you want the committed design and codebase to always be in sync.

Failing to do so is analogous to committing code that doesn't compile — something CI/CD processes aim to prevent.

You can use the `Software Factory CLI tool` with the `ensure-no-outstanding-changes` option as part of your CI/CD pipeline to enforce this behavior.

[Software Factory CLI tool documentation](xref:tools.software-factory-cli)

### Automate Governance of Architectural Deviations (Optional)

If you're using the [Deviation Tracking feature](xref:application-development.software-factory.about-software-factory-execution#the-deviations-screen) and its approval functionality, you can integrate governance checks into your CI/CD pipeline.

Run the `Software Factory CLI tool` with the `ensure-no-outstanding-changes` and `--check-deviations` options. This will cause the build to break if there are any unapproved deviations.

[Software Factory CLI tool documentation](xref:tools.software-factory-cli)

There are multiple ways to configure this, but a popular and effective setup is:

- Allow deviations in a `development` branch.
- Enforce approval checks in a `release` branch.

This approach allows developers to work freely in development while ensuring that deviations are reviewed before promotion.

## Upgrading and Installing Modules

Upgrading and installing modules can result in changes to your codebase. It is best practice to perform these operations on a **clean checkout** of your codebase. This helps isolate the impact of the upgrade and verify your codebase's readiness.

This is similar to manually upgrading NuGet packages — you'd typically do this from a clean state to ensure smooth upgrades.

On occasion, a module upgrade may result in many files being changed by the Software Factory, but you as the change in almost all the files are the exact same change to the pattern, typically the changes are incredibly quick to review.

Your codebase is a mix of Intent Architect–managed code and custom code. While the tool upgrades managed code automatically, some custom code may need manual adjustments.

This allows you to easily roll back the modules / changes, if for some reason you wanted to.

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

For more information on configuring Module Repositories, read further [here](xref:application-development.applications-and-solutions.how-to-manage-repositories).

### Module Server

If you have custom modules which you wish to distribute and don't want to go the UNC Path route, you can host your own Module Server to distribute your modules, this is very analogous to setting up a custom NuGet hosting solution for distributing your own NuGet packages.

For more information on deploying a Module Server, read further [here](xref:tools.module-server).

## Configure your Development Environment

When working with Intent Architect there are some best practices we recommend for configuring your development environment, these are detailed [here](xref:application-development.development-environment-setup).
