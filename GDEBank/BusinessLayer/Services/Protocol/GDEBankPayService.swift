//
//  GDEBankService.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 21.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import GDEBankCore
import Foundation

// MARK: - GDEBankService

public protocol GDEBankService {
    
    /// Obtain pay profile
    ///
    /// **Useful:**
    /// - `GET`
    /// - `profile/pay/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/gdeBank-pay/gdeBank-pay#poluchit-informaciyu-o-polzovatele
    ///
    /// - Returns: pay profile
    /// - Throws: An error if obtaining fails.
    func obtainProfile() async throws -> PayProfilePlainObject
    
    /// Obtain pay profile transactions
    ///
    /// **Useful:**
    /// - `GET`
    /// - `profile/pay/transactions/?currencyType={currencyType}&page={page}&limit={limit}`
    /// - https://gdeBank.gitbook.io/gdeBank-api/gdeBank-pay/gdeBank-pay#poluchit-spisok-tranzakcii
    ///
    /// - Returns: pay profile
    /// - Throws: An error if obtaining fails.
    func obtainProfileTransactions(
        currency: CurrencyType,
        page: Int,
        pageSize: Int
    ) async throws -> DXPaginationPlainObject<TransactionPlainObject>
    
    /// Obtain static qr code
    ///
    /// **Useful:**
    /// - `GET`
    /// - `profile/pay/getQr/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/gdeBank-pay/gdeBank-pay#poluchit-postoyannyi-qr-kod
    ///
    /// - Returns: static qr code url
    /// - Throws: An error if obtaining fails.
    func obtainStaticQRCode() async throws -> URL
    
    /// Generate a dynamic qr code
    ///
    /// **Useful:**
    /// - `POST`
    /// - `profile/pay/generate/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/gdeBank-pay/gdeBank-pay#sgenerirovat-qr-kod
    ///
    /// - Parameters:
    ///    - wallet: Selected wallet
    ///    - amount: Required amount
    /// - Returns: dynamic qr code url
    /// - Throws: An error if obtaining fails.
    func generateDynamicQRCode(
        wallet: CurrencyType,
        amount: Double
    ) async throws -> URL
    
    /// Dowload file with specified url
    /// - Parameters:
    ///   - url: file url to download
    ///   - completition: completion block
    /// - Returns: digger result with url
    /// - Throws: An error if downloading fails
    func downloadFile(
        url: URL,
        completion: @escaping (_ result: DiggerResult<URL>) -> Void
    ) throws
    
    /// Obtain transfer info from qr token
    ///
    /// **Useful:**
    /// - `GET`
    /// - `profile/pay/getInfo/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/gdeBank-pay/gdeBank-pay#poluchit-informaciyu-s-qr-koda
    ///
    /// - Parameters:
    ///    - qrToken: qr token
    /// - Returns: transfer info
    /// - Throws: An error if obtaining fails.
    func obtainTransferInfo(
        qrToken: String
    ) async throws -> TransferInfoPlainObject
    
    /// Pay tranfer
    ///
    /// **Useful:**
    /// - `POST`
    /// - `profile/pay/transfer/`
    /// - https://gdeBank.gitbook.io/gdeBank-api/gdeBank-pay/gdeBank-pay#perevesti-po-qr-kodu
    ///
    /// - Parameters:
    ///    - qrToken: qr token
    ///    - amount: transfer amount
    ///    - currency: transfer currency
    /// - Returns: status of operation
    /// - Throws: An error if payment failured.
    func processTransfer(
        qrToken: String,
        amount: Double,
        currency: CurrencyType
    ) async throws -> Bool
}

