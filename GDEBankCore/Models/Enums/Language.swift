//
//  Language.swift
//  GDEBank
//
//  Created by incetro on 29/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - Language

public enum AppLanguage: String, Identifiable, CaseIterable {
    
    // MARK: - Identifiable
    
    /// A unique identifier for each language case.
    /// This property returns the enum case itself.
    public var id: Self {
        self
    }
    
    case english = "en"
    case russian = "ru"
    case ukrainian = "uk"
    case chinese = "zh"
    case japanese = "ja"
    case georgian = "ka"
    case turkish = "tr"
    case arabian = "ar"
    case deutsch = "de"
    case french = "fr"
    case portuguese = "pt"
    case spanish = "es"
    
    // MARK: - Properties
    
    /// The default language of the application.
    /// This property returns the `english` case.
    public static var `default`: AppLanguage  {
        english
    }

    /// The default locale of the application.
    /// This property returns the raw value of the `english` case.
    public static var defaultLanguageCode: String  {
        `default`.rawValue
    }

    /// The locale object associated with the language.
    /// This property returns a `Locale` initialized with the raw value
    /// of the enum case as the identifier.
    public var locale: Locale {
        Locale(identifier: rawValue)
    }
    
    public var languageName: String {
        locale.localizedString(forLanguageCode: rawValue).unsafelyUnwrapped.uppercasedFirstLetter()
    }

    public var localizedPath: String {
        Bundle.main.path(
            forResource: rawValue,
            ofType: "lproj"
        ) ?? Bundle.main.path(
            forResource: AppLanguage.english.rawValue,
            ofType: "lproj"
        ).unsafelyUnwrapped
    }
    
    /// The localized title of the language.
    /// This computed property returns the language name in its
    /// respective language.
    public var title: String {
        switch self {
        case .russian:
            "Русский"
        case .english:
            "English"
        case .ukrainian:
            "Українською"
        case .chinese:
            "中文"
        case .japanese:
            "日本語"
        case .georgian:
            "ქართული"
        case .turkish:
            "Türk"
        case .arabian:
            "العربية"
        case .deutsch:
            "Deutsch"
        case .french:
            "Français"
        case .portuguese:
            "Português"
        case .spanish:
            "Español"
        }
    }

    public static let storageKey = "app.current-language"
}

// MARK: - UserDefaults

public extension UserDefaults {

    func retrieveLanguage() -> AppLanguage {
        let languageRawValue = value(
            forKey: AppLanguage.storageKey,
            default: AppLanguage.default.rawValue
        )
        return AppLanguage(rawValue: languageRawValue) ?? AppLanguage.default
    }
    
    func retrieveLanguageCode() -> String {
        retrieveLanguage().rawValue
    }
    
    func retrieveLocale() -> Locale {
        Locale(identifier: retrieveLanguageCode())
    }
}
