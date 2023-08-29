                .AddClass($"{Model.Name}", @class =>
                {
                    foreach (var attribute in model.Attributes)
                    {
                        @class.AddProperty(GetTypeName(attribute), attribute.Name.ToPascalCase());
                    }
                    foreach (var association in model.AssociatedClasses.Where(x => x.IsNavigable))
                    {
                        @class.AddProperty(GetTypeName(association), association.Name.ToPascalCase());
                    }
                });
