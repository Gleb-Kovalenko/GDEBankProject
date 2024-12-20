//
//  MainViewAppereance.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 17.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import GDEBankCore
import SwiftMacrosKit

// MARK: - MainViewAppearance

/// The `MainViewAppearance` struct defines the appearance settings for the `MainView` component.
/// It includes font and color configurations for various elements of the view.
@AutoInit
public struct MainViewAppearance {
    
    /// Total balance font
    public let totalBalanceFont: Font
    
    /// Balance font
    public let balanceFont: Font
    
    /// Transfer history title font
    public let transferHistoryTitleFont: Font
}

// MARK: - Default

public extension MainViewAppearance {

    static var `default`: MainViewAppearance {
        MainViewAppearance(
            totalBalanceFont: .inter(size: 13, weight: .regular),
            balanceFont: .inter(size: 20, weight: .semibold),
            transferHistoryTitleFont: .inter(size: 18, weight: .semibold)
        )
    }
}
