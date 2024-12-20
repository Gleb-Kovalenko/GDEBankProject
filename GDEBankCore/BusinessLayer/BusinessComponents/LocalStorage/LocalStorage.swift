//
//  LocalStorage.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 12.08.24.
//

import Foundation

// MARK: - LocalStorage

public class LocalStorage<Entity: Codable> {
    
    // MARK: - Properties

    /// UserDefaults instnace
    private let defaults: UserDefaults
    
    /// Unique key for entity
    private let key: String
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameters:
    ///  - defaults: target UserDefaults instance
    ///  - key: target key
    public init(
        defaults: UserDefaults = .standard,
        key: String
    ) {
        self.defaults = defaults
        self.key = key
    }
}

// MARK: - LocalStorage

extension LocalStorage: LocalStorageProtocol {
    
    public func persist(_ entity: Entity) {
        do {
            defaults.setValue(try entity.encoded(), forKey: key)
        } catch {
            //  log.error(error)
        }
    }
    
    public func clear() {
        defaults.removeObject(forKey: key)
    }
    
    public func obtain() -> Entity? {
        defaults.data(forKey: key).flatMap {
            try? $0.decoded() as Entity
        }
    }
}
