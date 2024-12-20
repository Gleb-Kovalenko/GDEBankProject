//
//  SessionStorage.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 12.08.24.
//

import Foundation

// MARK: - SessionStorage

public protocol SessionStorage {

    /// Returns current user session
    func session() -> SessionPlainObject?

    /// Save current user session
    /// - Parameter session: current session
    func save(session: SessionPlainObject)

    /// Remove everything from storage
    func clear()
}

extension SessionStorage {
    
    public var isAuthorized: Bool {
        session()?.accessToken != nil
    }
}
