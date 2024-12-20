//
//  TransactionListView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - TransactionListView

@WithLocalizationUpdater
public struct TransactionListView: View {
    
    // MARK: - Properties
    
    /// The store powering the `TransactionList` feature
    public let store: StoreOf<TransactionList>
    
    /// The appearance settings for the view.
    public let appearance: TransactionListViewAppearance
    
    // MARK: - Initialization

    /// Initializes a new instance of `TransactionListView`.
    /// - Parameters:
    ///   - store: The store powering the `TransactionList` reducer.
    ///   - appearance: The appearance settings for the view. Defaults to `.default`.
    public init(
        store: StoreOf<TransactionList>,
        appearance: TransactionListViewAppearance = .default
    ) {
        self.store = store
        self.appearance = appearance
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            Group {
                if store.itemsWithDates.isEmpty && store.isDataObtained {
                    TransactionListEmptyView()
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                } else {
                    ForEach(Array(store.itemsWithDates.enumerated()), id: \.offset) { index, item in
                        VStack(alignment: .leading, spacing: 16) {
                            Text(item.date.withWeekdayString)
                                .font(appearance.dateTextFont)
                                .foregroundStyle(appearance.dateTextColor)
                                .lineLimited()
                            ForEach(item.ids, id: \.self) { id in
                                IfLetStore(
                                    store.scope(
                                        state: \.transactionItems[id: id],
                                        action: \.transactionItem[id: id]
                                    ),
                                    then: TransactionItemView.init
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TransactionListView(
        store: Store(
            initialState: TransactionListState(),
            reducer: { TransactionList() }
        )
    )
}
