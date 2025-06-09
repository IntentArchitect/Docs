---
uid: module-building.templates-csharp.csharp-file-builder-system
---
# C# File Builder System

The C# File Builder System is Intent Architect's primary method for generating and manipulating C# source code through templates. It provides a fluent, builder-pattern API that allows you to construct C# files programmatically using semantically meaningful methods that align with C# language constructs.

## What is the C# File Builder System?

The C# File Builder System replaces traditional text-based templating approaches (like T4 templates) with a code-first builder pattern. Instead of writing string-based templates, you use strongly-typed C# code to construct your output files.

This approach provides a more maintainable, type-safe way to generate C# code that integrates seamlessly with other Intent Architect components like Factory Extensions.

### Why Use the File Builder System?

- **Type Safety**: Unlike text-based templates, the builder system provides compile-time checking of your template logic.
- **IntelliSense Support**: Full IDE support with auto-completion for all available methods and properties.
- **Refactoring Safety**: Changes to your template logic are caught by the compiler rather than failing at runtime.
- **Code Interrogation**: Other templates and Factory Extensions can inspect and modify the code being generated through the builder objects.
- **Better Maintainability**: Complex generation logic is easier to understand and maintain when written as structured C# code.

## Core Concepts

### The `ICSharpFileBuilderTemplate` Interface

When creating a template that uses the File Builder System, you need to:

1. Set the **Templating Method** to `C# File Builder` in the Module Builder Designer
2. Your template class will automatically implement the `ICSharpFileBuilderTemplate` interface

![Template Method Selection](images/template-method-selection.png)

Once configured, your template class will look like this:

```csharp
public partial class MyTemplate : CSharpTemplateBase<MyModel>, ICSharpFileBuilderTemplate
{
    public const string TemplateId = "MyModule.MyTemplate";

    public MyTemplate(IOutputTarget outputTarget, MyModel model) : base(TemplateId, outputTarget, model)
    {
        CSharpFile = new CSharpFile(this.GetNamespace(), this.GetFolderPath())
            .AddClass($"{Model.Name}", @class =>
            {
                // Configure the class using builder methods
            });
    }

    [IntentManaged(Mode.Fully)]
    public CSharpFile CSharpFile { get; }

    [IntentManaged(Mode.Fully)]
    protected override CSharpFileConfig DefineFileConfig()
    {
        return CSharpFile.GetConfig();
    }

    [IntentManaged(Mode.Fully)]
    public override string TransformText()
    {
        return CSharpFile.ToString();
    }
}
```

### The `CSharpFile` Object

The `CSharpFile` object is the root of the builder hierarchy. It represents the entire C# source file and provides methods to add top-level constructs:

```csharp
CSharpFile = new CSharpFile(namespace: "MyApp.Domain", relativeLocation: "Entities")
    .AddUsing("System")
    .AddUsing("System.Collections.Generic")
    .AddClass("Customer", @class => 
    {
        // Class configuration
    })
    .ImplementsInterface("ICustomerService", @interface =>
    {
        // Interface configuration  
    });
```

## Building Classes

Classes are the most common construct you'll build when using the File Builder System. The builder provides extensive methods for configuring class members:

### Basic Class Structure

```csharp
.AddClass("Customer", @class =>
{
    @class
        .WithBaseType("EntityBase")
        .ImplementsInterface("ICustomer")
        .AddProperty("string", "FirstName")
        .AddProperty("string", "LastName")
        .AddProperty("DateTime", "CreatedDate");
})
```

### Adding Constructors

```csharp
.AddClass("Customer", @class =>
{
    @class.AddConstructor(ctor =>
    {
        ctor.AddParameter("string", "firstName", param =>
        {
            param.IntroduceReadonlyField(); // Creates private readonly field
        });
        ctor.AddParameter("string", "lastName", param =>
        {
            param.IntroduceProperty("LastName"); // Creates property and assigns it
        });
    });
})
```

### Adding Methods

```csharp
.AddClass("CustomerService", @class =>
{
    @class.AddMethod("Customer", "GetCustomerById", method =>
    {
        method
            .AddParameter("int", "customerId")
            .AddStatement("var customer = _repository.FindById(customerId);")
            .AddReturn("customer ?? throw new CustomerNotFoundException(customerId)");
    });
})
```

