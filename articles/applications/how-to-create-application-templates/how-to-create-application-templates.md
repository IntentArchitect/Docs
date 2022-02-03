---
uid: applications.how-to-create-application-templates
remark: Used (https://library.kissclipart.com/20180903/wje/kissclipart-electronic-component-icon-clipart-electronic-compo-d2f1e79cc4feba0f.png) for icon in demo
---
# How to create Application Templates

This how-to guide will walk you through creating your own [Application Template](xref:applications.about-application-templates) using the `Intent Application Template Builder` [Designer](xref:designers.about-designers).

## Create a new Application

Create a new `Intent Application Template Builder` application and give it the name `MyApplicationTemplates`:

![Create a new Application](images/my-app-templates-creation.png)

- Click `NEXT`.
- Leave the ticked options as is and click `CREATE`:

![Installation dialog](images/installation-dialog.png)

Once the `Application Installation` is complete, it will automatically hide.

## Create a new Package

- Click on the `App Templates` Designer on the left.
- Click `CREATE NEW PACKAGE`.
- Give the package a name of `My Application Template`.
- Click `DONE`.
- Click the root Package element and in the Properties pane on the right:
  - For `Display Name` enter `My Application Template`:

[!Video-Loop videos/create-package.mp4]

## Specify a Group and a Component

- Right-click the root Package element and click the `New Group` option.
- Give the new element a name of `Group 1`.
- Right-click the `Group 1` element and click the `Add Component` option.
- Give the new element a name of `Component 1`.
- Click the root `Component 1` element and in the Properties pane on the right:
  - For `Icon` use the ellipses to [choose an icon](xref:user-interface.how-to-use-the-change-icon-dialogue):

[!Video-Loop videos/create-group-and-component.mp4]

## Add a Module

- Right-click the `Component 1` element and click the `Add Module` option.
- Give the new element a name of `Intent.Modelers.Domain`.

    > [!IMPORTANT]
    > This must be the exact name of a [module](xref:modules.about-modules) which is to be installed by the Application Template.
- Click the root `Intent.Modelers.Domain` element and in the Properties pane on the right:
  - For `Version` enter `3.0.4`.

    > [!IMPORTANT]
    > This must be a valid version for the Module name chosen above.

[!Video-Loop videos/add-a-module.mp4]

## Run the Software Factory to generate the module

Run the Software Factory and optionally review the proposed changes:

![Staging files](images/software-factory-run.png)

Click `APPLY CHANGES`.

Before you dismiss the Software Factory Execution dialog (after it's completed applying all the changes) expand the last item called `Finalizing Execution`, then `Execution Life Cycle` to see that a `dotnet build` was executed on the generated `Visual Studio` solution:

![Software Factory: dotnet build](images/software-factory-dotnet-build.png)

Take note of the following line in the output for the following step:

```text
Successfully created application template C:\Dev\MyApplicationTemplates\Intent.Modules\My Application Template.1.0.0.iat
```

Click on the close button (the red button).

## Test your Application Template

Ensure you have added the output path as noted in the above step as a repository in the [Repository Manager](xref:user-interface.how-to-manage-repositories).

Add a new Asset Repository with the name `My Modules` and address `C:\Dev\MyApplicationTemplates\Intent.Modules` (this is the folder where your `.iat` file resides), then click `Save`.

![Manage Repositories](images/repo-manager-module-folder.png)

Navigate to your Intent Solution dashboard then click to add a new application.
Ensure your module repository is selected in the drop down and you should see your application template:

![Select your Application Template](images/testing-select-application-template.png)

Give it a name and click `NEXT`.

![Application Template Components](images/testing-select-application-template-components.png)

Notice that it's showing all the elements we created in the [Specify a Group and a Component](#specify-a-group-and-a-component) and [Add a Module](#add-a-module) steps.

## Next steps

You can use the `App Templates` Designer to add/change Groups, Components and Modules, re-run the Software Factory and see the affect it has on your Application Template when used in Intent Architect.

## See also

[](xref:applications.about-application-templates)
