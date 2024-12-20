//
//  TimeInterval.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 14.08.24.
//

import Foundation

// MARK: - TimeInterval

extension TimeInterval {

    /// Converts seconds into correct time format
    /// - Returns: time format
    func convertToTimeFormat() -> String {
        let hours = Int(self / 3600)
        let minutes = (Int(self) - hours * 3600) / 60
        let hoursString = "\(hours)"
        let minutesString = minutes < 10 ? "0\(minutes)" : "\(minutes)"
        return hoursString + ":" + minutesString
    }
}

// MARK: - Randomable

extension TimeInterval: Randomable {
    
    public static func random() -> Self {
        Date.random().timeIntervalSince1970
    }
}
