//
//  AppVersionInfoPlainObject.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 17.01.2024.
//

import Foundation

// MARK: - AppVersionInfoPlainObject

public struct AppVersionInfoPlainObject: Codable, Equatable {
    
    // MARK: - Properties
    
    public let currentVersion: String
    
    public let minVersion: String
    
    // MARK: - CodingKeys
    
    public enum CodingKeys: String, CodingKey {
        
        case currentVersion = "ios_version"
        case minVersion = "ios_version_force_update"
    }
}
