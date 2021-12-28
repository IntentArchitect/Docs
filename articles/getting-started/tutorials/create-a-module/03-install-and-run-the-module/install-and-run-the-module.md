---
uid: tutorials.create-a-module.install-and-run-the-module
---
# Install and run the Module

When creating Modules it is often very useful to have a _test_ Application that we can use to test that our Modules are working correctly. This tutorial explains how to create this _test_ Application and how to install and run the Module we created in the [previous tutorial](xref:tutorials.create-a-module.create-a-simple-module).

## Create an empty Application

> [!NOTE]
> If you have already created an Application to install your module in, you can skip this section and jump straight to the [Install the Module](#install-the-module) section.

To get started, let's create an empty Application.

> [!TIP]
> Start a new instance of Intent Architect to create this application. It will make switching between your Modules Solution and the Test Application contexts very quick (this article will assume only one instance of Intent Architect).

1. From the home view, click `Create a new application`.
2. Set the Application's name, location, and Solution name. _NOTE: You can ignore which Application Template is selected. It won't affect an empty application._
3. Click `CREATE EMPTY` _NOTE: With `CREATE EMPTY` the selected application template is ignored)._
4. When prompted with a confirmation, click `YES` to continue.
5. Close the `Application Installation` dialog.

![Create Test Application](images/create-test-application.png)

> [!NOTE]
> We typically create Applications with an [Application Template](xref:applications.how-to-create-application-templates). Empty Applications are useful when there aren't any Application Templates that fulfill your needs.

## Set up Visual Studio projects

Applications need a way to know where to output specific code files. Since we're working with .NET we can install the `Intent.VisualStudio.Projects` Module which installs a Designer to configure our .NET solution and project structure.

To install this module we must navigate to the `Modules` tab within our application.

1. Search for the `Intent.VisualStudio.Projects` Module by typing "visual" into the filter.
2. Select the Module.
    ![Search Modules](images/modules-search-visual-studio.png)
3. In the details pane, click `Install` to install the latest version.
    ![Module Details](images/modules-visual-studio-details.png)
4. Intent Architect will install the module and its dependencies. Hide the `Installation Manager` once it's finished.

You may have noticed that a new `Visual Studio` Designer was installed into our Application. It will allow us to structure the C# projects in our codebase. For this tutorial, we can set up a typical web application project structure that separates Domain, Infrastructure, and API concerns.

1. Click on the `Visual Studio` Designer
2. Create a new `Visual Studio Solution` package by clicking on the `CREATE NEW PACKAGE` button.
3. Fill in the name of the Visual Studio solution, then click `DONE`.
4. Next, create a set of projects by right-clicking on the new Visual Studio Solution package and selecting the project type. We will create an `ASP.NET Core Web Application` and two `Class Library (.NET Core)` projects in this tutorial.

    ![Create Projects](images/visual-studio-create-projects.gif)

    The application structure should look as follows:

    ![Create Projects](images/visual-studio-project-structure.png)
5. To create this project structure, run the Software Factory Execution. Intent Architect should stage the changes as follows:
    ![Create Projects](images/software-factory-execution-project-structure.png)
6. Finally, click `APPLY CHANGES` to instruct Intent Architect to create the files in our codebase and minimize the Software Factory Execution.

## Install the Module

Next, let's install the Module we created in the [previous step](xref:tutorials.create-a-module.create-a-simple-module). To do this, we first navigate to the `Modules` tab of our Application.

### Finding and Installing the Module

By default, Intent Architect is configured only with the repository for official Modules hosted at [https://intentarchitect.com/](https://intentarchitect.com/). To be able to use our own Module we can make the folder where our `MyModule.Entities` was created within the default repository.

1. Open [User Settings](xref:user-interface.how-to-change-user-settings).
2. Add a new Repository with a unique `Name` (e.g. "My Modules") and the `Address` value being the full location of the folder where our Module was created (e.g. `C:\Dev\MyModules\Intent.Modules`).
3. Reorder the repositories so that this new one is at the top.
4. Click `Save`.

    <p><video style="max-width: 100%" muted="true" loop="true" autoplay="true" src="videos/add-new-modules-repository.mp4"></video></p>
5. Type in the search field `MyModules.Entities` to locate your new Module.

   > [!TIP]
   > You can also go to the Respository dropdown and select your newly created Respository which will list only the Modules you have created.
6. Install the Module and `HIDE` when done.

    <p><video style="max-width: 100%" muted="true" loop="true" autoplay="true" src="videos/selecting-repository-and-installing-module.mp4"></video></p>

### Assigning the Template Output

After the installation of the module, you would notice two parts of the application highlighted with warning signs.
![Warnings displayed after Module Installation](images/after-module-install-sf-warnings.png)

This is happening due to the background Software Factory Execution process (which you've minimized previously) which detected changes made to your project that triggered a re-run of the Software Factory Execution.

After opening the highlighted status button below, you can drill down into the details to inspect what went wrong.
<p><video style="max-width: 100%" muted="true" loop="true" autoplay="true" src="videos/after-module-install-sf-warnings-detail.mp4"></video></p>

This is important because it's telling us that we need to assign our `MyModules.Entities.EntityBase` template to an output location. This is done in the `Visual Studio` Designer.

1. Don't continue yet. Minimize the Execution window.
2. Navigate to the `Visual Studio` Designer.
3. Drag the `MyModules.Entities.EntityBase` Template Output into the `TestApp.Domain` project.

    <p><video style="max-width: 100%" muted="true" loop="true" autoplay="true" src="videos/visual-studio-assign-template-output.mp4"></video></p>
4. Click on Save.

We've now told Intent Architect that when generating the `EntityBase` template the output should be dumped in the `TestApp.Domain` project.

## Run the Module

We've created a project structure, installed our Module, and set the Output Target to our `TestApp.Domain` project. We are now ready to run our Module.

1. You will have noticed that the Software Factory executed once more. When you click on it you will see that the following changes should be staged:

    ![Software Factory Output](images/software-factory-module-output.png)
2. Click the `APPLY CHANGES` button.
3. Minimize the Software Factory Execution.
4. Open the codebase to verify that the new `EntityBase.cs` file was created in the correct location.

> [!NOTE]
> You may notice that a NuGet package (`Intent.RoslynWeaver.Attributes`) gets added to the `TestApp.Domain.csproj` file. This package provides _non-executing_ C# attributes which are used to instruct the [Code-Management](xref:getting-started.welcome#code-management) systems in C#. This is not a hard dependency, does not affect runtime execution in any way and can be swapped out or removed if needed.

## What's Next

### [Create Files per Model](xref:tutorials.creating-modules-net.create-templates-per-model)
