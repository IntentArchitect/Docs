---
uid: module-building.software-factory-events.software-factory-events
---
# Software factory events

Software factory events allow modules to interact with each other in a decoupled manner, a Template or Software Factory Extension can publish an event without having to be directly aware of any subscribers of that event. They enable use cases like different modules being able to service cross-cutting architectural concerns.

For example, a template could publish an event requesting its type be registered in a dependency injection container. The user of the module could then choose to install one of a variety of available dependency injection modules which are all listening for that event and will register the type in a technology specific way, the particular installed dependency injection module (perhaps Ninject), could be uninstalled and an alternative module (perhaps AutoFac) could be installed instead and because they both listen for the same event, the system still works with the original event publishing template not needing to be aware of which module is installed.

## Subscribing and consuming an event

Create an event type (typically in a "third", common project), for example:

```csharp
public class RegistrationRequest
{
    public RegistrationRequest(IClassProvider template)
    {
        Template = template;
    }

    public IClassProvider Template { get; set; }
}
```

In your template's constructor, subscribe to the event:

```csharp
ExecutionContext.EventDispatcher.Subscribe<RegistrationRequest>(Handle);
```

`Handler` above refers to a method in a class to handle the event, the implementation of which could be like so:

```c#
private void Handle(RegistrationRequest request)
{
    AddTemplateDependency(TemplateDependency.OnTemplate(request.Template)); // Will add project dependencies if needed
    _typesToRegister.Add($"{request.Template.Namespace}.{request.Template.ClassName}");
}
```

Add a field to the template to hold the types:

```csharp
private readonly List<string> _typesToRegister = new();
```

The `.tt` file can then be updated to make use of these types:

```csharp
namespace <#= Namespace #>
{
    public class <#= ClassName #>
    {
        public void DoRegistrations()
        {
<# foreach (var type in _typesToRegister) { #>
            DoRegistration(typeof(<#= UseType(type) #>));
<# } #>
        }

        public void DoRegistration(Type typeToRegister)
        {
            // Custom registration logic here...
        }
    }
}
```

## Publishing an event

Publishing of events must be done in the overridden `BeforeTemplateExecution()` method. Publishing from a template constructor will not work reliably because the software factory instantiates templates in an undefined order meaning that event subscribers may not have been instantiated yet and thus will not receive the published event.

If not done already, `override` the `BeforeTemplateExecution()` method and publish from inside of it:

```csharp
public override void BeforeTemplateExecution()
{
    base.BeforeTemplateExecution();
    ExecutionContext.EventDispatcher.Publish(new RegistrationRequest(this));
}
```

## Conclusion

When the above event is published, the subscriber adds its type to a list and a template's dependencies which later during the software factory execution is used when generating the template.
