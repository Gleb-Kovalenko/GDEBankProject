//
//  TransactionModelObject.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SDAO
import RealmSwift

// MARK: - TransactionModelObject

public final class TransactionModelObject: RealmModel {
    
    @objc dynamic public var id: String = ""
    @objc dynamic public var transactionID: String? = ""
    @objc dynamic public var amount: Double = 0.0
    @objc dynamic public var currency: String = ""
    @objc dynamic public var transaction: String? = ""
    @objc dynamic public var exchangeNumber: String? = ""
    @objc dynamic public var type: TransactionTypeModelObject?
    @objc dynamic public var transactionDescription: String = ""
    @objc dynamic public var mainTransaction: String? = ""
    @objc dynamic public var direction: String = ""
    @objc dynamic public var date: TimeInterval = 0
    @objc dynamic public var status: String = ""
    @objc dynamic public var orderNumber: String? = ""
    @objc dynamic public var cardID: String? = ""
    @objc dynamic public var walletNumber: String? = ""
    @objc dynamic public var txtID: String? = ""
    @objc dynamic public var fullName: String? = ""
    @objc dynamic public var iban: String? = ""
    public var fee = RealmProperty<Double?>()
    @objc dynamic public var senderID: String? = ""
    @objc dynamic public var merchantName: String? = ""
    @objc dynamic public var merchantCategory: String? = ""
    @objc dynamic public var receiptURL: String? = ""
    @objc dynamic public var transactionType: String? = ""
    @objc dynamic public var country: String? = ""
    @objc dynamic public var dpayUserEmail: String? = ""
    @objc dynamic public var currencyFrom: String? = ""
    @objc dynamic public var currencyTo: String? = ""
    @objc dynamic public var amountFrom: Double = 0.0
    @objc dynamic public var amountTo: Double = 0.0
    
}
