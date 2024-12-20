//
//  DXDialogViewAppearance.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 01.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftMacrosKit
import SwiftUI

// MARK: - DXDialogViewAppearance

/// A structure that defines the appearance and layout properties of a dialog view.
@AutoInit
public struct DXDialogViewAppearance {

    // MARK: - Properties

    /// The horizontal padding applied to the content of the dialog.
    public let horizontalPaddings: CGFloat

    /// The vertical padding applied to the content of the dialog.
    public let verticalPaddings: CGFloat
    
    /// Backgroud color
    public let backgroundColor: Color
    
    /// Indicates is need pin to top
    public let pinToTop: Bool

    /// The padding used for positioning the cross (close) button, if applicable.
    public let closeButtonPaddings: CGFloat?

    /// The font used for the dialog title.
    public let titleFont: Font

    /// The color used for the dialog title text.
    public let titleColor: Color

    /// The size of the outer circle used in the dialog's design, if any.
    public let outerCircleSize: CGFloat

    /// The size of the image displayed in the dialog.
    public let imageSize: CGFloat

    /// The spacing between elements in the dialog view.
    public let spacing: CGFloat

    /// The spacing between the buttons in the dialog view.
    public let buttonsSpacing: CGFloat

    /// The corner radius applied to the dialog's container, if any.
    public let cornerRadius: CGFloat?
}


// MARK: - Variation

extension DXDialogViewAppearance {
    
    public static var popup: DXDialogViewAppearance {
        DXDialogViewAppearance(
            horizontalPaddings: 24,
            verticalPaddings: 24,
            backgroundColor: CoreColors.bg4.swiftUIColor,
            pinToTop: false,
            closeButtonPaddings: 12,
            titleFont: .inter(size: 20, weight: .semibold),
            titleColor: CoreColors.textDefault.swiftUIColor,
            outerCircleSize: 56,
            imageSize: 32,
            spacing: 24,
            buttonsSpacing: 8,
            cornerRadius: 8
        )
    }
    
    public static var fullScreenCover: DXDialogViewAppearance {
        DXDialogViewAppearance(
            horizontalPaddings: 20,
            verticalPaddings: 0,
            backgroundColor: CoreColors.defaultPrimary.swiftUIColor.light,
            pinToTop: true,
            titleFont: .inter(size: 20, weight: .semibold),
            titleColor: CoreColors.textDefault.swiftUIColor,
            outerCircleSize: 56,
            imageSize: 32,
            spacing: 32,
            buttonsSpacing: 8
        )
    }
}
