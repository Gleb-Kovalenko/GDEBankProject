//
//  ServiceLanguageType.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 16.08.2024.
//

import SDAO

// MARK: - ServiceLanguageType
 
/// @realm
public enum ServiceLanguageType: String, Plain, Identifiable, Codable, CaseIterable {
    
    // MARK: - Cases
    
    case eng = "EN"
    case rus = "RU"
    case tr = "TR"
    case el = "GR"
    
    // MARK: - Useful
    
    // Unique id for database
    public var uniqueId: UniqueID {
        UniqueID(rawValue: id)
    }
    
    /// Language id
    public var id: String {
        rawValue
    }
    
    /// Language image name
    public var imageName: String {
        "flag_\(rawValue.lowercased())"
    }
}

// MARK: - ServiceLanguageType

extension ServiceLanguageType: Randomable {
    
    public static func random() -> ServiceLanguageType {
        allCases.randomElement().unsafelyUnwrapped
    }
}
