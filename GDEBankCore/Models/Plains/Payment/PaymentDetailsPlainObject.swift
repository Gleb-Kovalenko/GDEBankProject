//
//  PaymentDetailsPlainObject.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SwiftMacrosKit

// MARK: - PaymentDetailsPlainObject

/// Represents the details associated with a specific payment system,
/// including supported currencies, available methods, and their respective details.
@AutoInit
public struct PaymentDetailsPlainObject: Equatable {
    
    // MARK: - Properties
    
    /// The type of currency associated with the payment system.
    public let currency: CurrencyType
    
    /// Detailed information about each payment method.
    public let details: [PaymentMethodDetailsPlainObject]
}

// MARK: - Codable

extension PaymentDetailsPlainObject: Codable {
    
    // MARK: - CodingKeys
    
    /// Keys used for encoding and decoding `PaymentDetailsPlainObject`.
    public enum CodingKeys: String, CodingKey {
        
        // MARK: - Cases
        
        /// The currency type.
        case currency
        
        /// The crypto details
        case details = "method_details"
    }
}

// MARK: - Randomable

extension PaymentDetailsPlainObject: Randomable {
    
    /// Generates a random instance of `PaymentDetailsPlainObject` with mock data.
    ///
    /// - Returns: A randomly generated `PaymentDetailsPlainObject`.
    public static func random() -> PaymentDetailsPlainObject {
        let details: [PaymentMethodDetailsPlainObject] = .random()
        return PaymentDetailsPlainObject(
            currency: .random(),
            details: details
        )
    }
}
