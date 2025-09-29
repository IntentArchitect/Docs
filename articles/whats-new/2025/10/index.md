# What's new in Intent Architect (October 2025)

Welcome to the October edition of What’s New in Intent Architect. This month we’re introducing first-class support for building .NET serverless backends on AWS Lambda.

- Highlights
	- **[AWS Lambda Functions module](#aws-lambda-functions-module)** – Model operations in the Services designer and generate idiomatic .NET AWS Lambda functions with out-of-the-box tooling for local run and deployment.

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

