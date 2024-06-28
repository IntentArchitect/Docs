# What's new in Intent Architect (June 2024)

Welcome to the June 2024 edition of highlights of What's New in Intent Architect.


- Highlights
  - **[Kafka Publish/Subscribe (beta)](#kafka-publishsubscribe-beta)** - A new module which allows you to use Kafka publishing and subscription of integration messages.

- More updates

## Update details

### Kafka Publish/Subscribe (beta)

You can now use Kafka to realize your inter-application eventing design from Intent Architect. [Model your message publishing and subscriptions as you normally would using the Eventing Modeler](https://github.com/IntentArchitect/Intent.Modules/blob/development/Modules/Intent.Modules.Modelers.Eventing/README.md) and the new `Intent.Eventing.Kakfka` module will automatically generate Kafka Producers, Consumers and handlers for you allowing you interact with it using the same IEventBus interface in the same way as our other eventing technologies. You can also read more about the module [here](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Eventing.Kafka/README.md).

Available from:

- Intent.Eventing.Kakfka 1.0.0-beta.2