### Adding Properties with Different Configurations

```csharp
.AddClass("Customer", @class =>
{
    // Simple auto-property
    @class.AddProperty("string", "FirstName");
    
    // Property with private setter
    @class.AddProperty("DateTime", "CreatedDate", property => 
    {
        property.PrivateSetter();
    });
    
    // Property with initial value
    @class.AddProperty("bool", "IsActive", property =>
    {
        property.WithInitialValue("true");
    });
    
    // Property with custom getter logic
    @class.AddProperty("string", "FullName", property =>
    {
        property.WithoutSetter();
        property.Getter.WithBodyImplementation(@"return $""{FirstName} {LastName}"";");
    });

    // Property with expression implementation
    @class.AddProperty("string", "FullName", property =>
    {
        property.WithoutSetter();
        property.Getter.WithExpressionImplementation($@"""{FirstName} {LastName}""");
    });
})
```

### Controlling Accessibility and Modifiers

You can control the accessibility and modifiers of classes, methods, and properties:

```csharp
.AddClass("CustomerService", @class =>
{
    // Public static class
    @class.Static();
    
    // Private method
    @class.AddMethod("void", "ValidateCustomer", method =>
    {
        method.Private();
        method.AddParameter("Customer", "customer");
    });
    
    // Protected virtual method
    @class.AddMethod("bool", "CanProcess", method =>
    {
        method.Protected().Virtual();
        method.AddReturn("true");
    });
    
    // Static method with XML documentation
    @class.AddMethod("Customer", "CreateDefault", method =>
    {
        method
            .Static()
            .WithComments("""
                          /// <summary>
                          /// Creates a default customer instance.
                          /// </summary>
                          /// <returns>A new customer with default values.</returns>
                          """);
        method.AddReturn("new Customer()");
    });
})
```

### Working with Async Methods

The File Builder System supports async methods with proper return type handling:

```csharp
.AddClass("CustomerService", @class =>
{
    // Async method returning Task
    @class.AddMethod("Customer", "GetCustomerAsync", method =>
    {
        method
            .Async() // Will set the return type to Task<Customer>
            .AddParameter("int", "customerId");
        method.AddReturn("await _repository.FindByIdAsync(customerId)");
    });
    
    // Async method returning ValueTask
    @class.AddMethod("bool", "ExistsAsync", method =>
    {
        method
            .Async(true) // Will set the return type to ValueTask<bool>
            .AddParameter("int", "customerId");
        method.AddReturn("await _repository.ExistsAsync(customerId)");
    });
    
    // Async void method (for event handlers)
    @class.AddMethod("void", "OnCustomerChanged", method =>
    {
        method
            .Async() // Will set the return type to Task
            .AddParameter("object", "sender")
            .AddParameter("CustomerChangedEventArgs", "e");
        method.AddStatement("await ProcessCustomerChangeAsync(e.Customer);");
    });

    // Using standard Task type without async / await keywords
    @class.AddMethod("Task", "CompletedAsync", method =>
    {
        method.AddReturn("Task.CompletedTask");
    });
})
```

## Advanced Builder Patterns

### Conditional Code Generation

```csharp
.AddClass($"{Model.Name}", @class =>
{
    // Add properties for each attribute in the model
    foreach (var attribute in Model.Attributes)
    {
        @class.AddProperty(GetTypeName(attribute), attribute.Name.ToPascalCase());
    }
    
    // Conditionally add validation logic
    if (Model.HasStereotype("Validated"))
    {
        @class.AddMethod("bool", "IsValid", method =>
        {
            method.AddStatement("// Validation logic here");
            method.AddReturn("true");
        });
    }
})
```

### Using Builder Extensions

```csharp
.AddClass("ApiController", @class =>
{
    @class
        .WithBaseType("ControllerBase")
        .AddAttribute("[ApiController]") // C# Attribute with square brackets
        .AddAttribute("Route", attr => attr.AddArgument(@""api/[controller]"")); // C# Attribute with mutable arguments
        
    foreach (var operation in Model.Operations)
    {
        @class.AddMethod("IActionResult", operation.Name, method =>
        {
            method
                .AddAttribute($"[Http{operation.Verb}]")
                .AddParameter(GetTypeName(operation.RequestType), "request")
                .AddReturn($"Ok(_{operation.Name.ToCamelCase()}Service.Execute(request))");
        });
    }
})
```

