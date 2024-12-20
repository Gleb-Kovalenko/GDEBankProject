//
//  PayQRReceivingViewAppearance.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import GDEBankCore
import SwiftMacrosKit

// MARK: - PayQRReceivingViewAppearance

/// The `PayQRReceivingViewAppearance` struct defines the appearance settings for the `PayQRReceiving` component.
/// It includes font and color configurations for various elements of the view.
@AutoInit
public struct PayQRReceivingViewAppearance {
    
    /// Description font
    public let descriptionFont: Font
    
    /// Description color
    public let descriptionColor: Color
    
    /// Section title font
    public let sectionTitleFont: Font
    
    /// Field label font
    public let fieldLabelFont: Font
    
    /// Field label color
    public let fieldLabelColor: Color
    
    /// Balance title font
    public let balanceTitleFont: Font
    
    /// Balance subtitle font
    public let balanceSubtitleFont: Font
    
    /// Balance subtitle color
    public let balanceSubtitleColor: Color
    
    /// Warning message font
    public let warningFont: Font
    
    /// Warning message color
    public let warningColor: Color
    
    /// Currency menu item font
    public let currencyMenuItemFont: Font
}

// MARK: - Default

public extension PayQRReceivingViewAppearance {

    static var `default`: PayQRReceivingViewAppearance {
        PayQRReceivingViewAppearance(
            descriptionFont: .inter(size: 14, weight: .medium),
            descriptionColor: CoreColors.gray2.swiftUIColor,
            sectionTitleFont: .inter(size: 18, weight: .semibold),
            fieldLabelFont: .inter(size: 14, weight: .regular),
            fieldLabelColor: CoreColors.gray1.swiftUIColor,
            balanceTitleFont: .inter(size: 16, weight: .medium),
            balanceSubtitleFont: .inter(size: 14, weight: .regular),
            balanceSubtitleColor: CoreColors.gray2.swiftUIColor,
            warningFont: .inter(size: 11, weight: .medium),
            warningColor: CoreColors.warning1.swiftUIColor,
            currencyMenuItemFont: .inter(size: 16, weight: .regular)
        )
    }
}
