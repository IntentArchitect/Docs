# What's new with Intent Architect (February 2024)

Welcome to the February 2024 edition of highlights of What's New with Intent Architect.

We hope you also had a great break at the end of the year at which time at Intent Architect we also generally wind down a bit meaning we don't have as much to show as usual, but we nevertheless managed to get some great things done.

- Highlights

- More updates
  - **[Model your Domain and persist it in a Redis Stack through Object Mapper](#model-your-domain-and-persist-it-in-a-redis-stack-through-object-mapper)** - Redis Stack is now available as a persistence option for Domain Modeling.
  - **[Send Integration Commands using MassTransit](#send-integration-commands-using-masstransit)** - Send a command to a specific recipient through a designated queue.
  - **[Model Request/Response interactions over message brokers with MassTransit](#model-requestresponse-interactions-over-message-brokers-with-masstransit)** - Use MassTransit to exchange commands/queries between applications, similar to HTTP calls, via a message broker.

## Update details

### Model your Domain and persist it in a Redis Stack through Object Mapper

![Redis Domain Modeling](images/redis-om-domain-modeling.png)

This module brings in a new `Document Database Provider`, `Redis OM`, allowing you realize your DocumentDB paradigm Domain Models with a Redis Stack persistence layer. This module includes

- Modeler customizations.
- Repositories using Object Mapper.
- Unit of work pattern.

For more detail, refer to the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Redis.Om.Repositories/README.md).

Available from:

- Intent.Redis.Om.Repositories 1.0.0

### Send Integration Commands using MassTransit

Send a command to a specific recipient through a designated queue.

![New Integration Command](images/new-integration-command.png)

For more detail, refer to the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Eventing.MassTransit/README.md).

Available from:

- Intent.Eventing.MassTransit 6.0.2

### Model Request/Response interactions over message brokers with MassTransit

Use MassTransit to exchange commands/queries between applications, similar to HTTP calls, via a message broker.

![Request/Response proxies](images/sender-app-service-proxies-created.png)

For more detail, refer to the [module documentation](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Eventing.MassTransit.RequestResponse/README.md).

Available from:

- Intent.Eventing.MassTransit.RequestResponse 1.0.0
