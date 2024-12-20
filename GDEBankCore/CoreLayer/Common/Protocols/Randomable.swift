//
//  Randomable.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 22.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - Randomable

public protocol Randomable {
    
    static func random() -> Self
    static func random<ID>(id: ID) -> Self
}

// MARK: - Default

extension Randomable {
    
    public static func random<ID>(id: ID) -> Self {
        random()
    }
}

// MARK: - Array+Randomable

extension Array where Element: Randomable {
    
    public static func random(count: Int) -> [Element] {
        (0..<count).reduce(into: [Element]()) { result, _ in
            result.append(.random())
        }
    }
}

