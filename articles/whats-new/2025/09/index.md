# What's new in Intent Architect (September 2025)

Welcome to the August September edition of highlights of What's New in Intent Architect. Here's a roundup of the latest updates and improvements.

- Highlights

- More updates
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
