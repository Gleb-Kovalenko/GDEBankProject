//
//  TransactionTypeTranslator.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SDAO
import Monreau
import Foundation

// MARK: - TransactionTypeTranslator

public final class TransactionTypeTranslator {

    // MARK: - Aliases

    public typealias PlainModel = TransactionTypePlainObject
    public typealias DatabaseModel = TransactionTypeModelObject

    /// TransactionType storage
    private lazy var TransactionTypeStorage = RealmStorage<TransactionTypeModelObject>(configuration: self.configuration)

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

extension TransactionTypeTranslator: Translator {

    public func translate(model: DatabaseModel) throws -> PlainModel {
        TransactionTypePlainObject(
            type: TransactionType(rawValue: model.type ?? ""),
            imageURL: URL(string: model.imageURL ?? "")
        )
    }

    public func translate(plain: PlainModel) throws -> DatabaseModel {
        let model = try TransactionTypeStorage.read(byPrimaryKey: plain.uniqueId.rawValue) ?? DatabaseModel()
        try translate(from: plain, to: model)
        return model
    }

    public func translate(from plain: PlainModel, to databaseModel: DatabaseModel) throws {
        if databaseModel.uniqueId.isEmpty {
            databaseModel.uniqueId = plain.uniqueId.rawValue
        }
        databaseModel.type = plain.type?.rawValue
        databaseModel.imageURL = plain.imageURL?.absoluteString
    }
}