### Working with CSharp Statements

The File Builder System provides a rich set of statement types and control over their formatting:

```csharp
.AddMethod("void", "ProcessCustomer", method =>
{
    // Basic statements
    method.AddStatement("var isValid = ValidateCustomer(customer);");
    
    // Statements with spacing control
    method
        .AddStatement("// First validation step")
        .AddStatement("var basicValidation = customer.Name != null;")
        .AddStatement("var advancedValidation = customer.Email?.Contains(\"@\") == true;")
        .SeparatedFromPrevious() // Adds extra spacing before this statement
        .AddStatement("// Processing logic")
        .AddIfStatement("isValid", ifStmt =>
        {
            ifStmt.AddStatement("ProcessValidCustomer(customer);");
            ifStmt.AddStatement("LogSuccess(customer.Id);");
        })
        .AddElseStatement(elseStmt =>
        {
            elseStmt.AddStatement("LogError($\"Invalid customer: {customer.Id}\");");
            elseStmt.AddThrowStatement("new InvalidOperationException(\"Customer validation failed\")");
        });
})
```

### Method Invocations with Lambda Expressions

You can create method calls that accept lambda expressions as arguments:

```csharp
.AddMethod("void", "ConfigureServices", method =>
{
    // Method invocation with lambda argument
    method.AddInvocationStatement("services.Configure<AppSettings>", invocation =>
    {
        invocation.AddArgument(new CSharpLambdaBlock("options"), lambda =>
        {
            lambda.AddStatement(@"options.ConnectionString = configuration.GetConnectionString(""Default"");");
            lambda.AddStatement("options.EnableRetry = true;");
        });
    });
    
    // Multiple lambda arguments
    method.AddInvocationStatement("app.UseWhen", invocation =>
    {
        invocation.AddArgument(new CSharpLambdaBlock("context"), lambda => lambda.WithExpressionBody(@"context.Request.Path.StartsWithSegments(""/api"")"));
        invocation.AddArgument(new CSharpLambdaBlock("appBuilder"), lambda =>
        {
            lambda.AddStatement("appBuilder.UseAuthentication();");
            lambda.AddStatement("appBuilder.UseAuthorization();");
        });
    });
})
```

### OnBuild vs AfterBuild Callbacks

The File Builder System provides two types of callbacks for modifying generated code:

```csharp
// In your template constructor
CSharpFile = new CSharpFile(this.GetNamespace(), this.GetFolderPath())
    .AddClass("Customer", @class =>
    {
        @class.AddProperty("string", "Name");
    });

// OnBuild: Executes during the file building process
// Use this when you need to modify the structure before other templates can see it
CSharpFile.OnBuild(file =>
{
    var customerClass = file.Classes.First(c => c.Name == "Customer");
    customerClass.AddProperty("DateTime", "CreatedAt");
    
    // This modification is visible to other templates and Factory Extensions
});

// AfterBuild: Executes after all OnBuild callbacks are complete
// Use this for final modifications that shouldn't affect other templates
CSharpFile.AfterBuild(file =>
{
    var customerClass = file.Classes.First(c => c.Name == "Customer");
    
    // Add final validation or cleanup
    if (!customerClass.Properties.Any(p => p.Name == "Id"))
    {
        customerClass.AddProperty("int", "Id", prop => prop.WithInitialValue("0"));
    }
});
```

> [!TIP]
> Use `OnBuild` when other templates or Factory Extensions need to see your modifications. Use `AfterBuild` for final touches that don't need to be visible to other components.

## Working with Using Directives

You can manually manage using directives by explicitly adding them:

```csharp
CSharpFile = new CSharpFile(this.GetNamespace(), this.GetFolderPath())
    .AddUsing("System.Collections.Generic") // Explicit using
    .AddClass("MyClass", @class =>
    {
        // When you add usings explicitly, the type is used as-is
        @class.AddProperty("IEnumerable<string>", "Items");
    });
```

