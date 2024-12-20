//
//  PaymentMethodType.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - PaymentMethodType

/// Enum representing the various payment methods available.
public enum PaymentMethodType: String, Codable, Equatable, CaseIterable {
    
    // MARK: - Deposit
    
    /// Represents a deposit made via IBAN transfer.
    case depositIBAN = "deposit_iban"
    
    /// Represents a deposit made using a card.
    case depositCard = "deposit_card"
    
    /// Represents a deposit made with cryptocurrency.
    case depositCrypto = "deposit_crypto"
    
    /// Represents a deposit made in cash.
    case depositCash = "deposit_cash"
    
    // MARK: - Transfer
    
    /// Represents a transfer made via IBAN.
    case transferIBAN = "transfer_iban"
    
    /// Represents a transfer made using a card.
    case transferCard = "transfer_card"
    
    /// Transfer manager cheque case
    case transferCheque = "transfer_cheque"
    
    /// Represents a transfer made with cryptocurrency.
    case transferCrypto = "transfer_crypto"
    
    /// Represents a transfer made in cash.
    case transferCash = "transfer_cash"
    
    // MARK: - Useful
    
    /// Payment type of the method
    public var type: PaymentType {
        switch self {
        case .depositIBAN, .depositCard, .depositCrypto, .depositCash:
            return .deposit
        case .transferIBAN, .transferCard, .transferCrypto, .transferCash, .transferCheque:
            return .transfer
        }
    }
}
