//
//  CollectableAssembly.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Swinject

// MARK: - CollectableAssembly

public protocol CollectableAssembly {

    init()

    /// Method for registering your assemblies
    ///
    /// - Parameter container: Container for dependency ijection
    func assemble(inContainer container: Container)
}

extension CollectableAssembly {

    /// Container with all dependencies
    public var container: Container {
        AssembliesHolder.container
    }

    /// Wrapper for protocol's assemble method
    public func assemble() {
        assemble(inContainer: container)
    }
}
