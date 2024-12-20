//
//  Date.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 13.08.24.
//

import Foundation

// MARK: - Date

extension Date {
    
    public var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    public var withMidnightTime: Date? {
        var noTimeZoneCalendar = calendar
        noTimeZoneCalendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        return noTimeZoneCalendar.date(bySettingHour: 0, minute: 0, second: 0, of: self)
    }
    
    public var defaultFormatString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }
    
    public var shortStringFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    public var formattedWithTimeAndDash: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd — HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    public var formattedWithTimeAndComma: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy, HH:mm"
        return formatter.string(from: self)
    }
    
    public var reversedFormatString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    public var withWeekdayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, EEE"
        dateFormatter.locale = UserDefaults.standard.retrieveLocale()
        return dateFormatter.string(from: self)
    }
    
    public func convertToTextFormat() -> String {
        let withoutYearFormatter = DateFormatter()
        withoutYearFormatter.locale = Locale.current
        withoutYearFormatter.dateFormat = "d MMMM"
        let withYearFormatter = DateFormatter()
        withYearFormatter.locale = Locale.current
        withYearFormatter.dateFormat = "d MMMM YYY"
        let calendar = Calendar.current
        let date1Components = calendar.dateComponents([.year], from: Date())
        let date2Components = calendar.dateComponents([.year], from: self)
        return date1Components.year == date2Components.year
        ? withoutYearFormatter.string(from: self)
        : withYearFormatter.string(from: self)
    }
    
    public func isToday(weekday: Weekday) -> Bool {
        let todayWeekday = self.weekday
        return weekday.rawValue == todayWeekday
    }
    
    public var timeInSeconds: Double {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: self)
        return Double(components.hour ?? 0) * 3600 + Double(components.minute ?? 0) * 60 + Double(components.second ?? 0)
    }
    
    public var weekday: Int {
        (calendar.component(.weekday, from: self) - calendar.firstWeekday + 7) % 7 + 1
    }
    
    public var calendar: Calendar { Calendar.current }
}
