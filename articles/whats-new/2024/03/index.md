# What's new in Intent Architect (March 2024)

Welcome to the March 2024 edition of highlights of What's New with Intent Architect.

- Highlights

- More updates
  - **[Open Telemetry Protocol for generic exports](#open-telemetry-module-now-has-open-telemetry-protocol-for-generic-exports)** - Enables generic export capabilities for systems like Jaeger and Elastic Search.
  - **[Serilog module enhancements](#serilog-module-has-extensible-sink-options-with-newly-added-file-and-graylog-sinks)** - Introduces File and Graylog sink options, enhancing logging capabilities.
  - **[New Bugsnag module for error monitoring](#new-bugsnag-module-for-error-monitoring-and-reporting)** - Offers cloud-based error monitoring and reporting for web and mobile apps.
  - **[Java weaver update](#java-weaver-updated-to-java-17-grammar)** - Supports Java 17 grammar, including text block quotes.

## Update details

### Open Telemetry Module now has Open Telemetry Protocol for generic exports

The OpenTelemetry module has been enhanced with the `OpenTelemetry Protocol`, which serves as a universal exporter for various systems including Jaeger and Elastic Search.

![Open Telemetry Options](images/open-telemetry-options.png)

Available from:

- Intent.OpenTelemetry 2.0.3

### Serilog Module has Extensible Sink Options with newly added File and Graylog sinks

We've relocated the Serilog sink configuration from the `Program.cs` file to the `appsettings.json` file, offering more flexibility in including custom sinks. New support for Graylog and File sinks has been added, broadening the logging functionality.

![Serilog sink options](images/serilog-graylog.png)

Available from:

- Intent.Modules.AspNetCore.Logging.Serilog 5.1.0

### New Bugsnag Module for Error Monitoring and Reporting

Integrate with Bugsnag for advanced, cloud-based error monitoring and reporting across web and mobile applications.

![Bugsnag UI Sample](images/bugsnag-ui-sample.png)

Available from:

- Intent.Bugsnag 1.0.0

### Java Weaver Updated to Java 17 Grammar

The Java Weaver now accommodates Java 17 grammar, enhancing support for modern Java features including the use of text block quotes.

Available from:

- Intent.Code.Weaving.Java 1.0.0
- Intent.Common.Java 4.0.0
