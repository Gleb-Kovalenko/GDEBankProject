//
//  DXCalendarState.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 05.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - DXCalendarState

@ObservableState
public struct DXCalendarState: Equatable {
    
    // MARK: - Properties
    
    /// The minimum selectable date in the calendar.
    public var minimumDate: Date
    
    /// The maximum selectable date in the calendar.
    public var maximumDate: Date
    
    /// The initially selected date in the calendar, if any.
    public var defaultSelectedDate: Date?
    
    /// The locale used for displaying the calendar.
    @Shared(.appLanguage)
    public var language: AppLanguage = AppLanguage.default
}

// MARK: - Initializers

extension DXCalendarState {
    
    public init(
        minimumDate: Date = .distantPast,
        maximumDate: Date = .distantFuture,
        defaultSelectedDate: Date? = nil
    ) {
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.defaultSelectedDate = defaultSelectedDate
    }
}
