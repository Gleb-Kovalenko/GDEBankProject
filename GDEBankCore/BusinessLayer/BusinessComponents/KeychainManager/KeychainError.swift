//
//  KeychainError.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 20.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Security

// MARK: - Keychain Errors

/// Errors that can occur when interacting with the Keychain.
public enum KeychainError: Error, Equatable {
    
    // MARK: - Cases
    
    case itemNotFound
    case unableToAddItem
    case unableToUpdateItem
    case unexpectedError(OSStatus)
}
