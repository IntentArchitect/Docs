---
uid: application-development.modelling.services-designer.modeling-services
---
# Modeling Services

The Services Designer in Intent Architect is a powerful tool that allows developers to model "Application Services" for their applications. This module's primary focus is to define how your application can be interacted with at the service level, effectively allowing for the creation of internal services and publicly exposed endpoints.

## What is an Application Services

An application service is a layer in the architecture of an application that serves as the intermediary between the domain layer (or business logic) and the presentation layer (such as a user interface or API). It typically contains high-level orchestration logic for use cases or business processes, delegating detailed domain logic to the domain layer.

### Key Characteristics of an Application Service

- **Coordinates Use Cases**, it encapsulates a specific use case or application workflow, such as "Register a user" or "Place an order."
- **Delegates Domain Logic**, it delegates core business logic to domain entities or domain services rather than implementing it directly.
- **Handles Input/Output**, It processes input from the presentation layer (e.g., HTTP requests) and returns output to it (e.g., HTTP responses or data transfer objects).
- **Transaction Management**, It often controls transaction boundaries (e.g., starting, committing, or rolling back database transactions).
- **Keeps Layers Separate**, It ensures that the presentation layer doesn't interact directly with the domain layer, maintaining separation of concerns.
- **Interaction with Infrastructure**,  It can use repositories, mappers, or other infrastructure components to fetch or persist data.

## Different Service Modeling Paradigms

Intent Architect empowers you to model your application services using two distinct paradigms: CQRS (Command Query Responsibility Segregation) and Traditional Services. This flexibility allows you to tailor your service design to match your system's architectural requirements. Whether you need the separation of read and write logic for scalability and clarity, or prefer a unified traditional approach, Intent Architect helps you efficiently structure your services, ensuring maintainable and scalable solutions.

High-Level Overview of the Two Paradigms:

### CQRS Paradigm

- Separates read and write responsibilities into distinct models, each optimized for its purpose.
- Commands handle state-changing operations, focusing on business logic and domain consistency.
- Queries handle data retrieval, often accessing read-optimized data stores or projections.
- Ideal for systems with complex requirements or high scalability demands.
- Use case centric

![CQRS Paradigm](./images/cqrs-paradigm.png)

### Traditional Service Paradigm

- Combines read and write logic into a single service.
- Simplifies development by using a unified data model and service structure.
- Common in systems with straightforward requirements or minimal scalability concerns.

![Traditional Service Paradigm](./images/traditional-service-paradigm.png)

Both paradigms have their strengths, and Intent Architect provides the tools to model your services effectively within either approach.

## Creating a CQRS Command

1. Add a `Command` to any diagram in the `Services Designer`.
2. Capture the name of your `Command`, typically suffixed with `Command`, e.g. `CreateCustomerCommand`.
3. Right-click the `Command` and select **Add Property** to define its data.
4. Add complex data types as needed:
   - *DTO* for modeling nested structures.
   - *Enum* for modeling enumerations.
5. *Optional* - Capture the return type of your `Command`, in the property pane or by pressing F2 on the `Command`.

![Modeled CQRS Command](./images/create-cqrs-command.png)

Here we have modeled a service contract, i.e. what data flows into and out of the service end point. Once you applied this design to your code-base, you can implement your business logic as follows.

1. Right-click on the `Command` and select **Open in IDE -> ...CommandHandler.cs**
2. Implement your business logic in the `Handle` method.

