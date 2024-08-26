using Docfx.Plugins;
using System.Text.RegularExpressions;

namespace Intent.DocFx.TagExtensions
{
    public class MarkdownVideoTag : ITagHandler
    {
        private static readonly Regex VideoRegex = new Regex(@"\[!Video-Loop\s+([a-zA-Z0-9\:\.\\\/_\-&;]+)\s*\]", RegexOptions.Compiled);

        public string Handle(string input, ManifestItem manifestItem, string inputFile, string outputFile)
        {
            var match = VideoRegex.Match(input);
            if (match is null)
            {
                return input;
            }

            return VideoRegex.Replace(input, m => @"<p><video style=""max-width: 100%"" muted=""true"" loop=""true"" autoplay=""true"" src="""
                + m.Groups[1].Value
                + @"""></video></p>");
        }
    }
}
