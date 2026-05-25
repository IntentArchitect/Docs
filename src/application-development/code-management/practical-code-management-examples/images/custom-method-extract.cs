[IntentManaged(Mode.Fully, Body = Mode.Fully)]
public async Task<Guid> Handle(CreateProductCommand request, CancellationToken cancellationToken)
{
    // IntentIgnore
    request = ValidateAndUpdateCommand(request);

    var product = new Product
    {
        Name = request.Name,
        Description = request.Description,
        Qty = request.Qty
    };

    _productRepository.Add(product);
    await _productRepository.UnitOfWork.SaveChangesAsync(cancellationToken);
    return product.Id;
}

private CreateProductCommand ValidateAndUpdateCommand(CreateProductCommand request)
{
    PerformCustomValidation(request);

    request.Name = MyHelperMethod(request.Name);
    request.Description = MyHelperMethod(request.Description);

    return request;
}