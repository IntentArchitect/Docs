# What's new in Intent Architect (March 2026)

Welcome to the March edition of What’s New in Intent Architect.

- Highlights
  - **[Mapperly-based DTO mapping generator](#mapperly-based-dto-mapping-generator)** - Type-safe, compile-time DTO mapping with zero reflection overhead.

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

