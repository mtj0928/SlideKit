import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct SlidePageMacro: ConformanceMacro, MemberMacro {
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
            let type = "SimplePhasedState"
            return [
                "@Phase private var _phase: \(raw: type)",
                "public var _phaseStore: PhasedStateStore<\(raw: type)> { $_phase }",
                type != "SlidePhasedState" ? "public typealias SlidePhasedState = \(raw: type)" : nil
            ].compactMap { $0 }
        }
        else if phasedVariables.count == 1 {
            let type = phasedVariables[0].type
            let name = phasedVariables[0].name
            return [
                "public var _phaseStore: PhasedStateStore<\(raw: type)> { $\(raw: name) }",
                type != "SlidePhasedState" ? "public typealias SlidePhasedState = \(raw: type)" : nil,
                """
                func phase(_ phase: \(raw: type)) -> Self {
                    $\(raw: name).current = phase
                    return self
                }
                """
            ].compactMap { $0 }
        }
        else {
            context.addDiagnostics(from: SlidePageError("There are two or more @Phase"), node: declaration)
            return []
        }
    }

    private static func hasPhase(_ variable: VariableDeclSyntax) -> Bool {
        let attributes = variable.attributes
        return attributes?
            .compactMap({ $0.as(AttributeSyntax.self) })
            .map(\.attributeName)
            .compactMap({ $0.as(SimpleTypeIdentifierSyntax.self) })
            .map(\.name.text)
            .contains(where: { name in
                name == "Phase"
            })
        ?? false
    }

    private static func extractTypeName(_ variable: VariableDeclSyntax) -> String? {
        variable.bindings
            .first?
            .typeAnnotation?
            .type.as(SimpleTypeIdentifierSyntax.self)?
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


    public static func expansion(
        of node: AttributeSyntax,
        providingConformancesOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [(TypeSyntax, GenericWhereClauseSyntax?)] {
        [
            ("Slide", nil)
        ]
    }
}

struct SlidePageError: CustomStringConvertible, Error {
    let description: String

    init(_ description: String) {
        self.description = description
    }
}
