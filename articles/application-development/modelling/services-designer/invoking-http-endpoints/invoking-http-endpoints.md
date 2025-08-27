---
uid: application-development.modelling.services-designer.invoking-http-endpoints
---
# Invoking HTTP Endpoints

In distributed architectures, services often need to communicate with one another. Writing service clients manually can be time-consuming, error-prone, and inconsistent. A _Service Proxy_ simplifies this process by allowing developers to reference _already defined services_ in other Intent Architect applications and automatically generate strongly typed clients that adhere to the specified service contract.

The generated `Service Proxy` acts as an intermediary between an application and an external service, providing a strongly typed API that abstracts away the complexity of request configuration and client setup.

This article explains how to model `Perform Invocation` relationships which are then realized in generated code as Service Proxies which will use HTTP to communicate with target endpoints.

> [!NOTE]
>
> Historically, [](xref:application-development.modelling.proxy-designer.proxy-designer) was required to invoke HTTP Endpoints, although that method is still fully supported, going forward the approach of using `Perform Invocation` as described in this article is recommended.

This article will describe the process of creating a Service Proxy from an example `eShop.Invoicing` application to an `eShop.Customers` application in the following solution:

![Intent Architect Solution Explorer showing the two applications](images/solution-explorer.png)

The Services designer for the `eShop.Customers` application has the following CQRS requests modeled:

![Screenshot of the Services designer in the eShop.Customers application](images/customers-services-designer.png)

## Adding the Customer CQRS requests to a diagram

We will start by adding the CQRS requests from the `eShop.Customers` applications onto a diagram in the `eShop.Invoicing` application's Services designer.

In the Services designer of the `eShop.Invoicing` application:

- [Add a package reference](xref:application-development.modelling.about-packages) to the `eShop.Customers.Services`.

  ![Package references manager screen showing the packages which need to be selected](images/package-references-manager.png)

  This will make the CQRS requests from the referenced package available for use in our designer.

- Right-click the package on the designer and select the `New Folder` option:

  ![New Folder context menu option on a package](images/package-new-folder-option.png)

- Give the folder a name, such as `Customers`.
- Right-click the folder and select the `New Diagram` option:

  ![New Diagram context menu option on a folder](images/new-diagram-option.png)

- Give the diagram a name such as `Customers`.
- Right-click the background of the diagram and select the `Add to Diagram` option:

  ![Add to Diagram context menu option](images/add-to-diagram-option.png)

- You can filter by `Customer` and then select all the Commands and Queries and then press DONE:

  ![Items selected to be added to the diagram](images/add-to-diagram-dialog.png)

  ![Items added to the Diagram](images/screenshot-showing-items-added-to-diagram.png)

## Creating a request and have it invoke a CQRS request over HTTP

- Right-click the diagram and choose the `New Query` option:

  ![New Command context menu option](images/new-command-option.png)

- Give the Command a name such as `GetCustomerByIdCommand`.
- Right-click the Command and select the `Invoke Service` option:

  ![Invoke Service context menu option](images/invoke-service-option.png)

- Click the `GetCustomersByIdQuery` to set it as the Target End.

  ![Invoke Service association with target end set](images/invoke-service-target-end-selected.png)

- Right-click the association line and select the `Map Call Operation` option:

  ![Map Call Operation context menu option](images/map-call-operation-option.png)

- Double click the `GetCustomerByIdQuery` element in the right-pane to map the command from the left-pane to it:

  ![Mapping created between GetCustomerByIdCommand and GetCustomerByIdQuery](images/command-mapped-to-query.png)

- Right-click the `CommandCustomerByIdCommand` in the left pane and select the `Add Property` option:

  ![Add Property context menu option](images/add-property-option.png)

- Give it a name of `Id` and type of `Guid`:

  ![The new property given a name and type](images/id-property-name-and-type.png)

- You can now double click the `Id: guid` in the right-pane to specify that its field needs to be populated from the `Id` on the command in the left pane:

  ![Mapping created between the Id properties](images/properties-mapped.png)

- Press DONE.

## Run the Software Factory

Run the Software Factory and review the proposed changes:

![Proposed software factory changes](images/proposed-software-factory-changes.png)

Reviewing the changes, observe the following in particular:

- `ICustomersService` is being is being created and registered up in `HttpClientConfiguration` against the also created `CustomersServiceHttpClient`.
- Other related contract files such as the Command and its referenced DTOs are being created.
- The `GetCustomerByIdCommandHandler` has an implementation as follows:

```csharp
public class GetCustomerByIdCommandHandler : IRequestHandler<GetCustomerByIdCommand>
{
    private readonly ICustomersService _customersService;

    [IntentManaged(Mode.Merge)]
    public GetCustomerByIdCommandHandler(ICustomersService customersService)
    {
        _customersService = customersService;
    }

    [IntentManaged(Mode.Fully, Body = Mode.Fully)]
    public async Task Handle(GetCustomerByIdCommand request, CancellationToken cancellationToken)
    {
        var result = await _customersService.GetCustomerByIdAsync(new GetCustomerByIdQuery
        {
            Id = request.Id
        }, cancellationToken);
    }
}
```

## Invoking Service Operations

The procedure for invoking traditional Service Operations is essentially the same as the above where `Invoke Service` associations are created with service operations as their target end:

![Screenshot of diagram showing Invoke Service association to the operation of a traditional service](images/invoke-traditional-service-operation-on-diagram.png)

![Mapping configuration for invoking a traditional service operation](images/invoke-traditional-service-operation-mapping-screen.png)

## Service Proxy for a 3rd party service

You can have a proxy created for a third-party services and invoke it, provided the service definition is modeled in Intent Architect. Invoking the service follows the same steps described [above.](#invoking-http-endpoints)

To represent a third-party service, you must create a **separate application** in your Intent Architect solution. Use the _External API_ application template for this purpose:

- Right-click the solution in Intent Architect and select **Create New Application**.
- Choose the `External API` application template.  
  ![External API](images/external-api-template.png)
- Give the application a clear, descriptive name to identify it as a third-party service.
- An empty Intent Application will be created and added to your solution, pre-configured with the necessary modules to model an external API.

### Using Intent.OpenApi.Importer

If the third-party service provides a OpenApi document, you can import it directly into the `Services Designer` using the [Intent.OpenApi.Importer](https://docs.intentarchitect.com/articles/modules-dotnet/intent-openapi-importer/intent-openapi-importer.html) module.

Once imported, follow the steps outlined above to [invoke the service](#invoking-http-endpoints).

> [!NOTE]
>
> The [Intent.OpenApi.Importer](https://docs.intentarchitect.com/articles/modules-dotnet/intent-openapi-importer/intent-openapi-importer.html) module is automatically installed when creating an application using the `External API` template.

### Manually Modeling the Service

If no OpenApi document is available, you can manually model the third-party service in the `Service Designer`. Once modeled, follow the same steps above to [invoke the service](#invoking-http-endpoints).

## Summary

This article guided you through using the `Invoke Service` association to invoke HTTP endpoints.

## Next steps

You can try invoking other endpoints in the same way as described above.
