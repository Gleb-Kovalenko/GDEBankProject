//
//  ActionListState.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - ActionListState

@ObservableState
public struct ActionListState<Payload: ActionListItemState>: Equatable {
    
    // MARK: - Properties

    /// Action items array
    public let actionItems: [Payload]
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameter actionItems: Action items array
    public init(actionItems: [Payload]) {
        self.actionItems = actionItems
    }
}
