---
uid: application-development.modelling.services-designer.modeling-services
---
# Modeling Services

The Services Designer in Intent Architect is a powerful tool that allows developers to model "Application Services" for their applications. This module's primary focus is to define how your application can be interacted with at the service level, effectively allowing for the creation of internal services and publicly exposed endpoints.

## What is an Application Service?

An application service is a layer in the architecture of an application that serves as the intermediary between the domain layer (or business logic) and the presentation layer (such as a user interface or API). It typically contains high-level orchestration logic for use cases or business processes, delegating detailed domain logic to the domain layer.

### Key Characteristics of an Application Service

- **Coordinates Use Cases**: Encapsulates a specific use case or application workflow, such as "Register a user" or "Place an order."
- **Delegates Domain Logic**: Delegates core business logic to domain entities or domain services rather than implementing it directly.
- **Handles Input/Output**: Processes input from the presentation layer (e.g. HTTP requests) and returns output to it (e.g. HTTP responses or data transfer objects).
- **Transaction Management**: Controls transaction boundaries (e.g. starting, committing, or rolling back database transactions).
- **Keeps Layers Separate**: Ensures that the presentation layer doesn't interact directly with the domain layer, maintaining separation of concerns.
- **Interacts with Infrastructure**: Uses repositories, mappers, or other infrastructure components to fetch or persist data.

## Different Service Modeling Paradigms

Intent Architect empowers you to model your application services using two distinct paradigms: CQRS (Command Query Responsibility Segregation) and Traditional Services. This flexibility allows you to tailor your service design to match your system's architectural requirements. Whether you need the separation of read and write logic for scalability and clarity or prefer a unified traditional approach, Intent Architect helps you efficiently structure your services, ensuring maintainable and scalable solutions.

Here you are modeling the flow of data in and out of your service and / or application, i.e. the data contracts of your service. You can also, optionally, model implementations for your service.

### CQRS Paradigm

- Separates read and write responsibilities into distinct models, each optimized for its purpose.
- Commands handle state-changing operations, focusing on business logic and domain consistency.
- Queries handle data retrieval, often accessing read-optimized data stores or projections.
- Ideal for systems with complex requirements or high scalability demands.
- Use case-centric.

![CQRS Paradigm](./images/cqrs-paradigm.png)

### Traditional Service Paradigm

- Combines read and write logic into a single service.
- Simplifies development by using a unified data model and service structure.
- Common in systems with straightforward requirements or minimal scalability concerns.

![Traditional Service Paradigm](./images/traditional-service-paradigm.png)

Both paradigms have their strengths, and Intent Architect provides the tools to model your services effectively within either approach.

## Exposing an Application Service

When modeling Application Services, by default, these application services are only available internally within the application.
It is very common to want to expose these so that external applications can consume them, this is an explicit action the modeler must take as there are several decisions which need to be made:

- Which Service end points are exposed ?
- What technology are they exposed over?
- Any technology specific configurations, for example security or addressing.

The various ways in which your Application Services can be exposed will depend on which modules you have installed, as an example if you have the `Intent.Metadata.WebApi` module installed you can `Expose as HTTP Endpoint` which will expose your service over HTTP using REST conventions.

## Creating a CQRS Command

1. Add a `Command` to any diagram in the `Services Designer`.
2. Name your `Command`, typically suffixed with `Command`, e.g. `CreateCustomerCommand`.
3. Right-click the `Command` and select **Add Property** to define its data.
4. Add complex data types as needed:
   - *DTO* for modeling nested structures.
   - *Enum* for modeling enumerations.
5. *Optional*: Define the return type of your `Command` in the property pane or by pressing F2 on the `Command`.

![Modeled CQRS Command](./images/create-cqrs-command.png)

Once applied to your codebase, implement your business logic as follows:

1. Right-click on the `Command` and select **Open in IDE -> ...{CreateCustomer}CommandHandler.cs**.
2. Implement your business logic in the `Handle` method.

