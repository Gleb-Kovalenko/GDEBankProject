//
//  KeychaingManager.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 20.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import Security
import CryptoKit

/// A manager responsible for storing, retrieving, and deleting a payment token in a shared Keychain.
public final class KeychainServiceImplementation: KeychainService {

    // MARK: - Keychain Keys

    private let payTokenKey = "com.gde-bank.pay-token"

    // MARK: - Initializers

    public init() {}

    // MARK: - Public Methods

    /// Retrieves the payment token from the Keychain.
    /// - Returns: The decrypted payment token as a `String` if it exists.
    /// - Throws: `KeychainError` if the token cannot be retrieved or decrypted.
    public func getPayKey() throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: payTokenKey,
            kSecAttrAccessGroup as String: AppConstants.Sharing.appGroupName,
            kSecReturnData as String: true
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        if status == errSecSuccess, let data = item as? Data {
            return try decrypt(data: data)
        } else if status == errSecItemNotFound {
            throw KeychainError.itemNotFound
        } else {
            throw KeychainError.unexpectedError(status)
        }
    }

    /// Deletes the payment token from the Keychain.
    /// - Throws: `KeychainError` if the token cannot be deleted.
    public func deletePayKey() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: payTokenKey,
            kSecAttrAccessGroup as String: AppConstants.Sharing.appGroupName
        ]

        let status = SecItemDelete(query as CFDictionary)

        if status != errSecSuccess && status != errSecItemNotFound {
            throw KeychainError.unexpectedError(status)
        }
    }

    /// Stores or updates the payment token in the Keychain.
    /// - Parameter token: The payment token to store.
    /// - Throws: `KeychainError` if the token cannot be stored or updated.
    public func setPayKey(_ key: String) throws {
        let encryptedData = try encrypt(string: key)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: payTokenKey,
            kSecAttrAccessGroup as String: AppConstants.Sharing.appGroupName
        ]

        let update: [String: Any] = [
            kSecValueData as String: encryptedData
        ]

        // Check if the item already exists
        let status = SecItemCopyMatching(query as CFDictionary, nil)

        if status == errSecSuccess {
            // Update existing item
            let updateStatus = SecItemUpdate(query as CFDictionary, update as CFDictionary)
            if updateStatus != errSecSuccess {
                throw KeychainError.unableToUpdateItem
            }
        } else if status == errSecItemNotFound {
            // Add new item
            var newItem = query
            newItem[kSecValueData as String] = encryptedData

            let addStatus = SecItemAdd(newItem as CFDictionary, nil)
            if addStatus != errSecSuccess {
                throw KeychainError.unableToAddItem
            }
        } else {
            throw KeychainError.unexpectedError(status)
        }
    }

    // MARK: - Encryption and Decryption

    /// Encrypts a given string using AES-GCM.
    /// - Parameter string: The string to encrypt.
    /// - Returns: The encrypted data.
    /// - Throws: An error if encryption fails.
    private func encrypt(string: String) throws -> Data {
        let data = Data(string.utf8)
        if let encryptKeyData = AppConstants.Business.encryptionKey.data(using: .utf8),
           let key = Data(base64Encoded: encryptKeyData.base64EncodedString()),
           let data = try AES.GCM.seal(data, using: SymmetricKey(data: key)).combined {
            return data
        } else {
            throw KeychainError.unexpectedError(-1)
        }
    }

    /// Decrypts a given data using AES-GCM.
    /// - Parameter data: The encrypted data.
    /// - Returns: The decrypted string.
    /// - Throws: An error if decryption fails.
    private func decrypt(data: Data) throws -> String {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        guard let encryptKeyData = AppConstants.Business.encryptionKey.data(using: .utf8),
           let key = Data(base64Encoded: encryptKeyData.base64EncodedString()) else {
            throw KeychainError.unexpectedError(-1)
        }
        let data = try AES.GCM.open(sealedBox, using: SymmetricKey(data: key))
        guard let decryptedString = String(data: data, encoding: .utf8) else {
            throw KeychainError.unexpectedError(-1)
        }
        return decryptedString
    }
}
