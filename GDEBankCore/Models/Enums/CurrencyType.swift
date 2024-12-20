//
//  CurrencyType.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 21.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - CurrencyType

public enum CurrencyType: String, Equatable, CaseIterable {
    
    // MARK: - Group
    
    public enum Group: String, Equatable, Codable, CaseIterable, Identifiable {
        
        // MARK: - Cases
        
        case fiat
        case crypto
        
        // MARK: - Identifiable
        
        /// Identifier of the currency group
        public var id: String {
            rawValue
        }
        
        /// Target title for account
        public var accountTitle: String {
            switch self {
            case .crypto:
                return L10n.Currency.Group.Crypto.title
            case .fiat:
                return L10n.Currency.Group.Fiat.title
            }
        }
    }
    
    // MARK: - Fiat
    
    case usd
    case eur
    case gbp
    case aed
    case `try`
    case gel
    
    // MARK: - Crypto
    
    case usdt
    case trx
    case ton
    case eth
    case btc
    
    // MARK: - Useful
    
    /// Currency short name
    public var shortName: String {
        rawValue.uppercased()
    }
    
    /// Currency wallet name
    public var walletName: String {
        switch self {
        case .usdt:
            return "USDT TRC-20"
        default:
            return shortName
        }
    }
    
    public var order: Int {
        CurrencyType.allCases.firstIndex(of: self) ?? 0
    }
    
    /// Currency wallet description
    public var walletDescription: String {
        switch self {
        case .usd:
            return L10n.Currency.Usd.walletDescription
        case .eur:
            return L10n.Currency.Eur.walletDescription
        case .gbp:
            return L10n.Currency.Gbp.walletDescription
        case .aed:
            return L10n.Currency.Aed.walletDescription
        case .gel:
            return L10n.Currency.Gel.walletDescription
        case .try:
            return L10n.Currency.Try.walletDescription
        case .usdt:
            return L10n.Currency.Usdt.walletDescription
        case .trx:
            return L10n.Currency.Trx.walletDescription
        case .ton:
            return L10n.Currency.Ton.walletDescription
        case .eth:
            return L10n.Currency.Eth.walletDescription
        case .btc:
            return L10n.Currency.Btc.walletDescription
        }
    }
    
    /// Currency account title
    public var accountTitle: String {
        switch self {
        case .usd:
            return L10n.Currency.Usd.accountTitle
        case .eur:
            return L10n.Currency.Eur.accountTitle
        case .gbp:
            return L10n.Currency.Gbp.accountTitle
        case .aed:
            return L10n.Currency.Aed.accountTitle
        case .gel:
            return L10n.Currency.Gel.accountTitle
        case .try:
            return L10n.Currency.Try.accountTitle
        case .usdt:
            return L10n.Currency.Usdt.accountTitle
        case .trx:
            return L10n.Currency.Trx.accountTitle
        case .ton:
            return L10n.Currency.Ton.accountTitle
        case .eth:
            return L10n.Currency.Eth.accountTitle
        case .btc:
            return L10n.Currency.Btc.accountTitle
        }
    }
    
    /// Currency circled image name
    public var cirleImageName: String {
        "\(rawValue.lowercased())-circle"
    }
    
    /// Currency symbol
    public var currencySymbol: String? {
        switch self {
        case .usd:
            return "$"
        case .eur:
            return "€"
        case .gbp:
            return "£"
        case .aed:
            return "د.إ"
        case .try:
            return "₺"
        case .gel:
            return "₾"
        case .usdt, .trx, .ton, .eth, .btc:
            return nil
        }
    }
    
    /// Localized name of the currency
    public var localizedName: String {
        switch self {
        case .usd:
            return L10n.Currency.Usd.localizedName
        case .eur:
            return L10n.Currency.Eur.localizedName
        case .gbp:
            return L10n.Currency.Gbp.localizedName
        case .aed:
            return L10n.Currency.Aed.localizedName
        case .try:
            return L10n.Currency.Try.localizedName
        case .gel:
            return L10n.Currency.Gel.localizedName
        case .usdt:
            return L10n.Currency.Usdt.localizedName
        case .trx:
            return L10n.Currency.Trx.localizedName
        case .ton:
            return L10n.Currency.Ton.localizedName
        case .eth:
            return L10n.Currency.Eth.localizedName
        case .btc:
            return L10n.Currency.Btc.localizedName
        }
    }
    
    /// Determines currency group
    public var group: Group {
        CurrencyType.fiat.contains(self) ? .fiat : .crypto
    }
}

// MARK: - Codable

extension CurrencyType: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self).lowercased()
        if let value = CurrencyType(rawValue: rawValue) {
            self = value
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid currency type: \(rawValue)")
        }
    }
}

// MARK: - Arrays

extension CurrencyType {
    
    public static let fiat: [Self] = [
        .usd,
        .eur,
        .aed,
        .gbp,
        .try,
        .gel
    ]
    
    public static let crypto: [Self] = [
        .usdt,
        .trx,
        .ton,
        .eth,
        .btc
    ]
}

// MARK: - Randomable

extension CurrencyType: Randomable {
    
    public static func random() -> Self {
        CurrencyType.allCases.randomElement().unsafelyUnwrapped
    }
    
    public static func randomFiat() -> Self {
        fiat.randomElement().unsafelyUnwrapped
    }
}
