//
//  GDEBankServiceImplementation.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 21.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import ServiceCore
import HTTPTransport
import GDEBankCore

// MARK: - GDEBankServiceImplementation

public final class GDEBankServiceImplementation: WebService {
}

// MARK: - GDEBankService

extension GDEBankServiceImplementation: GDEBankService {
    
    public func obtainProfile() async throws -> PayProfilePlainObject {
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: "/profile/pay/",
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncCall(from: request, dataByKey: "response")
    }
    
    public func obtainProfileTransactions(
        currency: CurrencyType,
        page: Int,
        pageSize: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject> {
        let parameters = fillHTTPRequestParameters(
            self.urlParameters,
            with: [
                "currencyType": currency,
                "page": page,
                "limit": pageSize
            ]
        )
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: "/profile/pay/transactions/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncPaginatedCall(
            from: request,
            page: page,
            pageSize: pageSize
        )
    }
    
    public func obtainStaticQRCode() async throws -> URL {
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: "/profile/pay/getQr/",
            timeout: 30,
            base: self.baseRequest
        )
        let urlString: String = try await asyncCall(from: request, dataByKey: "response.qr_img")
        if let url = URL(string: urlString) {
            return url
        } else {
            throw NSError.new(message: CoreLocalization.Errors.noQrCodeLink)
        }
    }

    public func generateDynamicQRCode(
        wallet: CurrencyType,
        amount: Double
    ) async throws -> URL {
        let parameters = self.fillHTTPRequestParameters(
            self.jsonParameters,
            with: [
                "wallet": wallet.rawValue.uppercased(),
                "amount": amount
            ]
        )
        let request = HTTPRequest(
            httpMethod: .post,
            endpoint: "/profile/pay/generate/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        let urlString: String = try await asyncCall(from: request, dataByKey: "response.qr_img")
        if let url = URL(string: urlString) {
            return url
        } else {
            throw NSError.new(message: CoreLocalization.Errors.noQrCodeLink)
        }
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
        let parameters = self.fillHTTPRequestParameters(
            self.urlParameters,
            with: [
                "token": qrToken
            ]
        )
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: "/profile/pay/getInfo/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        return try await asyncCall(from: request, dataByKey: "response")
    }
    
    public func processTransfer(
        qrToken: String,
        amount: Double,
        currency: CurrencyType
    ) async throws -> Bool {
        let parameters = self.fillHTTPRequestParameters(
            self.jsonParameters,
            with: [
                "wallet": currency.rawValue.uppercased(),
                "amount": amount,
                "token": qrToken
            ]
        )
        let request = HTTPRequest(
            httpMethod: .post,
            endpoint: "/profile/pay/transfer/",
            parameters: [parameters],
            timeout: 30,
            base: self.baseRequest
        )
        let status: String = try await asyncCall(from: request, dataByKey: "response.transferDpay.status")
        return status.asResultBool
    }
}

