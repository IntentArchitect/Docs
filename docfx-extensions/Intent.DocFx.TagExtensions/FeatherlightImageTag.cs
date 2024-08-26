using Docfx.Plugins;
using System.Text.RegularExpressions;

namespace Intent.DocFx.TagExtensions
{
    internal class FeatherlightImageTag : ITagHandler
    {
        private static readonly Regex ImageRegex = new Regex(@"\[featherlight\s+([a-zA-Z0-9\:\.\\\/_\-&;]+)\s*\]", RegexOptions.Compiled);

        public string Handle(string input, ManifestItem manifestItem, string inputFile, string outputFile)
        {
            var match = ImageRegex.Match(input);
            if (match is null)
            {
                return input;
            }

            return ImageRegex.Replace(
                    input,
                    m => $@"<a href=""#"" class=""featherlight-image"" title=""View Image"" data-featherlight=""{m.Groups[1].Value}"">🔍</a>");
        }
    }
}