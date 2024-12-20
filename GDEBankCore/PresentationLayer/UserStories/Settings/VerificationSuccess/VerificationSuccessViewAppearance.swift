//
//  VerificationSuccessViewAppearance.swift
//  GDEBankCore
//
//  Created by Andrey Barsukov on 23.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit

// MARK: - VerificationSuccessViewAppearance

/// The `VerificationSuccessViewAppearance` struct defines the appearance settings for the `VerificationSuccessView`.
/// It allows customization of the colors and fonts used within the view.
@AutoInit
public struct VerificationSuccessViewAppearance {

    // MARK: - Properties

    /// The color of the success circle background.
    public let successCircleBackgroundColor: Color

    /// The color of the success circle icon.
    public let successCircleIconColor: Color

    /// The font for the title text.
    public let titleFont: Font

    /// The color of the title text.
    public let titleColor: Color

    /// The height of the button.
    public let buttonHeight: CGFloat
    
    /// The frame of the image.
    public let imageFrame: CGFloat
}

// MARK: - Default

public extension VerificationSuccessViewAppearance {

    /// The default appearance settings for `VerificationSuccessView`.
    static var `default`: VerificationSuccessViewAppearance {
        VerificationSuccessViewAppearance(
            successCircleBackgroundColor: Colors.success2.swiftUIColor,
            successCircleIconColor: Colors.textWhite.swiftUIColor,
            titleFont: .inter(size: 20, weight: .semibold),
            titleColor: Colors.textDefault.swiftUIColor,
            buttonHeight: 50,
            imageFrame: 28.35
        )
    }
}
