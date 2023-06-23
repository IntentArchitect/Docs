# June 2023

Welcome to the June 2023 edition of highlights of What's New with Intent Architect.

- Product updates
- Module updates (C#)
  - **[Generate contracts only for services](#generate-contracts-only-for-services)** - Optionally turn off generation of implementations for a `Service` modelled in the Service designer.
  - **[Version AspNetCore.NET services](#version-aspnetcorenet-services)** - Apply version information to Commands, Queries or Service elements in your service designer to make use of the `Microsoft.AspNetCore.Mvc.Versioning` library.
  - **[AspNetCore & AzureFunctions featuring 404 response types for entities not found](#aspnetcore--azurefunctions-featuring-404-response-types-for-entities-not-found)** - CRUD-based patterns will now throw `NotFoundExceptions` when an Entity of given `id` could not be found.
- Pre-released Module updates (C#)

## Product updates

## Module updates (C#)

### Generate contracts only for services

It is now possible to specify that only contracts should be generated for a service by applying the `Contract Only` Stereotype to a Service. When applied, the interface ("contract") for the service will still be generated, but no implementation and corresponding dependency injection registration.

Available from:

- Intent.Application.ServiceImplementations 4.3.0

### Version AspNetCore.NET services

Apply version information to Commands, Queries or Service elements in your service designer to make use of the `Microsoft.AspNetCore.Mvc.Versioning` library. Add an `Api Version` (populate it with a few version numbers) and then apply the `API Version Settings` stereotype to the services you wish to apply versioning to.

> [!NOTE]
> This is only available for AspNetCore.NET currently even though the `Api Version` element can be added in other tech-stacks' Services designers.

Available from:

- Intent.AspNetCore.Versioning 1.0.1
- Intent.Metadata.WebApi 4.2.2
- Intent.AspNetCore.Controllers 5.2.0
- Intent.AspNetCore.Controllers.Dispatch.MediatR 5.2.0

### AspNetCore & AzureFunctions featuring 404 response types for entities not found

CRUD-based patterns will now throw `NotFoundExceptions` when an Entity of given `id` could not be found. This will be intercepted by middleware to translate into a 404 `Not found` error but may contain additional error details around what kind of Entity could not be found with a given `id`. Also other Exception handling code patterns have received an update too.

In the case for AspNetCore.NET applications, there is now an Exception Filter that will deal with all the known exceptions:

```c#
public class ExceptionFilter : IExceptionFilter
{
    public void OnException(ExceptionContext context)
    {
        switch (context.Exception)
        {
            case ValidationException exception:
                foreach (var error in exception.Errors)
                {
                    context.ModelState.AddModelError(error.PropertyName, error.ErrorMessage);
                }
                context.Result = new BadRequestObjectResult(new ValidationProblemDetails(context.ModelState))
                .AddContextInformation(context);
                break;
            case ForbiddenAccessException:
                context.Result = new ForbidResult();
                break;
            case NotFoundException exception:
                context.Result = new NotFoundObjectResult(new ProblemDetails
                {
                    Detail = exception.Message
                })
                .AddContextInformation(context);
                break;
        }
    }
}
```

As for Azure Functions, there is an additional `catch` statement for `NotFoundExceptions`:

```c#
try
{
    var requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    var dto = JsonConvert.DeserializeObject<SampleDomainCreateDto>(requestBody);
    var result = await _appService.CreateSampleDomain(dto);
    return new CreatedResult(string.Empty, result);
}
catch (NotFoundException exception)
{
    return new NotFoundObjectResult(new { Message = exception.Message });
}
catch (FormatException exception)
{
    return new BadRequestObjectResult(new { Message = exception.Message });
}
```

Available from (only update those that are applicable):

- Intent.AspNetCore.Controllers 5.2.0
- Intent.Entities.Repositories.Api 4.1.0
- Intent.Application.MediatR.CRUD 5.1.1
- Intent.Application.MediatR.CRUD.Tests 1.1.0
- Intent.AzureFunctions.Interop.EntityFrameworkCore 4.1.0
- Intent.Dapr.AspNetCore 1.1.0

## Pre-released Module updates (C#)
