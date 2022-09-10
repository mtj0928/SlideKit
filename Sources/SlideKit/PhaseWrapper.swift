//
//  PhaseWrapper.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import Combine
import SwiftUI

@propertyWrapper
public struct PhaseWrapper<State: PhasedState>: DynamicProperty {

    @Environment(\.observableObjectContainer)
    private var observableObjectContainer

    @ObservedObject
    private var internalPhasedStore = InternalObservableObject<PhasedStateStore<State>>()

    public init() {
        internalPhasedStore.observedObject = observableObjectContainer.resolve {
            PhasedStateStore()
        }
    }

    public var wrappedValue: PhasedStateStore<State> {
        internalPhasedStore.observedObject!
    }
}

@propertyWrapper
public struct SharedObject<Object: ObservableObject>: DynamicProperty {

    @Environment(\.observableObjectContainer)
    private var observableObjectContainer

    @ObservedObject
    private var internalObservableObject = InternalObservableObject<Object>()

    public init(wrappedValue factory: @autoclosure @escaping () -> Object) {
        internalObservableObject.observedObject = observableObjectContainer.resolve(factory)
    }

    public var wrappedValue: Object {
        internalObservableObject.observedObject!
    }

    public var projectedValue: Binding<Object> {
        Binding(
            get: { internalObservableObject.observedObject! },
            set: { internalObservableObject.observedObject = $0 }
        )
    }
}

private class InternalObservableObject<ObservedObject: ObservableObject>: ObservableObject {

    var observedObject: ObservedObject? {
        willSet {
            cancellable = newValue?.objectWillChange
                .sink(receiveValue: { [weak self] _ in
                    self?.objectWillChange.send()
                })
        }
    }

    private var cancellable: AnyCancellable?
}
