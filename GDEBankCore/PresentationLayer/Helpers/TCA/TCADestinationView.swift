//
//  TCADestinationView.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 16.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

// MARK: - TCADestinationView

public struct TCADestinationView<State: CaseReducerState, Action, Content: View>: View where Action == State.StateReducer.Action {
    
    // MARK: - Properties
    
    /// Destination store
    public let store: Store<State, Action>
    
    /// Destination content
    public let content: (State.StateReducer.CaseScope) -> Content
    
    // MARK: - Initializers
    
    /// Initializes a new instance of `TCADestinationView`.
    ///
    /// This initializer accepts a store that holds the state and actions that manage the view's state,
    /// along with a closure that generates the content based on the state scope.
    ///
    /// - Parameters:
    ///   - store: A `Store` containing the state and actions that govern the view's state.
    ///   - content: A `@ViewBuilder` closure that takes a `State.StateReducer.CaseScope`
    ///     and returns the content to be displayed in the view.
    public init(
        store: Store<State, Action>,
        @ViewBuilder content: @escaping (State.StateReducer.CaseScope) -> Content
    ) {
        self.store = store
        self.content = content
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            content(store.case)
        }
    }
}
