---
uid: application-development.applications-and-solutions.scm-integration-with-intent-architect
---
# SCM Integration with Intent Architect

This document serves as a guide on how to integrate Intent Architect with source control management (SCM) systems, focusing on the configuration of "ignore rules" for Intent Architect folders and files.

## Understanding Intent Architect and SCM

Intent Architect is not inherently aware of source control; it primarily saves files to your file system. From the perspective of source control, these files are no different from other source code files (e.g., `.cs`, `.csproj`, `.sln`, etc.).

To ensure seamless integration, it is crucial that Intent Architect files are committed into the same Git repository as the other source code files. This approach allows for smooth switching between branches in Visual Studio or any Git client, with Intent Architect files being managed alongside the rest of the source code.

## Files and Folders to always include

When you create a new Application in Intent Architect and you keep the default layout structure settings, the solution folder will have an `intent` subfolder housing all the Intent Architect files that are made up of solution and application information as well as their designer metadata.

Should you alter the layout structure when you create a new Application, the files and folders to include to source control are:

| File, Extension or Folder                                     | Description                                                                                                                                                           |
|---------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `.isln`                                                       | Intent Architect Solution                                                                                                                                             |
| `.application.config`                                         | Intent Architect Application                                                                                                                                          |
| `modules.config`                                              | Installed modules registry                                                                                                                                            |
| `Intent.Metadata`                                             | Designer Metadata                                                                                                                                                     |
| `.application.deviations.log` / `.application.deviations.xml` | Intent Architect uses this to "audit" which parts of the code base are allowed to deviate from the generated pattern and where it was signed off by authorized users. |
| `.application.output.log` / `.application.output.xml`         | Intent Architect uses this to track files under management so that it can determine when files might need to be deleted or renamed.                                   |
| `intent.repositories.config`                                  | Solution-level asset repository configuration                                                                                                                         |

## Folders which should always be ignored

`.intent` folders should always be ignored, they contain data like downloaded/restored modules and other cached data.

## Configuring Git (`.gitignore` files)

As of version [3.1.8](xref:release-notes.version-3-1#new-features-added-in-318), Intent Architect has an option during creation of a new Solution or Application to add or update the appropriate `.gitignore` files.

If your application or solution was created in a version of Intent Architect less than 3.1.8, you can manually add the following to your `.gitignore` file:

```text
# Intent Architect

**/.intent/*
!*.application.output.log
```
