---
uid: application-development.user-interface.telemetry-collection
---
# Telemetry collection

Intent Architect includes a telemetry collection feature designed to help improve performance, stability, and user experience. By gathering essential usage statistics, the Intent Architect team can better understand how the tool is being used and make informed decisions about future enhancements.

## What data is collected?

Intent Architect collects only basic statistical and error data, including:

- **Software Factory Execution Time** - The duration of the Software Factory execution.
- **Designer Load Time** - How long it takes for Designers to load.
- **Code Generation Metrics** - The total amount of code generated.
- **Modeling Activity** - The number of elements modeled within the designers.
- **Application Name** - The specific Intent Architect application in use.
- **Account Identifier** - The identifier of the current user account.
- **Errors** - Errors/exceptions which occur in Intent Architect itself.

## What data is NOT collected?

Intent Architect prioritizes user privacy and ensures that no proprietary or sensitive information is transmitted. Specifically, data such as the following is not collected:

- **Element Names** - The names of modeled elements, services, classes, or any other defined types.
- **Generated or Written Code** - Any source code, whether automatically generated or manually written, remains entirely private and is never sent through telemetry.

## Why is telemetry important?

Telemetry data allows the Intent Architect team to:

- Optimize performance by identifying slow processes.
- Enhance user experience by improving Designer load times.
- Track feature usage to focus development efforts on the most impactful areas.
- Diagnose potential issues before they become widespread.
