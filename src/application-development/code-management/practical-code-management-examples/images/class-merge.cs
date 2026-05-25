[IntentManaged(Mode.Merge, Signature = Mode.Fully)]
public class CreateProductCommandHandler : IRequestHandler<CreateProductCommand, Guid>
{
    private readonly IProductRepository _productRepository;

    [IntentManaged(Mode.Merge)]
    public CreateProductCommandHandler(IProductRepository productRepository)
    {
        _productRepository = productRepository;
    }

    // Additional code omitted for brevity
}