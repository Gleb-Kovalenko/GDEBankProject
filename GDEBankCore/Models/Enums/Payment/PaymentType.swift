//
//  PaymentType.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - PaymentType

/// Enum representing the different types of payments.
public enum PaymentType: String, Equatable {
    
    // MARK: - Cases
    
    /// Represents a deposit transaction.
    case deposit
    
    /// Represents a transfer transaction.
    case transfer
}
