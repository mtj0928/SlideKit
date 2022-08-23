//
//  Phase.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/23.
//

import Combine
import SwiftUI

@propertyWrapper
public struct Phase<State: PhasedState>: DynamicProperty {

    @Environment(\.observableObjectContainer)
    private var observableObjectContainer

    @ObservedObject
    private var internalPhasedStore = InternalObserservableObject<PhasedStateStore<State>>()

    public init() {
        internalPhasedStore.observedObject = observableObjectContainer.resolve { .init() }
    }

    public var wrappedValue: State {
        internalPhasedStore.observedObject!.curreent
    }

    public var projectedValue: PhasedStateStore<State> {
        internalPhasedStore.observedObject!
    }
}

private class InternalObserservableObject<ObservedObject: ObservableObject>: ObservableObject {

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