> [!NOTE]
> Many service implementations are predictable and repetitive. Intent Architect can generate these implementations for you: [Modeled Service Implementations](#modeled-service-implementations).
> [!TIP]
> Quickly model or bootstrap your services using the [CQRS CRUD Accelerator](#create-crud-cqrs-operations-accelerator).

## Creating a CQRS Query

1. Add a `Query` to any diagram in the `Services Designer`.
2. Name your `Query`, typically suffixed with `Query`, e.g. `GetCustomerByIdQuery`.
3. Right-click the `Query` and select **Add Property** to define its data.
4. Add complex data types as needed:
   - *DTO* for modeling nested structures.
   - *Enum* for modeling enumerations.
5. Define the return type of your `Query` in the property pane or by pressing F2 on the `Query`.

![Modeled CQRS Query](./images/create-cqrs-query.png)

Once applied to your codebase, implement your business logic as follows:

1. Right-click on the `Query` and select **Open in IDE -> ...QueryHandler.cs**.
2. Implement your business logic in the `Handle` method.

> [!NOTE]
> Many service implementations are predictable and repetitive. Intent Architect can generate these implementations for you: [Modeled Service Implementations](#modeled-service-implementations).
> [!TIP]
> Quickly model or bootstrap your services using the [Traditional Service CRUD Accelerator](#create-crud-traditional-service-accelerator).

## Creating a Traditional Application Service

To create a service with operations:

1. Right-click on the diagram and select `New Service`, then provide it with a unique name.
2. Right-click on the Service and select `Add Operation`, then provide it with a name.
3. Right-click on the Operation and select `Add Parameter`. Provide it with a name and a type. If the type represents an inbound payload, select the corresponding DTO.
4. If the Operation does not return anything, leave the Type as `void`. Otherwise, select the appropriate return type.

![Modeled Traditional Service](./images/service-with-operations.png)

Once applied to your codebase, implement your business logic as follows:

1. Right-click on the `Service` and select **Open in IDE -> {OrganizationsService}.cs**.
2. Implement your business logic in the method corresponding to your modeled `Operation`, e.g. `CreateOrganization`.

> [!NOTE]
> Many service implementations are predictable and repetitive. Intent Architect can generate these implementations for you: [Modeled Service Implementations](#modeled-service-implementations).
> [!TIP]
> Quickly model or bootstrap your services using the [Traditional Service CRUD Accelerator](#create-crud-traditional-service-accelerator).

## Creating a DTO

![Normal DTOs](./images/normal-dtos.png)

To create a DTO:

1. Right-click on the Service Package or a containing Folder within and select `New DTO`, then provide it with a unique name.
2. Right-click on the DTO and select **Add Field**. Provide it with a name and type.

## Inheriting from a DTO

![Inheritance DTO](./images/inheritance-dto.png)

To inherit one DTO from another:

1. Right-click on the DTO that will inherit and select `New Inheritance`.
2. Select the DTO to inherit from.

## Mapping an Outbound DTO

![Outbound Mapping DTO](./images/outbound-mapping-dto.png)

To map outbound DTOs:

1. Right-click on the DTO that will receive mapped information and select `Map From Domain`.
2. In the dialog, specify the Domain entity and select the attributes to include in the outbound DTO.
3. Check the desired attributes and click `Done`. This links your Domain data to the DTO.

## Adding a Diagram to the Services Designer

![Diagram View](./images/diagram-view.png)

To enhance visual organization:

1. Right-click on the Services package and select `New Diagram`.
2. If the designer was in Tree-view, it switches to a diagram view.
3. Rename the diagram by right-clicking it in the Tree-view and selecting `Rename`.
4. Drag Services from the Tree-view onto the diagram to create visual representations.
5. Optionally, create multiple diagrams for different perspectives, though the Tree-view remains the source of truth.

> [!TIP]
> Hold down CTRL while dragging elements from the Tree-view to include directly associated elements.

## Using Accelerators to Rapidly Model Services

Accelerators are marcos or scripts which can automate modeling tasks.

### Create CRUD CQRS Operations Accelerator

This accelerator will model a CQRS paradigm service with a CRUD implementation, including the following:

- Create Entity Command
- Update Entity Command
- Delete Entity Command
- Get Entity by Id Query
- Get All Entities Query
- `Command`s based on the `Entity`'s operations.

1. Right-click on the `Services Package`, select the `Create CRUD CQRS Operations`.
2. Select the domain `Entity` to would like to model the service around.

![Generated CRUD CQRS Service Example](./images/accelerator-crud-cqrs.png)

> [!NOTE]
> You can also run this accelerator on a `Folder` in the `Services Designer`.

### Create CRUD Traditional Service Accelerator

This accelerator will model a Traditional Service with a CRUD implementations, including the following operations:

- Create Entity
- Update Entity
- Delete Entity
- Get Entity by Id
- Get All Entities
- `Operations`'s based on the `Entity`'s operations.

1. Right-click on the `Services Package`, select the `Create CRUD Traditional Service`.
2. Select the domain `Entity` to would like to model the service around.

![Generated CRUD CQRS Service Example](./images/accelerator-crud-traditional.png)

### Paginate Accelerator

`Pagination` on an operation allows large datasets to be returned in smaller, more manageable chunks. The `Paginate` accelerator is available for any `Operation` or `Query` that returns a **collection**.

1. Right-click on the qualifying `Operation` or `Query`.
2. Select the `Paginate` menu item.

This accelerator will automatically perform the following actions:

- The return type of the `Operation` or `Query` will be changed from the configured return type `TReturnType` to `PagedResult<TReturnType>`.
- Three `parameters`/`properties` will be added to the `Operation`/`Query` respectively:

  - **PageNo**: Specifies the page number of the data to retrieve, based on the *PageSize*.
  - **PageSize**: Specifies how many records should be included in a single page.
  - **OrderBy**: Specifies how data should be sorted before pagination is applied. This field is optional, and if no value is supplied, the default database ordering will be used.

> [!NOTE]  
> If using the default CRUD implementation, the `PageNo` parameter is *1-based*. That is, the first page of the dataset has a page number of 1. Changing the name of the `parameter`/`attribute` to `PageIndex` will change the pagination to be *0-based*, with the first page of the dataset having a page number of 0.

> [!TIP]  
> Our CRUD modules treats the `OrderBy` as a dynamic Linq statement. The `OrderBy` parameter can be supplied with a *single* entity property, or *multiple* entity properties. Additionally, sorting can be applied to each property. These are all valid `OrderBy` formats:
>
> - `name`
> - `name asc`
> - `name desc`
> - `created, name`
> - `created desc, name asc`

![Pagination](./images/paginate.png)

## Modeled Implementations

### Create Entity Action

This action allows you to model the creation of a domain `Entity`(`Class`), using either an `Object Initializer` or a `Constructor`.
This action can be modeled against a `Command`, a service `Operation` or a `Domain Event Handler Association`, referred to as the `Element` below.

#### Creating a Domain Entity using Object Initialization

1. On a diagram, select **Add to Diagram** and choose the domain `Entity` you want to create.
2. Right-click on the `Element` and select **Create Entity**.
3. Connect the `Element` to the `Entity` by left-clicking it.

This will open the `Create Entity Mapping` Dialog, this dialog helps you map data from the `Element` to the `Entity`.

1. Double-Click the `Entity` in right hand panel.
This will add purple line between the `Element` and the `Entity`, this represents how the `Entity` will be created i.e. `Object Initialization`.
2. Map how the data from the `Element` to the `Entity`,  this can be done in several ways:

    - **Double-click the `Entity` again**, this map all the `Entity` attributes to the corresponding `Element` properties, adding missing ones where required.
    - **Double-click individual `Entity` attributes**, this map the `Entity` attribute to the corresponding `Element` property, adding it if required.
    - **Double-click individual `Element` property**, this will map the `Element` property to the `Entity` property, if there is an attribute with the same name.
    - **Drag an individual `Element` property onto a `Entity` attribute**, this will map the two elements.
    - **Drag multiple mappable items from either side to the other side's background**, this will batch map the items, adding items if applicable.

![Create Entity Action Mapping](./images/create-entity-action-object-mapping.png)

> [!TIP]  
> If there is no mappable concept in the `Element` for the `Entity` attribute, you are able to capture an expression in the text box to the right of the attribute e.g. `true`, `0`, `""`, etc.

![Create Entity Action ](./images/create-entity-action-object-initializer.png)

> [!TIP]  
> To get back to the mapping screen right click on the `Create Entity Action`, under the `Entity`, or on the Association linking the `Element` and `Entity` and select **Map Entity Creation**.

#### Creating a Domain Entity using a Constructor

1. On a diagram, select **Add to Diagram** and choose the domain `Entity` you want to create.
2. Right-click on the `Element` and select **Create Entity**.
3. Connect `Element` to a `Constructor` on the `Entity` Left-click on the `Constructor`.

This will open the `Create Entity Mapping` Dialog, this dialog helps you map data from the `Element` to the `Entity`.

1. Double-Click the `Constructor` in right hand panel.
This will add purple line between the `Element` and the `Constructor`, this represents how the `Entity` will be created i.e. using this `Constructor`.
2. Map how the data from the `Element` to the `Constructor`,  this can be done in several ways:

    - **Double-click the `Constructor` again**, this map all the `Constructor` parameters to the corresponding `Element` properties, adding missing ones where required.
    - **Double-click individual `Constructor` parameter**, this map the `Constructor` parameter to the corresponding `Element` property, adding it if required.
    - **Double-click individual `Element` property**, this will map the `Element` property to the `Constructor` parameter, if there is an parameter with the same name.
    - **Drag an individual `Element` property onto a `Constructor` parameter**, this will map the two elements.
    - **Drag multiple mappable items from either side to the other side's background**, this will batch map the items, adding items if applicable.

![Create Entity Action Mapping](./images/create-entity-action-constructor-mapping.png)

> [!TIP]  
> If there is no mappable concept in the `Element` for the `Constructor` parameter, you are able to capture an expression in the text box to the right of the attribute e.g. `true`, `0`, `""`, etc.

![Create Entity Action ](./images/create-entity-action-constructor.png)

> [!TIP]  
> To get back to the mapping screen right click on the `Create Entity Action`, under the `Entity`, or on the Association linking the `Element` and `Constructor` and select **Map Entity Creation**.

### Update Entity Action

This action allows you to model the update of a domain `Entity`(`Class`), using either an `Attribute`s or a domain entity `Operation`.
This action can be modeled against a `Command`, a service `Operation` or a `Domain Event Handler Association`, referred to as the `Element` below.

#### Updating a Domain Entity using its properties

1. On a diagram, select **Add to Diagram** and choose the domain `Entity` you want to create.
2. Right-click on the `Element` and select **Update Entity**.
3. Connect the `Element` to the `Entity` by left-clicking the `Entity`.

This will open the `Update Entity Mapping` Dialog, this dialog maps the data flow from from the `Element` to the `Entity`.

1. Double-Click the `Entity` in right hand panel.
This will add purple line between the `Element` and the `Entity`, this represents how the `Entity` will be created i.e. `Object Initialization`.
2. Map how the data from the `Element` to the `Entity`,  this can be done in several ways:

    - **Select `Entity` attributes, drag them to the background of the left hand side**, this map the `Entity` attributes to the corresponding `Element` properties, adding them if required.
    - **Double-click individual `Entity` attributes**, this map the `Entity` attribute to the corresponding `Element` property, adding it if required.
    - **Double-click individual `Element` property**, this will map the `Element` property to the `Entity` property, if there is an attribute with the same name.
    - **Drag an individual `Element` property onto a `Entity` attribute**, this will map the two elements.
    - **Drag multiple mappable items from either side to the other side's background**, this will batch map the items, adding items if applicable.
    ![Update Entity Action Mapping](./images/update-entity-action-mapping.png)
3. Click the **Map Entity Query** button.
This will change the dialog to the `Query Entity Mapping` view, which maps how the entity should be retrieved.
4. Map the data from the `Element` which should be used to query the `Entity` to be updated, typically the `Entity`'s primary key.

    - **Double-click the `Entity` primary key attribute(s)**, this map the `Entity` attribute to the corresponding `Element` property, adding it if required.
    - **Drag an individual `Element` properties onto a `Entity` attributes**, this will map the two elements.

![Update Entity Action ](./images/update-entity-action-properties.png)

> [!TIP]  
> To get back to the mapping screen right click on the `Update Entity Action`, under the `Entity`, or on the Association linking the `Element` and `Entity` and select **Map Entity Update**.

#### Updating a Domain Entity using a Domain Entity Operation

1. On a diagram, select **Add to Diagram** and choose the domain `Entity` you want to create.
2. Right-click on the `Element` and select **Update Entity**.
3. Connect `Element` to an `Operation` on the `Entity` by left-clicking the `Operation`.

This will open the `Update Entity Mapping` dialog, this dialog maps data flow from the `Element` to the invoked `Operation`.

1. Double-click the `Operation` in right hand panel.
This will add purple line between the `Element` and the `Operation`, this represents the invocation of the `Operation`.
2. Map how the data from the `Element` flows to the `Operation`,  this can be done in several ways:

    - **Double-click the `Operation` again**, this map all the `Operation` parameters to the corresponding `Element` properties, adding missing ones where required.
    - **Double-click individual `Operation` parameter**, this map the `Operation` parameter to the corresponding `Element` property, adding it if required.
    - **Double-click individual `Element` property**, this will map the `Element` property to the `Operation` parameter, if there is an parameter with the same name.
    - **Drag an individual `Element` property onto a `Operation` parameter**, this will map the two elements.
    - **Drag multiple mappable items from either side to the other side's background**, this will batch map the items, adding items if applicable.
    ![Update Entity Action Operation Mapping](./images/update-entity-action-operation-mapping.png)
3. Click the **Map Entity Query** button.
This will change the dialog to the `Query Entity Mapping` view, which maps how the entity should be retrieved.
4. Map the data from the `Element` which should be used to query the `Entity` to be updated, typically the `Entity`'s primary key.

    - **Double-click the `Entity` primary key attribute(s)**, this map the `Entity` attribute to the corresponding `Element` property, adding it if required.
    - **Drag an individual `Element` properties onto a `Entity` attributes**, this will map the two elements.

![Update Entity Action using an Operation](./images/update-entity-action-operation.png)

> [!TIP]  
> To get back to the mapping screen right click on the `Update Entity Action`, under the `Entity`, or on the Association linking the `Element` and `Entity` and select **Map Entity Update**.

### Delete Entity Action

### Query Entity Action

### Call Service Operation Action

### Processing Actions
