using Microsoft.DocAsCode.MarkdownLite;

namespace Intent.DocFx.TagExtensions.FeatherlightImageTag
{
    public class FeatherlightImageInlineToken : IMarkdownToken
    {
        // The arrangement of these parameters actually matter
        public FeatherlightImageInlineToken(IMarkdownRule rule, IMarkdownContext context, string imageSrc, SourceInfo sourceInfo)
        {
            Rule = rule;
            Context = context;
            SourceInfo = sourceInfo;
            ImageSrc = imageSrc;
        }

        public IMarkdownRule Rule { get; }

        public IMarkdownContext Context { get; }

        public string ImageSrc { get; }

        public SourceInfo SourceInfo { get; }
    }
}
