//
//  TransactionListState.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - TransactionListState

@ObservableState
public struct TransactionListState: Equatable {
    
    // MARK: - ItemsWithDate
    
    public struct ItemsWithDate: Equatable {
        
        // MARK: - Properties
        
        /// Date
        public var date: Date
        
        /// Items ids
        public var ids: [TransactionPlainObject.ID]
        
        // MARK: - Initializer
        
        public init(date: Date, ids: [TransactionPlainObject.ID]) {
            self.date = date
            self.ids = ids
        }
    }
    
    // MARK: - Properties
    
    /// Items with dates
    public var itemsWithDates = [ItemsWithDate]()
    
    /// Indicates is data obtained
    public var isDataObtained = false
    
    // MARK: - Children
    
    /// Identified array of `TransactionItemState`
    ///
    /// It's represents children of `TransactionItemState` module.
    /// We use it here to integrate `TransactionItemState` array logic inside current module.
    /// If you change the state inside one of the `TransactionItemState` module items then all changes will be saved here.
    public var transactionItems: IdentifiedArrayOf<TransactionItemState>
}

// MARK: - Initailziers

extension TransactionListState {
    
    public init() {
        self.transactionItems = []
    }
}
