---
uid: module-building.module-distribution
description: "How to distribute Intent Architect modules and application templates: publish them privately to the Intent Architect Module Server, use a self-hosted Module Server or a file-system repository, with versioning practices and the .imod artifact."
---
# Distributing your Modules to others

Modules built using Intent Architect can be distributed to other team members by [publishing them privately to the Intent Architect Module Server](#distributing-modules-using-the-intent-architect-module-server), using a [self-hosted Module Server](#distributing-modules-using-a-self-hosted-module-server) instance or a [file system based repository location](#distributing-modules-using-file-system-based-repositories).

## Distributing modules using the Intent Architect Module Server

Intent Architect can host your organization's custom modules (`.imod`) and application templates (`.iat`) on its own Module Server, so you don't have to run a [self-hosted Module Server](#distributing-modules-using-a-self-hosted-module-server) or share a [file system location](#distributing-modules-using-file-system-based-repositories).

Artifacts you publish with your organization's id are **private**: they belong to your organization, and only Intent Architect users signed in with an account in your organization can see, search for or install them. Everyone else using the Intent Architect Module Server never sees them.

Public artifacts, such as Intent Architect's own modules, stay visible to everyone, including members of your organization. Your developers see your private modules alongside the public ones in the same repository.

The Intent Architect Module Server is at `https://modules.intentarchitect.com/`, which is the server address used in the commands in this section.

### Prerequisites

- The latest LTS version of [.NET](https://dotnet.microsoft.com/download).
- The [](xref:tools.module-server-client-cli), installed as a .NET global tool:

  ```powershell
  dotnet tool install Intent.ModuleServer.Client.CLI --global
  ```

  After installation the command is available as `module-server-client-cli`.

  > [!NOTE]
  > If the install fails because a private NuGet feed can't be reached, add the `--ignore-failed-sources` option.

- An **Organization Access Token** for your organization that grants the permission to upload modules, and your **organization id**. [Contact the Intent Architect support team](xref:getting-help#contact-support) to get both.
- A **common prefix** for all of your modules. Every module identifier you publish must start with a prefix reserved for your organization, for example `Acme` for `Acme.Modules.Auditing`. Agree the prefix with the Intent Architect support team when you request your Organization Access Token. See [Reserved prefixes](#reserved-prefixes).
- A version of Intent Architect that supports private modules on every developer machine that needs to use them.
  <!-- TODO: give the minimum Intent Architect version that supports private modules. -->

### How visibility works

An artifact uploaded **with** an organization id is private to that organization. When a developer is signed in to Intent Architect, they see:

- all public artifacts, **and**
- all private artifacts owned by the organization their account belongs to.

They never see another organization's private artifacts, whether in search results, version lists, artifact details, documentation topics or downloads.

Visibility comes from the organization of the account the developer **signed in to Intent Architect with**. Nothing else needs to be configured on developer machines: there's no extra repository to add and no token to distribute.

Documentation topics bundled inside a private module are private to the same organization.

### Publishing a private module

1. **Build your module.** Build the module project to produce the `.imod` file. The build output shows where it was written, for example `Successfully created module 'C:\Dev\MyModule\Intent.Modules\MyModule.1.0.0.imod'`. See [Copying your `.imod` file](#copying-your-imod-file) for more about the build output.

1. **Set the module version.** Each identifier and version is published once, so make sure the version in your `.imodspec` hasn't been published before.

1. **Upload the module** with your Organization Access Token and organization id:

   ```bash
   module-server-client-cli upload-module https://modules.intentarchitect.com/ <path-to-.imod> \
     --access-token <organization-access-token> \
     --organization-id <organization-id>
   ```

   > [!WARNING]
   > Always pass `--organization-id` when you mean to publish a private artifact. Don't rely on any default.

1. **Check that your developers can see it.** Ask a member of your organization, signed in to Intent Architect, to search for the module in the **Modules** screen of an application.

The Organization Access Token must belong to the same organization as `--organization-id`, and it must grant the permission to upload modules. If either isn't true, the upload is rejected as forbidden.

#### Upload options

| Option                    | Description                                                                                        |
| ------------------------- | -------------------------------------------------------------------------------------------------- |
| `--access-token`, `--oat` | The Organization Access Token used to authenticate.                                                |
| `--organization-id`       | The organization that will own the artifact. Access is restricted to members of this organization. |
| `--unlisted`              | Upload the version as unlisted: hidden from search but still installable by its exact version.     |

To upload a version that is hidden from search from the start, for example a pre-release you only want a few projects to use, add `--unlisted`:

```bash
module-server-client-cli upload-module https://modules.intentarchitect.com/ <path-to-.imod> \
  --access-token <organization-access-token> \
  --organization-id <organization-id> \
  --unlisted
```

#### Module ownership

The first private upload of a module identifier makes your organization its owner.

- Uploading a new version of a module your organization already owns adds that version, and the module stays private to your organization.
- Another organization can't upload a module with an identifier your organization owns, and you can't upload one with an identifier another organization owns. These uploads are rejected.

#### Reserved prefixes

Module identifiers must start with a prefix reserved for your organization. The prefix is the first dot-separated segment of the identifier, so `Acme.Modules.Auditing` has the prefix `Acme`. Uploads that use a prefix not reserved for your organization are rejected.

Your prefix is reserved by the Intent Architect support team, along with your Organization Access Token and organization id.

#### Publishing from a CI/CD pipeline

Store the Organization Access Token and organization id as secret pipeline variables, never in source control. The following Azure Pipelines steps install the CLI and upload every `.imod` file the build produced:

```yaml
variables:
  # Defined as secret variables on the pipeline, or in a linked variable group:
  #   IntentOrganizationAccessToken
  #   IntentOrganizationId
  intentModuleServerUrl: 'https://modules.intentarchitect.com/'

steps:
- task: UseDotNet@2
  displayName: 'Use .NET'
  inputs:
    packageType: 'sdk'
    version: '<dotnet-lts-version>'

- task: PowerShell@2
  displayName: 'Install the Module Server Client CLI'
  inputs:
    targetType: 'inline'
    pwsh: true
    script: dotnet tool install Intent.ModuleServer.Client.CLI --global

- task: PowerShell@2
  displayName: 'Publish private modules'
  env:
    INTENT_OAT: $(IntentOrganizationAccessToken)
    INTENT_ORGANIZATION_ID: $(IntentOrganizationId)
  inputs:
    targetType: 'inline'
    pwsh: true
    script: |
      Get-ChildItem -Path "$(Build.SourcesDirectory)" -Recurse -Filter *.imod | ForEach-Object {
        module-server-client-cli upload-module "$(intentModuleServerUrl)" $_.FullName `
          --access-token $env:INTENT_OAT `
          --organization-id $env:INTENT_ORGANIZATION_ID
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
      }
```

> [!TIP]
> Azure Pipelines doesn't expose secret variables to scripts automatically, which is why the step maps them into environment variables with `env`. Other CI systems, such as GitHub Actions, work the same way: read the token from the system's secret store and pass it to `--access-token`.

### Managing published versions

Members of your organization with an Organization Access Token can **unlist** a version, which hides it from search, or **list** it again. You can only do this for your own organization's artifacts.

To unlist a version:

```bash
module-server-client-cli unlist-module-version https://modules.intentarchitect.com/ <moduleId> <moduleVersion> \
  --access-token <organization-access-token>
```

To list it again:

```bash
module-server-client-cli list-module-version https://modules.intentarchitect.com/ <moduleId> <moduleVersion> \
  --access-token <organization-access-token>
```

Unlisting doesn't delete anything. Projects that already depend on the exact version can still restore it, so unlisting is a safe way to steer developers away from a version without breaking anyone.

### Publishing application templates

Application templates (`.iat`) follow the same visibility, authentication and `--organization-id` rules as modules:

```bash
module-server-client-cli upload-application-template https://modules.intentarchitect.com/ <path-to-.iat> \
  --access-token <organization-access-token> \
  --organization-id <organization-id>
```

Members of your organization see your private application templates in the **Create new application** wizard, alongside the public ones.

### Important behaviours and warnings

> [!WARNING]
> **Keep your Organization Access Token secret.** Anyone holding it can publish and unlist artifacts for your organization. Store it in your CI system's secret store, and rotate it if it leaks.

> [!WARNING]
> **Always pass `--organization-id`** on uploads that are meant to be private.

> [!NOTE]
> **Your developers must sign in to Intent Architect with an account in your organization**, or they won't see your private modules and application templates.

### Troubleshooting

| Symptom                                               | Likely cause                                                                                                                                                                                                                                             |
| ----------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Upload fails with _Forbidden_                         | The token is for a different organization than `--organization-id`, the token doesn't grant the permission to upload modules, the identifier is owned by another organization, or the identifier doesn't start with your organization's reserved prefix. |
| Upload fails with _Conflict_ or "already exists"      | That identifier and version is already published. Increase the version and upload it again.                                                                                                                                                              |
| A developer can't find the module in Intent Architect | They aren't signed in with an account in the owning organization, the version is unlisted, their version of Intent Architect is too old, or the module's supported client versions exclude their version of Intent Architect.                            |
| `Token request failed`                                | The Organization Access Token is invalid, has expired or has been revoked.                                                                                                                                                                               |

### FAQ

#### Do my developers need to add a repository to see our private modules?

No. Private modules are served from the same Intent Architect Module Server as the public modules. Signing in to Intent Architect with an account in your organization is enough.

#### Can other organizations see that our module exists?

No. Another organization's members don't see your private artifacts in search results, version lists, artifact details, documentation topics or downloads.

#### Does unlisting a version break projects that use it?

No. Unlisting only hides the version from search. Projects that depend on that exact version can still restore it.

#### Should we use this or a self-hosted Module Server?

Use the Intent Architect Module Server if you want to share modules with your organization without running any infrastructure. Use a [self-hosted Module Server](xref:tools.module-server) or a [file system repository](#distributing-modules-using-file-system-based-repositories) if your modules must stay on your own network.

## Distributing modules using a self-hosted Module Server

Custom modules can be uploaded to a self-hosted Module Server which makes them accessible at an https URL.

For more information on setting up the Module Server, refer to [this](xref:tools.module-server) article. For more information on uploading modules to your self-hosted Module Server, refer to [this](xref:tools.module-server-client-cli) article.

Once the self-hosted Module Server has been set up, [configure Intent Architect to use its address as repository](#configure-intent-architect-to-use-your-repository-location)

## Distributing modules using file system based repositories

At a high level:

* Decide on a common file system accessible location which everyone within your team has read access to.
* Each Intent Architect user in your team adds this common location to their repositories under their user settings.
* Modules already used by others should be treated as immutable, so if you've made changes within your module, then be sure to increment its version.
* Build the module to get the `.imod` artifact.
* Copy the `.imod` to the common file system accessible location.

### Decide on a location for the file system based repository

#### Network based file sharing option

If all members are connected via a local network (or via VPN for remote working), one can make use of network file sharing hosting solutions. For example, most operating systems can access a Windows hosted network file location that resembles `\\server\intent-modules`.

This is a simple way to distribute modules so long as everyone has at least readonly access (except for the publisher who needs write access) to that server location.

#### Cloud based file sharing option

If your team is geographically distributed (but this option can still be leveraged for members on a local network too), then we recommend internet based file sharing with automatic synchronization to users machines, for example, Google Drive, Dropbox, OneDrive (SharePoint with OneDrive), etc.

One of the benefits of this approach is that you have an offline cache available during network disruptions and your cloud storage provider also makes backups on your behalf.

##### Example: Using Sharepoint and OneDrive

For example, if your organisation has SharePoint and OneDrive, you could use the following process to sync `.imod` files to developers computers:

* If you don't already have a document library for this purpose, [create one in SharePoint](https://support.microsoft.com/office/create-a-document-library-in-sharepoint-306728fe-0325-4b28-b60d-f902e1d75939).
* If desired, [create a folder](https://support.microsoft.com/office/create-a-document-library-in-sharepoint-306728fe-0325-4b28-b60d-f902e1d75939) within the document library for the `.imod` files.
* [Set up syncing](https://support.microsoft.com/office/sync-sharepoint-and-teams-files-with-your-computer-6de9ede8-5b6e-4503-80b2-6190f3354a88) of the SharePoint folder to your computer's file system.
* Make note of the location of the folder on your computer's file system to where OneDrive is syncing the folder with the `.imod` files and then [configure Intent Architect to use this location as a repository](#configure-intent-architect-to-use-your-repository-location).

## Configure Intent Architect to use your repository location

This [article](xref:application-development.applications-and-solutions.how-to-manage-repositories) explains how to setup your known Intent Architect module repositories which let Intent know from where it can install and update modules.

> [!NOTE]
> This isn't needed for modules published to the [Intent Architect Module Server](#distributing-modules-using-the-intent-architect-module-server). They're served from the built-in Intent Architect repository.

## Module versioning concerns

When distributing modules to other members of the team, always ensure that you update the version number. Unless the version number is changed, Intent Architect will assume that the contents of the module are unchanged and continue to using a cached version of it.

Additionally, if you're keeping your Intent Architect application in SCM (Source Code Management), Intent Architect keeps track of installed module versions inside of `modules.config` files which are alongside the Intent Architect Application and so are also committed into SCM. This means you can safely check out an earlier version of the code base and Intent Architect will restore and run the correct version of the module such that running the Software Factory will produce the same output as it did at the time of the SCM check-in.

For these reasons, a version of a module which has been distributed to anyone else _must_ be treated as immutable.

Intent Architect supports [Semantic Versioning 2.0.0](https://semver.org/) and it is our recommendation that you follow Semantic Versioning practices. Without having to understand Semantic Version practices in depth, you could simply increment the major version (the first version component) each time, so `1.0.0` -> `2.0.0` -> `3.0.0`, etc. By increasing version numbers, users of Intent Architect will be notified that new version of those modules are available and can choose to install them.

## Copying your `.imod` file

Locate where your newly built `.imod` file is placed after it's built in your IDE (such as Visual Studio). The console output generally displays the location (where it says "Successfully created module"):

Example of build output log:

```text
Build started...
1>------ Build started: Project: MyModule, Configuration: Debug Any CPU ------
1>MyModule -> C:\Dev\MyModule\MyModule\bin\Debug\net5.0\MyModule.dll
1>Intent Architect Packager PackAll Task (C:\Users\User\.nuget\packages\intent.packager\3.2.0\lib\netstandard2.0\Intent.Packager.BuildTasks.dll)
1>Packaging module for C:\Dev\MyModule\MyModule\MyModule.imodspec
1>Added lib/MyModule.dll.
1>Added lib/MyModule.pdb.
1>Added MyModule.1.0.0.imodspec.
1>Successfully created module 'C:\Dev\MyModule\Intent.Modules\MyModule.1.0.0.imod'.
========== Build: 1 succeeded, 0 failed, 0 up-to-date, 0 skipped ==========
```

Copy the `.imod` file from the `Intent.Modules` folder to your file sharing location.
