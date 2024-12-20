//
//  PayQRReceivingAction.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation
import GDEBankCore

// MARK: - PayQRReceivingAction

@CasePathable
public enum PayQRReceivingAction: Equatable {
    
    // MARK: - Cases
    
    /// General action that calls when view appears
    case onAppear
    
    /// An action that calls when user taps on the `Share` button
    case shareButtonTapped(type: PayQRReceivingState.QRType)
    
    /// An action that calls when user taps on the `AddToWallet` button
    case addToWalletButtonTapped
    
    /// An action that calls when user taps on the `GenerateQr` button
    case generateQrButtonTapped
    
    /// An action that calls when share sheet dismissed
    case shareSheetDismiss
    
    /// An action that calls when another currency selected
    case currencySelected(CurrencyBalancePlainObject)
    
    // MARK: - Bindings
    
    /// An action that calls when user taps on the `Tab`
    case tabTapped(type: PayQRReceivingState.QRType)
    
    /// An action that calls when need to set sum text
    case setSumText(String)
    
    // MARK: - Children
    
    /// Child action for `Alert` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `alert` case means that every action in `Alert` module
    /// will be sent to current module through it
    case alert(PresentationAction<DXAlertAction>)
    
    // MARK: - Service
    
    /// An action that calls when qr code obtained
    case qrCodeObtained(qrType: PayQRReceivingState.QRType, result: Result<URL, NSError>)
    
    /// An action that calls when qr code dowloaded
    case qrCodeDownloaded(qrType: PayQRReceivingState.QRType, result: Result<URL, NSError>)
}
