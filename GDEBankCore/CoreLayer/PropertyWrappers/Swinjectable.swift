//
//  Swinjectable.swift
//  GDEBank
//
//  Created by incetro on 2/9/23.
//

import Swinject

// MARK: - Swinjectable

@propertyWrapper
public struct Swinjectable<T> {

    // MARK: - Properties

    public let wrappedValue: T
    public let container: Container
    
    // MARK: - Initializers

    public init(container: Container = AssembliesHolder.container) {
        self.wrappedValue = container.resolve(T.self).unsafelyUnwrapped
        self.container = container
    }
}

func resolve<T>() -> T {
    AssembliesHolder.container.resolve(T.self).unsafelyUnwrapped
}
