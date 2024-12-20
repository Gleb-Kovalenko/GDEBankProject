//
//  CacheCleanerImplementation.swift
//  GDEBank
//
//  Created by incetro on 10/05/2021
//  Copyright © 2021 Incetro Inc. All rights reserved.
//

import RealmSwift
import Foundation

// MARK: - CacheCleanerImplementation

public final class CacheCleanerImplementation {

    // MARK: - Properties

    /// UserDefaults instance
    private let defaults: UserDefaults

    /// Realm instance
    private let realm: Realm

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - bundle: Bundle instance
    ///   - defaults: UserDefaults instance
    ///   - realm: Realm instance
    public init(
        defaults: UserDefaults,
        realm: Realm
    ) {
        self.defaults = defaults
        self.realm = realm
    }
}

// MARK: - CacheCleaner

extension CacheCleanerImplementation: CacheCleaner {

    public func clean() {
        do {
            for item in AppConstants.UserDefaultsKeys.allCases where item.shouldRemoveOnCleaning {
                defaults.removeValue(forKey: item)
            }
            defaults.synchronize()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
//            log.error(error)
        }
    }
}
