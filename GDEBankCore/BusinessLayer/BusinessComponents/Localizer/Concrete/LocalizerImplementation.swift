//
//  LocalizerImplementation.swift
//  TheRun
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 incetro. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - LocalizerImplementation

public final class LocalizerImplementation: ObservableObject {

    // MARK: - Properties

    /// UserDefaults instance
    private let defaults: UserDefaults
    
    /// Localization stores
    private let localizationStores: [any LocalizationStore.Type]

    // MARK: - Initializers

    /// Default initializers
    /// - Parameters:
    ///   - defaults: user defaults
    ///   - localizationStores: localization store like `L10n` and so on
    public init(
        defaults: UserDefaults,
        localizationStores: [any LocalizationStore.Type]
    ) {
        self.defaults = defaults
        self.localizationStores = localizationStores
    }
}

// MARK: - Localizer

extension LocalizerImplementation: Localizer {
    
    public var currentLanguage: AppLanguage {
        defaults.retrieveLanguage()
    }

    public func setCurrrentLanguage(_ language: AppLanguage) {
        let newLocale = language.locale
        let newBundle = Bundle(path: language.localizedPath)
        localizationStores.forEach {
            $0.locale = newLocale
            $0.bundle = newBundle
        }
        defaults.setValue(language.rawValue, forKey: AppLanguage.storageKey)
        NotificationCenter.default.post(name: NSLocale.currentLocaleDidChangeNotification, object: nil)
    }
}
