//
//  PayTransferState.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import GDEBankCore

// MARK: - PayTransferState

@ObservableState
public struct PayTransferState: Equatable {
    
    // MARK: - Focus
    
    public enum Focus {
        
        // MARK: - Cases
        
        case amount
    }
    
    // MARK: - Properties
    
    /// User to transfer email
    public let email: String
    
    /// Currency
    public var currency: CurrencyType
    
    /// Amount text
    public var amountText: String
    
    /// Qr token
    public let qrToken: String
    
    /// Indicates is editing available
    public let isEditingAvailable: Bool
    
    /// Indicates is remoting operaration
    public var isRemotingOperation = false
    
    /// Indicates is insufficient fund error now
    public var isInsufficientFundsError = false
    
    /// Module localization
    public var l10n: PayTransferLocalization = .default
    
    // MARK: - Children
    
    /// `AlertState` instance
    ///
    /// It's an instance of `Alert` submodule.
    /// We use it here to be able to integrate `Alert` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `Alert` module all changes will be saved here.
    @Presents public var alert: AlertState<DXAlertAction>?
}

// MARK: - Initializers

extension PayTransferState {
    
    public init(qrToken: String, transferInfo: TransferInfoPlainObject) {
        self.qrToken = qrToken
        self.email = transferInfo.email
        if let wallet = transferInfo.wallet,
           let amount = transferInfo.amount {
            self.currency = wallet
            self.amountText = amount.formatCurrency(wallet, withCurrencySymbol: false)
            self.isEditingAvailable = false
        } else {
            self.currency = CurrencyType.allCases.first ?? .usd
            self.amountText = ""
            self.isEditingAvailable = true
        }
    }
}
