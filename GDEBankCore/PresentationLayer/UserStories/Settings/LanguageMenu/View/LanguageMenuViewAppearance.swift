//
//  LanguageMenuViewAppearance.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 30.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit

// MARK: - LanguageMenuViewAppearance

/// The `LanguageMenuViewAppearance` struct defines the appearance settings for the language menu view.
/// It allows customization of fonts and colors used in various elements of the view.
@AutoInit
public struct LanguageMenuViewAppearance {
    
    // MARK: - Properties
    
    /// The font used for the language button text.
    public let languageButtonFont: Font
}

// MARK: - Default

public extension LanguageMenuViewAppearance {
    
    /// The default appearance settings for the language menu view.
    static var `default`: LanguageMenuViewAppearance {
        LanguageMenuViewAppearance(
            languageButtonFont: .inter(size: 16, weight: .regular)
        )
    }
}
