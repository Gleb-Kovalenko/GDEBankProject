//
//  PathAction.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 16.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture

// MARK: - PathAction

public enum PathAction<R: Reducer> {
    
    // MARK: - Cases
    
    /// Push screen with state
    case push(R.State)
    
    /// Pop to element with specified id
    case popTo(id: StackElementID)
    
    /// Pop from element with specified id
    case popFrom(id: StackElementID)
    
    /// Go to previous screen
    case goBack
    
    /// Go to current module root
    case popToRoot
    
    /// Go to app module root
    case popToAppRoot
    
    /// Go to current module root
    case removeLast(Int)
    
    /// None (instead of optional)
    case none
    
    // MARK: - Useful
    
    public func convert<OtherReducer: Reducer>(
        stateTransform: (R.State) -> OtherReducer.State
    ) -> PathAction<OtherReducer> {
        switch self {
        case let .push(state):
            return .push(stateTransform(state))
        case let .popTo(id):
            return .popTo(id: id)
        case let .popFrom(id):
            return .popFrom(id: id)
        case .goBack:
            return .goBack
        case .popToRoot:
            return .popToRoot
        case .popToAppRoot:
            return .popToAppRoot
        case .none:
            return .none
        case let .removeLast(count):
            return .removeLast(count)
        }
    }
}
