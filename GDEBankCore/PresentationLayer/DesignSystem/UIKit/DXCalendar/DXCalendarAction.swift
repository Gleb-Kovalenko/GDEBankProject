//
//  DXCalendarAction.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 05.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - DXCalendarAction

@CasePathable
public enum DXCalendarAction: Equatable {
    
    // MARK: - Cases
    
    /// An action that calls when some date selected
    case onDateSelection(Date)
}
