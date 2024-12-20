//
//  TransferServiceMockImplementation.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 12.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import ServiceCore

// MARK: - TransferServiceMockImplementation

public final class TransferServiceMockImplementation: MockableService {
    
    // MARK: - Initializers
    
    public init() {}
}

// MARK: - TransferService

extension TransferServiceMockImplementation: TransferService {
    
    public func obtainPaymentDetails(
        walletType: CurrencyType
    ) async throws -> PaymentDetailsPlainObject {
        try await mock(.random())
    }
    
    public func checkAddress(
        network: String,
        address: String
    ) async throws -> Bool {
        try await mock(true)
    }
    
    public func transferIBAN(
        currency: CurrencyType,
        amount: Double,
        iban: String,
        fullName: String
    ) async throws -> TransactionPlainObject.ID {
        try await mock(.randomID())
    }
    
    public func transferCrypto(
        currency: CurrencyType,
        amount: Double,
        network: String,
        address: String,
        memo: String?
    ) async throws -> TransactionPlainObject.ID {
        try await mock(.randomID())
    }
    
    public func transferCard(
        currency: CurrencyType,
        amount: Double,
        fullName: String,
        cardNumber: String
    ) async throws -> TransactionPlainObject.ID {
        try await mock(.randomID())
    }
}
