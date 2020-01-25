---
uid: TutorialCreateApp
---
# Getting started - Create an ASP.NET Core web app

The aim of this tutorial is to familiarize you with the interface of Intent Architect while learning the value of using visual models to design the application and generate code using different Modules.

The app manages a database of movie titles. In this guide, you will learn how to:
 - Create a workspace and application from an _Application Template_.
 - Execute the _Software Factory_ to generate or update code.
 - Model a Domain entity
 - Describe services, their operations and data contracts (Data Transfer Objects)
 - Open, run and code within the generated codebase

At the end of the tutorial, you will have an app that can manage movie data. Once you have the hang of it, you will be able to build an app like this in less than 5 min :)

[View or download sample](https://github.com/IntentSoftware/Docs/tree/master/source_code/samples/create-web-app)

***
## Prerequisites

This guide has the following prerequisites:
 - Intent Architect is currently only supported on Windows OS and MacOS (_Linux support coming soon_)
 - (Windows) Windows 8.1 or later with Visual Studio 2017 (with .NET Core 2.1 SDK) or later.
 - (MacOS) 10.10 (Yosemite) or later with Visual Studio for Mac.
 - An instance of SQL Server is optional.


***
## 1. Installing and running Intent Architect

Get Intent Architect up and running through the following steps.

- Download the latest version of Intent Architect from the website: [https://intentarchitect.com/#/downloads](https://intentarchitect.com/#/downloads)
- Double click the downloaded executable to install and run Intent Architect.
- Log in using the credentials created for your account, or create a free account within Intent Architect.


***
## 2. Create a workspace

A `workspace` provides the root location of your solution. This is typically the root folder of your version control repository. It may for example contain a single monolithic application or several microservices.

**From the home screen, click `Create new workspace...` under the 'Create' header.**

Fill in the Name, Description (optional), and Location of your workspace. You can also change the icon by clicking on it.

![New Workspace Dialog](images/create-web-app/create-workspace.png)

*Create Workspace Dialog*

>[!TIP]
>Good names for Workspaces would typically be things like the client name, your product name, business area / unit or your organization name.

**Once the workspace details have been filled out, click `Save`.**

The workspace will open automatically.


***
## 3. Create a new Application

Next we will create an `Application`. An application could represent a standalone monolithic application, a mircroservice, or simply a location for Intent Architect to generate code into.

**To create an application, click the `New Application` tile from within the workspace.**

A `Create application` wizard will be displayed, presenting a set of `application templates`.
- Select the `Web Application ASP.NET Core` application template.
- Capture the Name, Location, Icon and Description (option) of your application.

![Select an Application Template](images/create-web-app/create-application-page1.png)
*Select an application template and fill out application details.*

**Click `NEXT`.**

The `Web Application ASP.NET Core` application template provides a set of components which can be turned on or off. Each component represents one or more Modules that will be installed. By default the main components are selected, with others presented as options.

We will want to test our services later, and for that we can use the [Swagger UI](https://swagger.io/tools/swagger-ui/).

**Select the `Swagger (Swashbuckle)` component for installation.**

![Capture Application Details](images/create-web-app/create-application-page2.png)
*Select application components to install*

>[!TIP]
>You will be able to add or remove Modules later, so don't worry about ensuring you get everything you need installed upfront.

**Click `CREATE`.**

Intent Architect will now create the application as defined by the `Web Application ASP.NET Core` application template and begin downloading all the necessary Modules. Once downloading is complete the application will be opened automatically.

Applications open by default on the `Project Layout` section. This application template lays out the projects in the following way:

![Project Layout](images/create-web-app/configuration.png)
*Project Layout*

>[!TIP]
>Find out more about [Project Layout and Roles in this article](xref:ProjectLayout).

There is nothing to change here since the defaults is exactly what we need. This is just a formality to show you how your application is structured after a code-generation run.

***
## 4. Run the `Software Factory`

Your application is now created, and pre-configured with a `Project Layout` and Modules for realising an ASP.NET Core web application. Now to generate the code, we must run the `Software Factory`. The `Software Factory` must be run after each time we make changes to the application inside of Intent Architect. In essence it is the process which feeds the _Metadata_ (what we've described about our application) into the _Modules_ (how these descriptions must be realized in code), and then output this code into our codebase.

>[!TIP]
>To see which Modules were installed by the `Web Application ASP.NET Core` application template, navigate to the Intent Module Manager by clicking on `Modules` in the side menu, then click on `Installed`.

**To run the `Software Factory`, click the _'play'_ button in the top right hand corner (or press F5):**

The `Run Software Execution` dialogue will appear, providing an output log in the `Console` tab, followed by staging files it intends on creating, updating or deleting in the `Changes` tab:

![Execution of the Software Factory](images/create-web-app/software-factory-execute.gif)
*Software Factory Execution*

The `Software Factory` hasn’t created or altered any files at this point. The files are staged so that it is clear to the developer what the software factory is intending on doing. By clicking on one of the files, Intent Architect will open a diff-tool (by default Visual Studio) to compare changes. 

>[!TIP]
>Try clicking the `Startup.cs` file to see what Intent Architect intends to output. Note that the default Visual Studio installation locations are inspected to automatically wire up the diff-tool. If not found, an error will be shown. Any diff-tool can be used, and can be changed under your profile settings located in the top right hand corner, to the right of the Software Factory _"play"_ button..

**Click the `APPLY CHANGES` button.**

The `Software Factory` will apply the staged code changes from the list. We can now close the `Software Factory Execution` window.

**Click the `CLOSE` button.**


***
## 5. Run the application in Visual Studio

At this point, we've told Intent Architect that we want an ASP.NET Core web application, and allowed it to generate the required files for just that. To open the solution in Visual Studio, we need to navigate to the application's folder. An easy shortcut to the code is to navigate to the `Project Layout` section in the aside menu, and click on the `Open in Folder` button.

The folder should look something like this:

![View of Generated Output](images/create-web-app/generated-application.png)
*Generated outputs*

**Open the solution (e.g. `MyMovies.sln` file) in Visual Studio 2017** or later (since this is a .NET Core application). The solution will look as follows:

![Visual Studio Solution](images/create-web-app/visual-studio-solution.png)

*Visual Studio solution layout*

Notice how closely it resembles the layout in Intent Architect when we were still on the `Project Layout` page.

Allow Visual Studio to restore NuGet dependencies then **compile and run the application by clicking `Debug` -> `Start Debugging` menu items** (or press F5).

The server will be launched locally. **Navigate to `/swagger` relative url to open the Swagger UI.**

![Empty Swagger](images/create-web-app/swagger-empty.png)
*Swagger UI - No operations defined in spec!*

Since we haven't described any services, the Swagger UI will be empty. Let's now begin describing what we want our web server to do (_describing our "intent"_).


***
## 6. Describing a Domain

A good place to start designing a system is with the Domain. The Domain should represent the business entities and their relationships to one another. 

>[!TIP]
>Modeling domains in this way brings _visibility_ and _transparency_ to your business layer. Developers can discuss design decisions amongst each other (and even with business) with the knowledge that the diagram they are looking at represents the truth of the underlying code. In his book, **_Domain-Driven Design: Tackling Complexity in the Heart of Software_**, Eric Evans describes the value of having a model to align developers and domain experts.

To model our Movies domain, **navigate to the `Domain` modeler.**

>[!NOTE]
>Since the new Intent Architect 2.0 update, we have made enhancements to the diagrams in the `Domain` modeler. Unfortunately we also have yet to resolve one or two minor issues with creating them from the beginning, which we're hoping to have resolved in a close future release.
>
>You'll also notice that the view starts off looking like a Tree view. Go ahead and first click on the button ![](images/create-web-app/DiagramToggler.png) to toggle between the UML diagram view and the Treeview diagram view. This is located on the top toolbar.
>
>Next you need to create a new Diagram. You'll notice a `Domain` package on the panel to your right. ![](images/create-web-app/DomainPackage.png)
>
>Right click on that package and click on `New Diagram`. Give it a name of "Default view". Double click on it to select the diagram and to begin modeling your domain.

Let's now add a class called `Movie` to our Domain. To add a class, **right-click the diagram view and click `New Class`.** The newly added class automatically allows you to rename it in the model window on the right. **Rename it to `Movie`.** Alternatively, right-click the class and click `Rename` (or press F2).

Next let's add attributes to our `Movie` class. To add an attribute, right-click the class and click `Add Attribute` (or press _ctrl + shift + a_).

**Add the following attributes:**

![Movie class](images/create-web-app/domain-movie-class.png)

*Domain Modeler - adding classes and attributes.*

To change the `Type` of the attribute, select the desired type from the dropdown inside the `Properties` window that is displayed on selecting an element in the diagram.

The following `gif` illustrates this process:

![Adding a Domain Class](images/create-web-app/domain-create-movies.gif)
*Domain Modeler - adding classes and attributes.*

**Press the _'save'_ icon to save your `Domain` model, and re-run the `Software Factory`.**

The changes should look as follows:

![Software Factory Execution - Domain changes](images/create-web-app/software-factory-domain-changes.png)
*Software Factory Execution - Domain changes.*

>[!NOTE]
>Looking through the changes above we can see the `Movie.cs` entity, it's state `MovieState.cs` and interface `IMovie.cs` being created, with a [repository](https://docs.microsoft.com/en-us/dotnet/standard/microservices-architecture/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-design) interface `IMovieRepository.cs` and [specification](https://deviq.com/specification-pattern/) object `MovieSpecification.cs`. These reside in the domain project (`MyCompany.MyMovies.Domain.csproj`), and as part of the architecture, none of these classes or interfaces has any _technology_ dependencies. 

>In the infrastructure project (`MyCompany.MyMovies.Infrastructure.csproj`) we see the [Entity Framework](https://docs.microsoft.com/en-gb/ef/core/) mapping `MovieMapping.cs` and the repository implementation `MovieRepository.cs`. These patterns are determined by the Modules that were installed on application creation.

**Click `APPLY CHANGES` and close the `Software Factory Execution` window.**


***
## 7. Describing Services

Next, we want to create services to create and access our Movies. To do this, we must **navigate to the `Services` modeler.**

Let's create a service that will allow us to add and retrieve our movies. To add a service, **right-click the `Services` package and click on `New Service`.** Name the service `MovieManager`, and **add two operations, `Create` and `List`,** by right-clicking the new service and clicking on `New Operation`.

![Adding a Service](images/create-web-app/services-service-creation.gif)
*Services - adding a service with operations*

Operations by themselves have limited uses. We need to describe what parameters they accept as well as what data they return. Our `Create` operation needs to accept a data object which we will refer to as a `Data Transfer Object (DTO)`. To add a DTO, simply **right-click the `Services` package and click `New DTO`.** We will name this DTO `MovieDTO`.

Next, we must describe the data fields that this DTO provides. Since we are using it to create a `Movie` entity, it should have the same fields as we modeled earlier in the Domain.

**Describe the `MovieDTO` as shown below:**

![Adding a DTO](images/create-web-app/services-dto-creation.png)

*Services - adding a DTO*

To wire up our DTO with our operations, we add parameters and return types. **right-click the `Create` operation and assign in a parameter called `dto` with Type `MovieDTO`. Next, right-click the `List` operation and assign it a return type of Type `MovieDTO`, and check the `Is Collection` option in the `Properties` on the right. Click the _"save"_ icon.**

![Assigning parameters and return types to operations](images/create-web-app/services-assign-parameters-returntypes.gif)
*Services - assigning parameters and return types to operations*

The services should look as follows:

![Adding a DTO](images/create-web-app/services-final-result.png)

*Services - MovieManager.*

**Re-run the `Software Factory` and apply changes.**

![Software Factory Execution - Services changes](images/create-web-app/software-factory-services-changes.png)
*Software Factory Execution - Services changes.*

>[!NOTE]
>As can be expected, our service is created as an ASP.NET Core MVC controller `MovieManagerController.cs` in our API project (`MyCompany.MyMovies.Api.csproj`).

>In our application project (`MyCompany.MyMovies.Application.csproj`) the DTO `MovieDTO.cs`, service interface `IMovieManager.cs` and service implementation class `MovieManager.cs` is created.

>The service implementation class is where we will put our logic to save and retrieve movies. Let's do this now.


***
## 8. Writing code: implementing the service

Now that we have described our domain and services, and allowed Intent Architect to generate our required infrastructure, all that is left is to code our implementation. Since we will only be creating and retrieving Movie entities, this will be very easy.

**Re-open the solution in Visual Studio, and navigate to the service implementation class `MovieManager.cs`.** It will be located in the `MyCompany.MyMovies.Application` project, in the `ServiceImplementation` folder.

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Intent.RoslynWeaver.Attributes;
using MyCompany.MyMovies.Application;


[assembly: DefaultIntentManaged(Mode.Merge)]
[assembly: IntentTemplate("Intent.Application.ServiceImplementations", Version = "1.0")]

namespace MyCompany.MyMovies.Application.ServiceImplementation
{
    public class MovieManager : IMovieManager
    {

        public MovieManager()
        {
        }

        [IntentManaged(Mode.Merge, Body = Mode.Ignore, Signature = Mode.Fully)]
        public async Task Create(MovieDTO dto)
        {
            throw new NotImplementedException("Write your implementation for this service here...");
        }

        [IntentManaged(Mode.Merge, Body = Mode.Ignore, Signature = Mode.Fully)]
        public async Task<List<MovieDTO>> List()
        {
            throw new NotImplementedException("Write your implementation for this service here...");
        }

        public void Dispose()
        {
        }
    }
}
```

>[!TIP]
>The attributes above the namespace are part of the Roslyn Weaving system that is provided by installing the `Intent.OutputManager.RoslynWeaver` module.

>This system ultimately takes the pain out of continuous code generation, making it possible to work alongside continuously-generated code and to take over methods and classes if the generated output isn't meeting the specific requirements. 


>In this case it allows you to add your _user-managed_ code to this file, while simultaneously allowing Intent Architect to change signatures and add methods later (e.g. if we want to change the pattern).

>The `[IntentManaged(Mode.Merge, Body = Mode.Ignore, Signature = Mode.Fully)]` attribute is instructing the Roslyn Weaving system to allow you to alter the body of the method (`Body = Mode.Ignore`), while Intent Architect must manage the signature (`Signature = Mode.Fully`). Therefore, if we update the signature of our operations in the `Services` modeler, it will update the signature, but **leave** your implementation as is.

>For more information on the Roslyn Weaving system, click [here](xref:RoslynWeaver).

In this application architecture, the service implementation classes are where we implement our application layer business logic.

**Implement the `MovieManager.cs` service as follows:**
[!code-csharp[MovieManager](~/source_code/samples/create-web-app/MyMovies/MyCompany.MyMovies.Application/ServiceImplementation/MovieManager.cs)]

And that's all the code needed for our system to work :)

>[!NOTE]
>Since the `IMovieRepository` class is in the domain project (`MyCompany.MyMovies.Domain`), you will need to add a project reference to it in the `MyCompany.MyMovies.Application` project.

The last step before we run our application is that we need to set up the database. Here we have two options:
 - Option 1: Use an in-memory database.
 - Option 2: Use the [Entity Framework migration](https://docs.microsoft.com/en-us/ef/core/managing-schemas/migrations/) system to create our database (requires access to a SQL Server instance).

### Option 1: In-memory Database
In the `Startup.cs` file, find the `ConfigureDbContext` method and update it as follows:
```csharp
    [IntentManaged(Mode.Ignore)] // We're taking this method over
    private void ConfigureDbContext(IServiceCollection services)
    {
        services.AddDbContext<MyMoviesDbContext>(x => 
            x.UseInMemoryDatabase("MyCompany.MyMovies"));
    }
```

### Option 2: Entity Framework Migrations
1. Ensure that the connection string in the `appsettings.json` file are correct (by default it tries to access a local server through the following connection string: `"Server=.;Initial Catalog=MyMovies;Integrated Security=true;MultipleActiveResultSets=True"`).
2. Open the `MIGRATION_README.txt` file in the `MyCompany.MyMovies.Infrastructure.Data` project. This file is a reference for Entity Framework migration commands relevant to this application.
3. Open the `Package Manager Console` (Tools -> NuGet Package Manager -> Package Manager Console).
4. Run the _Create new migration_ command, changing the `{ChangeName}` option to "Initial": `Add-Migration -Name Initial -StartupProject "MyCompany.MyMovies.Api" -Project MyCompany.MyMovies.Infrastructure.Data`. This will create the migration.
5. Run the _Update to latest version_ command, changing the `{ChangeName}` option to "Initial": `Update-Database -StartupProject "MyCompany.MyMovies.Api" -Project MyCompany.MyMovies.Infrastructure.Data`. This will create the database and required table schema.


***
## 9. Run and test the app

**Rebuild and run the application (press F5)**.

Once the app is running, **navigate to the Swagger UI (`~/swagger`) test the services.**

### Testing the `Create` operation
For the `'POST /api/MovieManager/create'` service, use the Swagger UI to set the DTO body with data and execute it. The response should indicate that the call was successful:

![Swagger Test - Create Movie](images/create-web-app/swagger-test-createmovie.gif)
*Swagger Test - Create Movie*

### Testing the `List` operation
For the `'GET /api/MovieManager/list'` service, use the Swagger UI to list the movies that were added to the database in the previous step:

![Swagger Test - List Movies](images/create-web-app/swagger-test-listmovies.gif)
*Swagger Test - List Movies*


***
## Summary

In this guide, we've created a simple, functioning, ASP.NET Core web application.

We introduced the following concepts:
 - **Application Template**: a predefined `Project Layout` and set of Modules that can be used to set up a new application.
 - **Project Layout**: the project structure of the application.
 - **Module**: a pattern that has been codified. In the same way that a NuGet package provides the reuse of code, an Intent Module provides the reuse of patterns. Modules are run during the Software Factory Execution process.
 - **Software Factory**: the process which, when executed, feeds the _Metadata_ about our application (i.e. `Domain`, `Services`, `Project Layout`) into the installed _Modules_, which turn this information into file outputs such as C# files, etc.
 - **Domain modeler**: the modeler where we describe entities and their relationships to one another.
 - **Services modeler**: the modeler where we describe our applications services and data contracts.
 - **Roslyn Weaver**: the system which _"weaves"_ user-code and generated-code into a single file. It allows you to take over methods and classes that were previously under _Intent management_ to alter the code to your specific needs. In this way, the pain often associated with code-generation is completely removed, ensuring you have 100% control of your codebase.


***
## What's Next?

Explore how easy it is to extend this application by adding Actors to the domain and creating a service to manage them. Create a service to connect Actors with Movies they play in. Go wild!