//
//  TransactionCheckType.swift
//  DaxilCore
//
//  Created by Gleb Kovalenko on 18.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - TransactionCheckType

/// Represents types of transaction checks with their navigation titles.
public enum TransactionCheckType: String, CaseIterable, Codable, Equatable {
    
    // MARK: - Cases
    
    case depositCard = "deposit_card"
    case transferCrypto = "transfer_crypto"
    case transferIban = "transfer_iban"
    case paymentCard = "payment_card"
    case transferCard = "transfer_card"
    case conversion = "conversion"
    case fee = "fee"
    case depositCrypto = "deposit_crypto"
    case depositPay = "deposit_pay"
    case transferPay = "transfer_pay"
    case depositIban = "deposit_iban"
    case depositCash = "deposit_cash"
    case transferCash = "transfer_cash"
    case cheque = "cheque"
    
    // MARK: - Properties
    
    /// Returns the localized navigation title for each transaction type.
    public var navigationTitle: String {
        switch self {
        case .depositCard:
            return L10n.TransactionCheck.DepositCard.navigationTitle
        case .transferCrypto:
            return L10n.TransactionCheck.TransferCrypto.navigationTitle
        case .transferIban:
            return L10n.TransactionCheck.TransferIban.navigationTitle
        case .paymentCard:
            return L10n.TransactionCheck.PaymentCard.navigationTitle
        case .transferCard:
            return L10n.TransactionCheck.TransferCard.navigationTitle
        case .conversion:
            return L10n.TransactionCheck.Conversion.navigationTitle
        case .fee:
            return L10n.TransactionCheck.Fee.navigationTitle
        case .depositCrypto:
            return L10n.TransactionCheck.DepositCrypto.navigationTitle
        case .depositPay:
            return L10n.TransactionCheck.DepositPay.navigationTitle
        case .transferPay:
            return L10n.TransactionCheck.TransferPay.navigationTitle
        case .depositIban:
            return L10n.TransactionCheck.DepositIban.navigationTitle
        case .depositCash:
            return L10n.TransactionCheck.DepositCash.navigationTitle
        case .transferCash:
            return L10n.TransactionCheck.TransferCash.navigationTitle
        case .cheque:
            return L10n.TransactionCheck.Cheque.navigationTitle
        }
    }
    
    public var titleImageName: String {
        switch self {
        case .depositCard:
            return CoreAssets.cardSend.name
        case .transferCrypto:
            return CoreAssets.bitcoin.name
        case .transferIban:
            return CoreAssets.euro.name
        case .paymentCard:
            return CoreAssets.arrowFatLineRight.name
        case .transferCard:
            return CoreAssets.arrowFatLineRight.name
        case .conversion:
            return CoreAssets.transferHorizontal.name
        case .fee:
            return CoreAssets.commission.name
        case .depositCrypto:
            return CoreAssets.bitcoin.name
        case .depositPay:
            return CoreAssets.arrowFatLineRight.name
        case .transferPay:
            return CoreAssets.arrowFatLineRight.name
        case .depositIban:
            return CoreAssets.euro.name
        case .depositCash:
            return CoreAssets.moneyPlus.name
        case .transferCash:
            return CoreAssets.moneyMinus.name
        case .cheque:
            return CoreAssets.receipt.name
        }
    }
}

// MARK: - Randomable

extension TransactionCheckType: Randomable {
    
    public static func random() -> TransactionCheckType {
        allCases.randomElement().unsafelyUnwrapped
    }
}
