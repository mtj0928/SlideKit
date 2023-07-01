import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SlideKitMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        SlideMacro.self
    ]
}
