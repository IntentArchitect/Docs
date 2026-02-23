# What's new in Intent Architect (March 2026)

Welcome to the March edition of What’s New in Intent Architect.

- Highlights
  - **[Mapperly-based DTO mapping generator](#mapperly-based-dto-mapping-generator)** - Type-safe, compile-time DTO mapping with zero reflection overhead.
  - **[Automatic route parameter filtering in API documentation](#automatic-route-parameter-filtering-in-api-documentation)** – Eliminates duplicate parameter documentation in API specs when properties are already defined as route parameters.
  - **[Convert many-to-many associations to intermediate entities](#convert-many-to-many-associations-to-intermediate-entities)** - Transform implicit join tables into explicitly modeled entities for advanced customization.

## Update details

### Mapperly-based DTO mapping generator

![Mapperly](images/mapperly-logo.png)

The new `Intent.Application.Dtos.Mapperly` module generates type-safe mapper classes and extension methods using [Mapperly](https://mapperly.riok.app), providing compile-time code generation instead of reflection-based mapping. Mappers automatically handle entity-to-DTO conversions with null-safety and nested DTO references, while remaining fully extensible via partial classes for custom mapping logic.

#### Example Generated Code

```csharp
[Mapper]
public partial class CustomerDtoMapper
{
    [UseMapper]
    private readonly AddressDtoMapper _addressDtoMapper;

    [MapProperty(nameof(Customer.Addresses), nameof(CustomerDto.Addresses))]
    public partial CustomerDto CustomerToCustomerDto(Customer customer);

    public partial List<CustomerDto> CustomerToCustomerDtoList(List<Customer> customers);
}

// Extension method usage
var customerDto = customer.MapToCustomerDto();
var customerDtos = customers.MapToCustomerDtoList();
```

Available from:

- Intent.Application.Dtos.Mapperly 1.0.3

### Automatic route parameter filtering in API documentation

![Swagger Example](images/swagger-route-param-filter-example.png)
![Scalar Example](images/scalar-route-param-filter-example.png)

When documenting REST endpoints, you often reference the same parameter as both a route parameter (`/api/users/{id}`) and in the request body schema, causing confusing duplication. Both `Intent.AspNetCore.Swashbuckle` and `Intent.AspNetCore.Scalar` now automatically remove properties from request body schemas when they match route parameter names, ensuring clean API documentation.

The implementation handles inline and referenced schemas, matches names case-insensitively, and removes properties from the `required` list automatically.

Available from:

- Intent.AspNetCore.Swashbuckle 5.2.3
- Intent.AspNetCore.Scalar 1.0.7

### Convert many-to-many associations to intermediate entities

![Suggestion to Convert to Intermediate Entity](images/suggestion-convert-intermediate-entity.png)
![Converted](images/converted-intermediate-entity.png)

When modeling many-to-many relationships, a new `Convert to Intermediate Entity` suggestion (available in the Domain Designer) allows you to convert implicit join tables into explicitly modeled entities. Hover over any many-to-many association and select the suggestion to create an intermediate entity with two many-to-one associations, giving you full control over the join table structure for adding properties, indexes, or constraints.

Available from:

- Intent.Metadata.RDBMS 3.7.12

