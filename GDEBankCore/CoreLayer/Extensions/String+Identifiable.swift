//
//  String+Identifiable.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 05.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - IdentifiableString

public struct IdentifiableString: Equatable, Identifiable {
    
    // MARK: - Properties
    
    /// String id
    public var id: String {
        string
    }
    
    /// String value
    public let string: String
}

// MARK: - String + IdentifiableString

extension String {
    
    public var toIdentifiable: IdentifiableString {
        IdentifiableString(string: self)
    }
}
