using Microsoft.DocAsCode.Dfm;
using Microsoft.DocAsCode.MarkdownLite;

namespace Intent.DocFx.TagExtensions.MarkdownVideoTag
{
    public class MarkdownVideoTokenRendererPart : DfmCustomizedRendererPartBase<IMarkdownRenderer, MarkdownVideoInlineToken, MarkdownInlineContext>
    {
        public override string Name => "MarkdownVideoPart";

        public override bool Match(IMarkdownRenderer renderer, MarkdownVideoInlineToken token, MarkdownInlineContext context)
        {
            return true;
        }

        public override StringBuffer Render(IMarkdownRenderer renderer, MarkdownVideoInlineToken token, MarkdownInlineContext context)
        {
            return StringBuffer.Empty
                + @"<p><video style=""max-width: 100%"" muted=""true"" loop=""true"" autoplay=""true"" src="""
                + token.VideoSrc
                + @"""></video></p>";
        }
    }
}
