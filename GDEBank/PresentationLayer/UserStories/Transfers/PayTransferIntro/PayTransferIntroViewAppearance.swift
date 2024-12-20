//
//  PayTransferIntroViewAppearance.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import GDEBankCore
import SwiftMacrosKit

// MARK: - PayTransferIntroViewAppearance

/// The `PayTransferIntroViewAppearance` struct defines the appearance settings for the `PayTransferIntro` component.
/// It includes font and color configurations for various elements of the view.
@AutoInit
public struct PayTransferIntroViewAppearance {
    
    /// Font font
    public let titleFont: Font
    
    /// Subtitle font
    public let subtitleFont: Font
    
    /// Subtitle color
    public let subtitleColor: Color
}

// MARK: - Default

public extension PayTransferIntroViewAppearance {

    static var `default`: PayTransferIntroViewAppearance {
        PayTransferIntroViewAppearance(
            titleFont: .inter(size: 20, weight: .semibold),
            subtitleFont: .inter(size: 14, weight: .medium),
            subtitleColor: CoreColors.gray2.swiftUIColor
        )
    }
}
