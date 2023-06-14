using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Intent.RoslynWeaver.Attributes;
using MediatR;
using NewApplication9.Domain.Entities;
using NewApplication9.Domain.Repositories;

[assembly: DefaultIntentManaged(Mode.Fully)]
[assembly: IntentTemplate("Intent.Application.MediatR.CommandHandler", Version = "1.0")]

namespace NewApplication9.Application.Orders.Checkout
{
    [IntentManaged(Mode.Merge, Signature = Mode.Fully)]
    public class CheckoutCommandHandler : IRequestHandler<CheckoutCommand, Guid>
    {
        private readonly IBasketRepository _basketRepository;
        private readonly IOrderRepository _orderRepository;

        [IntentManaged(Mode.Merge)]
        public CheckoutCommandHandler(IBasketRepository basketRepository, IOrderRepository orderRepository)
        {
            _basketRepository = basketRepository;
            _orderRepository = orderRepository;
        }

        [IntentManaged(Mode.Fully, Body = Mode.Ignore)]
        public async Task<Guid> Handle(CheckoutCommand request, CancellationToken cancellationToken)
        {
            var basket = await _basketRepository.FindByIdAsync(request.BasketId);
            if (basket == null)
            {
                throw new ArgumentException("Invalid basketId");
            }
            var order = new Order()
            {
                CustomerId = basket.id,
                OrderDate = DateTime.Now,
                OrderItems = basket.BasketItems.Select(CreateOrderItem).ToList(),
                Status = Domain.OrderStatus.Submitted
            };
            _orderRepository.Add(order);
            _basketRepository.Remove(basket);
            await _orderRepository.UnitOfWork.SaveChangesAsync(cancellationToken);
            return order.Id;
        }

        private OrderItem CreateOrderItem(BasketItem basketItem)
        {
            return new OrderItem()
            {
                ProductId = basketItem.ProductId,
                Quantity = basketItem.Quantity,
                UnitPrice = basketItem.UnitPrice,
            };
        }
    }
}