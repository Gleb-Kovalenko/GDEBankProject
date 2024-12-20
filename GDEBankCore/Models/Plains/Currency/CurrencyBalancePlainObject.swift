//
//  CurrencyBalancePlainObject.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 21.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - CurrencyBalancePlainObject

public struct CurrencyBalancePlainObject: Decodable, Identifiable, Equatable {
    
    // MARK: - Properties
    
    /// Plain id
    public var id: CurrencyType {
        currencyType
    }
    
    /// Currency type
    public let currencyType: CurrencyType
    
    /// Currency balance
    public let balance: Double
    
    // MARK: - Initializers
    
    public init(currencyType: CurrencyType, balance: Double) {
        self.currencyType = currencyType
        self.balance = balance
    }
}

// MARK: - Randomable

extension CurrencyBalancePlainObject: Randomable {
    
    public static func random() -> CurrencyBalancePlainObject {
        CurrencyBalancePlainObject(
            currencyType: .random(),
            balance: .random(
                in: 0..<500
            )
        )
    }
}

// MARK: - Array+Randomable

extension Array where Element == CurrencyBalancePlainObject {
    
    public static func random(count: Int) -> [CurrencyBalancePlainObject] {
        CurrencyType.allCases.reduce(into: [Element]()) { partialResult, currency in
            partialResult.append(CurrencyBalancePlainObject(
                currencyType: currency,
                balance: .random(
                    in: 0..<500
                )
            ))
        }
    }
}
