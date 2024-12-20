//
//  TransactionServiceMockImplementation.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation

// MARK: - TransactionServiceMockImplementation

public final class TransactionServiceMockImplementation: MockableService {
    
    // MARK: - Initializers
    
    /// Default initializer
    public init() {}
}

// MARK: - TransactionService

extension TransactionServiceMockImplementation: TransactionService {
    
    public func obtainTransactions(
        page: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject> {
        try await mock(.infinityRandom(pageSize: AppConstants.Network.Pagination.pageSize, page: page))
    }
    
    public func obtainReceiptURL(
        id: TransactionPlainObject.ID
    ) async throws -> URL {
        try await mock(.randomFileURL(format: .pdf))
    }
    
    public func obtainFirstTransactionsPage() async throws -> [TransactionPlainObject] {
        try await mock(.random(count: 5))
    }
    
    public func obtainHistory(type: HistoryType, page: Int) async throws -> DXPaginationPlainObject<TransactionPlainObject> {
        try await mock(.infinityRandom(pageSize: AppConstants.Network.Pagination.pageSize, page: page))
    }
    
    public func obtainWalletTransactionHistory(
        walletType: CurrencyType,
        page: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject> {
        try await mock(.infinityRandom(pageSize: AppConstants.Network.Pagination.pageSize, page: page))
    }
    
    public func obtainTransaction(
        id: TransactionPlainObject.ID
    ) async throws -> TransactionPlainObject {
        try await mock(.random())
    }
}
