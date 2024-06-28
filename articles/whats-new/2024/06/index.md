# What's new in Intent Architect (June 2024)

Welcome to the June 2024 edition of highlights of What's New in Intent Architect.

- Highlights

- More updates
  - **[Solace Module](#solace-module)** - A new module which allows you to use Solce publish/subscribe message system for integration messaging.
  - **[EF Core column ordering](#ef-core-column-ordering)** - A new database setting which preserves Domain Model attribute ordering at a SQL Colum level.
  - **[`// TODO : Implement` comments](#-todo--implement-comments)** - Have upgrades our patterns which produce `throw new NotImplementedException` to also include the `TODO comment`.
  - **[EF Repository Dapper Hybrid Module](#ef-core-column-ordering)** - This module extends the standard EF repository pattern to make Dapper usage simple.

## Update details

### Solace Module

You can now use Solace to realize your inter-application eventing design from Intent Architect. [Model your message publishing and subscriptions as you normally would using the Eventing Modeler](https://github.com/IntentArchitect/Intent.Modules/blob/development/Modules/Intent.Modules.Modelers.Eventing/README.md) and the new `Intent.Eventing.Solace` module will automatically generate your Solace implementation  for you allowing you interact with it using the same IEventBus interface in the same way as our other eventing technologies. You can also read more about the module [here](https://github.com/IntentArchitect/Intent.Modules.NET/blob/development/Modules/Intent.Modules.Eventing.Solace/README.md).

Available from:

- Intent.Eventing.Solace 1.0.2

### EF Core column ordering

Added a new `Database Setting` to the `Intent.EntityFrameworkCore` module, when enabled Intent Architect will populated the relevant `ColumnOrdering` in the Entity configurations resulting in you SQL Tables having the same column ordering as your Intent Architect domain model.

![Setting](images/maintain-column-ordering.png)

Available from:

- Intent.EntityFrameworkCore 5.0.8

### `// TODO : Implement` comments

There are many places where Intent Architect would generate `throw new NotImplementedException` for developers to implement, we have updated this paradigm to include the `// TODO : Implement..` comments. This allows for better visibility on these though IDE Todo lists and can also be easily picked up in CI/CD pipelines.

Available from:

- Intent.Application.MediatR.CRUD 6.0.12

### EF Repository Dapper Hybrid Module

This module extends the `Intent.EntityFrameworkCore.Repositories` module adding the following method:

```csharp
    protected IDbConnection GetConnection()
    {
        return _dbContext.Database.GetDbConnection();
    }
```

Making it easy to add repository methods which can be implemented using Dapper.

Available from:

- Intent.EntityFrameworkCore.Repositories.DapperHybrid 1.0.0
