//
//  TCASwitchStoreView.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 16.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// MARK: - TCASwitchStoreView

public struct TCASwitchStoreView<State, Action, Content: View>: View {
    
    // MARK: - Properties
    
    /// Destination store
    public let store: Store<State, Action>
    
    /// Destination content
    public let content: (State) -> Content
    
    // MARK: - Initializers
    
    /// Initializes a new instance of `TCASwitchStoreView`.
    ///
    /// This initializer accepts a store that manages the state and actions for switching between different views,
    /// and a closure that generates the content based on the current state.
    ///
    /// - Parameters:
    ///   - store: A `Store` that holds the state and manages the actions for switching between different views.
    ///   - content: A `@ViewBuilder` closure that takes the current state and returns the view content to be displayed.
    public init(
        store: Store<State, Action>,
        @ViewBuilder content: @escaping (State) -> Content
    ) {
        self.store = store
        self.content = content
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            SwitchStore(store) {
                content($0)
            }
        }
    }
}
