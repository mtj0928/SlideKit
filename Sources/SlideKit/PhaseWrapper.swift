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
public struct SharedObject<Observable: ObservableObject>: DynamicProperty {

    @Environment(\.observableObjectContainer)
    private var observableObjectContainer

    @ObservedObject
    private var internalPhasedStore = InternalObservableObject<Observable>()

    public init(wrappedValue factory: @autoclosure @escaping () -> Observable) {
        internalPhasedStore.observedObject = observableObjectContainer.resolve(factory)
    }

    public var wrappedValue: Observable {
        internalPhasedStore.observedObject!
    }

    public var projectedValue: Binding<Observable> {
        Binding(
            get: { internalPhasedStore.observedObject! },
            set: { internalPhasedStore.observedObject = $0 }
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
