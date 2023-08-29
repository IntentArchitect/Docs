---
uid: module-building.additional-tools.software-factory-extensions.how-to-create-a-factory-extension
---
# How to create a Factory Extension

Generating source code is not the only thing that Intent Architect can do when it runs the Software Factory Execution. The processing pipeline can also be extended by running middleware called `Factory Extensions`.
This guide will explain how to create a `Factory Extension` and using it to invoke a command-line command:

```cmd
npm install
```

This guide assumes that you have a Module Project already setup to work from. If you would like to know how to set one up please visit the [Create Module](xref:module-building.tutorial-create-a-template.create-a-template-introduction) tutorial.

## Creating a Factory Extension

Inside your Module Builder designer, right click on the package and select `New Factory Extension`.
Give it the name of `NpmInstallFactoryExtension`.

![Create Factory Extension](images/create-factory-extension.png)

> [!NOTE]
> Make sure to Run the Software Factory Execution as this will generate the Factory Extension code.
>
> ![Software Factory Run](images/software-factory-execution-staging.png)

## Implementing the Factory Extension

Open your `MyModules.Entities` Visual Studio project and locate the `NpmInstallFactoryExtension.cs` file and open it.

Make changes to the class so that it looks like this:

```csharp
using Intent.Engine;
using Intent.Modules.Common.Plugins;
using Intent.Plugins.FactoryExtensions;
using Intent.RoslynWeaver.Attributes;
using Intent.Utils;
using System.Diagnostics;
using System.IO;
using System;

[assembly: DefaultIntentManaged(Mode.Fully)]
[assembly: IntentTemplate("Intent.ModuleBuilder.Templates.FactoryExtension", Version = "1.0")]

namespace SampleModule.FactoryExtensions
{
    [IntentManaged(Mode.Fully, Body = Mode.Merge)]
    public class NpmInstallFactoryExtension : FactoryExtensionBase
    {
        public override string Id => "SampleModule.NpmInstallFactoryExtension";

        [IntentManaged(Mode.Ignore)]
        public override int Order => 0;

        protected override void OnAfterCommitChanges(IApplication application)
        {
            try
            {
                var cmd = new Process
                {
                    StartInfo =
                        {
                            FileName = "cmd.exe",
                            RedirectStandardInput = true,
                            RedirectStandardOutput = true,
                            CreateNoWindow = false,
                            UseShellExecute = false,
                            WorkingDirectory = Path.GetFullPath(application.RootLocation)
                        }
                };
                cmd.Start();

                cmd.StandardInput.WriteLine("npm install");

                cmd.StandardInput.Flush();
                cmd.StandardInput.Close();

                var output = cmd.StandardOutput.ReadToEnd();
                Logging.Log.Info(output);
            }
            catch (Exception e)
            {
                Logging.Log.Failure($@"Failed to execute: ""npm install"", Reason: {e.Message}");
            }
        }
    }
}
```

> [!IMPORTANT]
> Make sure to compile your module project before continuing.

## Running the Factory Extension

Install your Module to your Test Application in Intent Architect. Follow these [steps](xref:module-building.tutorial-create-a-template.install-and-run-the-module#install-the-module) if you are not sure how.

Once that is done, run the Software Factory and click on the Apply button. Then you will observe the following at the end of the process in the console output:

![Complete](images/software-factory-execution-complete.png)

## Factory Extension extension points

If the above example the factory extension used the `OnAfterCommitChanges` extension point, here is a list of all the commonly used extension points.

* OnAfterTemplateRegistrations
* OnBeforeTemplateExecution
* OnAfterCommitChanges

