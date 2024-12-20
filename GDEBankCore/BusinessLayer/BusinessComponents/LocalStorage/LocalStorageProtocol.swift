//
//  LocalStorageProtocol.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 12.08.24.
//

import Foundation

// MARK: - LocalStorageProtocol

public protocol LocalStorageProtocol {

    // MARK: - Assosiated

    associatedtype Entity: Codable

    // MARK: - Useful

    /// Save current entity instance
    /// - Parameter entity: target instance
    func persist(_ entity: Entity)

    /// Remove everything from storage
    func clear()

    /// Returns current entity instance
    func obtain() -> Entity?
}
