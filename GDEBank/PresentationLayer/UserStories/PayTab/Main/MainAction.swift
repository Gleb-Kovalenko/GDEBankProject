//
//  MainAction.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import GDEBankCore
import Foundation
import TCANetworkReducers

// MARK: - MainAction

@CasePathable
public enum MainAction {
    
    // MARK: - Cases
    
    /// General action that calls when view appears
    case onAppear
    
    /// An action that calls when need to set new currency
    case setCurrency(CurrencyType)
    
    /// An action that calls when user taps on the `Transfer` button
    case transferButtonTapped
    
    /// An action that calls when user taps on the `Receive` button
    case receiveButtonTapped
    
    /// An action that calls when user taps on the `Reload` button
    case reloadButtonTapped
    
    /// Child action for `LanguageMenu` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `languageMenu` case means that every action in `LanguageMenu` module
    /// will be sent to current module through it
    case languageMenu(LanguageMenuAction)
    
    // MARK: - Children
    
    /// Error alert action
    case alert(PresentationAction<DXAlertAction>)
    
    /// Child action for `TransactionList` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `transactionList` case means that every action in `TransactionList` module
    /// will be sent to current module through it
    case transactionList(TransactionListAction)
    
    // MARK: - Pagination
    
    case reloadableMain(DXPaginationAction<TransactionPlainObject, NSError>)
    
    // MARK: - Service
    
    case payProfileObtained(Result<PayProfilePlainObject, NSError>)
}
