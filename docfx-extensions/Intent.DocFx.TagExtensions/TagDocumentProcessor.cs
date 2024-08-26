using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using Docfx.Plugins;
using Docfx.Common;
using System.Linq;
using System.Text;
using System.Composition;
using System.IO;

namespace Intent.DocFx.TagExtensions;


[Export(nameof(TagPostProcessor), typeof(IPostProcessor))]
public class TagPostProcessor : IPostProcessor
{
    static TagPostProcessor()
    {
        //Debugger.Launch();
    }

    public List<ITagHandler> Handlers { get; } = new();

    private bool _handlerInitialized;

    public ImmutableDictionary<string, object> PrepareMetadata(ImmutableDictionary<string, object> metadata)
    {
        if (!_handlerInitialized)
        {
            Handlers.Add(new FeatherlightImageTag());
            Handlers.Add(new MarkdownVideoTag());
            _handlerInitialized = true;
        }

        return metadata;
    }

    public Manifest Process(Manifest manifest, string outputFolder)
    {
        ArgumentNullException.ThrowIfNull(manifest);
        ArgumentNullException.ThrowIfNull(outputFolder);

        foreach (var tuple in from item in manifest.Files ?? Enumerable.Empty<ManifestItem>()
                              from output in item.Output
                              where output.Key.Equals(".html", StringComparison.OrdinalIgnoreCase)
                              select new
                              {
                                  Item = item,
                                  InputFile = item.SourceRelativePath,
                                  OutputFile = output.Value.RelativePath,
                              })
        {
            if (!EnvironmentContext.FileAbstractLayer.Exists(tuple.OutputFile))
            {
                continue;
            }
            
            string input;
            string output = null;
            try
            {
                using var stream = EnvironmentContext.FileAbstractLayer.OpenRead(tuple.OutputFile);
                input = new StreamReader(stream, Encoding.UTF8).ReadToEnd();
            }
            catch (Exception ex)
            {
                Logger.LogWarning($"Warning: Can't load content from {tuple.OutputFile}: {ex.Message}");
                continue;
            }

            output = input;
            foreach (var handler in Handlers)
            {
                output = handler.Handle(output, tuple.Item, tuple.InputFile, tuple.OutputFile);
            }

            using (var stream = EnvironmentContext.FileAbstractLayer.Create(tuple.OutputFile))
            {
                var w = new StreamWriter(stream, Encoding.UTF8);
                w.Write(output);
                w.Flush();
            }
        }
        return manifest;
    }
}
