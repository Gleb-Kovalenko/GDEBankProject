//
//  Int.swift
//  GDEBank
//
//  Created by incetro on 12/27/23.
//

import Foundation

extension Int {

    func timeString() -> String {
        var components: [Int] = []
        if self / 60 > 0 {
            components.append(self / 60)
        }
        if self % 60 > 0 {
            components.append(self % 60)
        }
        return components.map(String.init).joined(separator: ":")
    }
    
    func toHoursMinutesSeconds() -> (Int, Int, Int) {
        (self / 3_600, (self % 3_600) / 60, (self % 3_600) % 60)
    }
    
    /// Creating the correct date type format from string type
    /// - Returns: Correct date format
    public func asDate() -> Date? {
        dateFromISO8601Format() ?? dateFromMediumFormat()
    }
    
    public func dateFromISO8601Format() -> Date? {
        let timeInterval = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let fractionDate = dateFormatter.date(from: timeInterval.description)
        dateFormatter.formatOptions = [.withInternetDateTime]
        let nonFractionDate = dateFormatter.date(from: timeInterval.description)
        return fractionDate ?? nonFractionDate
    }
    
    public func dateFromMediumFormat() -> Date? {
        let timeInterval = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.date(from: timeInterval.description)
    }
    
    public var distanceTextKey: String {
        let distance = self
        if distance < 1_000 {
            return "\(distance) m"
        } else if distance < 1_000_000 {
            let double = Double(round(Double(distance) / 1_000 * 10) / 10)
            return "\(Int(double)) km"
        } else {
            return "\(distance / 1000) km"
        }
    }
}
