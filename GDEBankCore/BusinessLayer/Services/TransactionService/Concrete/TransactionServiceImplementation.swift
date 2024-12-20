//
//  TransactionServiceImplementation.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import ServiceCore
import HTTPTransport

// MARK: - TransactionServiceImplementation

public final class TransactionServiceImplementation: WebService {
}

// MARK: - TransactionService

extension TransactionServiceImplementation: TransactionService {
    
    public func obtainHistory(
        type: HistoryType,
        page: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject> {
        let parameters = fillHTTPRequestParameters(
            self.urlParameters,
            with: [
                "type": type.rawValue,
                "page": page
            ]
        )
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: "/profile/history/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncPaginatedCall(
            from: request,
            page: page,
            pageSize: AppConstants.Network.Pagination.pageSize
        )
    }
    
    public func obtainTransactions(
        page: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject> {
        let parameters = fillHTTPRequestParameters(
            self.urlParameters,
            with: [
                "page": page
            ]
        )
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: "/profile/fiat_profile/getTransaction/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncPaginatedCall(
            from: request,
            page: page,
            pageSize: AppConstants.Network.Pagination.pageSize
        )
    }
    
    public func obtainFirstTransactionsPage() async throws -> [TransactionPlainObject] {
        let firstPage = try await obtainTransactions(page: 1)
        return firstPage.array
    }
    
    public func obtainWalletTransactionHistory(
        walletType: CurrencyType,
        page: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject> {
        let parameters = fillHTTPRequestParameters(
            self.urlParameters,
            with: [
                "page": page,
                "wallet": walletType.rawValue
            ]
        )
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: "profile/wallet/history/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncPaginatedCall(
            from: request,
            page: page,
            pageSize: AppConstants.Network.Pagination.pageSize
        )
    }
    
    public func obtainTransaction(
        id: TransactionPlainObject.ID
    ) async throws -> TransactionPlainObject {
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: "profile/history/check/\(id)",
            timeout: 30,
            base: self.baseRequest
        )
        let array: [TransactionPlainObject] = try await asyncCall(from: request, dataByKey: "response.transaction")
        if !array.isEmpty {
            return array.first.unsafelyUnwrapped
        } else {
            throw NSError.new(message: "Empty array")
        }
    }
    
    public func obtainReceiptURL(
        id: TransactionPlainObject.ID
    ) async throws -> URL {
        let parameters = fillHTTPRequestParameters(
            self.jsonParameters,
            with: [
                "id": id
            ]
        )
        let request = HTTPRequest(
            httpMethod: .post,
            endpoint: "profile/history/receipt",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        let urlString: String = try await asyncCall(from: request, dataByKey: "response.document")
        if let url = URL(string: urlString) {
            return url
        } else {
            throw NSError.new(message: CoreLocalization.Errors.AccountStatement.noStatement)
        }
    }
}
