//
//  AssembliesCollector.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Swinject
import Foundation

// MARK: - AssembliesCollector

public protocol AssembliesCollector {

    init()

    /// Collect all Application assemblies in container
    ///
    /// - Parameters:
    ///   - container: container for collection
    func collect(inContainer container: Container)
}

extension AssembliesCollector {

    /// Collect all Application assemblies
    public func collect() {
        let token = String(describing: type(of: self))
        DispatchQueue.once(token: token) {
            self.collect(inContainer: AssembliesHolder.container)
        }
    }

    // Collect all Application assemblies
    public static func collect() {
        Self().collect()
    }

    /// Collect all Application assemblies in container
    ///
    /// - Parameters:
    ///   - container: container for collection
    public static func collect(in container: Container) {
        Self().collect(inContainer: container)
    }
}