Alternatively, you can use `UseType()` to automatically manage using directives:

```csharp
CSharpFile = new CSharpFile(this.GetNamespace(), this.GetFolderPath())
    .AddClass("MyClass", @class =>
    {
        // This will automatically add "using System.Collections.Generic;" if not already present
        @class.AddProperty($"{UseType("System.Collections.Generic.IEnumerable")}<string>", "Items");
    });
```

### Managing Type Names

Use the template's `GetTypeName()` methods to resolve types correctly:

```csharp
.AddClass("CustomerService", @class =>
{
    // GetTypeName will automatically apply the correct using directive
    @class.AddMethod(GetTypeName("Domain.Customer", Model), "GetCustomer", method =>
    {
        method.AddParameter("int", "id");
    });
})
```

### Template Type Resolution Methods

You can also use generated template extension methods for type resolution. When you create templates in the Module Builder, extension methods are automatically generated for resolving types from other templates:

```csharp
.AddClass($"{Model.Name}Repository", @class =>
{
    @class.ImplementsInterface(this.GetRepositoryInterfaceName(Model));
    // ...
}
```

## Best Practices

### Use semantic method names

Instead of building complex strings, use the builder's semantic methods:

```csharp
// Good
method.AddIfStatement("mode == 1", stmt =>
{
    stmt.AddReturn("true");
});

// Avoid - string-based approach
method.AddStatements(
    """
    if (mode == 1)
    {
        return true;
    }
    """
);
```

> [!NOTE]
> String-based code generation may work for simple cases, but you'll lose correct indentation and the ability to mutate statements at runtime through Factory Extensions.

### Leverage lambda configuration

All C# File Builder semantic methods use a consistent signature pattern:

- **Return Type** - The type the method/property returns
- **Object Name** - The name of the method/property/class
- **Configuration Lambda** - A lambda expression for configuring the object

```csharp
.AddMethod("void", "ConfigureServices", method =>
{
    method.AddParameter("IServiceCollection", "services");
    
    foreach (var service in GetServices())
    {
        method.AddStatement($"services.AddScoped<{service.Interface}, {service.Implementation}>();");
    }
});
```

### Keep builder logic focused

Don't mix business logic with building logic:

```csharp
// Good - separate concerns
var properties = CalculateRequiredProperties(Model);
.AddClass(Model.Name, @class =>
{
    foreach (var prop in properties)
    {
        @class.AddProperty(prop.Type, prop.Name);
    }
});

// Avoid - mixed concerns
.AddClass(Model.Name, @class =>
{
    // Complex business logic mixed with building
    if (Model.HasComplexBusinessRule() && SomeOtherCondition())
    {
        // ... complex logic
        MethodThatObscuresTheCreationOfProperties();
    }
});
```

## Integration with Factory Extensions

Factory Extensions can manipulate File Builder templates using the same `OnBuild` and `AfterBuild` callbacks, making them incredibly powerful for cross-cutting concerns:

```csharp
protected override void OnAfterTemplateRegistrations(IApplication application)
{
    var templates = application.FindTemplateInstances<ICSharpFileBuilderTemplate>("MyModule.Entity");

    foreach (var template in templates)
    {
        // Use OnBuild to add cross-cutting concerns
        template.CSharpFile.OnBuild(file =>
        {
            var @class = file.Classes.FirstOrDefault();
            if (@class != null)
            {
                // Add auditing properties to all entities
                @class.AddProperty("DateTime", "CreatedAt");
                @class.AddProperty("string", "CreatedBy");
                
                // Add interface implementation
                @class.ImplementsInterface("IAuditable");
            }
        });
        
        // Use AfterBuild for final validation or cleanup
        template.CSharpFile.AfterBuild(file =>
        {
            var @class = file.Classes.FirstOrDefault();
            
            // Ensure all entities have required using statements
            if (@class?.Interfaces.Any(i => i.Contains("IAuditable")) == true)
            {
                file.AddUsing("MyApp.Core.Interfaces");
            }
        });
    }
}
```

