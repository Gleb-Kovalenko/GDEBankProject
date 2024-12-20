//
//  AppType.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 21.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: AppType

public enum AppType {
    
    // MARK: - Cases
    
    case gdeBankWallet
    case gdeBank
    
    // MARK: - Useful
    
    public var refreshTokenApiURL: String {
        switch self {
        case .gdeBankWallet:
            return "/refresh"
        case .gdeBank:
            return "/profile/pay/tokens/refresh"
        }
    }
}
