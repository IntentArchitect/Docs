using Microsoft.DocAsCode.MarkdownLite;
using System.Text.RegularExpressions;

namespace Intent.DocFx.TagExtensions.MarkdownVideoTag
{
    public class MarkdownVideoInlineRule : IMarkdownRule
    {
        public virtual string Name => "MarkdownVideo";

        private static readonly Regex VideoRegex = new Regex(@"^\s*\[!Video-Loop\s+([a-zA-Z0-9\:\.\\\/_\-&;]+)\s*\]", RegexOptions.Compiled);

        public virtual IMarkdownToken TryMatch(IMarkdownParser parser, IMarkdownParsingContext context)
        {
            var match = VideoRegex.Match(context.CurrentMarkdown);
            if (match.Length == 0)
            {
                return null;
            }
            var sourceInfo = context.Consume(match.Length);
            var videoSrc = match.Groups[1].Value;
            return new MarkdownVideoInlineToken(this, parser.Context, videoSrc, sourceInfo);
        }
    }
}
