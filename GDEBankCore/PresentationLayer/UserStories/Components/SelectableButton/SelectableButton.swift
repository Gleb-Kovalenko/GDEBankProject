//
//  SelectableButtonReducer.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - SelectableButton

@Reducer
public struct SelectableButton<ChildObject: Equatable & Identifiable>: Reducer {
    
    // MARK: - Aliases

    public typealias State  = SelectableButtonState<ChildObject>
    public typealias Action = SelectableButtonAction
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onTap:
                guard !state.isSelected || state.uncheckedAllowed else { return .none }
                state.isSelected.toggle()
            }
            return .none
        }
    }
}
