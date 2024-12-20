//
//  SessionStorageImplementation.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 12.08.24.
//

import Foundation
import Codex

// MARK: - SessionStorageImplementation

public final class SessionStorageImplementation {

    // MARK: - Properties

    private let defaults: UserDefaults

    // MARK: - Initializers

    public init(defaults: UserDefaults) {
        self.defaults = defaults
    }
}

// MARK: - SessionStorage

extension SessionStorageImplementation: SessionStorage {

    public func session() -> SessionPlainObject? {
        defaults.retrieve(forKey: .session)
    }

    public func save(session: SessionPlainObject) {
        do {
            defaults.setValue(try session.encoded(), forKey: .session)
            defaults.setValue(session.userID, forKey: .currentUserId)
        } catch {
           // log.error(error)
        }
    }

    public func clear() {
        defaults.removeValue(forKey: .session)
        defaults.removeValue(forKey: .passcode)
    }
}
