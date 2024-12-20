//
//  PayTransferLocalization.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftMacrosKit
import GDEBankCore

// MARK: - PayTransferLocalization

/// The `PayTransferLocalization` struct defines the localization settings for the transfer screen.
@DynamicStringWrapper
public struct PayTransferLocalization {
    
    /// Navigation title
    public let navigationTitle: String
    
    /// Recipient label
    public let recipientLabel: String
    
    /// Amount label
    public let amountLabel: String
    
    /// Insufficient funds error message
    public let insufficientFundsError: String
    
    /// Currency label
    public let currencyLabel: String
    
    /// Transfer button title
    public let transferButtonTitle: String
    
    /// Key board bone button text
    public let keyboardDoneButtonText: String
}

// MARK: - Variations

extension PayTransferLocalization {
    
    public static var `default`: PayTransferLocalization {
        PayTransferLocalization(
            navigationTitle: L10n.PayTransfer.navigationTitle,
            recipientLabel: L10n.PayTransfer.recipientLabel,
            amountLabel: L10n.PayTransfer.amountLabel,
            insufficientFundsError: L10n.PayTransfer.insufficientFundsError,
            currencyLabel: L10n.PayTransfer.currencyLabel,
            transferButtonTitle: L10n.PayTransfer.transferButtonTitle,
            keyboardDoneButtonText: CoreLocalization.done
        )
    }
}

