using Docfx.Plugins;

namespace Intent.DocFx.TagExtensions;

public interface ITagHandler
{
    string Handle(string input, ManifestItem manifestItem, string inputFile, string outputFile);
}
