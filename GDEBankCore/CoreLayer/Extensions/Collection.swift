//
//  Collection.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 16.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - Collection

extension Collection where Self: RangeReplaceableCollection {
    
    public mutating func removeAll(after predicate: (Element) throws -> Bool) rethrows {
        guard let index = try firstIndex(where: predicate) else { return }
        let nextIndex = self.index(after: index)
        removeSubrange(nextIndex..<endIndex)
    }
}
