using System;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using Intent.RoslynWeaver.Attributes;
using MediatR;
using NewApplication9.Domain.Entities;
using NewApplication9.Domain.Repositories;

[assembly: DefaultIntentManaged(Mode.Fully)]
[assembly: IntentTemplate("Intent.Application.MediatR.CommandHandler", Version = "1.0")]

namespace NewApplication9.Application.Baskets.GetBasketById
{
    [IntentManaged(Mode.Merge, Signature = Mode.Fully)]
    public class GetBasketByIdHandler : IRequestHandler<GetBasketById, BasketDto>
    {
        private readonly IBasketRepository _basketRepository;
        private readonly IMapper _mapper;

        [IntentManaged(Mode.Merge)]
        public GetBasketByIdHandler(IMapper mapper, IBasketRepository basketRepository)
        {
            _basketRepository = basketRepository;
            _mapper = mapper;
        }

        [IntentManaged(Mode.Fully, Body = Mode.Ignore)]
        public async Task<BasketDto> Handle(GetBasketById request, CancellationToken cancellationToken)
        {
            var basket = await _basketRepository.FindByIdAsync(request.Id);
            if (basket == null)
            {
                basket = new Basket() { Id = request.Id };
                _basketRepository.Add(basket);
            }
            return basket.MapToBasketDto(_mapper);
        }
    }
}