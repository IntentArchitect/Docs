# January 2024

Welcome to the January 2024 edition of highlights of What's New with Intent Architect.

- Highlights
  - 
- More updates
  - **[Role based authorization - composite role support](#roles-based-authorization---composite-role-support)** - add the ability to describe more complex role requirements for authorization.
  - **[Configuration options for ASP.Net Core contract serialization](#configuration-options-for-aspnet-core-contract-serialization)** - added some configuration options to tweak ASP.Net Core Json serialization options.
  
## Update details

### Roles based authorization - composite role support

When configuring security in the `Service Designer`,  the `Authorization` stereotype can now use the `+` syntax to require multiple roles.

![Composite role configuration](images/roles-example.png)

For Example:

- Role1+Role2, requires the consumer to have both `Role1` and `Role2`.
- Role1,Role2+Role3, requires the consumers to have (`Role1` or `Role2`) and `Role3`.

Available from:

- Intent.AspNetCore.Controllers 6.0.0

### Configuration options for ASP.Net Core contract serialization

We have added 2 new `API Settings`

- Serialize Enums as Strings. 
- On Serialization ignore JSON reference cycles.

![API Settings](images/api-settings.png)

These setting control the following code:

![API Settings Output](images/api-settings-code.png)

Available from:

- Intent.AspNetCore.Controllers 6.0.0