> [!NOTE]
> There are many service implementations which are predictable and repetitive, Intent Architect can generate these implementation for you, [domain interactions](#domain-interactions--processing-actions-actions--implmentations).
> [!TIP]
> You can quickly model or bootstrap your services using the [CQRS CRUD Accelerator](#create-crud-cqrs-operations-accelerator).

## Creating a CQRS Query

1. Add a `Query` to any diagram in the `Services Designer`.
2. Capture the name of your `Query`, typically suffixed with `Query`, e.g. `GetCustomerByIdQuery`.
3. Right-click the `Query` and select **Add Property** to define its data.
4. Add complex data types as needed:
   - *DTO* for modeling nested structures.
   - *Enum* for modeling enumerations.
5. Capture the return type of your `Query`, in the property pane or by pressing F2 on the `Query`.

![Modeled CQRS Query](./images/create-cqrs-query.png)

Here we have modeled a service contract, i.e. what data flows into and out of the service end point. Once you applied this design to your code-base, you can implement your business logic as follows.

1. Right-click on the `Query` and select **Open in IDE -> ...CommandHandler.cs**
2. Implement your business logic in the `Handle` method.

> [!NOTE]
> There are many service implementations which are predictable and repetitive, Intent Architect can generate these implementation for you, [domain interactions](#domain-interactions--processing-actions-actions--implmentations).
> [!TIP]
> You can quickly model or bootstrap your services using the [Traditional Service CRUD Accelerator](#create-crud-traditional-service-accelerator).

## Creating a Traditional Service

To create a service with operations:

1. Right-click on the diagram and select `New Service` then provide it a unique Name.
2. Right click on the Service and select `Add Operation` and then provide it a with a Name.
3. Right click on the Operation and select `Add Parameter`. Provide it with a Name and a Type. If the type is meant to represent an inbound payload, select the corresponding DTO.
4. If the Operation is not meant to return anything, leave the Type as `void`. Alternatively, select the appropriate Type from the Type dropdown to represent the return type.

Here we have modeled a service contract, i.e. what data flows into and out of the service end point. Once you applied this design to your code-base, you can implement your business logic as follows.

![Modeled Traditional Service](images/service-with-operations.png)

1. Right-click on the `Service` and select **Open in IDE -> {OrganizationsService}.cs**
2. Implement your business logic in the method which is for your modeled `Operation` e.g. `CreateOrganization`.

> [!NOTE]
> There are many service implementations which are predictable and repetitive, Intent Architect can generate these implementation for you, [domain interactions](#domain-interactions--processing-actions-actions--implmentations).
> [!TIP]
> You can quickly model or bootstrap your services using the [Traditional Service CRUD Accelerator](#create-crud-traditional-service-accelerator).

## Creating a DTO

![Normal DTOs](images/normal-dtos.png)

To create a DTO:

1. Right click on the Service Package or a containing Folder within and select `New DTO` then provide it a unique Name.
2. Right click on the DTO and select `Add Field`. Provide it with a Name and Type.

## Inheriting from a DTO for a DTO

![Inheritance DTO](images/inheritance-dto.png)

Given that you have a DTO and a specific DTO you want to inherit from:

1. Right click on the DTO that will inherit from another DTO and select `New Inheritance`.
2. Select the DTO from which you would like to inherit from.

## Mapping an Outbound DTO

![Outbound mapping DTO](images/outbound-mapping-dto.png)

Mapping outbound DTOs allows you to transform data from Domain entities to Data Transfer Objects.

1. Right click on the DTO that will receive mapped information from a Domain Entity and select `Map From Domain`.
2. A dialog will open allowing you to specify the Domain entity and select the attributes you wish to include in the outbound DTO.
3. Check the boxes next to the attributes you would like to map and click `Done`. This establishes a clear link between your Domain data and the external interface represented by the DTO.

## Adding a Diagram to a Services Designer

![Diagram view](images/diagram-view.png)

Enhance the visual organization of your Services by incorporating diagrams. Follow these steps to add a diagram:

1. Right-click on the Services package and select `New Diagram`.
2. If your Services designer initially displayed a Tree-view, it will now switch to a diagram view based on the newly added diagram.
3. Rename the diagram by right clicking on it in the Tree-view and selecting `Rename` and specifying a more appropriate name.
4. Drag and drop Services from the Tree-view onto the diagram to create tailored visual representations. While other elements can also be dragged onto the diagram, not all elements will support visual rendering.
5. Optionally, you can create multiple diagrams to depict different perspectives of your application. However, remember that the Tree-view will always serve as the accurate source of truth.

> [!TIP]
> Hold down CTRL while dragging an element from the Tree-view onto the designer to include any directly associated elements with it.

## Using Accelerators to Rapidly Model Services

Accelerators are marcos or scripts which can automate modeling tasks. The Services Designer has several such macros.

### Create CRUD CQRS Operations Accelerator

### Create CRUD Traditional Service Accelerator

### Paginate Accelerator

## Modeling Service Implementations *New*

CRUD implementations
Processing Actions
Call Service Operation

TODO

> [!NOTE]
> Modeling Service implementations is optional, many service implementations would be bespoke.

## Domain Interactions  (Processing Actions, Actions , Implmentations)

### Create Entity
...

## Domain Event Handler Implementations


## Advanced Mapping Screen *New*
