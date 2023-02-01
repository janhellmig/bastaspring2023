using Microsoft.CodeAnalysis;

namespace Basta2023;

[Generator]
public class HelloGenerator : ISourceGenerator
{
    public void Execute(GeneratorExecutionContext context)
    {
        string source = """
            namespace Basta2023;
            
            public static class HelloWorld
            {
                public static string SayHello() => "Hello BASTA!";
            }
            """;
        context.AddSource("helloworld.g.cs", source);
    }

    public void Initialize(GeneratorInitializationContext context)
    {

    }
}
