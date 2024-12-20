//
//  PayProfilePlainObject.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 21.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import GDEBankCore
import Foundation

// MARK: - PayProfilePlainObject

public struct PayProfilePlainObject: Equatable {
    
    // MARK: - Properties
    
    /// Balances
    public let balances: [CurrencyBalancePlainObject]
}

// MARK: - Decodable

extension PayProfilePlainObject: Decodable {
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        // MARK: - Cases
        
        case balances
    }
    
    // MARK: - Initializers
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let balancesDict = try container.decode([String: Double].self, forKey: .balances)
        self.balances = balancesDict.compactMap { key, value in
            guard let currency = CurrencyType(rawValue: key.lowercased()) else {
                return nil
            }
            return CurrencyBalancePlainObject(currencyType: currency, balance: value)
        }.sorted(by: { $0.id.order < $1.id.order })
    }
}

// MARK: - Randomable

extension PayProfilePlainObject: Randomable {
    
    public static func random() -> PayProfilePlainObject {
        PayProfilePlainObject(
            balances: .random(count: 10)
        )
    }
}
