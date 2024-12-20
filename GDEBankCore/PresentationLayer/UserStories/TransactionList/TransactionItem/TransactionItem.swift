//
//  TransactionItem.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - TransactionItem

@Reducer
public struct TransactionItem {

    // MARK: - Aliases

    public typealias State  = TransactionItemState
    public typealias Action = TransactionItemAction
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
