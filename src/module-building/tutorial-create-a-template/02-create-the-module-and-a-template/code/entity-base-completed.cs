...

namespace MyModules.Templates.EntityBase
{
    [IntentManaged(Mode.Fully, Body = Mode.Merge)]
    public partial class EntityBaseTemplate : CSharpTemplateBase<object>, ICSharpFileBuilderTemplate
    {
        public const string TemplateId = "MyModules.Entities.EntityBase";

        [IntentManaged(Mode.Fully, Body = Mode.Ignore)]
        public EntityBaseTemplate(IOutputTarget outputTarget, object model = null) : base(TemplateId, outputTarget, model)
        {
            CSharpFile = new CSharpFile(this.GetNamespace(), this.GetFolderPath())
                .AddUsing("System")
                .AddClass($"EntityBase", @class =>
                {
                    @class.AddProperty("DateTime", "CreatedDate");
                    @class.AddProperty("string", "CreatedBy");
                    @class.AddProperty("DateTime", "UpdatedDate");
                    @class.AddProperty("string", "UpdatedBy");
                });
        }
        ...
    }
}