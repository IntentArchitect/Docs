---
uid: module-building.module-distribution
---
# Distributing your Modules to others

Modules built using Intent Architect can be distributed to other team members using a [self-hosted Module Server](#distributing-modules-using-a-self-hosted-module-server) instance or a [file system based repository location](#distributing-modules-using-file-system-based-repositories).

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
