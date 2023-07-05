using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using Intent.RoslynWeaver.Attributes;
using MediatR;
using SimplifiedEShopTutorial.Domain.Repositories;

[assembly: DefaultIntentManaged(Mode.Fully)]
[assembly: IntentTemplate("Intent.Application.MediatR.QueryHandler", Version = "1.0")]

namespace SimplifiedEShopTutorial.Application.Orders.GetMyOrders
{
    [IntentManaged(Mode.Merge, Signature = Mode.Fully)]
    public class GetMyOrdersQueryHandler : IRequestHandler<GetMyOrdersQuery, List<OrderDto>>
    {
        private readonly IOrderRepository _orderRepository;
        private readonly IMapper _mapper;

        [IntentManaged(Mode.Ignore)]
        public GetMyOrdersQueryHandler(IOrderRepository orderRepository, IMapper mapper)
        {
            _orderRepository = orderRepository;
            _mapper = mapper;
        }

        [IntentManaged(Mode.Fully, Body = Mode.Ignore)]
        public async Task<List<OrderDto>> Handle(GetMyOrdersQuery request, CancellationToken cancellationToken)
        {
            var orders = await _orderRepository.FindAllAsync(order => order.CustomerId == request.CustomerId, cancellationToken);
            return orders.MapToOrderDtoList(_mapper);
        }
    }
}