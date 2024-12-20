//
//  TransferServiceImplementation.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 12.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import ServiceCore
import HTTPTransport

// MARK: - TransferServiceImplementation

public final class TransferServiceImplementation: WebService {
}

// MARK: - TransferService

extension TransferServiceImplementation: TransferService {
    
    public func obtainPaymentDetails(
        walletType: CurrencyType
    ) async throws -> PaymentDetailsPlainObject {
        let parameters = fillHTTPRequestParameters(
            self.urlParameters,
            with: [
                "wallet": walletType.rawValue,
                "type": "transfer"
            ]
        )
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: "/profile/wallet/payment/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncCall(from: request, dataByKey: "response")
    }
    
    public func checkAddress(
        network: String,
        address: String
    ) async throws -> Bool {
        let parameters = self.fillHTTPRequestParameters(
            self.jsonParameters,
            with: [
                "network": network,
                "address": address
            ]
        )
        let request = HTTPRequest(
            httpMethod: .post,
            endpoint: "profile/transfer/validateCryptoAddress/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncCall(from: request, dataByKey: "valid")
    }
    
    public func transferIBAN(
        currency: CurrencyType,
        amount: Double,
        iban: String,
        fullName: String
    ) async throws -> TransactionPlainObject.ID {
        let parameters = self.fillHTTPRequestParameters(
            self.jsonParameters,
            with: [
                "type": "transferIban",
                "currency": currency.rawValue.uppercased(),
                "amount": "\(amount)",
                "iban": iban,
                "fullName": fullName
            ]
        )
        let request = HTTPRequest(
            httpMethod: .post,
            endpoint: "/profile/transfer/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncCall(from: request, dataByKey: "response.transfer.id")
    }
    
    public func transferCrypto(
        currency: CurrencyType,
        amount: Double,
        network: String,
        address: String,
        memo: String?
    ) async throws -> TransactionPlainObject.ID {
        let parameters = self.fillHTTPRequestParameters(
            self.jsonParameters,
            with: [
                "type": "transferCrypto",
                "currency": currency.rawValue.lowercased(),
                "amount": "\(amount)",
                "network": network.extractTextInParentheses(),
                "address": address,
                "memo": memo
            ]
        )
        let request = HTTPRequest(
            httpMethod: .post,
            endpoint: "/profile/transfer/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncCall(from: request, dataByKey: "response.transfer.id")
    }
    
    public func transferCard(
        currency: CurrencyType,
        amount: Double,
        fullName: String,
        cardNumber: String
    ) async throws -> TransactionPlainObject.ID {
        let parameters = self.fillHTTPRequestParameters(
            self.jsonParameters,
            with: [
                "type": "transferCard",
                "currency": currency.rawValue.uppercased(),
                "amount": "\(amount)",
                "fullName": fullName,
                "card": cardNumber
            ]
        )
        let request = HTTPRequest(
            httpMethod: .post,
            endpoint: "/profile/transfer/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncCall(from: request, dataByKey: "response.transfer.id")
    }
}
