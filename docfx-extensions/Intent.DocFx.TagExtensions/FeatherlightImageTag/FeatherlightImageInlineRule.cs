using Microsoft.DocAsCode.MarkdownLite;
using System.Text.RegularExpressions;

namespace Intent.DocFx.TagExtensions.FeatherlightImageTag
{
    public class FeatherlightImageInlineRule : IMarkdownRule
    {
        public virtual string Name => "FeatherlightImage";

        private static readonly Regex ImageRegex = new Regex(@"^\s*\[featherlight\s+([a-zA-Z0-9\:\.\\\/_\-&;]+)\s*\]", RegexOptions.Compiled);

        public virtual IMarkdownToken TryMatch(IMarkdownParser parser, IMarkdownParsingContext context)
        {
            var match = ImageRegex.Match(context.CurrentMarkdown);
            if (match.Length == 0)
            {
                return null;
            }
            var sourceInfo = context.Consume(match.Length);
            var imageSrc = match.Groups[1].Value;
            return new FeatherlightImageInlineToken(this, parser.Context, imageSrc, sourceInfo);
        }
    }
}
