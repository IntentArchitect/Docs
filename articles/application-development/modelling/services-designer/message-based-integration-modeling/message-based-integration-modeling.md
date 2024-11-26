---
uid: application-development.modelling.services-designer.message-based-integration-modeling
---
# Message-Based Integration Modeling

## What is Message-Based Integration / Event Driven Architecture

Message-based integration is a design approach where systems communicate asynchronously by exchanging messages through a message broker, such as RabbitMQ, Kafka, or Azure Service Bus. This approach decouples systems, meaning each service can operate independently, improving scalability, fault tolerance, and flexibility in system design. It allows services to exchange data or trigger actions without being directly dependent on each other’s availability or implementation, fostering resilience and enabling integration across diverse platforms and technologies. Message-based integration is particularly useful in distributed systems where real-time or asynchronous processing is required, such as processing orders, handling events, or coordinating microservices.

## How to Model Message-Based Integrations

With in Intent Architect you can model your applications Message-Based Integration or Event-Driven Architecture.

The image below illustrates this type of design.

![Message Based Integration](./images/message-based-integration.png)

Here we can see the following

- The application subscribes to a `CustomerCreated` integration message.
- Which fires off a `AccountCreatedCommand` service end point.
- This process published as `AccountCreated` integration message for any applications which are subscribed.

This can all be done in the Services Designer with a few simple steps.

- *Model the message contracts*, design the data contracts which will flow between your systems.
- *Model where these messages are published*, explicitly model which parts the application send integration messages to other systems.
- *Model who subscribes to the messages*, configure which integration messages the applications wants to know about.

## Integration Messages vs Integration Commands

When modeling Integration messages you can can use either `Message` or `Integration Message`. `Message`s can be thought of as Integration Events, from a modeling perspective these are fairly similar but tend to have different implementations.

The table below describes the characteristics of `Message`s vs `Integration Command`s.

| Aspect  | Message | Command |
| --------| ------- |--------|
| Technical realization | Topic | Queue |
| Purpose  | Notifies about an occurrence | Instructs an action |
| Recipients | Multiple subscribers (potentially) | Single recipient |
| Expectations | No action is mandated; subscribers decide how to react | Sender expects the action to be performed |
| Ordering of messages |Unordered | Naturally ordered (i.e. Queued) |

## Publishing an Integration Message from a Command

1. On this diagram, hover your mouse over the `Command` and click the `Suggestion` icon (:light bulb:) .
2. Select the `Publish Integration Event` option.
This will add a new `Message` and a associate it with your command
3. Type in the name of your `Message` and press 'Enter'.
4. You can now using the Advanced Mapping Screen to project the structure of you message.
Double clicking elements on the left hand side will add and map them onto your `Message`.

![Modeled Message](./images/publish-event-from-command.png)

## Publishing an Integration Message from a Service

1. On this diagram, hover your mouse over the `Service`'s `Operation` and click the `Suggestion` (Lightbulb) icon.
2. Select the `Publish Integration Event` option.
This will add a new `Message` and a associate it with your command
3. Type in the name of your `Message` and press 'Enter'.
4. You can now using the Advanced Mapping Screen to project the structure of you message.
Double clicking elements on the left hand side will add and map them onto your `Message`.

![Modeled Message](./images/publish-event-from-command.png)

## Create an Integration Message

Start by adding a new `Message` on any `Diagram` in the `Services Designer`, this would typically represent an integration message your application will publish.

> [!NOTE]
> `Message`s are modelled in an `Eventing Package`, as opposed to a `Services Package`, this is because these messages are contracts which are designed to be shared with other applications.

Next you can model out the data requirements of you message.

Right click on the `Message`, and select `Add Property` to start modeling the data of your message.

You can also add the following data types as required.

- *Eventing DTO* - for modeling complex children.
- *Enum* - for modeling enumeration.

![Modeled Message](./images/message-modeling.png)

> [!NOTE]
> It is often faster to define/map your message structure while [publishing the message](#publishing-an-integration-message-from-a-command).

## Publishing an Existing Integration Message from a Command

Given you have a Diagram with your Command on which you want to publish an existing integration `Message`.

1. Select `Add to Diagram`, and select the existing `Message` you want to publish.
2. 'Right click' on the command, and select `Publish Integration Event`, `Left click` the `Message` to link them.
3. 'Right click' on the `Publish Integration Event` association and select `Map to Message`
4. Map the relevant data between the `Command` and the `Message`.

> [!TIP]
> If the`Message` you are looking for is not available in the dialog, ensure you have added the `Package` which contains the `Message` as a reference to the `Services Package` which contains diagram.

## Subscribing to an Integration Message

## Create an Integration Command

Start by adding a new `Integration Command` on any `Diagram` in the `Services Designer`, this would typically represent an integration message your application will publish.

> [!NOTE]
> `Integration Command`s are modelled in an `Eventing Package`, as opposed to a `Services Package`, this is because these messages are contracts which are designed to be shared with other applications.

Next you can model out the data requirements of you message.

Right click on the `Integration Command`, and select `Add Property` to start modeling the data of your message.

You can also add the following data types as required.

- *Eventing DTO* - for modeling complex children.
- *Enum* - for modeling enumeration.

![Modeled Message](./images/integration-command-modeling.png)

> **Note:**
>
> When publishing an `Integration Command` the message can be modeled out by using the advanced mapping screen(Joel Link to advanced mapping).

## Publishing an Integration Command

## Subscribing to an Integration Command

## Realize your Message-Based Integration in any of the following Technologies

## Modeling Integration Events and Commands
