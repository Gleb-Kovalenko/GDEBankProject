//
//  TransactionTranslator.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SDAO
import Monreau
import Foundation

// MARK: - TransactionTranslator

public final class TransactionTranslator {

    // MARK: - Aliases

    public typealias PlainModel = TransactionPlainObject
    public typealias DatabaseModel = TransactionModelObject

    /// Transaction storage
    private lazy var TransactionStorage = RealmStorage<TransactionModelObject>(configuration: self.configuration)

    /// RealmConfiguration instance
    private let configuration: RealmConfiguration

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - configuration: current realm db config
    public init(configuration: RealmConfiguration) {
        self.configuration = configuration
    }
}

// MARK: - Translator

extension TransactionTranslator: Translator {

    public func translate(model: DatabaseModel) throws -> PlainModel {
        guard let typeModel = model.type,
              let direction = TransactionDirection(rawValue: model.direction),
              let currency = CurrencyType(rawValue: model.currency),
              let status = TransactionStatus(rawValue: model.status) else {
            throw NSError.new(message: "Database incorrect data")
        }
        return TransactionPlainObject(
            id: model.id,
            transactionID: model.transactionID,
            mainTransaction: model.mainTransaction,
            transaction: model.transaction,
            country: model.country,
            amount: model.amount,
            orderNumber: model.orderNumber,
            exchangeNumber: model.exchangeNumber,
            cardID: model.cardID,
            walletNumber: model.walletNumber,
            txtID: model.txtID,
            fullName: model.fullName,
            dpayUserEmail: model.dpayUserEmail,
            iban: model.iban,
            fee: model.fee.value,
            senderID: model.senderID,
            merchantName: model.merchantName,
            merchantCategory: model.merchantCategory,
            transactionType: TransactionCheckType(rawValue: model.transactionType ?? ""),
            currency: currency,
            currencyFrom: CurrencyType(rawValue: model.currencyFrom ?? ""),
            currencyTo: CurrencyType(rawValue: model.currencyTo ?? ""),
            amountFrom: model.amountFrom,
            amountTo: model.amountTo,
            type: try TransactionTypeTranslator(configuration: configuration).translate(model: typeModel),
            description: model.transactionDescription,
            receiptURL: URL(string: model.receiptURL ?? ""),
            direction: direction,
            date: model.date,
            status: status
        )
    }

    public func translate(plain: PlainModel) throws -> DatabaseModel {
        let model = try TransactionStorage.read(byPrimaryKey: plain.uniqueId.rawValue) ?? DatabaseModel()
        try translate(from: plain, to: model)
        return model
    }

    public func translate(from plain: PlainModel, to databaseModel: DatabaseModel) throws {
        if databaseModel.uniqueId.isEmpty {
            databaseModel.uniqueId = plain.uniqueId.rawValue
        }
        databaseModel.id = plain.id
        databaseModel.transactionID = plain.transactionID
        databaseModel.amount = plain.amount
        databaseModel.currency = plain.currency.rawValue
        if let type = plain.type {
            databaseModel.type = try TransactionTypeTranslator(configuration: configuration).translate(plain: type)
        }
        databaseModel.transactionDescription = plain.description
        databaseModel.direction = plain.direction.rawValue
        databaseModel.date = plain.date
        databaseModel.status = plain.status.rawValue
        databaseModel.orderNumber = plain.orderNumber
        databaseModel.cardID = plain.cardID
        databaseModel.walletNumber = plain.walletNumber
        databaseModel.txtID = plain.txtID
        databaseModel.fullName = plain.fullName
        databaseModel.iban = plain.iban
        databaseModel.fee.value = plain.fee
        databaseModel.senderID = plain.senderID
        databaseModel.merchantName = plain.merchantName
        databaseModel.merchantCategory = plain.merchantCategory
        databaseModel.transactionType = plain.transactionType?.rawValue
        databaseModel.receiptURL = plain.receiptURL?.absoluteString
        databaseModel.country = plain.country
        databaseModel.dpayUserEmail = plain.dpayUserEmail
        databaseModel.currencyFrom = plain.currencyFrom?.rawValue
        databaseModel.currencyTo = plain.currencyTo?.rawValue
        databaseModel.amountFrom = plain.amountFrom ?? 0
        databaseModel.amountTo = plain.amountTo ?? 0
        databaseModel.transaction = plain.transaction
        databaseModel.exchangeNumber = plain.exchangeNumber
        databaseModel.mainTransaction = plain.mainTransaction
    }
}
