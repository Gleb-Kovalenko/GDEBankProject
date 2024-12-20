//
//  TransactionTypePlainObject.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SDAO

/// @realm
public struct TransactionTypePlainObject: Plain, Identifiable, Equatable {
    
    // MARK: - Properties

    /// Unique id for database
    public var uniqueId: UniqueID {
        .init(rawValue: id)
    }
    
    /// Transaction id
    public var id: String {
        imageURL?.absoluteString ?? UUID().uuidString
    }

    /// Transaction type name
    public let type: TransactionType?
    
    /// Transaction type image url
    public let imageURL: URL?
}

// MARK: - Randomable

extension TransactionTypePlainObject: Randomable {
    
    public static func random() -> TransactionTypePlainObject {
        TransactionTypePlainObject(
            type: .random(),
            imageURL: .randomTransactions()
        )
    }
}

// MARK: - Codable

extension TransactionTypePlainObject: Codable {
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        
        // MARK: - Cases
        
        case type = "name"
        case imageURL = "image_url"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeRawValue = try container.decodeIfPresent(String.self, forKey: .type)
        self.type = TransactionType(rawValue: typeRawValue ?? "") ?? .none
        self.imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
    }
}
