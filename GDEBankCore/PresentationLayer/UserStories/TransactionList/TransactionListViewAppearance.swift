//
//  TransactionListViewAppearance.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 24.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import GDEBankCore
import SwiftMacrosKit

// MARK: - TransactionListViewAppearance

/// The `TransactionListViewAppearance` struct defines the appearance settings for a transaction list view.
/// It allows customization of the fonts and colors for various elements in the view.
@AutoInit
public struct TransactionListViewAppearance {
    
    // MARK: - Properties
    
    /// The font for the date text.
    public let dateTextFont: Font

    /// The color for the date text.
    public let dateTextColor: Color

    /// The font for the empty state title text.
    public let emptyTitleFont: Font

    /// The font for the empty state subtitle text.
    public let emptySubtitleFont: Font

    /// The color for the empty state subtitle text.
    public let emptySubtitleColor: Color

    /// The color for the leading image in the statement button.
    public let statementButtonLeadingImageColor: Color
}

// MARK: - Default

public extension TransactionListViewAppearance {

    /// The default appearance settings for the transaction list view.
    static var `default`: TransactionListViewAppearance {
        TransactionListViewAppearance(
            dateTextFont: .inter(size: 12, weight: .medium),
            dateTextColor: CoreColors.gray1.swiftUIColor,
            emptyTitleFont: .inter(size: 20, weight: .semibold),
            emptySubtitleFont: .inter(size: 14, weight: .medium),
            emptySubtitleColor: CoreColors.gray2.swiftUIColor,
            statementButtonLeadingImageColor: CoreColors.gray1.swiftUIColor
        )
    }
}
