//
//  String+Random.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 14.08.2024.
//

import Foundation

// MARK: - String+Random

extension String {

    /// A string containing all digits from 0 to 9.
    /// Can be used as a sequence for generating random numeric strings.
    public static let digits = "0123456789"
    
    /// Generates a random string of the specified length from the given character sequence.
    /// - Parameters:
    ///   - sequence: The string containing characters to pick from.
    ///   - length: The length of the random string to generate.
    /// - Returns: A random string of the specified length, containing characters
    ///   from the provided sequence.
    public static func random(from sequence: String, ofLength length: Int) -> String {
        String((0..<length).compactMap { _ in sequence.randomElement() })
    }
    
    /// Generates a random UUID string in the standard format.
    /// - Returns: A string representing a random UUID, useful as a unique identifier.
    public static func randomID() -> String {
        UUID().uuidString
    }
    
    // MARK: - User
    
    /// Generates a random author name from a predefined list of names.
    /// - Returns: A randomly selected name.
    public static func randomName() -> String {
        [
            "Cayden Mata",
            "Phyllis Strickland",
            "Monty Dillon",
            "Duncan Larson",
            "Keelan Pitts",
            "Finnley Holder",
            "Jason Campos",
            "Arron Murray",
            "Bradley Tyler",
            "Monica Ray",
            "Melissa Bass",
            "Aine Shaw",
            "Julie Bishop",
            "Elena Fuentes",
            "Coral Koch",
            "Jon Hubbard",
        ].randomElement().unsafelyUnwrapped
    }
    
    /// Generates a random social media platform name.
    /// - Returns: A randomly selected social media name.
    public static func randomSocialName() -> String {
        let socialsName = [
            "Telegram",
            "Instagram",
            "Whatapp"
        ]
        return socialsName.randomElement().unsafelyUnwrapped
    }
    
