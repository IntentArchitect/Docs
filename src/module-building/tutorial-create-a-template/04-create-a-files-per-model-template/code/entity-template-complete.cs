using System;
using System.Linq;
using System.Collections.Generic;
using Intent.Engine;
using Intent.Modelers.Domain.Api;
using Intent.Modules.Common;
using Intent.Modules.Common.CSharp.Builder;
using Intent.Modules.Common.CSharp.Templates;
using Intent.Modules.Common.Templates;
using Intent.RoslynWeaver.Attributes;
using Intent.Templates;

[assembly: DefaultIntentManaged(Mode.Fully)]
[assembly: IntentTemplate("Intent.ModuleBuilder.CSharp.Templates.CSharpTemplatePartial", Version = "1.0")]

namespace MyModules.Templates.Entity
{
    [IntentManaged(Mode.Fully, Body = Mode.Merge)]
    public partial class EntityTemplate : CSharpTemplateBase<ClassModel>, ICSharpFileBuilderTemplate
    {
        public const string TemplateId = "MyModules.Entities.Entity";

        [IntentManaged(Mode.Fully, Body = Mode.Ignore)]
        public EntityTemplate(IOutputTarget outputTarget, ClassModel model) : base(TemplateId, outputTarget, model)
        {
            CSharpFile = new CSharpFile(this.GetNamespace(), this.GetFolderPath())
                .AddClass($"{Model.Name}", @class =>
                {
                    @class.WithBaseType(this.GetEntityBaseName());                    
                    foreach (var attribute in model.Attributes)
                    {
                        @class.AddProperty(GetTypeName(attribute), attribute.Name.ToPascalCase());
                    }
                    foreach (var association in model.AssociatedClasses.Where(x => x.IsNavigable))
                    {
                        @class.AddProperty(GetTypeName(association), association.Name.ToPascalCase());
                    }
                });
        }

        [IntentManaged(Mode.Fully)]
        public CSharpFile CSharpFile { get; }

        [IntentManaged(Mode.Fully)]
        protected override CSharpFileConfig DefineFileConfig()
        {
            return CSharpFile.GetConfig();
        }

        [IntentManaged(Mode.Fully)]
        public override string TransformText()
        {
            return CSharpFile.ToString();
        }
    }
}