//
//  SessionRefreshPlainObject.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 12.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - SessionRefreshPlainObject

public struct SessionRefreshPlainObject: Equatable {

    // MARK: - Properties

    /// Signed user token
    public var accessToken: String

    /// Refreshing token value
    public let refreshToken: String
}

// MARK: - Codable

extension SessionRefreshPlainObject: Decodable {
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        
        // MARK: - Cases
        
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case accessTokenCamelCase = "accessToken"
        case refreshTokenCamelCase = "refreshToken"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = try (container.decodeIfPresent(String.self, forKey: .accessToken) ?? container.decode(String.self, forKey: .accessTokenCamelCase))
        self.refreshToken = try (container.decodeIfPresent(String.self, forKey: .refreshToken) ?? container.decode(String.self, forKey: .accessTokenCamelCase))
    }
}
