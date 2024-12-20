//
//  DXAlertAction.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 22.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - DXAlertAction

public enum DXAlertAction: Equatable {
    
    // MARK: - Cases
    
    case dismiss
}

extension AlertState where Action == DXAlertAction {
    
    public static func show(error: NSError) -> Self {
        Self {
            TextState(L10n.General.error)
        } actions: {
            ButtonState(action: .dismiss) {
                TextState("OK")
            }
        } message: {
            TextState(error.errorMessage)
        }
    }
}
