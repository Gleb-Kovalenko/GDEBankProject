//
//  TransactionListAction.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - TransactionListAction

@CasePathable
public enum TransactionListAction {
    
    // MARK: - Cases
    
    /// An action that calls when data obtained
    case dataObtained([TransactionPlainObject], merge: Bool)
    
    /// An action that calls when error obtained
    case errorObtained(NSError)
    
    /// An action that calls when need to clear items
    case reset
    
    // MARK: - Children
    
    /// Child action for `TransactionItem` module.
    ///
    /// It's necessary as we use `ForEach` scope operator in current module's reducer.
    /// In short, the `transactionItem` case means that every action in `TransactionItem` module
    /// will be sent to current module with target element identifier
    case transactionItem(IdentifiedActionOf<TransactionItem>)
}
