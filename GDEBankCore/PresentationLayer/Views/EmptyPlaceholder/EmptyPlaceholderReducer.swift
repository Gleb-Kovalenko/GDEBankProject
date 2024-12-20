//
//  EmptyPlaceholderReducer.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - EmptyPlaceholderReducer

public struct EmptyPlaceholderReducer: Reducer {
    
    // MARK: - Feature
    
    public var body: some Reducer<EmptyPlaceholderState, EmptyPlaceholderAction> {
        Reduce { state, action in
            switch action {
            default:
                break
            }
            return .none
        }
    }
}
