[IntentManaged(Mode.Fully, Body = Mode.Fully)]
public async Task<Guid> Handle(CreateProductCommand request, CancellationToken cancellationToken)
{
    // IntentIgnore
    request.Name = MyHelperMethod(request.Name);

    // IntentMerge
    var product = new Product
    {
        Name = request.Name,
        // IntentIgnore
        Description = GetProductDescription(request),
        Qty = request.Qty,
        DateCreated = DateTime.UtcNow
    };

    _productRepository.Add(product);
    await _productRepository.UnitOfWork.SaveChangesAsync(cancellationToken);
    return product.Id;
}