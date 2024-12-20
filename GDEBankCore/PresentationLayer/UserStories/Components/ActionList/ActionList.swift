//
//  ActionList.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - ActionList

@Reducer
public struct ActionList<Payload: ActionListItemState> {

    // MARK: - Aliases

    public typealias State  = ActionListState<Payload>
    public typealias Action = ActionListAction<Payload>
    
    // MARK: - Initializers
    
    public init() {
    }

    // MARK: - Feature

    public var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
