//
//  WeekDay.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 15.08.24.
//

import Foundation

// MARK: - Weekday

public enum Weekday: Int, CaseIterable, Equatable, Codable {

    static let weekdaysCount = 7

    // MARK: - Cases

    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    // MARK: - Useful

    /// Next weekday
    public var next: Weekday {
        Weekday(rawValue: (rawValue + 1) % Weekday.weekdaysCount).unsafelyUnwrapped
    }
    
    /// Indicates is today this weekday
    public var isToday: Bool {
        Date().isToday(weekday: self)
    }
    
    public var currentTime: Double {
        Date().timeInSeconds
    }
}
