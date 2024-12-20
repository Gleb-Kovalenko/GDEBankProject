//
//  TransactionList.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - TransactionList

@Reducer
public struct TransactionList {

    // MARK: - Aliases

    public typealias State  = TransactionListState
    public typealias Action = TransactionListAction
    
    // MARK: - Initializers
    
    /// Default initializer
    public init() {}
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .dataObtained(data, merge):
                let newItems = data.map(TransactionItemState.init)
                if merge {
                    state.transactionItems += newItems
                } else {
                    state.transactionItems = IdentifiedArray(uniqueElements: newItems)
                    state.itemsWithDates.removeAll()
                }
                newItems.forEach {
                    if let date = $0.date.withMidnightTime {
                        if let index = state.itemsWithDates.firstIndex(where: { $0.date == date }) {
                            state.itemsWithDates[index].ids.append($0.id)
                        } else {
                            state.itemsWithDates.append(State.ItemsWithDate(date: date, ids: [$0.id]))
                        }
                    }
                }
                state.isDataObtained = true
            case .reset:
                state.itemsWithDates.removeAll()
                state.transactionItems = []
                state.isDataObtained = false
            default:
                break
            }
            return .none
        }
        .forEach(\.transactionItems, action: \.transactionItem) {
            TransactionItem()
        }
    }
}
