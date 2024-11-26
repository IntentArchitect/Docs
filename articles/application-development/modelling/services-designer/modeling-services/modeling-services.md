---
uid: application-development.modelling.services-designer.modeling-services
---
# Modeling Services

The Services Designer in Intent Architect is a powerful tool that allows developers to model "Application Services" for their applications. This module's primary focus is to define how your application can be interacted with at the service level, effectively allowing for the creation of internal services and publicly exposed endpoints.

## Purpose of Application Services

Application Services act as the contract for how client applications interact with the business logic encapsulated in your application. They manage communication between the client and the internal system, ensuring that the appropriate commands are executed and queries are returned.

## Creating a Service with Operations

![Service with operations](images/service-with-operations.png)

To create a service with operations:

1. Right-click on the diagram and select `New Service` then provide it a unique Name.
2. Right click on the Service and select `Add Operation` and then provide it a with a Name.
3. Right click on the Operation and select `Add Parameter`. Provide it with a Name and a Type. If the type is meant to represent an inbound payload, select the corresponding DTO.
4. If the Operation is not meant to return anything, leave the Type as `void`. Alternatively, select the appropriate Type from the Type dropdown to represent the return type.

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
