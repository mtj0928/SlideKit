//
//  PhaseWrapper.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import Combine
import SwiftUI

@propertyWrapper
@MainActor
public struct PhaseWrapper<State: PhasedState>: DynamicProperty {

    @Environment(\.slideIndexController)
    private var slideIndexController

    @ObservedObject
    private var internalPhasedStore = InternalObservableObject<PhasedStateStore<State>>()

    public init() {
    }

    public var wrappedValue: State {
        get {
            projectedValue.current
        }
        set {
            projectedValue.current = newValue
        }
    }

    public var projectedValue: PhasedStateStore<State> {
        get {
            if internalPhasedStore.observedObject == nil {
                internalPhasedStore.observedObject = slideIndexController?.phaseStateStore()
            }
            return internalPhasedStore.observedObject!
        }
        nonmutating set {
            internalPhasedStore.observedObject = newValue
        }
    }
}

@MainActor
@propertyWrapper
public struct SharedObject<Object: ObservableObject>: DynamicProperty {

    @Environment(\.observableObjectContainer)
    private var observableObjectContainer

    @ObservedObject
    private var internalObservableObject = InternalObservableObject<Object>()

    private let factory: () -> Object

    public init(wrappedValue factory: @autoclosure @escaping () -> Object) {
        self.factory = factory
    }

    public var wrappedValue: Object {
        if internalObservableObject.observedObject == nil {
            internalObservableObject.observedObject = observableObjectContainer.resolve(factory)
        }
         return internalObservableObject.observedObject!
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
