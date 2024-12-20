//
//  Double.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 15.08.2024.
//

import Foundation

// MARK: - Double

extension Double {
    
    public func formatWithDotSeperator(minDigits: Int = 0, maxDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ""
        formatter.minimumFractionDigits = minDigits
        formatter.maximumFractionDigits = maxDigits
        return formatter.string(for: self) ?? "0.0"
    }
    
    public func formatWithSpaceSeparatorText(maxFragtionDigits: Int = 0) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maxFragtionDigits
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        return formatter.string(for: self) ?? "0.0"
    }
    
    public var defaultBalanceFormatText: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        return formatter.string(for: self) ?? "0.0"
    }
    
    public var toDate: Date {
        Date(timeIntervalSince1970: self)
    }
    
    public func roundedPriceString() -> String {
        let roundedPrice = Double(Int(self * 10)) / 10
        if roundedPrice == Double(Int(roundedPrice)) {
            return String(Int(roundedPrice))
        }
        return String(roundedPrice).replacingOccurrences(of: ".", with: ",")
    }
    
    public func formatCurrency(_ currency: CurrencyType, withCurrencySymbol: Bool = true) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ""
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = switch currency.group {
        case .crypto: AppConstants.Business.Currency.cryptoRound
        case .fiat: AppConstants.Business.Currency.fiatRound
        }
        if withCurrencySymbol, let currencySymbol = currency.currencySymbol {
            formatter.numberStyle = .currency
            formatter.currencyCode = currency.rawValue
            formatter.currencySymbol = currencySymbol
        }
        var suffix = ""
        if case .crypto = currency.group, withCurrencySymbol {
            suffix = " " + currency.shortName
        }
        return (formatter.string(for: self) ?? "0.0") + suffix
    }
}
