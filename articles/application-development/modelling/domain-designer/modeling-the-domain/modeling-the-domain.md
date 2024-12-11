# Modeling the Domain

## Adding a Diagram

You can add Diagrams to your `Domain Package`, by default Application Templates typically add a default one.
Diagrams are useful for:

- Visualizing your domain.
- Visually modeling your domain.
- Visualize sub-sets or logical areas of a large domain

1. Right-click on the **Domain** package and select **New Diagram**.
2. If the designer was in Tree-view, it will switch to a diagram view.
3. Rename the diagram by right-clicking it in the Tree-view and selecting **Rename**.
4. Add domain elements to your diagram
    - From the context-menu, select **Add to Diagram** and choose `Elements` to add to the `Diagram`.
    - Drag domain elements, like `Class`s from the tree-view onto the diagram.
    - Model new domain elements
5. Optionally, create multiple diagrams for different perspectives. The Tree-view remains the source of truth.

> [!TIP]
> Hold down **CTRL** while dragging elements from the Tree-view to include directly associated elements.

![Diagram View](./images/add-diagram.png)

## Creating an Entity

An `Entity` is a core building block in domain modeling that represents a uniquely identifiable object within a system, such as a Customer or Order. Entities are essential because they encapsulate business rules and behavior, ensuring the system consistently reflects the real-world concepts they model.

> [!NOTE]
> We typically do domain modeling in Diagrams, it's important to realize that tree-view is the source of truth, the Diagrams are simply a visualization of the domain or part or part of the domain.

1. `Add an Entity` to the diagram.
2. Give your `Entity` a name.

> [!NOTE]
> The `Entity`'s Element type is `Class`.

Now you can model the various aspects of you entity,

- **Attributes**, model the data of your `Entity`.
- **Associations**, model the relationships between your `Entity`s.
- **Constructors**, model the construction of your `Entity`.
- **Operations**, model the behaviour of your `Entity`.

### Capturing Attributes

To model the data of an Entity:

1. `Add Attribute` (Ctrl + Shit + A) on a class.
2. Capture the name of the `Attribute`
3. Press **Tab** and select the `Type` for the attribute.

> [!TIP]
> Pressing F2 on an attribute allows you to rename and change the type of an attribute.
> [!TIP]
> If you have an `Attribute` selected, pressing **CTRL+ENTER** will add a new `Attribute` to the class, and edit it. This is very useful for rapidly capturing attributes.

### Adding Entity Associations

To model the relationships an 'Entity' has with other 'Entity's:

1. Both `Entity`s should be on the diagram, `Add to Diagram` if required.
2. Right-click on the `Entity` which will own the relationship, **hover** you mouse over the `New Association` and select the type of relationship you want from the sub-menu e.g. `Many to One`.
3. Left-click on the related `Entity` to create the association between them.

> [!NOTE]
> For a  more details of modeling Domain Association [click here](#modeling-entity-associations).

![Basic Domain](./images/create-domain.png)

## Inheritance with Entities

To inherit one Entity from another:

1. Right-click on the `Entity` that will inherit and select **New Inheritance**.
2. Select the parent `Entity`.

![Inheritance Entity](./images/inheritance-entity.png)

## Creating a Domain Contract

A `Domain Contract` encapsulates a specific intent or operation to be performed within a domain, bundling the data required for that operation into a single object. They can be used to maintaining clear and explicit boundaries in the domain, promoting separation of concerns and ensuring the domain logic operates on well-defined inputs. Domain `Data Contract`s are sometimes referred to as (domain) Data Transfer Objects or Command Objects.

> [!NOTE]
> The `Domain Contract`'s Element type is `Data Contract`.

1. `Add Domain Contract` in the tree-view.
2. Name your `Domain Contract`.
3. Right-click the `Domain Contract` and select **Add Attribute** to define its data.
4. Add complex data types as needed:
   - *Domain Contract* for modeling nested structures.
   - *Enum* for modeling enumerations.

![Domain Contract](./images/domain-contracts.png)

## Modeling Entity Associations

To Do