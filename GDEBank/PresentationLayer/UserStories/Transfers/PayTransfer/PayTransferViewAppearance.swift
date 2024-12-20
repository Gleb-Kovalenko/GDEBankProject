//
//  PayTransferViewAppearance.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import GDEBankCore
import SwiftMacrosKit

// MARK: - PayTransferViewAppearance

/// The `PayTransferViewAppearance` struct defines the appearance settings for the `PayTransfer` component.
/// It includes font and color configurations for various elements of the view.
@AutoInit
public struct PayTransferViewAppearance {
    
    /// Field title font font
    public let fieldTitleFont: Font
    
    /// Field title color
    public let fieldTitleColor: Color
    
    /// Currency menu items font
    public let currencyMenuItemFont: Font
    
    /// Currency font
    public let currencyFont: Font
    
    /// Email text font
    public let emailTextFont: Font
    
    /// Error color
    public let errorColor: Color
    
    /// Error text font
    public let errorTextFont: Font
}

// MARK: - Default

public extension PayTransferViewAppearance {

    static var `default`: PayTransferViewAppearance {
        PayTransferViewAppearance(
            fieldTitleFont: .inter(size: 14, weight: .regular),
            fieldTitleColor: CoreColors.gray1.swiftUIColor,
            currencyMenuItemFont: .inter(size: 16, weight: .regular),
            currencyFont: .inter(size: 16, weight: .medium),
            emailTextFont: .inter(size: 14, weight: .semibold),
            errorColor: CoreColors.alert1.swiftUIColor,
            errorTextFont: .inter(size: 12, weight: .medium)
        )
    }
}