> [!NOTE]
> Factory Extensions have access to the same builder APIs as templates, allowing them to perform sophisticated code modifications across multiple modules.

### Working with Statement Spacing and Organization

You can control the visual organization of your generated code using spacing methods:

```csharp
.AddMethod("void", "ProcessOrder", method =>
{
    // Group related statements
    method.AddStatement("// Validation phase");
    method.AddStatement("ValidateOrder(order);");
    method.AddStatement("CheckInventory(order);");
    
    // Add visual separation before processing
    method
        .SeparatedFromPrevious()
        .AddStatement("// Processing phase")
        .AddStatement("var result = ProcessPayment(order);")
        .AddIfStatement("result.IsSuccess", ifStmt =>
        {
            ifStmt.AddStatement("CompleteOrder(order);");
            ifStmt.AddStatement("SendConfirmation(order.CustomerEmail);");
        });
        
    // Final cleanup section
    method
        .SeparatedFromPrevious()
        .AddStatement("// Cleanup")
        .AddStatement("LogOrderProcessing(order.Id, result);");
})
```

## Common Patterns

### Repository Pattern Generation

```csharp
.AddClass($"{Model.Name}Repository", @class =>
{
    @class
        .ImplementsInterface($"I{Model.Name}Repository")
        .AddConstructor(ctor =>
        {
            ctor.AddParameter("DbContext", "context", param => param.IntroduceReadonlyField());
        })
        .AddMethod($"{Model.Name}", "GetById", method =>
        {
            method
                .AddParameter("int", "id")
                .AddReturn($"_context.{Model.Name.Pluralize()}.FirstOrDefault(x => x.Id == id)");
        })
        .AddMethod("void", "Add", method =>
        {
            method
                .AddParameter($"{Model.Name}", "entity")
                .AddStatement("_context.Add(entity);");
        });
})
```

### DTO Generation

```csharp
.AddClass($"{Model.Name}Dto", @class =>
{
    foreach (var attribute in Model.Attributes.Where(a => a.IsPublic))
    {
        @class.AddProperty(GetTypeName(attribute), attribute.Name.ToPascalCase());
    }
    
    // Add conversion methods
    @class.AddMethod($"{Model.Name}Dto", "FromDomain", method =>
    {
        method
            .Static()
            .AddParameter(GetTypeName(Model), "entity")
            .AddStatement("return new()")
            .AddObjectInitializerBlock(block =>
            {
                foreach (var attr in Model.Attributes.Where(a => a.IsPublic))
                {
                    block.AddInitStatement(attr.Name.ToPascalCase(), $"entity.{attr.Name.ToPascalCase()}");
                }
            });
    });
})
```

## Error Handling and Debugging

### Common issues

- **Missing using directives**: If your generated code has compilation errors due to missing using statements, ensure you're using `GetTypeName()` methods or explicitly adding using directives with `AddUsing()`.
- **Incorrect type resolution**: Always use the template's type resolution methods rather than hardcoded type names.
- **Builder method order**: Some builder methods must be called in a specific order. Consult the IntelliSense documentation for guidance.

### Debugging tips

- **Review generated output**: Always check the actual generated C# code to understand what the builder is producing.
- **Use the debugger**: You can debug your templates and inspect the real-time state of C# File Builder objects using the [.NET Debugger](xref:module-building.debugging-modules).

## Migration from T4 Templates

If you're migrating from T4 templates to the File Builder System:

### Before (T4)

```csharp
namespace <#= Namespace #>
{
    public class <#= ClassName #>
    {
<# foreach(var prop in Model.Properties) { #>
        public <#= GetTypeName(prop) #> <#= prop.Name #> { get; set; }
<# } #>
    }
}
```

### After (File Builder)

```csharp
CSharpFile = new CSharpFile(this.GetNamespace(), this.GetFolderPath())
    .AddClass(ClassName, @class =>
    {
        foreach (var prop in Model.Properties)
        {
            @class.AddProperty(GetTypeName(prop), prop.Name);
        }
    });
```

The File Builder approach provides better maintainability, type safety, and integration capabilities.

## Next Steps

- [Factory Extensions Integration](xref:module-building.additional-tools.software-factory-extensions)
