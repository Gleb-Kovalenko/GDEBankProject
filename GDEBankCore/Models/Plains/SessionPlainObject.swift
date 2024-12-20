//
//  SessionPlainObject.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 12.08.24.
//

import Foundation

// MARK: - SessionPlainObject

public struct SessionPlainObject: Codable, Equatable {

    // MARK: - Properties
    
    /// User id
    public var userID: String

    /// Signed user token
    public var accessToken: String

    /// Refreshing token value
    public let refreshToken: String
    
    /// Indicates is session valid
    public var isValid: Bool {
        [accessToken, refreshToken].allSatisfy { !$0.isEmpty }
    }

    // MARK: - Initializers

    public init(
        userID: String,
        accessToken: String,
        refreshToken: String
    ) {
        self.userID = userID
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(String.self, forKey: .userID)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
        self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
    }
}

// MARK: - Useful

extension SessionPlainObject {
    
    public func set(accessToken: String, refreshToken: String) -> SessionPlainObject {
        SessionPlainObject(
            userID: userID,
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
    
    public func expireAuthToken() -> SessionPlainObject {
        SessionPlainObject(
            userID: userID,
            accessToken: accessToken + "123",
            refreshToken: refreshToken
        )
    }
    
    public func expiredAllTokens() -> SessionPlainObject {
        SessionPlainObject(
            userID: userID,
            accessToken: accessToken + "123",
            refreshToken: refreshToken + "123"
        )
    }
}

// MARK: - Randomable

extension SessionPlainObject: Randomable {
    
    public static func random() -> SessionPlainObject {
        SessionPlainObject(
            userID: UUID().uuidString,
            accessToken: UUID().uuidString,
            refreshToken: UUID().uuidString
        )
    }
}
