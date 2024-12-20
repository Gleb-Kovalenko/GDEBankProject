//
//  TransactionPlainObject.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 21.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SDAO

/// @realm
public struct TransactionPlainObject: Plain, Identifiable, Equatable {
    
    // MARK: - Properties

    /// Unique id for database
    public var uniqueId: UniqueID {
        .init(rawValue: id)
    }
    
    /// Transaction id
    public let id: String
    
    /// Transaction id
    public let transactionID: String?
    
    /// Main transaction
    public let mainTransaction: String?
    
    /// Transaction
    public let transaction: String?
    
    /// Transaction country
    public let country: String?

    /// Transascation amount
    public let amount: Double
    
    /// Order number
    public let orderNumber: String?
    
    /// Exchange number
    public let exchangeNumber: String?
    
    /// Card id
    public let cardID: String?
    
    /// Wallet number
    public let walletNumber: String?
    
    /// Txt id
    public let txtID: String?
    
    /// Transaction person full name
    public let fullName: String?
    
    /// Dpay user email
    public let dpayUserEmail: String?
    
    /// Iban
    public let iban: String?
    
    /// Transaction fee
    public let fee: Double?
    
    /// Sender id
    public let senderID: String?
    
    /// Merchant name
    public let merchantName: String?
    
    /// Merchant category
    public let merchantCategory: String?
    
    /// Transaction check type
    public let transactionType: TransactionCheckType?

    /// Transaction currency
    public let currency: CurrencyType
    
    /// Currency from
    public let currencyFrom: CurrencyType?
    
    /// Currency to
    public let currencyTo: CurrencyType?
    
    /// Amount from
    public let amountFrom: Double?
    
    /// Amount to
    public let amountTo: Double?
    
    /// Transaction name
    public let type: TransactionTypePlainObject?
    
    /// Transaction descirption
    public let description: String
    
    /// Receipt url string
    public let receiptURL: URL?
    
    /// Transacation type
    public let direction: TransactionDirection
    
    /// Transation date in seconds
    public let date: TimeInterval

    /// User's name value
    public let status: TransactionStatus
}

// MARK: - Codable

extension TransactionPlainObject: Decodable {
    
    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        
        // MARK: - Cases
        
        case id
        case transactionID = "transaction_id"
        case amount
        case currency
        case type
        case direction = "type_balance"
        case date
        case status
        case transactionType
        case orderNumber = "order_number"
        case cardID = "card"
        case walletNumber = "address"
        case txtID
        case fullName
        case iban
        case fee
        case dpayUserEmail = "dpay_user"
        case senderID = "sender_id"
        case merchantName
        case merchantCategory
        case receiptURL = "receipt"
        case country
        case exchangeNumber = "exchange_number"
        case currencyFrom = "currency_from"
        case currencyTo = "currency_to"
        case amountFrom = "amount_from"
        case amountTo = "amount_to"
        case mainTransaction = "main_transaction"
        
        // MARK: - Desription Possible Keys
        
        case description
        case transaction
    }
    
    // MARK: - Initializers
    
    /// Initializes a new instance of `TransactionPlainObject` from a decoder.
    /// - Parameter decoder: The decoder to use for decoding the instance.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        transactionID = try container.decodeIfPresent(String.self, forKey: .transactionID)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        amount = try container.decodeStringToDouble(forKey: .amount)
        currency = try container.decode(CurrencyType.self, forKey: .currency)
        type = try container.decodeIfPresent(TransactionTypePlainObject.self, forKey: .type)
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? (try container.decode(String.self, forKey: .transaction))
        direction = try container.decode(TransactionDirection.self, forKey: .direction)
        date = try container.decode(TimeInterval.self, forKey: .date)
        status = try container.decode(TransactionStatus.self, forKey: .status)
        transactionType = try container.decodeIfPresent(TransactionCheckType.self, forKey: .transactionType)
        orderNumber = try container.decodeIfPresent(String.self, forKey: .orderNumber)
        cardID = try container.decodeIfPresent(String.self, forKey: .cardID)
        walletNumber = try container.decodeIfPresent(String.self, forKey: .walletNumber)
        txtID = try container.decodeIfPresent(String.self, forKey: .txtID)
        fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
        iban = try container.decodeIfPresent(String.self, forKey: .iban)
        fee = try container.decodeIfPresentStringToDouble(forKey: .fee)
        senderID = try container.decodeIfPresent(String.self, forKey: .senderID)
        dpayUserEmail = try container.decodeIfPresent(String.self, forKey: .dpayUserEmail)
        merchantName = try container.decodeIfPresent(String.self, forKey: .merchantName)
        merchantCategory = try container.decodeIfPresent(String.self, forKey: .merchantCategory)
        transaction = try container.decodeIfPresent(String.self, forKey: .transaction)
        exchangeNumber = try container.decodeIfPresent(String.self, forKey: .transactionID)
        let receiptURLString = try container.decodeIfPresent(String.self, forKey: .receiptURL)
        currencyFrom = try container.decodeIfPresent(CurrencyType.self, forKey: .currencyFrom)
        currencyTo = try container.decodeIfPresent(CurrencyType.self, forKey: .currencyTo)
        amountFrom = try container.decodeIfPresent(Double.self, forKey: .amountFrom)
        mainTransaction = try container.decodeIfPresent(String.self, forKey: .mainTransaction)
        amountTo = try container.decodeIfPresent(Double.self, forKey: .amountTo)
        if let receiptURLString, !receiptURLString.isEmpty {
            receiptURL = URL(string: receiptURLString)
        } else {
            receiptURL = nil
        }
    }
}


// MARK: - Randomable

extension TransactionPlainObject: Randomable {
    
    public static func random() -> TransactionPlainObject {
        random(id: UUID().uuidString)
    }
    
    public static func random(id: Int) -> Self {
        .random(id: UUID().uuidString)
    }
    
    public static func random(id: String = UUID().uuidString) -> Self {
        let info = String.randomTransactionInfo()
        return TransactionPlainObject(
            id: id,
            transactionID: .randomID(),
            mainTransaction: .randomID(),
            transaction: .randomID(),
            country: .randomName(),
            amount: .randomAmount(),
            orderNumber: String(Int.random(in: 1_000_000..<10_000_000)),
            exchangeNumber: String(Int.random(in: 1_000_000..<10_000_000)),
            cardID: String(Int.random(in: 1_000_000..<10_000_000)),
            walletNumber: .randomIBAN(),
            txtID: URL.randomSite().absoluteString,
            fullName: .randomName(),
            dpayUserEmail: .randomEmail(),
            iban: .randomIBAN(),
            fee: .random(in: 0..<5.0),
            senderID: .randomID(),
            merchantName: .randomBankName(),
            merchantCategory: .randomBankName(),
            transactionType: .random(),
            currency: .random(),
            currencyFrom: .random(),
            currencyTo: .random(),
            amountFrom: .randomAmount(),
            amountTo: .randomAmount(),
            type: .random(),
            description: info.description,
            receiptURL: .randomFileURL(),
            direction: .random(),
            date: .random(),
            status: .random()
        )
    }
}
