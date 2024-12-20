//
//  PersistenceReaderKey+Bool.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 30.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture

// MARK: - PersistenceReaderKey+Bool

extension PersistenceReaderKey where Self == AppStorageKey<Bool> {
    public static var useDarkTheme: Self {
        appStorage(AppConstants.UserDefaultsKeys.useDarkTheme.rawValue)
    }
}

extension PersistenceReaderKey where Self == AppStorageKey<Bool> {
    public static var useTouchID: Self {
        appStorage(AppConstants.UserDefaultsKeys.useTouchID.rawValue)
    }
}

extension PersistenceReaderKey where Self == AppStorageKey<Bool> {
    public static var useFaceID: Self {
        appStorage(AppConstants.UserDefaultsKeys.useFaceID.rawValue)
    }
}
