---
uid: references.stereotypes
---
# Stereotypes

Intent Architect's Designers enables modelling of a sub-set of [UML](https://en.wikipedia.org/wiki/Unified_Modeling_Language), in particular [Stereotypes](https://en.wikipedia.org/wiki/Stereotype_(UML)). They can be used to extend the vocabulary of elements on the diagram.

It can be likened to an [`Attribute`](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/attributes/) found in C# or an [`Annotation`](https://en.wikipedia.org/wiki/Java_annotation) found in Java. It offers a richer way of modelling in a domain that would make the developer's experience more suited to the problem at hand.

## How it works

To illustrate, the standard Services Designer would only allow the user to capture the Service name and its Operations and nothing more.

![How the standard Services Designer would look like](images/services-designer-vanilla.png)

As soon as the `Intent.Metadata.WebApi` [module](xref:references.modules) is installed, it would offer the `Http Settings` Stereotype (that is automatically applied on all Operations) that would allow the user to specify how a client can access this API using a specific HTTP Verb.

The Stereotype can be located on the Properties panel located on the right of the Designer.

![How the Services Designer would look like with API Metadata](images/services-designer-api-metadata.png)

![How the Http Settings Stereotype looks like](images/http-settings-stereotype.png)

Stereotypes not only offers a form of "tagging" on Elements found in Intent Architect Designers, but it allows one to capture additional information using properties. These properties can hold different data types, allowing for a richer way of specifying more information on the Element at hand.

## What it consists of

Stereotypes can be defined by the use of Stereotype Definitions. This [article](xref:references.stereotypes.stereotype-definitions) will provide more detail on the matter.

## See also

* [](xref:how-to-guides.use-stereotypes)