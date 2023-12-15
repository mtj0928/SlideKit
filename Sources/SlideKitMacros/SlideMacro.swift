import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct SlideMacro: ExtensionMacro, MemberMacro {

    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        try [
            ExtensionDeclSyntax(
                """
                extension \(type): Slide {}
                """
            )
        ]
    }

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let variables = declaration.memberBlock.members.map(\.decl).compactMap { $0.as(VariableDeclSyntax.self) }
        let phasedVariables: [(name: String, type: String)] = variables.compactMap { variable -> (name: String, type: String)? in
            guard hasPhase(variable),
                let name = extractVariableName(variable),
                  let type = extractTypeName(variable)
            else { return nil }
            return (name: name, type: type)
        }
        if phasedVariables.isEmpty {
            return [
                "public typealias SlidePhasedState = SimplePhasedState"
            ]
        }
        else if phasedVariables.count == 1 {
            let type = phasedVariables[0].type
            let name = phasedVariables[0].name
            return [
                type != "SlidePhasedState" ? "public typealias SlidePhasedState = \(raw: type)" : nil,
                "public typealias Phase = PhaseWrapper",
                """
                @Environment(\\.observableObjectContainer) private var container
                """,
                """
                func phase(_ phase: \(raw: type)) -> Self {
                    let store: PhasedStateStore<\(raw: type)> = container.resolve {
                        PhasedStateStore(phase)
                    }
                    store.current = phase
                    return self
                }
                """,
                """
                func phasesStateSore(_ phasedStateStore: PhasedStateStore<SlidePhasedState>) {
                    $\(raw: name) = phasedStateStore
                }
                """
            ].compactMap { $0 }
        }
        else {
            context.addDiagnostics(from: SlideError("There are two or more @Phase"), node: declaration)
            return []
        }
    }

    private static func hasPhase(_ variable: VariableDeclSyntax) -> Bool {
        variable.attributes
            .compactMap({ $0.as(AttributeSyntax.self) })
            .map(\.attributeName)
            .compactMap({ $0.as(IdentifierTypeSyntax.self) })
            .map(\.name.text)
            .contains(where: { name in
                name == "Phase"
            })
    }

    private static func extractTypeName(_ variable: VariableDeclSyntax) -> String? {
        variable.bindings
            .first?
            .typeAnnotation?
            .type.as(IdentifierTypeSyntax.self)?
            .name
            .text
    }

    private static func extractVariableName(_ variable: VariableDeclSyntax) -> String? {
        variable.bindings
            .first?
            .pattern.as(IdentifierPatternSyntax.self)?
            .identifier
            .text
    }
}

struct SlideError: CustomStringConvertible, Error {
    let description: String

    init(_ description: String) {
        self.description = description
    }
}
