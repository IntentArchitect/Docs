using Intent.DocFx.TagExtensions.MarkdownVideoTag;
using Microsoft.DocAsCode.Dfm;
using System.Collections.Generic;
using System.Composition;

namespace Intent.DocFx.TagExtensions
{
    [Export(typeof(IDfmCustomizedRendererPartProvider))]
    public class RendererPartProvider : IDfmCustomizedRendererPartProvider
    {
        public IEnumerable<IDfmCustomizedRendererPart> CreateParts(IReadOnlyDictionary<string, object> parameters)
        {
            yield return new MarkdownVideoTokenRendererPart();
        }
    }
}
