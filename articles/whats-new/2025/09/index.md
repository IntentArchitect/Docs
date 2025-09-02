# What's new in Intent Architect (September 2025)

Welcome to the August September edition of highlights of What's New in Intent Architect. Here's a roundup of the latest updates and improvements.

- Highlights

- More updates
  - **[AutoMapper and MediatR commercial version settings](#automapper-and-mediatr-commercial-version-settings)** - Choose between free and commercial versions of AutoMapper and MediatR packages.
  - **[RDBMS importer improvements](#rdbms-importer-improvements)** - The RDBMS importer has had various usability and performance improvements.
  - **[EF Core Migrations README update](#ef-migrations-readme-file-changed-from-a-txt-to-md-file)** - Migrations README file updated to leverage Markdown formatting.

## Update details

### RDBMS importer improvements

The RDBMS import experience has been reviewed end-to-end and greatly improved to make it more intuitive and performant to use.

In particular:

- The dialogue is now a wizard paradigm, you now press `NEXT` instead of the having to open a stacked dialogue to configure filtering options.
- The filtering options screen now shows only a single tree view of selectable database objects with a dropdown allowing to select whether the selected items are included or excluded.
- It now shows loading indicators at various points preventing accidentally proceeding before any required background asynchronous processes have completed.
- When the tree view has many objects (1000s or more) it is no longer very slow to check/un-check parent nodes and will a loading indicator is now shown when there are lots of nodes to initialize.
- When the actual import process has been kicked off, output is now shown in a module task dialogue which pops up.

Refer to the [RDBMS Importer Documentation](https://docs.intentarchitect.com/articles/modules-importers/intent-rdbms-importer/intent-rdbms-importer.html) for more information.

> [!NOTE]
>
> In order to see latest version of the importer you will need to ensure you are running the latest release version of Intent Architect, at least version 4.5.13.

Available from:

- Intent.Rdbms.Importer 1.0.3
- Intent Architect 4.5.13

### EF migrations README file changed from a `.txt` to `.md` file

The `MIGRATIONS_README.txt` file has been changed to a `README.md` file which will now by default generate in the the same `Migrations` folder in which EF generates the migrations themselves and the content has been significantly altered to make use of Markdown formatting:

![Example of updated migrations README.md file](images/sample-migrations-readme-file.png)

Available from:

- Intent.EntityFrameworkCore 3.0.28

### AutoMapper and MediatR commercial version settings

![AutoMapper & MediatR](images/automapper-and-mediatr.png)

Following up on our [July 2025 announcement](../07/index.md#automapper-and-mediatr-going-commercial), both the `Intent.Application.AutoMapper` (version 5.3.0+) and `Intent.Application.MediatR` (version 4.5.0+) modules have been updated with new settings that give you full control over which versions of these popular NuGet packages to use in your applications.

You can now choose whether to lock the versions of AutoMapper and MediatR to those prior to their commercial editions, or proceed with the latest commercial versions while accepting their respective licenses. This flexibility ensures that your projects can adapt to your organization's licensing preferences and requirements. For more details about the commercial transition, read Jimmy Bogard's announcement [here](https://www.jimmybogard.com/automapper-and-mediatr-commercial-editions-launch-today/).

> [!WARNING]
>
> If you decide to use the commercial versions, you will need to obtain and configure the appropriate license keys. License keys can be requested as detailed in Jimmy Bogard's article above, and should be configured in your `appsettings.json` file under `AutoMapper:LicenseKey` for AutoMapper or `MediatR:LicenseKey` for MediatR. Alternatively, you can set them as environment variables using `AutoMapper__LicenseKey` or `MediatR__LicenseKey` respectively.

Available from:

- Intent.Application.AutoMapper 5.3.0
- Intent.Application.MediatR 4.5.0
