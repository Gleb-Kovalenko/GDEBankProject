//
//  PersistenceReaderKey+String.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 11.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture

// MARK: - PersistenceReaderKey+Bool

extension PersistenceReaderKey where Self == AppStorageKey<String?> {
    public static var fcmToken: Self {
        appStorage(AppConstants.UserDefaultsKeys.fcmToken.rawValue)
    }
}
