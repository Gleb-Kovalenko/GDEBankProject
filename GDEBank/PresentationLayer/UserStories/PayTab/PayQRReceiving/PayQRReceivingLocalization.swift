//
//  PayQrReceivingLocalization.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftMacrosKit
import GDEBankCore

// MARK: - PayQrReceivingLocalization

@DynamicStringWrapper
public struct PayQrReceivingLocalization {
    
    /// Navigation title
    public let navigationTitle: String
    
    /// Static Qr code tab title
    public let staticQrCodeTab: String
    
    /// Dynamic Qr code tab title
    public let dynamicQrCodeTab: String
    
    /// Static Qr code description
    public let staticQrCodeDescription: String
    
    /// Share button title
    public let shareButtonTitle: String
    
    /// Add to wallet button title
    public let addToWalletButtonTitle: String
    
    /// Transfer data title
    public let transferDataTitle: String
    
    /// Currency label
    public let currencyLabel: String
    
    /// Amount placeholder
    public let amountPlaceholder: String
    
    /// Generate Qr code button title
    public let generateQrCodeButtonTitle: String
    
    /// Dynamic Qr code warning
    public let dynamicQrWarning: String
    
    /// Balance text
    public let balanceText: String
    
    /// The text displayed for the "Done" button on the keyboard toolbar.
    public let keyboardDoneButtonText: String
}

// MARK: - Useful

extension PayQrReceivingLocalization {
    
    /// Currency balance text
    public func currencyBalanceText(currencyType: CurrencyType) -> String {
        currencyType.shortName + " " + balanceText
    }
    
    /// Currency text
    public func currencyText(currency: CurrencyBalancePlainObject, withCurrencySymbol: Bool = false) -> String {
        currency.balance.formatCurrency(currency.currencyType, withCurrencySymbol: withCurrencySymbol)
    }
}

// MARK: - Variations

extension PayQrReceivingLocalization {
    
    public static var `default`: PayQrReceivingLocalization {
        PayQrReceivingLocalization(
            navigationTitle: L10n.QrReceiving.navigationTitle,
            staticQrCodeTab: L10n.QrReceiving.StaticQrCode.tabName,
            dynamicQrCodeTab: L10n.QrReceiving.DynamicQrCode.tabName,
            staticQrCodeDescription: L10n.QrReceiving.StaticQrCode.description,
            shareButtonTitle: L10n.QrReceiving.shareButton,
            addToWalletButtonTitle: L10n.QrReceiving.addToWalletButton,
            transferDataTitle: L10n.QrReceiving.TransferData.title,
            currencyLabel: L10n.QrReceiving.currencyLabel,
            amountPlaceholder: L10n.QrReceiving.amountPlaceholder,
            generateQrCodeButtonTitle: L10n.QrReceiving.generateQrButtonTitle,
            dynamicQrWarning: L10n.QrReceiving.DynamicQrCode.warning,
            balanceText: CoreLocalization.balance.lowercased(),
            keyboardDoneButtonText: CoreLocalization.done
        )
    }
}
