//
//  TransactionItemState.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - TransactionItemState

@ObservableState
public struct TransactionItemState: Equatable, Identifiable {
    
    // MARK: - Properties
    
    /// Transaction id
    public let id: TransactionPlainObject.ID
    
    /// Transaction date
    public let date: Date
    
    /// Transaction amount
    public let amount: Double
    
    /// Transaction type
    public let direction: TransactionDirection
    
    /// Transaction image name
    public let imageURL: URL?
    
    /// Transaction name
    public let name: String
    
    /// Transaction description
    public let description: String
    
    /// Localization
    public var l10n: TransactionItemLocalization = .default
    
    /// Transaction currency
    public let currency: String
}

// MARK: - Localization

extension TransactionItemState {
    
    public var amountText: String {
        "\(direction.symbol) \(amount.formatWithDotSeperator()) \(currency)"
    }
}

// MARK: - Initailizers

extension TransactionItemState {
    
    public init(plain: TransactionPlainObject) {
        self.id = plain.id
        self.date = Date(timeIntervalSince1970: plain.date)
        self.direction = plain.direction
        self.name = plain.type?.type?.name ?? ""
        self.amount = plain.amount
        self.description = plain.description
        self.currency = plain.currency.rawValue.uppercased()
        self.imageURL = plain.type?.imageURL
    }
}
