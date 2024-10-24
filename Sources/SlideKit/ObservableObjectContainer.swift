import SwiftUI

@MainActor
public final class ObservableObjectContainer: Sendable {

    private var container: [ObjectKey: Any] = [:]

    nonisolated public init() {}

    public func resolve<Object: ObservableObject>(_ factory: () -> Object) -> Object {
        let objectKey = ObjectKey(objectType: Object.self)
        if let object = container[objectKey] as? Object {
            return object
        }
        let object = factory()
        container[objectKey] = object
        return object
    }
}

extension ObservableObjectContainer {
    private struct ObjectKey: Hashable {
        let objectType: Any.Type

        func hash(into hasher: inout Hasher) {
            ObjectIdentifier(objectType).hash(into: &hasher)
        }

        static func == (lhs: ObjectKey, rhs: ObjectKey) -> Bool {
            lhs.objectType == rhs.objectType
        }
    }
}
