//
//  SelectableButtonAction.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - SelectableButtonAction

@CasePathable
public enum SelectableButtonAction: Equatable {
    
    // MARK: - Cases
    
    /// On action that calls when button tapped
    case onTap
}
