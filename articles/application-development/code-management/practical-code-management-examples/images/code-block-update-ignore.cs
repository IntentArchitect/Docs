[IntentManaged(Mode.Fully, Body = Mode.Merge)]
public async Task<List<ProductDto>> Handle(GetProductsQuery request, CancellationToken cancellationToken)
{
    // IntentIgnore
    var products = await _productRepository.FindAllAsync(x => x.Active && x.Qty > 0, cancellationToken);
    return products.MapToProductDtoList(_mapper); 
}