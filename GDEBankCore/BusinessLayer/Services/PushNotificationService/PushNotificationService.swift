//
//  PushNotificationService.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 12.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - AccountStatementService

public protocol PushNotificationService {
    
    /// Set firebase token
    ///
    /// **Useful:**
    /// - `POST`
    /// - `profile/firebase/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/ustanovit-token-firebase
    ///
    /// - Parameters:
    ///   - token: fcm token
    /// - Returns: Operation status
    /// - Throws: An error if operartion fails.
    func setFirebaseToken(
        token: String
    ) async throws -> Bool
}
