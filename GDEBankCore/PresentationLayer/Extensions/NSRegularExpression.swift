//
//  NSRegularExpression.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import Foundation

// MARK: - NSRegularExpression

public extension NSRegularExpression {

    /// Convenient initializer for regular expressions
    /// - Parameter pattern: regex string
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }

    /// Checks if the given string matches current regular expression
    /// - Parameter string: some string to check
    /// - Returns: true if the given string matches current regular expression
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
