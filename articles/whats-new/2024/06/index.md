# What's new in Intent Architect (June 2024)

Welcome to the June 2024 edition of highlights of What's New in Intent Architect.


- Highlights
  - **[Solace Module](#solace-module)** - A new module which allows you to use Solce publish/subscribe message system for integration messaging.

- More updates

## Update details

### Solace Module

You can now use Solace to realize your inter-application eventing design from Intent Architect. [Model your message publishing and subscriptions as you normally would using the Eventing Modeler](https://github.com/IntentArchitect/Intent.Modules/blob/development/Modules/Intent.Modules.Modelers.Eventing/README.md) and the new `Intent.Eventing.Solace` module will automatically generate your Solace implementation  for you allowing you interact with it using the same IEventBus interface in the same way as our other eventing technologies. You can also read more about the module [here](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Eventing.Solace/README.md).

Available from:

- Intent.Eventing.Solace 1.0.2
