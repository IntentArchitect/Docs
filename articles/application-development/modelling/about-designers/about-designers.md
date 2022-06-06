---
uid: application-development.modelling.about-designers
---
# About Designers

Designers in Intent Architect allow you describe your [application's](xref:application-development.applications-and-solutions.about-applications) design as visual models and hierarchical concepts. For example, Designers could be used to describe: the entities in a domain, the services that make up the applications API, events that are published and subscribed, etc.

Designers are added to the [Application](xref:application-development.applications-and-solutions.about-applications) when a [Module](xref:application-development.applications-and-solutions.about-modules) that has designer configuration is installed. You can therefore choose which Designers you would like to use in your Application.

![Domain Designer](images/designers-domain.png)
_An example from our from a sample application showing a Domain model inside of the Domain Designer._

![Workflow Designer](images/designers-workflow.png)
_An example of a sample application showing a custom made Workflow designer modelling a bespoke workflow._

Designers serve as a **blueprint** of your system. They can be used to describe any aspect of your Application. Typically, they are used to capture the following:

- **Codebase Structure** - Visual Studio Projects in .NET, Folder Structures in other languages, etc.
- **Entities** - Entities and their relationships to one another, Domain Driven Design (DDD) concepts (Aggregate Roots, Entities and Value Objects), etc.
- **Database Schemas** - Tables, Documents, Foreign keys, Indices, etc.
- **Services** - RESTful web services, SOAP services, security settings, transactional settings, etc.
- **Client Proxies** - Web client proxies, Synchronous Query Proxies, etc.
- **Eventing** - Messages, Topics, Queues, Subscriptions, etc. Often used to support a Microservices architectures.
- **Workflows** - Workflow Diagrams, Process Diagrams, etc.
- **Front-End Structure** - Components, Routing, Modules, View Models, Views, etc.
