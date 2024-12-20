//
//  ActionListView.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - ActionListView

@WithLocalizationUpdater
public struct ActionListView<Payload: ActionListItemState>: View {
    
    // MARK: - Properties
    
    /// The store powering the `ActionList` feature
    public let store: StoreOf<ActionList<Payload>>

    // MARK: - Initializers

    /// Default initializer
    /// - Parameter store: The store powering the `ActionList` feature
    public init(store: StoreOf<ActionList<Payload>>) {
        self.store = store
    }

    // MARK: - View

    public var body: some View {
        WithPerceptionTracking {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(store.actionItems, id: \.title) { payload in
                        ActionListItemView(payload: payload) { item in
                            store.send(.onTap(item))
                        }
                        .frame(height: ActionListViewConstants.itemHeight)
                        .clipShape(Rectangle())
                    }
                }
            }
        }
    }
}

// MARK: - ActionListViewConstants

public enum ActionListViewConstants {
    public static let itemHeight: CGFloat = 50
}

// MARK: - PresentationDetent

public extension PresentationDetent {
    
    /// Creates a custom presentation detent based on the number of items in the action list.
    ///
    /// This function calculates the height of the detent by multiplying the number
    /// of items by a constant item height and adding an extra space.
    ///
    /// - Parameter count: The number of items in the action list.
    /// - Returns: A custom `PresentationDetent` with the calculated height.
    static func actionListHeight(count: Int) -> Self {
        .height(CGFloat(count) * ActionListViewConstants.itemHeight + 100)
    }
}
