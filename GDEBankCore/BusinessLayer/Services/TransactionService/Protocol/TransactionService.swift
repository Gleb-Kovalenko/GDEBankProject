//
//  TransactionService.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - TransactionService

public protocol TransactionService {
    
    /// Obtain user transaction history
    ///
    /// **Useful:**
    /// - `GET`
    /// - `https://host.gdeBank.io/api/v1/profile/fiat_profile/getTransaction/?page={}`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/glavnaya-stranica-fiat
    ///
    /// - Parameters:
    ///   - page: page number to obtain
    /// - Returns: Pagination list with transactions.
    /// - Throws: An error if obtaining fails.
    func obtainTransactions(
        page: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject>
    
    /// Obtain first page of user transaction history
    ///
    /// **Useful:**
    /// - `GET`
    /// - `https://host.gdeBank.io/api/v1/profile/fiat_profile/getTransaction/?page={}`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/glavnaya-stranica-fiat
    ///
    /// - Returns: Pagination list with transactions.
    /// - Throws: An error if obtaining fails.
    func obtainFirstTransactionsPage() async throws -> [TransactionPlainObject]
    
    /// Obtain user transaction history
    ///
    /// **Useful:**
    /// - `GET`
    /// - `profile/history/?type={}&page={}`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/istoriya
    ///
    /// - Parameters:
    ///   - type: history type
    ///   - page: page number to obtain
    /// - Returns: Pagination list with transactions.
    /// - Throws: An error if obtaining fails.
    func obtainHistory(
        type: HistoryType,
        page: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject>
    
    /// Obtain transaction info
    ///
    /// **Useful:**
    /// - `GET`
    /// - `https://host.gdeBank.io/api/v1/profile/history/check/{id}`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/informaciya-o-tranzakcii
    ///
    /// - Parameters:
    ///   - id: transaction id
    /// - Returns: Transaction info.
    /// - Throws: An error if obtaining fails.
    func obtainTransaction(
        id: TransactionPlainObject.ID
    ) async throws -> TransactionPlainObject
    
    /// Obtain transaction receipt url
    ///
    /// **Useful:**
    /// - `POST`
    /// - `https://host.gdeBank.io/api/v1/profile/history/receipt/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/poluchit-chek-tranzakcii
    ///
    /// - Parameters:
    ///   - id: transaction id
    /// - Returns: Transaction receipt url.
    /// - Throws: An error if obtaining fails.
    func obtainReceiptURL(
        id: TransactionPlainObject.ID
    ) async throws -> URL
    
    /// Obtain transaction history for a specific wallet
    ///
    /// **Useful:**
    /// - `GET`
    /// - `profile/wallet/transactions`
    /// - https://gdeBank.gitbook.io/gdeBank-api/reference/dokumentaciya-api/poluchit-dannye-konkretnogo-koshelka
    ///
    /// - Parameters:
    ///   - walletType: type of the wallet
    ///   - page: current page
    /// - Returns: Transaction history list.
    /// - Throws: An error if obtaining fails.
    func obtainWalletTransactionHistory(
        walletType: CurrencyType,
        page: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject>
}
