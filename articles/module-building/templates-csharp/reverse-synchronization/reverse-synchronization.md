---
uid: module-building.templates-csharp.reverse-synchronization
---
# C# reverse synchronization

This article explains how to add support for [reverse (or code-to-model) synchronization](xref:application-development.software-factory.reverse-synchronization) to C# templates.

Reverse synchronization allows templates in Intent Architect to detect user edits in C# files and translate those edits back into *model changes* in Intent Architect Designers.

Minimum required NuGet packages:

- Intent.SoftwareFactory.SDK 3.13.0
- Intent.Modules.Common.CSharp 3.10.0

Additionally, for applications using your module, they must also use at least version `4.10.0` of the `Intent.OutputManager.RoslynWeaver` module for the template's `ISynchronizeCSharpCodeToModel.Accept(...)` method to be called.

## Overview of required implementation

1. Add the `ISynchronizeCSharpCodeToModel` interface to your template's class.
2. Implement the `void Accept(ICSharpSemanticComparisonNode rootComparisonNode)` method to store the provided `ICSharpSemanticComparisonNode` for later. This method is called by the `Intent.OutputManager.RoslynWeaver` module if it finds semantic differences in the file it generated compared to the existing file on the file system.
3. Implement the `IReadOnlyCollection<ICodeToModelOperation> GetCodeToOperationModels()` method. This is called by the Software Factory and returns any "code to model operations" (or "instructions") to be run in Intent Architect Designers to apply changes.

## The `void Accept(ICSharpSemanticComparisonNode rootComparisonNode)` method

This method simply needs to store the provided `ICSharpSemanticComparisonNode` for use later, for example you could add the following to your template:

```csharp
private ICSharpSemanticComparisonNode _rootComparisonNode;

public void Accept(ICSharpSemanticComparisonNode rootComparisonNode)
{
    _rootComparisonNode = rootComparisonNode;
}
```

This method is called by the `Intent.OutputManager.RoslynWeaver` module if it finds any semantic differences between the generated and existing file.

> [!NOTE]
>
> Only versions `4.10.0` and greater of the `Intent.OutputManager.RoslynWeaver` module have the logic present which calls this method.

## The `IReadOnlyCollection<ICodeToModelOperation> GetCodeToOperationModels()` method

