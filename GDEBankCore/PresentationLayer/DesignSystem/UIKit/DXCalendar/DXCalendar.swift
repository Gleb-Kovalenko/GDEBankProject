//
//  DXCalendar.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 05.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - DXCalendar

@Reducer
public struct DXCalendar: Reducer {

    // MARK: - Aliases
    
    public typealias State  = DXCalendarState
    public typealias Action = DXCalendarAction
    
    // MARK: - Initializers
    
    public init() {
    }
    
    // MARK: - Feature

    public var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
