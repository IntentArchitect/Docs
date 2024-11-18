# What's new in Intent Architect (December 2024)

Welcome to the December 2024 edition of highlights of What's New in Intent Architect.

- Highlights
  - **[SonarQube Analysis](#sonarqube-module)** - Provides real-time code quality analysis and feedback on the quality, readability and complexity of the code using [SonarQube](https://www.sonarsource.com/products/sonarlint/)
  - **[Multi-tenancy Route Strategy](#multi-tenancy-route-strategy)** - In a multi-tenancy application, determine the tenant from a route parameter.

## Update details

### SonarQube Module

This module installs the SonarQube IDE linter into your application, providing real-time code quality analysis and feedback on the quality, readability and complexity of the code.

An example of some warnings raised by SonarQube (as well as other analysis tools):

![SonarQube warning](images/sonarqube-warnings.png)

### Multi-tenancy Route Strategy

When configuring multi-tenancy settings, `Route` is now as strategy option, as well as the `parameter` name to use as the tenant:

![Route strategy](images/route-strategy.png)
![Route parameter](images/route-parameter.png)

The `route parameter` specified can then be used as a valid placeholder when defining an HTTP route:

![Route parameter](images/route-placeholder.png)
