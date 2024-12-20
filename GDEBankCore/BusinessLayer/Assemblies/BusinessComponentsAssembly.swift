//
//  BusinessComponentsAssembly.swift
//  GDEBank
//
//  Created by incetro on 10/05/2021
//  Copyright © 2021 Incetro Inc. All rights reserved.
//
// swiftlint:disable closure_parameter_position

import SDAO
import Monreau
import Swinject
import RealmSwift
import Foundation

// MARK: - BusinessComponentsAssembly

public final class BusinessComponentsAssembly: CollectableAssembly {

    public required init() {
    }

    public func assemble(inContainer container: Container) {

        container.register(SessionStorage.self) { resolver in
            let defaults = resolver.resolve(UserDefaults.self).unsafelyUnwrapped
            return SessionStorageImplementation(defaults: defaults)
        }.inObjectScope(.container)
        
        container.register(CacheCleaner.self) { resolver in
            let defaults = resolver.resolve(UserDefaults.self).unsafelyUnwrapped
            let realm = resolver.resolve(Realm.self).unsafelyUnwrapped
            return CacheCleanerImplementation(
                defaults: defaults,
                realm: realm
            )
        }
    }
}
