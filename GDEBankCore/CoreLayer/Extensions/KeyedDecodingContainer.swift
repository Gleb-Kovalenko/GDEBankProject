//
//  KeyedDecodingContainer.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - KeyedDecodingContainer

/// Extension to `KeyedDecodingContainer` to add a helper method for decoding `String` values and converting them to `Int`.
/// If the value is already an `Int`, it will return the value directly.
extension KeyedDecodingContainer {
    
    /// Decodes a value as either a `String` or `Int` and attempts to convert `String` values to `Int`.
    /// - Parameter key: The key to decode the value for.
    /// - Returns: The decoded `Int` value.
    /// - Throws: Throws an error if the value cannot be decoded as either a string or integer, or if the string cannot be converted to an integer.
    public func decodeStringToDouble(forKey key: KeyedDecodingContainer<K>.Key) throws -> Double {
        if let stringValue = try? self.decode(String.self, forKey: key),
           let doubleValue = Double(stringValue) {
            return doubleValue
        } else if let doubleValue = try? self.decode(Double.self, forKey: key) {
            return doubleValue
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "The value could not be decoded as a string or number."
            )
        }
    }
    
    /// Decodes a value as either a `String` or `Int` and attempts to convert `String` values to `Int`.
    /// - Parameter key: The key to decode the value for.
    /// - Returns: The decoded `Int` value.
    /// - Throws: Throws an error if the value cannot be decoded as either a string or integer, or if the string cannot be converted to an integer.
    public func decodeIfPresentStringToDouble(forKey key: KeyedDecodingContainer<K>.Key) throws -> Double? {
        if let stringValue = try? self.decodeIfPresent(String.self, forKey: key),
           let doubleValue = Double(stringValue) {
            return doubleValue
        } else {
            return try? self.decodeIfPresent(Double.self, forKey: key)
        }
    }
    
    public func decodeStringToInt(forKey key: KeyedDecodingContainer<K>.Key) throws -> Int {
        if let stringValue = try? self.decode(String.self, forKey: key),
           let intValue = Int(stringValue) {
            return intValue
        } else if let intValue = try? self.decode(Int.self, forKey: key) {
            return intValue
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "The value could not be decoded as a string or number."
            )
        }
    }
}
