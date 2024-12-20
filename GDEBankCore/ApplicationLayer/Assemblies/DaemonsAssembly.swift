//
//  DaemonsAssembly.swift
//  GDEBank
//
//  Created by incetro on 10/05/2021
//  Copyright © 2021 Incetro Inc. All rights reserved.
//
// swiftlint:disable unused_closure_parameter

import Foundation
import Swinject

// MARK: - DaemonsAssembly

public final class DaemonsAssembly: CollectableAssembly {

    public required init() {
    }

    public func assemble(inContainer container: Container) {

        container.register(ForceUpdateDaemon.self) { resolver in
            let bundle = resolver.resolve(Bundle.self).unsafelyUnwrapped
            return ForceUpdateDaemon(bundle: bundle)
        }

        container.register([Daemon].self) { resolver in
            [
                resolver.resolve(ForceUpdateDaemon.self).unsafelyUnwrapped
            ]
        }
    }
}
