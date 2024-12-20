//
//  TransferService.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 12.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

// MARK: - TransferService

public protocol TransferService {
    
    /// Obtain payment methods by wallet type.
    ///
    /// **Useful:**
    /// - `GET`
    /// - `profile/wallet/payment`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/poluchit-dostupnye-metody-dlya-perevoda-ili-popolneniya
    ///
    /// - Parameters:
    ///   - walletType: The type of wallet for which payment methods should be obtained.
    /// - Returns: Detailed payment data.
    /// - Throws: An error if the operation fails.
    func obtainPaymentDetails(
        walletType: CurrencyType
    ) async throws -> PaymentDetailsPlainObject
    
    /// Perform an IBAN transfer for the specified wallet.
    ///
    /// **Useful:**
    /// - `POST`
    /// - `profile/transfer/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/perevody-iban
    ///
    /// - Parameters:
    ///   - currency: The currency type of the wallet used for the transfer.
    ///   - amount: The amount to transfer.
    ///   - iban: The IBAN (International Bank Account Number) of the recipient.
    ///   - fullName: The full name of the recipient.
    /// - Returns: A Boolean value indicating whether the transfer was successful.
    /// - Throws: An error if the operation fails.
    func transferIBAN(
        currency: CurrencyType,
        amount: Double,
        iban: String,
        fullName: String
    ) async throws -> TransactionPlainObject.ID
    
    /// Perform an card transfer for the specified wallet.
    ///
    /// **Useful:**
    /// - `POST`
    /// - `profile/transfer/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/perevody-card
    ///
    /// - Parameters:
    ///   - currency: The currency type of the wallet used for the transfer.
    ///   - amount: The amount to transfer.
    ///   - cardNumber: Card number
    ///   - fullName: The full name of the recipient.
    /// - Returns: A Boolean value indicating whether the transfer was successful.
    /// - Throws: An error if the operation fails.
    func transferCard(
        currency: CurrencyType,
        amount: Double,
        fullName: String,
        cardNumber: String
    ) async throws -> TransactionPlainObject.ID
    
    /// Perform an crypto transfer for the specified wallet.
    ///
    /// **Useful:**
    /// - `POST`
    /// - `profile/transfer/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/perevody-crypto
    ///
    /// - Parameters:
    ///   - currency: The currency type of the wallet used for the transfer.
    ///   - amount: The amount to transfer.
    ///   - network: Network name
    ///   - address: Crypto wallet address
    ///   - memo: Crypto wallet memo
    /// - Returns: A Boolean value indicating whether the transfer was successful.
    /// - Throws: An error if the operation fails.
    func transferCrypto(
        currency: CurrencyType,
        amount: Double,
        network: String,
        address: String,
        memo: String?
    ) async throws -> TransactionPlainObject.ID
    
    /// Check network address
    ///
    /// **Useful:**
    /// - `POST`
    /// - `profile/transfer/validateCryptoAddress/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/validaciya-kripto-adresa
    ///
    /// - Parameters:
    ///   - network: Network name
    ///   - address: Crypto wallet address
    /// - Returns: A Boolean value indicating whether the transfer was successful.
    /// - Throws: An error if the operation fails.
    func checkAddress(
        network: String,
        address: String
    ) async throws -> Bool
}
