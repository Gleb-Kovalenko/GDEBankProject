//
//  GDEBankServiceMockImplementation.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 21.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import GDEBankCore
import Foundation

// MARK: - GDEBankServiceMockImplementation

public final class GDEBankServiceMockImplementation: MockableService {
    
    // MARK: - Initializers
    
    /// Default initializer
    public init() {}
}

// MARK: - GDEBankService

extension GDEBankServiceMockImplementation: GDEBankService {
    
    public func obtainProfile() async throws -> PayProfilePlainObject {
        try await mock(.random())
    }
    
    public func obtainProfileTransactions(
        currency: CurrencyType,
        page: Int,
        pageSize: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject> {
        try await mock(.infinityRandom(pageSize: pageSize, page: page))
    }
    
    public func obtainStaticQRCode() async throws -> URL {
        try await mock(.randomQRURL())
    }

    public func generateDynamicQRCode(
        wallet: CurrencyType,
        amount: Double
    ) async throws -> URL {
        try await mock(.randomQRURL())
    }

    public func downloadFile(
        url: URL,
        completion: @escaping (_ result: DiggerResult<URL>) -> Void
    ) throws {
        try DiggerManager
            .shared
            .download(with: url)
            .completion(completion)
    }
    
    public func obtainTransferInfo(
        qrToken: String
    ) async throws -> TransferInfoPlainObject {
        try await mock(.random())
    }
    
    public func processTransfer(
        qrToken: String,
        amount: Double,
        currency: CurrencyType
    ) async throws -> Bool {
        try await mock(true)
    }
}

