//
//  MainState.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import GDEBankCore
import TCANetworkReducers

// MARK: - MainState

@ObservableState
public struct MainState: Equatable {
    
    // MARK: - Properties
    
    /// Current currency
    public var currency: CurrencyType?
    
    /// Currency balance
    public var currencyBalance: Double?
    
    /// Accounts
    public var accounts = [CurrencyBalancePlainObject]()
    
    /// Transactions
    public var transactions = [TransactionPlainObject]()
    
    /// Indicates is remoting operation now
    public var isRemotingOperation = false
    
    /// Indicates is reloading in progress
    public var isReloadingInProgress = false
    
    /// Current chosen language
    @Shared(.appLanguage)
    public var currentLanguage = AppLanguage.default
    
    /// Module localization
    public var l10n: MainViewLocalization
    
    // MARK: - Children
    
    /// Error alert state instnace
    @Presents public var alert: AlertState<DXAlertAction>?
    
    /// `TransactionListState` instance
    ///
    /// It's an instance of `TransactionList` submodule.
    /// We use it here to be able to integrate `TransactionList` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `TransactionList` module all changes will be saved here.
    public var transactionList = TransactionListState()
    
    /// `LanguageMenuState` instance
    ///
    /// It's an instance of `LanguageMenu` submodule.
    /// We use it here to be able to integrate `LanguageMenu` feature into a current module logic.
    /// All necessary processing is placed inside current reducer. Also, if you change the state
    /// inside the `LanguageMenu` module all changes will be saved here.
    public var languageMenu = LanguageMenuState()
    
    // MARK: - Pagination
    
    /// PaginationState instance
    public var reloadableMain: DXIDPaginationState<TransactionPlainObject, CurrencyType>?
}

// MARK: - Initializers

extension MainState {
    
    /// Default initializer
    public init() {
        self.l10n = .default
    }
}
