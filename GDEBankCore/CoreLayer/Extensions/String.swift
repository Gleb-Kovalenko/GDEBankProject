//
//  String.swift
//  Reviews
//
//  Created by Dmitry Savinov on 13.08.2024.
//

import Foundation

// MARK: - String

extension String {
    
    /// Creating the correct date type format from string type
    /// - Returns: Correct date format
    public func asDate() -> Date? {
        dateFromISO8601Format() ?? dateFromMediumFormat()
    }
    
    public func dateFromISO8601Format() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let fractionDate = dateFormatter.date(from: self)
        dateFormatter.formatOptions = [.withInternetDateTime]
        let nonFractionDate = dateFormatter.date(from: self)
        return fractionDate ?? nonFractionDate
    }
    
    public func dateFromMediumFormat() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.date(from: self)
    }
    
    /// Returns a string with two dots in the center and a specified number of characters visible from the end.
    ///
    /// - Parameter visibleCount: The number of characters to show from the end of the string.
    /// - Returns: A formatted string with two dots in the center and visible characters from the end.
    public func obscured(withVisibleCount visibleCount: Int) -> String {
        guard visibleCount > 0 else { return "" }
        let visiblePart = self.suffix(visibleCount)
        return "··\(visiblePart)"
    }
    
    public func extractTextInParentheses() -> String {
        let pattern = "\\(([^)]+)\\)"
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: self.utf16.count)
            
            if let match = regex.firstMatch(in: self, options: [], range: range) {
                let matchRange = match.range(at: 1)
                if let swiftRange = Range(matchRange, in: self) {
                    return String(self[swiftRange])
                }
            }
        } catch {
            return self
        }
        return self
    }
    
    public func expieryFormat() -> String {
        let cleanText = filter { $0.isNumber }
        let trimmedText = String(cleanText.prefix(4))
        switch trimmedText.count {
        case 0, 2:
            return trimmedText
        case 1:
            return "01".contains(trimmedText) ? trimmedText : "0\(trimmedText)"
        default:
            let startIndex = trimmedText.startIndex
            let month = String(trimmedText[startIndex..<trimmedText.index(startIndex, offsetBy: 2)])
            let year = String(trimmedText[trimmedText.index(startIndex, offsetBy: 2)...])
            let validMonth = min(max(Int(month) ?? 1, 1), 12)
            return String(format: "%02d / %@", validMonth, year)
        }
    }
    
    public var extractedMonthAndYear: (month: Int, year: Int)? {
        let components = self.split(separator: "/").map { $0.trimmingCharacters(in: .whitespaces) }
        guard components.count == 2,
              let month = Int(components[0]), (1...12).contains(month),
              let year = Int(components[1]) else {
            return nil
        }
        return (month: month, year: year)
    }
    
    public func uppercasedFirstLetter() -> String {
        prefix(1).uppercased().appending(dropFirst())
    }
    
    public func nilIf(_ condition: Bool) -> String? {
        condition ? nil : self
    }

    public var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var isOnlyDigits: Bool {
        digits == self
    }
    
    var isRemoteURL: Bool {
        URL(string: self) != nil && hasPrefix("http")
    }
    
    func changeEmpty(on text: String) -> String {
        isEmpty ? text : self
    }
    
    func appending(_ string: String, if condition: Bool) -> String {
        condition ? self + string : self
    }

    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var isValidPhone: Bool {
        count > 10 && count < 16
    }

    /// Checks if the string meets the password criteria:
    ///
    /// - At least 6 characters long.
    /// - Contains at least one uppercase letter.
    /// - Contains at least one lowercase letter.
    /// - Contains at least one digit.
    /// - Contains at least one special character.
    ///
    /// - Returns: `true` if the string meets the criteria, otherwise `false`.
    var isValidPassword: Bool {
        if AppConstants.Business.useMock {
            return count >= 8
        } else {
            let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&/]{8,}$"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            return passwordTest.evaluate(with: self)
        }
    }
    
    public var isValidCardExpiery: Bool {
        guard let (month, year) = self.extractedMonthAndYear else {
            return false
        }

        let calendar = Calendar.current
        let currentDate = Date()
        
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate) % 100
        return currentYear < year || (currentMonth <= month && currentYear == year)
    }

    public func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        return formatter.number(from: self)?.doubleValue
    }
}

// MARK: - StringProtocol

extension StringProtocol {

    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }

    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }

    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }

    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        self[index(startIndex, offsetBy: range.lowerBound)...]
    }

    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        self[...index(startIndex, offsetBy: range.upperBound)]
    }

    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        self[..<index(startIndex, offsetBy: range.upperBound)]
    }
}
