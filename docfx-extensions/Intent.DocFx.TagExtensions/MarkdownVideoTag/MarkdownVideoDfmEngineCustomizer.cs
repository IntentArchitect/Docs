using Microsoft.DocAsCode.Dfm;
using Microsoft.DocAsCode.MarkdownLite;
using System.Collections.Generic;
using System.Composition;

namespace Intent.DocFx.TagExtensions.MarkdownVideoTag
{
    [Export(typeof(IDfmEngineCustomizer))]
    public class MarkdownVideoDfmEngineCustomizer : IDfmEngineCustomizer
    {
        public void Customize(DfmEngineBuilder builder, IReadOnlyDictionary<string, object> parameters)
        {
            // This seems fine for in-line rules.
            builder.InlineRules = builder.InlineRules.Insert(0, new MarkdownVideoInlineRule());
        }
    }
}
