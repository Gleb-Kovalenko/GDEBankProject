//
//  KeychainService.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 20.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

/// A manager responsible for storing, retrieving, and deleting a payment token in a shared Keychain.
public protocol KeychainService {
    
    /// Retrieves the payment token from the Keychain.
    /// - Returns: The decrypted payment token as a `String` if it exists.
    /// - Throws: `KeychainError` if the token cannot be retrieved or decrypted.
    func getPayKey() throws -> String

    /// Deletes the payment token from the Keychain.
    /// - Throws: `KeychainError` if the token cannot be deleted.
    func deletePayKey() throws

    /// Stores or updates the payment token in the Keychain.
    /// - Parameter key: The payment token to store.
    /// - Throws: `KeychainError` if the token cannot be stored or updated.
    func setPayKey(_ key: String) throws
}
