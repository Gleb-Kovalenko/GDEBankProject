//
//  PaymentMethodDetailsPlainObject.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SwiftMacrosKit

// MARK: - PaymentMethodDetailsPlainObject

/// Represents the details associated with a specific payment method.
@AutoInit
public struct PaymentMethodDetailsPlainObject: Equatable {
    
    // MARK: - Properties
    
    /// Detailts title
    public let title: String
    
    /// Icon url
    public let iconURL: URL?
    
    /// The type of payment method.
    public let type: PaymentMethodType
    
    /// The fee associated with the payment method, if applicable.
    public let fee: Double?
    
    /// The minimum deposit amount required for the payment method, if applicable.
    public let minimumDeposit: Double?
    
    /// The minimum transfer amount required for the payment method, if applicable.
    public let minimumTransfer: Double?
}

// MARK: - Codable

extension PaymentMethodDetailsPlainObject: Codable {
    
    // MARK: - CodingKeys
    
    /// Keys used for encoding and decoding the `PaymentMethodDetailsPlainObject`.
    public enum CodingKeys: String, CodingKey {
        
        // MARK: - Cases
        
        /// Details title
        case title
        
        /// Icon url
        case iconURL = "icon_url"
        
        /// The type of payment method.
        case type
        
        /// The fee associated with the payment method.
        case fee
        
        /// The minimum deposit amount.
        case minimumDeposit = "minimum_deposit"
        
        /// The minimum transfer amount.
        case minimumTransfer = "minimum_transfer"
    }
}

// MARK: - Randomable

extension PaymentMethodDetailsPlainObject: Randomable {
    
    /// Generates a random `PaymentMethodDetailsPlainObject` instance with mock data.
    ///
    /// - Returns: A randomly generated `PaymentMethodDetailsPlainObject`.
    public static func random() -> PaymentMethodDetailsPlainObject {
        PaymentMethodDetailsPlainObject(
            title: .randomMethodName(),
            type: .allCases.randomElement().unsafelyUnwrapped,
            fee: Bool.random() ? .random(in: 1...5) : nil,
            minimumDeposit: Bool.random() ? .random(in: 1...5) : nil,
            minimumTransfer: Bool.random() ? .random(in: 1...5) : nil
        )
    }
}

// MARK: - Randomable Array Extension

extension Array where Element == PaymentMethodDetailsPlainObject {
    
    /// Generates an array of random `PaymentMethodDetailsPlainObject` instances with mock data.
    ///
    /// - Returns: An array of randomly generated `PaymentMethodDetailsPlainObject` instances.
    public static func random() -> [PaymentMethodDetailsPlainObject] {
        let types = PaymentMethodType.allCases
        var result = [PaymentMethodDetailsPlainObject]()
        for type in types {
            result.append(
                PaymentMethodDetailsPlainObject(
                    title: .randomMethodName(),
                    type: type,
                    fee: Bool.random() ? .random(in: 1...5) : nil,
                    minimumDeposit: Bool.random() ? .random(in: 1...5) : nil,
                    minimumTransfer: Bool.random() ? .random(in: 1...5) : nil
                )
            )
        }
        return result
    }
}