This method needs to return a list of "code of model operations" for the designers to apply when the user presses the [synchronize changes](xref:application-development.software-factory.reverse-synchronization#using-the-feature) button on the Software Factory.

The operations to return varies by each template as it depends on how a template's generated content relates to metadata in Intent Architect Designers, but in essence you will need to inspect the `ICSharpSemanticComparisonNode` and its `ChildNodes` (which are also `ICSharpSemanticComparisonNode`s), check if each node is an Addition, Removal or Update, possibly correlate with existing members of your class and then return operations as appropriate.

### Creating code to model operations

To create operations, use the `CodeToModelOperationFactory` static class from the `Intent.CodeToModelOperations` namespace, this class has an `Instance` property with various factory methods available on it for various operation types, there are also extension methods available for this factory class from the `Intent.Modules.Common` namespace providing higher level convenient overloads for most operations.

#### Resolving type references from type names

For model operations to create or update elements with type references in Intent Architect Designers they require an `ITypeReference`.

`ICSharpSemanticComparisonNode` has `Current` and `Generated` properties each with `string TypeName { get; }` members. To convert from these strings to required `ITypeReference`s for operations, the `TryGetTypeReference` on `IntentTemplateBase` (which `CSharpTemplateBase` derives from) can be used. This method was created for this purpose and (amongst other logic) uses the type resolution infrastructure already available in templates to resolve actual types, be they built in type definitions (`string`, `int`, etc) or types from other template instances which have been referred to using the `AddTypeSource` method on the current template.

### Example: DTO

Here is the (probably) simplest possible example of reverse synchronizing properties from an existing `.cs` file to `Field` elements in the `Services` designer in Intent Architect.

The code below was taken from [`DtoModelTemplatePartial.cs`](https://github.com/IntentArchitect/Intent.Modules.NET/blob/master/Modules/Intent.Modules.Application.Dtos/Templates/DtoModel/DtoModelTemplatePartial.cs) ([permalink](https://github.com/IntentArchitect/Intent.Modules.NET/blob/400733db176e7b0ab5a5763a9f98753e8cb989c0/Modules/Intent.Modules.Application.Dtos/Templates/DtoModel/DtoModelTemplatePartial.cs#L447)) available as open source.

```csharp
public IReadOnlyCollection<ICodeToModelOperation> GetCodeToOperationModels()
{
    var properties = _rootComparisonNode?
        .ChildNodes.FirstOrDefault(x => x.SyntaxKind == CSharpSyntaxKind.NamespaceDeclaration)?
        .ChildNodes.FirstOrDefault(x => x.SyntaxKind == CSharpSyntaxKind.ClassDeclaration)?
        .ChildNodes.Where(x => x.SyntaxKind == CSharpSyntaxKind.PropertyDeclaration)
        .ToArray();

    if (properties == null || properties.Length == 0)
    {
        return [];
    }

    var changes = new List<ICodeToModelOperation>();

    foreach (var property in properties)
    {
        var typeReference = TryGetTypeReference((property.Current ?? property.Generated)!.TypeName!, Model.InternalElement.Package, out var reference)
            ? CodeToModelOperationFactory.Instance.TypeReference(reference)
            : null;

        switch (property.DifferenceType)
        {
            case CSharpDifferenceType.Added:
                changes.Add(CodeToModelOperationFactory.Instance.CreateChildElement(
                    parent: Model.InternalElement,
                    newElementId: Guid.NewGuid().ToString(),
                    name: property.Current!.Identifier!,
                    specialization: DTOFieldModel.SpecializationType,
                    specializationId: DTOFieldModel.SpecializationTypeId,
                    typeReference: typeReference));
                break;
            case CSharpDifferenceType.Changed:
                var fieldToUpdate = Model.Fields.FirstOrDefault(x => string.Equals(x.Name, property.Generated!.Identifier, StringComparison.OrdinalIgnoreCase));
                if (fieldToUpdate != null)
                {
                    changes.Add(CodeToModelOperationFactory.Instance.UpdateElement(
                        element: fieldToUpdate.InternalElement,
                        name: property.Current!.Identifier.ToPascalCase(),
                        typeReference: typeReference));
                }

                break;
            case CSharpDifferenceType.Removed:
                var fieldToRemove = Model.Fields.FirstOrDefault(x => string.Equals(x.Name, property.Generated!.Identifier, StringComparison.OrdinalIgnoreCase));
                if (fieldToRemove != null)
                {
                    changes.Add(CodeToModelOperationFactory.Instance.DeleteElement(fieldToRemove.InternalElement));
                }

                break;
        }
    }

    return changes;
}
```

### Example: Domain Entity

As a more complex example, below shows synchronizing a domain entity back to a `Class` in the `Domain` Designer in Intent Architect and covering synchronization of associations, attributes, methods and parameters.

The code below was taken from [`DomainEntityTemplatePartial.cs`](https://github.com/IntentArchitect/Intent.Modules.NET/blob/master/Modules/Intent.Modules.Entities/Templates/DomainEntity/DomainEntityTemplatePartial.cs) ([permalink](https://github.com/IntentArchitect/Intent.Modules.NET/blob/400733db176e7b0ab5a5763a9f98753e8cb989c0/Modules/Intent.Modules.Entities/Templates/DomainEntity/DomainEntityTemplatePartial.cs#L533)) available as open source.

```csharp
public IReadOnlyCollection<ICodeToModelOperation> GetCodeToOperationModels()
{
    var @class = _rootComparisonNode?
        .ChildNodes.FirstOrDefault(x => x.SyntaxKind == CSharpSyntaxKind.NamespaceDeclaration)?
        .ChildNodes.FirstOrDefault(x => x.SyntaxKind == CSharpSyntaxKind.ClassDeclaration);

    if (@class == null)
    {
        return [];
    }

    var changes = new List<ICodeToModelOperation>();

    foreach (var member in @class.ChildNodes)
    {
        var typeReference = TryGetTypeReference((member.Current ?? member.Generated).TypeName, Model.InternalElement.Package, out var typeNameReference)
            ? CodeToModelOperationFactory.Instance.TypeReference(typeNameReference)
            : null;

        switch (member.SyntaxKind)
        {
            case CSharpSyntaxKind.MethodDeclaration:
                switch (member.DifferenceType)
                {
                    case CSharpDifferenceType.Added:
                        {
                            var method = CodeToModelOperationFactory.Instance.CreateChildElement(
                                parent: Model.InternalElement,
                                newElementId: Guid.NewGuid().ToString(),
                                name: member.Current.Identifier!,
                                specialization: OperationModel.SpecializationType,
                                specializationId: OperationModel.SpecializationTypeId,
                                typeReference: typeReference);

                            changes.Add(method);

                            foreach (var parameter in member.ChildNodes.Where(x => x.SyntaxKind == CSharpSyntaxKind.Parameter))
                            {
                                changes.Add(CodeToModelOperationFactory.Instance.CreateChildElement(
                                    parent: method,
                                    newElementId: Guid.NewGuid().ToString(),
                                    name: parameter.Current.Identifier!,
                                    specialization: ParameterModel.SpecializationType,
                                    specializationId: ParameterModel.SpecializationTypeId,
                                    typeReference: TryGetTypeReference((parameter.Current ?? parameter.Generated).TypeName!, Model.InternalElement.Package, out var parameterReference)
                                        ? CodeToModelOperationFactory.Instance.TypeReference(parameterReference)
                                        : null));
                            }

                            break;
                        }
                    case CSharpDifferenceType.Removed:
                        {
                            var operation = Model.Operations.SingleOrDefault(x => string.Equals(x.Name, member.Generated!.Identifier, StringComparison.OrdinalIgnoreCase));
                            if (operation != null)
                            {
                                changes.Add(CodeToModelOperationFactory.Instance.DeleteElement(operation.InternalElement));
                            }

                            break;
                        }
                    case CSharpDifferenceType.Changed:
                        {
                            var operation = Model.Operations.SingleOrDefault(x => string.Equals(x.Name, member.Generated!.Identifier, StringComparison.OrdinalIgnoreCase));
                            if (operation != null)
                            {
                                changes.Add(CodeToModelOperationFactory.Instance.UpdateElement(
                                    element: operation.InternalElement,
                                    name: member.Current.Identifier.ToPascalCase(),
                                    typeReference: typeReference));

                                // TODO Sync parameters
                            }

                            break;
                        }
                }

                break;
            case CSharpSyntaxKind.PropertyDeclaration:
                // Attributes
                if (typeNameReference == null ||
                    typeNameReference.Element.SpecializationTypeId is TypeDefinitionModel.SpecializationTypeId or EnumModel.SpecializationTypeId)
                {
                    switch (member.DifferenceType)
                    {
                        case CSharpDifferenceType.Added:
                            changes.Add(CodeToModelOperationFactory.Instance.CreateChildElement(
                                parent: Model.InternalElement,
                                name: member.Current.Identifier!,
                                specialization: AttributeModel.SpecializationType,
                                specializationId: AttributeModel.SpecializationTypeId,
                                typeReference: typeReference));
                            break;
                        case CSharpDifferenceType.Removed:
                            {
                                var existing = Model.Attributes.FirstOrDefault(x => string.Equals(x.Name, member.Generated!.Identifier, StringComparison.OrdinalIgnoreCase));
                                if (existing == null)
                                {
                                    break;
                                }

                                changes.Add(CodeToModelOperationFactory.Instance.DeleteElement(existing.InternalElement));
                                break;
                            }
                        case CSharpDifferenceType.Changed:
                            {
                                var existing = Model.Attributes.FirstOrDefault(x => string.Equals(x.Name, member.Generated!.Identifier, StringComparison.OrdinalIgnoreCase));
                                if (existing == null)
                                {
                                    break;
                                }

                                changes.Add(CodeToModelOperationFactory.Instance.UpdateElement(
                                    element: existing.InternalElement,
                                    name: member.Current.Identifier.ToPascalCase(),
                                    typeReference: typeReference));

                                break;
                            }
                    }

                    break;
                }

                // Associations
                switch (member.DifferenceType)
                {
                    case CSharpDifferenceType.Added:
                        changes.Add(CodeToModelOperationFactory.Instance.CreateAssociation(
                            specialization: AssociationModel.SpecializationType,
                            specializationId: AssociationModel.SpecializationTypeId,
                            targetEndElement: (IElement)typeNameReference.Element,
                            targetEndName: member.Current.Identifier,
                            targetEndIsNullable: typeNameReference.IsNullable,
                            targetEndIsCollection: typeNameReference.IsCollection,
                            ownerEndElement: Model.InternalElement));
                        break;
                    case CSharpDifferenceType.Changed:
                        changes.Add(CodeToModelOperationFactory.Instance.CreateAssociation(
                            specialization: AssociationModel.SpecializationType,
                            specializationId: AssociationModel.SpecializationTypeId,
                            targetEndElement: (IElement)typeNameReference.Element,
                            targetEndName: member.Current.Identifier,
                            targetEndIsNullable: typeNameReference.IsNullable,
                            targetEndIsCollection: typeNameReference.IsCollection,
                            ownerEndElement: Model.InternalElement));
                        break;
                }

                break;
        }
    }

    return changes;
}
```

## Summary

This article explains how to implement reverse code synchronization for templates with working real world examples.
