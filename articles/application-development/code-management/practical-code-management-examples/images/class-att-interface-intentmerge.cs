[assembly: DefaultIntentManaged(Mode.Fully)]
[assembly: IntentTemplate("Intent.Application.Dtos.DtoModel", Version = "1.0")]

namespace CodeManagementDemo.Application.Products
{
    [IntentMerge]
    [Serializable]
    public record ProductDto : IAuditable
    {
        public ProductDto()
        {
            // Additional code omitted for brevity
        }
        
        // Additional code omitted for brevity
    }
}