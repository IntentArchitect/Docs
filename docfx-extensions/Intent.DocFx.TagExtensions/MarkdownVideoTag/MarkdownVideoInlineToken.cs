using Microsoft.DocAsCode.MarkdownLite;

namespace Intent.DocFx.TagExtensions.MarkdownVideoTag
{
    public class MarkdownVideoInlineToken : IMarkdownToken
    {
        // The arrangement of these parameters actually matter
        public MarkdownVideoInlineToken(IMarkdownRule rule, IMarkdownContext context, string videoSrc, SourceInfo sourceInfo)
        {
            Rule = rule;
            Context = context;
            SourceInfo = sourceInfo;
            VideoSrc = videoSrc;
        }

        public IMarkdownRule Rule { get; }

        public IMarkdownContext Context { get; }

        public string VideoSrc { get; }

        public SourceInfo SourceInfo { get; }
    }
}
