//
//  Inter.swift
//  GDEBankCore
//
//  Created by incetro on 8/2/24.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - InterFont

public enum InterFont {
    
    case black
    case bold
    case extraBold
    case extraLight
    case light
    case medium
    case regular
    case semibold
    case thin
    
    var fontConvertible: FontConvertible {
        switch self {
        case .black:
            SGFontFamily.Inter.black
        case .bold:
            SGFontFamily.Inter.bold
        case .extraBold:
            SGFontFamily.Inter.extraBold
        case .extraLight:
            SGFontFamily.Inter.extraLight
        case .light:
            SGFontFamily.Inter.light
        case .medium:
            SGFontFamily.Inter.medium
        case .regular:
            SGFontFamily.Inter.regular
        case .semibold:
            SGFontFamily.Inter.semiBold
        case .thin:
            SGFontFamily.Inter.thin
        }
    }
}

extension Font {

    public static func inter(
        size: CGFloat,
        weight: InterFont
    ) -> Font {
        Font.custom(weight.fontConvertible, size: size)
    }
}

extension UIFont {
    
    public static func inter(
        size: CGFloat,
        weight: InterFont
    ) -> UIFont {
        weight.fontConvertible.font(size: size)
    }
}
