//
//  Date+Random.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 15.08.2024.
//

import Foundation

// MARK: - Date

extension Date {
    
    public static func random() -> Date {
        Date(timeIntervalSince1970: TimeInterval.random(in: 1690038044..<1700038044))
    }
}
