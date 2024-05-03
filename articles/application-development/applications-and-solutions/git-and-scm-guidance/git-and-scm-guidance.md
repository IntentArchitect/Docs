---
uid: application-development.applications-and-solutions.git-and-scm-guidance
---
# Git and SCM guidance

This article provides an overview on working with Intent Architect and SCM (Source Control Management) systems (such as Git) including details on which files should or should not be committed and versioned into source code repositories.

## Understanding Intent Architect and SCM

Intent Architect is not inherently aware of SCMs, it merely reads and writes files to your file system, allowing users to use their own choice of SCM systems and associated tooling, but Intent Architect is intentionally designed with the use of SCMs in mind.

In particular, it is intended that Intent Architect files are committed into SCM repositories alongside normal source code files in the same commits. This enables checking out other versions or branches of a code base using your SCM and having the Intent Architect Designer metadata correlate with the committed source code. The other benefit of this approach is that teams practicing automated CI (Continuous Integration) can run the
[Intent Architect Software Factory CLI tool](https://docs.intentarchitect.com/articles/tools/software-factory-cli/software-factory-cli.html) as part of their CI process to provide another quality check.

Another aspect of intentionally designing Intent Architect with SCMs in mind is the format and layout of files. Careful consideration has been applied as to whether Designer metadata is saved in its own file per element or embedded in the file of a parent element. For example, in the Domain Designer each Class is saved as a separate file, with all aspects of it (e.g. Attributes, Operations, Constructors, etc) being saved in the same file. This means that you are unlikely to have merge conflicts with other developers unless you are working on the same Class on the designer. If there is a merge conflict, all files are deliberately stored in a clear text format allowing the conflicts to be resolved using regular merge tools.

## Files and Folders to always include

When you create a new Application in Intent Architect and you keep the default layout structure settings, the solution folder will have an `intent` subfolder housing all the Intent Architect files that are made up of solution and application information as well as their designer metadata.

Should you alter the layout structure when you create a new Application, the files and folders to include to source control are:

| File, Extension or Folder | Description |
|---------------------------|-------------|
| `.isln`                   | Intent Architect Solution |
| `.application.config`     | Intent Architect Application |
| `modules.config` file     | Installed modules registry |
| `Intent.Metadata` folder  | Designer Metadata |
| `.application.deviations.log` / `.application.deviations.xml` | Intent Architect uses this to "audit" which parts of the code base are allowed to deviate from the generated pattern and where it was signed off by authorized users. |
| `.application.output.log` / `.application.output.xml` | Intent Architect uses this to track files under management so that it can determine when files might need to be deleted or renamed. |
| `intent.repositories.config` file | Solution-level asset repository configuration |

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
