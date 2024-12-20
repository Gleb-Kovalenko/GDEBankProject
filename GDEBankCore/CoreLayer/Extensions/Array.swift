//
//  Array.swift
//  GDEBank
//
//  Created by incetro on 11/18/23.
//

import Foundation

// MARK: - Array

public extension Array {
    
    /// Returns a new array with the first elements up to specified distance
    /// being shifted to the end of the collection.
    ///
    /// If the distance is negative, returns a new array with the last elements
    /// up to the specified absolute distance being shifted to the beginning of the collection.
    ///
    /// If the absolute distance exceeds the number of elements in the array,
    /// the elements are not shifted.
    ///
    /// - Parameter distance: shifting distance
    /// - Returns: new shifted array
    func shifted(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 
            ? self.index(startIndex, offsetBy: distance, limitedBy: endIndex)
            : self.index(endIndex, offsetBy: distance, limitedBy: startIndex)
        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }

    /// Returns the first element of the array where the value of the specified property equals the given value.
    ///
    /// - Parameters:
    ///   - keyPath: The key path of the property to compare.
    ///   - value: The value to compare the property against.
    /// - Returns: The first element where the property matches the given value, or `nil` if no match is found.
    func first<T: Equatable>(where keyPath: KeyPath<Element, T>, equalTo value: T) -> Element? {
        first { $0[keyPath: keyPath] == value }
    }
    
    func filter(not: KeyPath<Element, Bool>) -> Array<Element> {
        filter { !$0[keyPath: not] }
    }

    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

// MARK: - Array+Equatable

extension Array where Element: Equatable {
    
    public mutating func remove(_ element: Element) {
        removeAll(where: { $0 == element })
    }
}
