//
//  PayLoginAction.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - PayLoginAction

@CasePathable
public enum PayLoginAction: Equatable {
    
    // MARK: - Cases
    
    /// An action that calls when user taps on the `Connect` button
    case connectButtonTapped
}
