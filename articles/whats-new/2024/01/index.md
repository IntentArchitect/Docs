# January 2024

Welcome to the January 2024 edition of highlights of What's New with Intent Architect.

- Highlights
  - 
- More updates
  - **[Role based authorization - composite role support](#roles-based-authorization---composite-role-support)** - add the ability to describe more complex role requirements for authorization.
  
## Update details

### Roles based authorization - composite role support

When specifying roles in the Service Designer on the `Authorization` stereotype, you can now use the `+` syntax to require multiple roles.

For Example:

- Role1+Role2, requires the consumer to have both `Role1` and `Role2`.
- Role1,Role2+Role3, requires the consumers to have (`Role1` or `Role2`) and `Role3`.

Available from:

- Intent.AspNetCore.Controllers 6.0.0
