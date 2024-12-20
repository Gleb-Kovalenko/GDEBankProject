//
//  ActionListAction.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - ActionListAction

@CasePathable
public enum ActionListAction<Payload: ActionListItemState>: Equatable {
    
    // MARK: - Cases
    
    /// General action that calls when view appears
    case onAppear
    
    /// General action that calls when view disappears
    case onDisappear

    /// Some item has been tapped
    case onTap(Payload)
    
    /// An action that calls when close button tapped
    case closeButtonTapped
}
