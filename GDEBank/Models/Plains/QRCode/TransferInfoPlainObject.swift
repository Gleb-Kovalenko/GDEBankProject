//
//  TransferInfoPlainObject.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import GDEBankCore

// MARK: - TransferInfoPlainObject

public struct TransferInfoPlainObject: Equatable {
    
    // MARK: - Properties
    
    /// Transfer user email
    public let email: String
    
    /// Transfer wallet
    public let wallet: CurrencyType?
    
    /// Transfer amount
    public let amount: Double?
}

// MARK: - Initializers

extension TransferInfoPlainObject: Codable {
    
    // MARK: - CodingKeys
    
    public enum CodingKeys: String, CodingKey {
        
        // MARK: - Cases
        
        case email
        case wallet
        case amount
    }
    
    // MARK: - Initializers
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try container.decode(String.self, forKey: .email)
        let walletString = try container.decode(String.self, forKey: .wallet)
        if walletString == "any" {
            self.amount = nil
        } else {
            self.amount = try container.decode(Double.self, forKey: .amount)
        }
        self.wallet = CurrencyType(rawValue: walletString.lowercased())
    }
}

// MARK: - Randomable

extension TransferInfoPlainObject: Randomable {
    
    public static func random() -> TransferInfoPlainObject {
        TransferInfoPlainObject(
            email: .randomEmail(),
            wallet: .random(),
            amount: .randomAmount()
        )
    }
}