    /// Generates a random email address by combining a random username and domain.
    /// - Returns: A random email address.
    public static func randomEmail() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let usernameLength = Int.random(in: 5...10)
        let randomUsername = String((0..<usernameLength).map { _ in characters.randomElement().unsafelyUnwrapped })
        let domains = ["gmail.com", "yahoo.com", "outlook.com", "mail.com", "example.com"]
        let randomDomain = domains.randomElement().unsafelyUnwrapped
        return "\(randomUsername)@\(randomDomain)"
    }
    
    /// Generate random device name
    public static func randomDeviceName() -> String {
        let deviceNames = [
            /// iOS Devices
            "iPhone 12", "iPhone 12 Pro", "iPhone 13", "iPhone 13 Pro",
            "iPhone 14", "iPhone 14 Pro", "iPhone SE", "iPad Air",
            "iPad Pro", "MacBook Air", "MacBook Pro",
            
            /// Android Devices
            "Samsung Galaxy S21", "Samsung Galaxy Note 20", "Google Pixel 6",
            "Google Pixel 5", "OnePlus 9", "Xiaomi Mi 11", "Huawei P40",
            "Oppo Find X3", "Sony Xperia 1", "Motorola Edge"
        ]
        return deviceNames.randomElement().unsafelyUnwrapped
    }

    // MARK: - Language
    
    /// Generates a random service language from the available options.
    /// - Returns: A randomly selected language.
    public static func randomServiceLanguage() -> String {
        let languages = ["Russian", "English"]
        return languages.randomElement().unsafelyUnwrapped
    }
    
    // MARK: - Currency
    
    /// Generates a random currency symbol from the available options.
    /// - Returns: A randomly selected currency symbol.
    public static func randomCurrencySymbol() -> String {
        let currencySymbols = ["€", "$", "£"]
        return currencySymbols.randomElement().unsafelyUnwrapped
    }
    
    /// Generates a random currency name from the available options.
    /// - Returns: A randomly selected currency name.
    public static func randomCurrencyName() -> String {
        let currencyNames = ["Euro", "US Dollar", "British Pound"]
        return currencyNames.randomElement().unsafelyUnwrapped
    }
    
    /// Generates a random currency code from the available options.
    /// - Returns: A randomly selected currency code.
    public static func randomCurrencyCode() -> String {
        let codes = [
            "EUR",
            "RUB",
            "USD",
            "TRY"
        ]
        return codes.randomElement().unsafelyUnwrapped
    }
    
    // MARK: - Transaction
    
    /// Generates a random transaction name from the available options.
    /// - Returns: A randomly selected transaction name.
    public static func randomTransactionName() -> String {
        [
            "Пополнение",
            "Перевод на карту",
            "Конвертация",
        ].randomElement().unsafelyUnwrapped
    }
    
    /// Generates a random transaction name from the available options.
    /// - Returns: A randomly selected transaction name.
    public static func randomMethodName() -> String {
        [
            "Transfer to a card",
            "Transfer via IBAN",
            "Cash Withdrawal",
        ].randomElement().unsafelyUnwrapped
    }
    
    /// Generates a random transaction description.
    /// - Returns: A randomly selected transaction description.
    public static func randomTransactionDescription() -> String {
        [
            "Кому: **24124124",
            "D: 5121 07хх хх78 5577",
            "USD / USDT",
        ].randomElement().unsafelyUnwrapped
    }
    
    /// Generates a random transaction name and description pair.
    /// - Returns: A tuple containing a random transaction name and its corresponding description.
    public static func randomTransactionInfo() -> (name: String, description: String) {
        let pair = [
            "Пополнение": "Кому: **24124124",
            "Перевод на карту": "Кому: **24124124",
            "Конвертация" : "USD / USDT",
        ].randomElement().unsafelyUnwrapped
        return (name: pair.key, description: pair.value)
    }
    
    // MARK: - Cards
    
    /// Generates a random card expiration date in the format MM/YYYY.
    /// - Returns: A random expiration date.
    public static func randomExpiry() -> String {
        let month = Int.random(in: 1...12)
        let currentYear = Calendar.current.component(.year, from: Date())
        let year = Int.random(in: currentYear...(currentYear + 5))
        return String(format: "%02d/%d", month, year)
    }
    
    /// Generates a random 4-digit card number suffix.
    /// - Returns: A randomly selected 4-digit card number suffix.
    public static func randomLast4Digits() -> String {
        let last4Digits = Int.random(in: 0...9999)
        return String(format: "%04d", last4Digits)
    }
    
    // MARK: - Accounts
    
    public static func randomAccountID() -> String {
        String(String.randomID().dropFirst(10))
    }
    
    // MARK: - Requisites
    
    public static func randomIBAN() -> String {
        return "DE\(Int.random(in: 1000000000000000...9999999999999999))"
    }
    
    public static func randomBIC() -> String {
        return String((0..<8).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()! })
    }
    
    public static func randomBankName() -> String {
        let bankNames = ["GDEBank Finance LTD", "Global Bank", "EuroBank"]
        return bankNames.randomElement() ?? "GDEBank Finance LTD"
    }
    
    public static func randomAddress() -> String {
        let streetNumber = Int.random(in: 1...9999)
        let streetNames = ["Main St", "Elm St", "Maple Ave", "Broadway"]
        let cities = ["Some City", "Metropolis", "Gotham", "Springfield"]
        return "\(streetNumber) \(streetNames.randomElement() ?? "Main St"), \(cities.randomElement() ?? "Some City")"
    }
    
    public static func randomCountry() -> String {
        let countries = [
            "Dubai",
            "Germany",
            "England"
        ]
        return countries.randomElement().unsafelyUnwrapped
    }
    
    /// Generates a random crypto address (for illustration purposes).
    public static func randomCryptoAddress() -> String {
        let addressPrefixes = ["0x", "TK", "EQ"]
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let addressBody = String((0..<34).map { _ in characters.randomElement().unsafelyUnwrapped })
        return (addressPrefixes.randomElement() ?? "0x") + addressBody
    }
    
    public static func randomNetwork() -> String {
        ["Ethereum (ERC-20)", "Tron (TRC-20)", "Toncoin"].randomElement().unsafelyUnwrapped
    }
    
    public static func randomMemo() -> String {
        (0..<10).reduce("") { memo, _ in
            memo + "\(Int.random(in: 0...9))"
        }
    }
    
    public static func randomOrderNumber() -> String {
        (0..<6).reduce("") { number, _ in
            number + "\(Int.random(in: 0...9))"
        }
    }
    
    public static func randomWabadaNumber() -> String {
        [
            "AE28837083XXXXX",
            "BA25137083XXXXX",
            "LG28837083XXXTQW"
        ].randomElement().unsafelyUnwrapped
    }
    
    public static func randomComment() -> String {
        [
            "Top Up of Wabada balance. User token: fddfjke98",
            "Top Up of other balance. User token: gsfdgds23"
        ].randomElement().unsafelyUnwrapped
    }
}
