//
//  UIState.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 02.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - UIState

public enum UIState: Equatable {
    
    // MARK: - Cases
    
    case normal
    case error(isBorderColorEnabled: Bool = true)
}
