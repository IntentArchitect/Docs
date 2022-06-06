using Microsoft.DocAsCode.Dfm;
using Microsoft.DocAsCode.MarkdownLite;

namespace Intent.DocFx.TagExtensions.FeatherlightImageTag
{
    public class FeatherlightImageTokenRendererPart : DfmCustomizedRendererPartBase<IMarkdownRenderer,
        FeatherlightImageInlineToken, MarkdownInlineContext>
    {
        public override string Name => "FeatherlightImagePart";

        public override bool Match(IMarkdownRenderer renderer, FeatherlightImageInlineToken token,
            MarkdownInlineContext context)
        {
            return true;
        }

        public override StringBuffer Render(IMarkdownRenderer renderer, FeatherlightImageInlineToken token,
            MarkdownInlineContext context)
        {
            return StringBuffer.Empty +
                   $@"<a href=""#"" class=""featherlight-image"" title=""View Image"" data-featherlight=""{token.ImageSrc}"">🔍</a>";
        }
    }
}