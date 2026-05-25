---
uid: module-building.templates-csharp.how-to-add-custom-to-cs-projects
---

# How to add custom configuration to C# projects

There may be times when a C# project needs to be customized beyond what Intent Architect generates. This section details how this can be achieved.

A typical use case is adding a post build event to the csproj file to execute a script after the project has been built.

## Post Build Event Example

In the below example, we are going to add a post build event to the Infrastructure project, which will execute a `dotnet --info` command.

1. Create a Factory Extension in your module to handle the updating of the csproj file.
2. Add a NuGet Reference to `Intent.Modules.VisualStudio.Projects`, to gain access to the required code/templates.
3. Inject `ISoftwareFactoryEventDispatcher` into the constructor of the Factory Extension:

    ``` csharp
    private readonly ISoftwareFactoryEventDispatcher _sfEventDispatcher;

    public PostBuildEventExtension(ISoftwareFactoryEventDispatcher sfEventDispatcher)
    {
        _sfEventDispatcher = sfEventDispatcher;
    }
    ```

4. In the overridden `OnAfterTemplateExecution` method in the Factory Extension, add some code to look-up the correct csproj file:

    ``` csharp
    protected override void OnAfterTemplateExecution(IApplication application)
    {
    // Get all C# project templates
    IEnumerable<CSharpProjectTemplate> projects = application.FindTemplateInstances<CSharpProjectTemplate>("Intent.VisualStudio.Projects.CSharpProject");
    // Get the infrastructure project
    CSharpProjectTemplate infraProject = projects.FirstOrDefault(x => x.OutputTarget.Name.EndsWith("Infrastructure", StringComparison.OrdinalIgnoreCase));
    }
    ```

5. Next the content of the template (the project file XML) is loaded and parsed:

    ``` csharp
    // Load the content
    string projectContent = infraProject.LoadContent();
    XDocument document = XDocument.Parse(projectContent);

    XElement projectElement = document.Root;
    if (projectElement is null)
    {
        return;
    }
    ```

6. Construct the new content, and add it to the initial content, and then update the template with the new content

    ``` csharp
    XNamespace ns = projectElement.Name.Namespace;

    const string targetName = "SamplePostBuild";
    XElement existingTarget = projectElement.Elements(ns + "Target")
        .FirstOrDefault(e => string.Equals((string)e.Attribute("Name"), targetName, StringComparison.Ordinal));

    // Only add if the element doesn't already exist
    if (existingTarget is null)
    {
        // Build the element
        XElement postBuildTarget = new XElement(ns + "Target", 
            new XAttribute("Name", targetName),
            new XAttribute("AfterTargets", "Build"),
            new XElement(ns + "Message", new XAttribute("Importance", "high"),
                new XAttribute("Text", "Sample post-build event running...")),
            new XElement(ns + "Exec", new XAttribute("Command", "dotnet --info"))
        );

        // Add to the XML
        projectElement.Add(postBuildTarget);

        // Update the template with the new content
        infraProject.UpdateContent(document.ToString(), _sfEventDispatcher);
    }
    ```

The following block should now be added to the Infrastructure project when running the Software Factory:

``` xml
<Target Name="SamplePostBuild" AfterTargets="Build">
  <Message Importance="high" Text="Sample post-build event running..." />
  <Exec Command="dotnet --info" />
</Target>
```

### Full code sample

Below is the full code snippet of the contents of the `PostBuildEventExtension` Factory Extension:

``` csharp
private readonly ISoftwareFactoryEventDispatcher _sfEventDispatcher;

public PostBuildEventExtension(ISoftwareFactoryEventDispatcher sfEventDispatcher)
{
    _sfEventDispatcher = sfEventDispatcher;
}

protected override void OnAfterTemplateExecution(IApplication application)
{
    IEnumerable<CSharpProjectTemplate> projects = application.FindTemplateInstances<CSharpProjectTemplate>("Intent.VisualStudio.Projects.CSharpProject");
    CSharpProjectTemplate infraProject = projects.FirstOrDefault(x => x.OutputTarget.Name.EndsWith("Infrastructure", StringComparison.OrdinalIgnoreCase));

    if (infraProject is not null)
    {
        string projectContent = infraProject.LoadContent();
        XDocument document = XDocument.Parse(projectContent);

        XElement projectElement = document.Root;
        if (projectElement is null)
        {
            return;
        }

        XNamespace ns = projectElement.Name.Namespace;

        const string targetName = "SamplePostBuild";
        XElement existingTarget = projectElement.Elements(ns + "Target")
            .FirstOrDefault(e => string.Equals((string)e.Attribute("Name"), targetName, StringComparison.Ordinal));

        if (existingTarget is null)
        {
            XElement postBuildTarget = new XElement(ns + "Target",
                new XAttribute("Name", targetName),
                new XAttribute("AfterTargets", "Build"),
                new XElement(ns + "Message", new XAttribute("Importance", "high"),
                    new XAttribute("Text", "Sample post-build event running...")),
                new XElement(ns + "Exec", new XAttribute("Command", "dotnet --info"))
            );

            projectElement.Add(postBuildTarget);

            infraProject.UpdateContent(document.ToString(), _sfEventDispatcher);
        }
    }
}
```
