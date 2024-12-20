//
//  TransactionType.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - TransactionType

public enum TransactionType: String, Equatable, Codable, CaseIterable {
    
    // MARK: - Cases
    
    case exchange
    case transfer
    case payment
    case deposit
    case fee
    case depositCash = "deposit_cash"
    case transferCash = "transfer_cash"
    case cheque
    
    // MARK: - Useful
    
    public var name: String {
        switch self {
        case .exchange: CoreLocalization.TransactionType.Exchange.name
        case .transfer: CoreLocalization.TransactionType.Transfer.name
        case .payment: CoreLocalization.TransactionType.Payment.name
        case .deposit: CoreLocalization.TransactionType.Deposit.name
        case .fee: CoreLocalization.TransactionType.Fee.name
        case .depositCash: CoreLocalization.TransactionType.DepositСash.name
        case .transferCash: CoreLocalization.TransactionType.TransferСash.name
        case .cheque: CoreLocalization.TransactionType.Cheque.name
        }
    }
}

// MARK: - Randomable

extension TransactionType: Randomable {
    
    public static func random() -> TransactionType {
        allCases.randomElement().unsafelyUnwrapped
    }
}
