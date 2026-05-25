[IntentManaged(Mode.Fully, Body = Mode.Fully)]
public async Task<Guid> Handle(CreateProductCommand request, CancellationToken cancellationToken)
{
    // IntentIgnore
    request.Name = MyHelperMethod(request.Name);

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