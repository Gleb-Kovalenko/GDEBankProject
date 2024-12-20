//
//  PayLogin.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - PayLogin

@Reducer
public struct PayLogin {

    // MARK: - Aliases

    public typealias State  = PayLoginState
    public typealias Action = PayLoginAction
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                break
            }
            return .none
        }
    }
}
