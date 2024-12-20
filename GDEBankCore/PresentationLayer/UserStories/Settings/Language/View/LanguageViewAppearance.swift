//
//  LanguageViewAppearance.swift
//  GDEBankCore
//
//  Created by incetro on 9/5/24.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit

// MARK: - LanguageViewAppearance

/// The `LanguageViewAppearance` struct defines the appearance settings for the `LanguageView`.
/// It allows customization of the font, text color, background color, checkmark image, and other visual elements.
@AutoInit
public struct LanguageViewAppearance {
    
    // MARK: - Properties
    
    /// The font used for the language titles.
    public let titleFont: Font
    
    /// The color of the language titles.
    public let titleColor: Color
    
    /// The color of the background.
    public let backgroundColor: Color
    
    /// The color of the checkmark icon.
    public let checkmarkColor: Color
    
    /// The image used for the checkmark icon.
    public let checkmarkImage: Image
    
    /// The color of the divider between languages.
    public let dividerColor: Color
}

// MARK: - Default

public extension LanguageViewAppearance {
    
    /// The default appearance for `LanguageView`.
    static var `default`: LanguageViewAppearance {
        LanguageViewAppearance(
            titleFont: .inter(size: 16, weight: .medium),
            titleColor: Colors.textDefault.swiftUIColor,
            backgroundColor: Colors.defaultPrimary.swiftUIColor,
            checkmarkColor: Colors.accentColor.swiftUIColor,
            checkmarkImage: Image("check-circle"),
            dividerColor: .gray
        )
    }
}
