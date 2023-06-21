using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using Intent.RoslynWeaver.Attributes;
using MediatR;
using SimplifiedEShopTutorial.Domain.Entities;
using SimplifiedEShopTutorial.Domain.Repositories;

[assembly: DefaultIntentManaged(Mode.Fully)]
[assembly: IntentTemplate("Intent.Application.MediatR.CommandHandler", Version = "1.0")]

namespace SimplifiedEShopTutorial.Application.Baskets.CreateOrGetBasket
{
    [IntentManaged(Mode.Merge, Signature = Mode.Fully)]
    public class CreateOrGetBasketCommandHandler : IRequestHandler<CreateOrGetBasketCommand, BasketDto>
    {
        private readonly IBasketRepository _basketRepository;
        private readonly IMapper _mapper;

        [IntentManaged(Mode.Merge)]
        public CreateOrGetBasketCommandHandler(IBasketRepository basketRepository, IMapper mapper)
        {
            _basketRepository = basketRepository;
            _mapper = mapper;
        }

        [IntentManaged(Mode.Fully, Body = Mode.Ignore)]
        public async Task<BasketDto> Handle(CreateOrGetBasketCommand request, CancellationToken cancellationToken)
        {
            var basket = await _basketRepository.FindByIdAsync(request.Id, cancellationToken);
            if (basket == null)
            {
                basket = new Basket { Id = request.Id };
                _basketRepository.Add(basket);
            }

            return basket.MapToBasketDto(_mapper);
        }
    }
}