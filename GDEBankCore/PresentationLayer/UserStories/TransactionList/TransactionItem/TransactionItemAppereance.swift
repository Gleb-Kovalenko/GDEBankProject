//
//  TransactionItemAppereance.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 26.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit

// MARK: - TransactionItemViewAppearance

/// The `TransactionItemViewAppearance` struct defines the appearance settings for a transaction item view.
/// It allows customization of the fonts and colors for various elements in the view.
@AutoInit
public struct TransactionItemViewAppearance {
    
    // MARK: - Properties

    /// The font for the title text.
    public let titleFont: Font

    /// The color for the title text.
    public let titleColor: Color

    /// The font for the subtitle text.
    public let subtitleFont: Font

    /// The color for the subtitle text.
    public let subtitleColor: Color

    /// The font for the amount text.
    public let amountTextFont: Font

    /// The color for the amount text based on direction.
    public let amountTextColor: (TransactionDirection) -> Color
}

// MARK: - Default

public extension TransactionItemViewAppearance {

    /// The default appearance settings for the transaction item view.
    static var `default`: TransactionItemViewAppearance {
        TransactionItemViewAppearance(
            titleFont: .inter(size: 14, weight: .semibold),
            titleColor: CoreColors.textDefault.swiftUIColor,
            subtitleFont: .inter(size: 12, weight: .regular),
            subtitleColor: CoreColors.gray2.swiftUIColor,
            amountTextFont: .inter(size: 14, weight: .semibold),
            amountTextColor: { $0.foregroundColor }
        )
    }
}
