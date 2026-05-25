[IntentManaged(Mode.Fully, Body = Mode.Fully)]
public async Task<List<ProductDto>> Handle(GetProductsQuery request, CancellationToken cancellationToken)
{
    // IntentIgnore(Match="var products = ")
    var products = await _productRepository.FindAllActive(cancellationToken);
    return products.MapToProductDtoList(_mapper);
}