//
//  ShareSheetState.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 06.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - ShareSheetState

public struct ShareSheetState<Action>: Identifiable {
    
    // MARK: - Properties
    
    /// Share sheet state id
    public let id: UUID
    
    /// Share sheet activity items
    public let activityItems: [Any]
    
    // MARK: - Initializer
    
    /// Default initializer
    public init(
        id: UUID = UUID(),
        activityItems: [Any]
    ) {
        self.id = id
        self.activityItems = activityItems
    }
    
    /// Default initializer
    public init(
        id: UUID = UUID(),
        activityItem: Any
    ) {
        self.id = id
        self.activityItems = [activityItem]
    }
}

// MARK: - Equtable

extension ShareSheetState: Equatable {
    
    public static func ==(lhs: ShareSheetState<Action>, rhs: ShareSheetState<Action>) -> Bool {
        
        guard lhs.activityItems.count == rhs.activityItems.count else { return false }
        
        return zip(lhs.activityItems, rhs.activityItems).allSatisfy { (lhsItem, rhsItem) in
            func compareEquatable<L: Equatable, R: Equatable>(_ l: L, _ r: R) -> Bool? {
                if let rAsL = r as? L {
                    return l == rAsL
                }
                return nil
            }
            if let lhsAsEquatable = lhsItem as? (any Equatable), let rhsAsEquatable = rhsItem as? (any Equatable) {
                return compareEquatable(lhsAsEquatable, rhsAsEquatable) ?? false
            } else {
                return true
            }
        }
    }
}

// MARK: - Hashable

extension ShareSheetState: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        
        for item in activityItems {
            if let equatableItem = item as? (any Equatable) {
                let typeDescriptor = String(reflecting: type(of: equatableItem))
                hasher.combine("\(equatableItem)")
                hasher.combine(typeDescriptor)
            }
        }
    }
}

