//
//  TransactionItemView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - TransactionItemView

@WithLocalizationUpdater
public struct TransactionItemView: View {
    
    // MARK: - Properties
    
    /// The store powering the `TransactionItem` reducer
    public let store: StoreOf<TransactionItem>

    /// The appearance settings for the view.
    public let appearance: TransactionItemViewAppearance
    
    // MARK: - Initialization

    /// Initializes a new instance of `TransactionItemView`.
    /// - Parameters:
    ///   - store: The store powering the `TransactionItem` reducer.
    public init(store: StoreOf<TransactionItem>) {
        self.store = store
        self.appearance = .default
    }
    
    /// Initializes a new instance of `TransactionItemView`.
    /// - Parameters:
    ///   - store: The store powering the `TransactionItem` reducer.
    ///   - appearance: The appearance settings for the view. Defaults to `.default`.
    public init(
        store: StoreOf<TransactionItem>,
        appearance: TransactionItemViewAppearance
    ) {
        self.store = store
        self.appearance = appearance
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            HStack(spacing: 0) {
                CircledImage(imageURL: store.imageURL)
                    .padding(.trailing, 12)
                VStack(alignment: .leading, spacing: 4) {
                    Text(store.name)
                        .font(appearance.titleFont)
                        .foregroundStyle(appearance.titleColor)
                    Text(store.description)
                        .font(appearance.subtitleFont)
                        .foregroundStyle(appearance.subtitleColor)
                }
                Spacer(minLength: 4)
                Text(store.amountText)
                    .font(appearance.amountTextFont)
                    .foregroundStyle(appearance.amountTextColor(store.direction))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                store.send(.onTap)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TransactionItemView(
        store: Store(
            initialState: TransactionItemState(plain: .random()),
            reducer: { TransactionItem() }
        )
    )
}
