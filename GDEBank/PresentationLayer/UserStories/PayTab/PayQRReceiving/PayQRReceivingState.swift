//
//  PayQRReceivingState.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import GDEBankCore

// MARK: - PayQRReceivingState

@ObservableState
public struct PayQRReceivingState: Equatable {
    
    // MARK: - Tabs
    
    public enum QRType: Equatable, CaseIterable {
        
        // MARK: - Cases
        
        case `static`
        case `dynamic`
        
        // MARK: - Useful
        
        public var title: String {
            switch self {
            case .static:
                return L10n.QrReceiving.StaticQrCode.tabName
            case .dynamic:
                return L10n.QrReceiving.DynamicQrCode.tabName
            }
        }
    }
    
    // MARK: - Focus
    
    public enum Focus {
        
        // MARK: - Cases
        
        case amount
    }
    
    // MARK: - Properties
    
    /// Current selected tab
    public var selectedTab: QRType = .static
    
    /// Module localization
    public var l10n: PayQrReceivingLocalization = .default
    
    // MARK: - StatisQrFlow
    
    /// Statis qr url
    public var staticQrURL: URL?
    
    // MARK: - DynamicQrFlow
    
    /// Dynamic qr url
    public var dynamicQrURL: URL?
    
    /// Dynamic qr input text
    public var dynamicQrSumText = ""
    
    /// Indicates is generating in progress
    public var isGenerateQRAvailable = false
    
    /// Current selected currency with balance
    public var selectedCurrency: CurrencyBalancePlainObject
    
    /// All user possible currecies
    public var possibleCurrencies: [CurrencyBalancePlainObject]
    
    // MARK: - Children
    
    /// Share sheet state instance
    @Presents public var shareSheet: ShareSheetState<PayQRReceivingAction>?
    
    /// `AlertState` instance
    ///
    /// It's an instance of `Alert` submodule.
    /// We use it here to be able to integrate `Alert` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `Alert` module all changes will be saved here.
    @Presents public var alert: AlertState<DXAlertAction>?
}

// MARK: - Initializers

extension PayQRReceivingState {
    
    public init(defaultCurrency: CurrencyBalancePlainObject, currencies: [CurrencyBalancePlainObject]) {
        self.selectedCurrency = defaultCurrency
        self.possibleCurrencies = currencies
    }
}
