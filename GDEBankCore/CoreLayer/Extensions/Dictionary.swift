//
//  Dictionary.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 19.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - Dictionary

extension Dictionary where Key == String {

    /// Retrieves a value from a nested dictionary structure using a key path string separated by a specified delimiter.
    ///
    /// This method allows fetching values from nested dictionaries using a key string that represents the path to the desired value.
    /// The key path is separated by a specified `separator`, which defaults to `"."`. For example, given a key path `"user.profile.name"`,
    /// the method will look up the `"name"` key inside the nested dictionaries corresponding to `"user"` and `"profile"`.
    ///
    /// - Parameters:
    ///   - key: A `String` representing the key path to the desired value. Each part of the key path should be separated by the `separator`.
    ///   - separator: A `String` used to separate the key path components. Defaults to `"."`.
    ///
    /// - Returns: The value located at the final key in the key path if it exists, or `nil` if the key path is invalid or the value does not exist.
    ///
    /// - Example:
    ///   ```swift
    ///   let dictionary: [String: Any] = [
    ///       "user": [
    ///           "profile": [
    ///               "name": "John",
    ///               "age": 30
    ///           ]
    ///       ]
    ///   ]
    ///
    ///   if let name = dictionary.data(byKey: "user.profile.name") as? String {
    ///       print(name) // Outputs "John"
    ///   }
    ///   ```
    public func data(byKey key: String, separator: String = ".") -> Any? {
        key.split(separator: separator).reduce(into: self) { value, key in
            value = (value as? [String: Any])?[String(key)]
        }
    }
}

