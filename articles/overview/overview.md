---
uid: overview
---
# Overview

## The Two Development Roles

In the same way that traditional software development teams have members who fulfil different roles (such as developing infrastructure, architecture, backends, front-end applications, API integration and consumer services, etc.) Intent Architect is no different in that developers who design and implement Applications may be different to the developers who supply the [Modules](xref:modules.about-modules) that support the ability for the Application developers to function (more efficiently) and deliver value.

![Overview](images/overview-two-development-roles.png)

> [!NOTE]
> Not all software development teams may have the need to develop and maintain their own Modules, since Intent Architect offers a suite of Modules out of the box to development teams. However, Intent Architect offers power and flexibility for those who do.

### Module Building

This can be likened in general to developers who create their own library packages for Nuget, NPM, Yarn, PIP, etc. It allows for an installable package to supply code that can plug in to the existing code-base to provide additional functionality to help achieve the goal of delivering business value.

Developers who build Modules in Intent Architect are providing different value in that their focus is on finding ways to automate architecture, patterns and any other predictable aspects of software development and provide installable Module packages to the development teams who need them.

This can form part of the same software development development-cycle of the team who is developing applications using Intent Architect, or it can even be an entirely different team operating on a separate development-cycle.

### Application Development

These are the consumers of the said Module packages who install and benefit from the automation features that it provides. This can include new forms of code being generated which saves a lot of time and effort for development teams or it can be that new and/or enhanced designers are provided which offer richer designing experiences and can potentially offer opportunities for other parts of the code-base to be automated that previously had to be maintained by hand.

## Module Building Ecosystem

### Ecosystem

![Module Building Ecosystem](images/overview-module-builder-ecosystem.png)

Here is the overview of what you can expect to find inside a Module in Intent Architect. Components inside Modules can be categorized as follows:

### Metadata

Metadata is the information that is captured by the Designers and are feed to the components that are responsible for generating code.

#### Designer

[Designers](xref:designers.about-designers) provide the interface that allow users to model what an Application should look and behave like while the designer itself also provides the structure for the model. The model can resemble a Tree-view or a Diagram of sorts. Each Designer exists to address a distinct aspect of the Application being developed. Examples are: modelling API services or what the underlying Database structure should look like, yet these Designers can also borrow information from one another so as to enrich the picture of what the Application looks like overall. Designers are themselves composed of Elements which are the building blocks for capturing user metadata.

#### Designer Extension

Existing Designers are be open for [extension](xref:designers.about-designer-extensions) which allows Module developers to add new Elements to a Designer from a different Module. This retains the idea of reuse and can provide users of Designers with a richer experience and with more ways to model what an Application. This should not be confused with Stereotypes.

#### Stereotypes

[Stereotypes](xref:stereotypes.about-stereotypes) offer additional ways to capture metadata from a user but not in the same way as Elements from Designers. They can only be applied on top of Elements (and/or their fields and associations) and offer a way to capture extra information about a given Designer Element.

#### Designer API

Not only do users of Intent Architect have an interface with which to model what the metadata should look like, Module developers will also get an easy to use generated API to query the modelled metadata for Template development. Example: [](xref:stereotypes.how-to-use-stereotypes#query-stereotypes-from-templates).

### Code Generation

Components associated with Code Generation will rely on the Designer API to supply it with metadata. This will then through some process transform the metadata into content that will be written to output files.

#### Template

Using a [Text Template](xref:templates.about-templates-csharp) containing control logic, metadata can be consistently transformed based on the format of the Text Template and the output will become the content of a text file. These file types can range from XML to programming languages source code as long as the output type is text based.

#### Decorator

Some Text Templates can be open for extension by exposing hook-in points for [Decorators](xref:templates.about-decorators) to supply additional content. Decorators offer a way to decouple certain logic from Text Templates. Decorators can also be installed through Modules that are separate from the Modules containing the Text Templates.

### Advanced

Components and infrastructural concerns additional to Metadata and Code Generation.

#### Eventing Message

Components can achieve a level of decoupling using the Publish / Subscriber pattern with Eventing Messages.

#### Factory Extension

One can introduce [Extensions](xref:software-factory.how-to-create-a-factory-extension) which will execute tasks at certain phases of the Software Factory Execution process. This can include:

- Loading Metadata from outside Intent Architect.
- Alter the output produced from Text Templates.
- Execute external processes which developers might have needed to execute manually after a Software Factory Execution.
