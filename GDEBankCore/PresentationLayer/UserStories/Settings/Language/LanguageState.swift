//
//  LanguageState.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import ComposableArchitecture
import Foundation

// MARK: - LanguageState

/// `Language` module state
///
/// Basically, `LanguageState` is a type that describes the data
/// `Language` feature needs to perform its logic and render its UI.
@ObservableState
public struct LanguageState: Equatable {
    
    // MARK: - Properties
    
    /// Current chosen language 
    @Shared(.appLanguage)
    public var currentLanguage = AppLanguage.default

    /// All available languages
    public let languages = AppLanguage.allCases
    
    // MARK: - Initializers
    
    public init() {
    }
}

// MARK: - PersistenceReaderKey

extension PersistenceReaderKey where Self == AppStorageKey<AppLanguage> {
    public static var appLanguage: Self {
        appStorage(AppLanguage.storageKey)
    }
}
