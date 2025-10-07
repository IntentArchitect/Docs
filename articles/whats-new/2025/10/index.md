# What's new in Intent Architect (October 2025)

Welcome to the October edition of What’s New in Intent Architect. This month we’re introducing first-class support for building .NET serverless backends on AWS Lambda.

- Highlights
  - **[AWS Lambda Functions module](#aws-lambda-functions-module)** – Model operations in the Services designer and generate idiomatic .NET AWS Lambda functions with out-of-the-box tooling for local run and deployment.
  - **[External API Template](#external-api-template)** - A new app template is now available which makes importing an external service’s OpenAPI document quick and straightforward.
  - **[Service Proxy URLs auto-populated](#service-proxy-url-population)** - When creating a proxy service to an external API or another Intent Architect application, the client app now **auto-fills the base URL** from the source.

## Update details

### AWS Lambda Functions module

![AWS Lambda Functions](images/aws-lambda-functions.png)

The new `Intent.Aws.Lambda.Functions` module enables modeling-first development of serverless APIs on AWS Lambda. 

Key features include:

- Uses `Amazon.Lambda.Annotations` to handle AWS configuration concerns directly in code.
- Standard .NET configuration via appsettings.json and environment variables.
- Out-of-the-box support for standard testing and deployment tools like the Mock Lambda Test Tool and SAM CLI.

```csharp
[LambdaFunction]
[HttpApi(LambdaHttpMethod.Post, "/api/orders")]
public async Task<IHttpResult> CreateOrderAsync([FromBody] CreateOrderCommand command)
{
    // AWSLambda0107: can parameter of type System.Threading.CancellationToken passing is not supported.
    var cancellationToken = CancellationToken.None;
    return await ExceptionHandlerHelper.ExecuteAsync(async () =>
    {
        var result = await _mediator.Send(command, cancellationToken);
        return HttpResults.Created($"/api/orders/{Uri.EscapeDataString(result.ToString())}", new JsonResponse<Guid>(result));
    });
}
```

For more information, see the [documentation](https://docs.intentarchitect.com/articles/modules-dotnet/intent-aws-lambda-functions/intent-aws-lambda-functions.html).

Available from:

- Intent.Aws.Lambda.Functions 1.0.0

### External API Template

The new **External API Template** streamlines bringing external APIs into your app. Provide an OpenAPI document and the template will model its endpoints so you can configure and call those APIs directly from your application.

![External API Template](images/external-api-template.png)

When you create an application with this template, all modules required for OpenAPI import are installed and pre-configured — no manual setup needed.

![Imported OpenAPI Document](images/imported-external.png)

Available from:

- Intent Architect 4.5.0


### Service Proxy URL Population

A client application now pre-populates the default service URL when you add a proxy service. This works in two scenarios:

#### External API

When importing an OpenAPI document with the [Intent.OpenApi.Importer](https://docs.intentarchitect.com/articles/modules-importers/intent-openapi-importer/intent-openapi-importer.html) module, any server URL found in the spec is saved on the **Service Package** as the *Service URL*. That value is then used automatically as the default URL when you create a proxy to that external service.

Available from:

- Intent.OpenApi.Importer 1.1.8

![Service URL](images/external-service-url.png)

#### Intent Architect Application

The **Api** projects `Base URL` is now stored in the Visual Studio Designer. When you create a proxy service to that application, this Base URL is used as the default service URL in the client.

![Base URL](images/internal-base-url.png)

Available from:

- Intent.Blazor.HttpClients 4.0.17
- Intent.Integration.HttpClients 6.0.7
- Intent.VisualStudio.Projects 3.9.2

