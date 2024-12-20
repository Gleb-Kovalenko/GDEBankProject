//
//  TransactionDirection.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 21.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - TransactionDirection

public enum TransactionDirection: String, Equatable, Codable {
    
    // MARK: - Cases
    
    case coming
    case consumption
    
    // MARK: - Useful
    
    public var symbol: String {
        switch self {
        case .coming: "+"
        case .consumption: "-"
        }
    }
    
    public var foregroundColor: Color {
        switch self {
        case .coming:
            Colors.success2.swiftUIColor
        case .consumption:
            Colors.alert1.swiftUIColor
        }
    }
}

// MARK: - Randomable

extension TransactionDirection: Randomable {
    
    public static func random() -> Self {
        [.coming, .consumption].randomElement().unsafelyUnwrapped
    }
}
