//
//  MainViewLocalization.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 17.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftMacrosKit

// MARK: - MainViewLocalization

@DynamicStringWrapper
public struct MainViewLocalization {
    
    /// Navigation title
    public let navigationTitle: String
    
    /// Total balance
    public let totalBalance: String
    
    /// Transfer button title
    public let transferButtonTitle: String
    
    /// Receive button title
    public let receiveButtonTitle: String
    
    /// Transfer history title
    public let transferHistoryTitle: String
}

// MARK: - Variations

extension MainViewLocalization {
    
    public static var `default`: MainViewLocalization {
        MainViewLocalization(
            navigationTitle: L10n.Main.navigationTitle,
            totalBalance: L10n.Main.totalBalance,
            transferButtonTitle: L10n.Main.transferButtonTitle,
            receiveButtonTitle: L10n.Main.receiveButtonTitle,
            transferHistoryTitle: L10n.Main.TransferHistory.title
        )
    }
}
