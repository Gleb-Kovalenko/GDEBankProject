//
//  VerificationSuccess.swift
//  GDEBankCore
//
//  Created by Andrey Barsukov on 23.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture

// MARK: - VerificationSuccess

@Reducer
public struct VerificationSuccess: Reducer {
    
    // MARK: - Aliases
    
    public typealias State = VerificationSuccessState
    public typealias Action = VerificationSuccessAction
    
    // MARK: - Reducer
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .buttonTapped:
                return .none
            }
            return .none
        }
    }
}
