//
//  WalletRequisitesType.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 13.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - WalletRequisitesType

public enum WalletRequisitesType: String, Equatable, Codable, CaseIterable, Identifiable {
    
    // MARK: - Properties
    
    public var id: String {
        rawValue
    }
    
    // MARK: - Cases
    
    case sepa = "SEPA"
    case swift = "SWIFT"
    
    // MARK: - Useful
    
    public var title: String {
        switch self {
        case .sepa:
            return CoreLocalization.WalletRequisites.Fiat.Sepa.title
        case .swift:
            return CoreLocalization.WalletRequisites.Fiat.Swift.title
        }
    }
    
    public var imageName: String {
        switch self {
        case .sepa:
            return CoreAssets.sepa.name
        case .swift:
            return CoreAssets.swift.name
        }
    }
}

// MARK: - Randomable

extension WalletRequisitesType: Randomable {
    
    public static func random() -> WalletRequisitesType {
        WalletRequisitesType.allCases.randomElement().unsafelyUnwrapped
    }
}
