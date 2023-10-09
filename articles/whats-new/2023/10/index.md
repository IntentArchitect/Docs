# October 2023

Welcome to the October 2023 edition of highlights of What's New with Intent Architect.

- Highlights

- More updates
  - **[Apple Silicon Support](#apple-silicon-support)** - Intent Architect now runs code natively for Apple Silicon based Macs.
  - **[CRUD Update Command consumption convenience](#crud-update-command-consumption-convenience)** - When Controller parameters match with Update Command fields, we've made consuming these endpoints easier.

## Update details

### Apple Silicon Support

macOS releases are now published as "universal" packages which will run code natively for both Intel and Apple Silicon based Macs.

Available from:

- Intent Architect 4.1

### CRUD Update Command consumption convenience

When Controller parameters match with Update Command fields, we've made consuming these endpoints easier. Now, you don't need to populate the fields on the Command that are already populated via a Route parameter.

Previously you had to specify the Id for an Update Command via the Route parameter and the Command itself. Now if you have a parameter being specified elsewhere (e.g. Url Route) is found, it will prefer that as the source. Note the specifying the `Id` property in the Command will still be accepted so it needs to be the same as the Route Parameter value.

```csharp
[HttpPut("api/person/{id}")]
public async Task<ActionResult> UpdatePerson(
    [FromRoute] Guid id,
    [FromBody] UpdatePersonCommand command,
    CancellationToken cancellationToken = default)
{
    if (command.Id == default)
    {
        command.Id = id;
    }
    if (id != command.Id)
    {
        return BadRequest();
    }

    await _mediator.Send(command, cancellationToken);
    return NoContent();
}
```

Available from:

- Intent.AspNetCore.Controllers 5.4.1
- Intent.Application.MediatR 4.1.4
- Intent.AspNetCore.Controllers.Dispatch.MediatR 5.4.0