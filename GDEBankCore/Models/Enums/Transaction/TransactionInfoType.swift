//
//  TransactionInfoType.swift
//  DaxilCore
//
//  Created by Gleb Kovalenko on 18.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - TransactionInfoType

/// Represents transaction information types with associated values.
public enum TransactionInfoType: Equatable, Hashable {
    
    // MARK: - Cases
    
    /// The date and time of the transaction.
    case dateAndTime(Date)
    
    /// The order number.
    case orderNumber(String)
    
    /// The recipient's information.
    case recipientID(String)
    
    /// The recipient's name.
    case recipientName(String)
    
    /// Indicates if the transaction is made to a card.
    case toCard(String)
    
    /// The wallet associated with the transaction.
    case wallet(CurrencyType)
    
    /// The ID of the sender.
    case senderID(String)
    
    /// Transaction
    case transaction(String)
    
    /// Exchange number
    case exchangeNumber(String)
    
    /// The country where the transaction took place.
    case country(String)
    
    /// The recipient's IBAN.
    case recipientIBAN(String)
    
    /// Dpay sender user email
    case dpaySenderUserEmail(String)
    
    /// Dpay recipient user email
    case dpayRecipientUserEmail(String)
    
    /// The wallet number of the recipient.
    case walletNumber(String)
    
    /// The currency used in the transaction.
    case currency(CurrencyType)
    
    /// Currency direction
    case currencyDirection(from: CurrencyType, to: CurrencyType)
    
    /// Amount from
    case amountFrom(Double)
    
    /// Amount to
    case amountTo(Double)
    
    /// The commission fee for the transaction.
    case fee(Double)
    
    /// The transaction Txt ID.
    case transactionTxtId(String)
    
    /// Address
    case address(String)
    
    /// The status of the transaction.
    case status(TransactionStatus)
    
    // MARK: - Properties
    
    /// The raw value of the field.
    public var valueText: String {
        switch self {
        case .dateAndTime(let date):
            return date.formattedWithTimeAndComma
        case .orderNumber(let number), .exchangeNumber(let number):
            return number
        case .recipientID(let recipientID):
            return recipientID.obscured(withVisibleCount: 4)
        case .recipientName(let fullName):
            return fullName
        case .toCard(let cardID):
            return cardID.obscured(withVisibleCount: 4)
        case .wallet(let currency):
            return currency.shortName
        case .senderID:
            return "xxxxxxxxxxxx"
        case .country(let countryName):
            return countryName
        case .recipientIBAN(let iban):
            return iban
        case .walletNumber(let address):
            return address.obscured(withVisibleCount: 6)
        case .currency(let currency):
            return currency.shortName
        case .fee(let fee):
            return fee.formatWithDotSeperator()
        case .transactionTxtId(let txtID):
            return txtID
        case let .currencyDirection(from, to):
            return "\(from.shortName)/\(to.shortName)"
        case .amountFrom(let value), .amountTo(let value):
            return value.defaultBalanceFormatText
        case .dpaySenderUserEmail(let email), .dpayRecipientUserEmail(let email):
            return email
        case .status:
            return ""
        case .address(let address):
            return address
        case .transaction(let transactionID):
            return transactionID
        }
    }
    
    public var imageName: String? {
        switch self {
        case .status(let status):
            return status.statusImageName
        default:
            return nil
        }
    }
    
    public var imageColor: Color? {
        switch self {
        case .status(let status):
            return status.statusImageColor
        default:
            return nil
        }
    }
    
    /// Determines if the field is clickable.
    public var isClickable: Bool {
        switch self {
        case .transactionTxtId:
            return true
        default:
            return false
        }
    }
    
    /// Determines if the field may be copied.
    public var isCopyAvailable: Bool {
        switch self {
        case .transactionTxtId:
            return true
        default:
            return false
        }
    }
    
    public var lineLimit: Int {
        switch self {
        case .address: return 3
        default: return 1
        }
    }
    
    /// The localized title for the field.
    public var title: String {
        switch self {
        case .dateAndTime: return L10n.TransactionInfo.DateAndTime.title
        case .orderNumber: return L10n.TransactionInfo.OrderNumber.title
        case .exchangeNumber: return L10n.TransactionInfo.ExchangeNumber.title
        case .recipientID: return L10n.TransactionInfo.Recipient.title
        case .recipientName: return L10n.TransactionInfo.RecipientName.title
        case .toCard: return L10n.TransactionInfo.ToCard.title
        case .wallet: return L10n.TransactionInfo.Wallet.title
        case .senderID: return L10n.TransactionInfo.SenderId.title
        case .country: return L10n.TransactionInfo.Country.title
        case .recipientIBAN: return L10n.TransactionInfo.RecipientIban.title
        case .walletNumber: return L10n.TransactionInfo.WalletNumber.title
        case .currency: return L10n.TransactionInfo.Currency.title
        case .fee: return L10n.TransactionInfo.Commission.title
        case .transactionTxtId: return L10n.TransactionInfo.TransactionTxtId.title
        case .transaction: return L10n.TransactionInfo.Transaction.title
        case .status: return L10n.TransactionInfo.Status.title
        case .currencyDirection: return L10n.TransactionInfo.Direction.title
        case .amountTo: return L10n.TransactionInfo.DepositAmount.title
        case .amountFrom: return L10n.TransactionInfo.WithdrawalAmount.title
        case .dpaySenderUserEmail: return L10n.TransactionInfo.DpaySenderUserEmail.title
        case .dpayRecipientUserEmail: return L10n.TransactionInfo.DpayRecipientUserEmail.title
        case .address: return L10n.TransactionInfo.Address.title
        }
    }
}

// MARK: - Array+TransactionInfoType

extension Array where Element == TransactionInfoType {
    
    public func info(for plain: TransactionPlainObject) -> Self {
        Self.info(for: plain)
    }
    
    public static func info(for plain: TransactionPlainObject) -> Self {
        guard let transactionType = plain.transactionType else {
            return []
        }
        var array: [TransactionInfoType] = [
            .dateAndTime(plain.date.toDate)
        ]
        switch transactionType {
        case .fee:
            if let transactionID = plain.mainTransaction {
                array.append(.orderNumber(transactionID))
            }
            if let transaction = plain.transaction {
                array.append(.transaction(transaction))
            }
            array.append(.status(plain.status))
        case .depositCard:
            if let transactionID = plain.transactionID {
                array.append(.orderNumber(transactionID))
            }
            if let cardID = plain.cardID {
                array.append(.toCard(cardID))
            }
            array.append(.wallet(plain.currency))
        case .transferCard, .paymentCard:
            if let transactionID = plain.transactionID {
                array.append(.orderNumber(transactionID))
            }
            if let cardID = plain.cardID {
                array.append(.recipientID(cardID))
            }
            if let country = plain.country {
                array.append(.country(country))
            }
            array.append(.currency(plain.currency))
            if let fee = plain.fee {
                array.append(.fee(fee))
            }
            array.append(.status(plain.status))
        case .transferIban:
            if let transactionID = plain.transactionID {
                array.append(.orderNumber(transactionID))
            }
            if let fullName = plain.fullName {
                array.append(.recipientName(fullName))
            }
            if let iban = plain.iban {
                array.append(.recipientIBAN(iban))
            }
            if let fee = plain.fee {
                array.append(.fee(fee))
            }
            array.append(.status(plain.status))
        case .conversion:
            if let exchangeNumber = plain.exchangeNumber {
                array.append(.exchangeNumber(exchangeNumber))
            }
            if let currencyFrom = plain.currencyFrom,
               let currencyTo = plain.currencyTo {
                array.append(.currencyDirection(from: currencyFrom, to: currencyTo))
            }
            if let amountFrom = plain.amountFrom {
                array.append(.amountFrom(amountFrom))
            }
            if let amountTo = plain.amountTo {
                array.append(.amountTo(amountTo))
            }
            if let fee = plain.fee {
                array.append(.fee(fee))
            }
        case .depositCrypto:
            if let transactionID = plain.transactionID {
                array.append(.orderNumber(transactionID))
            }
            array.append(.wallet(plain.currency))
            if let walletNumber = plain.walletNumber {
                array.append(.walletNumber(walletNumber))
            }
            if let txtID = plain.txtID {
                array.append(.transactionTxtId(txtID))
            }
        case .depositPay:
            if let dpayUserEmail = plain.dpayUserEmail {
                array.append(.dpaySenderUserEmail(dpayUserEmail))
            }
            array.append(.currency(plain.currency))
            array.append(.status(plain.status))
        case .transferPay:
            if let dpayUserEmail = plain.dpayUserEmail {
                array.append(.dpayRecipientUserEmail(dpayUserEmail))
            }
            array.append(.currency(plain.currency))
            array.append(.status(plain.status))
        case .transferCrypto:
            if let transactionID = plain.transactionID {
                array.append(.orderNumber(transactionID))
            }
            array.append(.wallet(plain.currency))
            if let walletNumber = plain.walletNumber {
                array.append(.walletNumber(walletNumber))
            }
            if let txtID = plain.txtID {
                array.append(.transactionTxtId(txtID))
            }
        case .depositIban:
            if let transactionID = plain.transactionID {
                array.append(.orderNumber(transactionID))
            }
            array.append(.wallet(plain.currency))
        case .depositCash:
            if let transactionID = plain.transactionID {
                array.append(.orderNumber(transactionID))
            }
            if let country = plain.country {
                array.append(.country(country))
            }
            if let fee = plain.fee {
                array.append(.fee(fee))
            }
            array.append(.currency(plain.currency))
        case .transferCash:
            if let transactionID = plain.transactionID {
                array.append(.orderNumber(transactionID))
            }
            if let country = plain.country {
                array.append(.country(country))
            }
            if let fee = plain.fee {
                array.append(.fee(fee))
            }
            array.append(.currency(plain.currency))
        case .cheque:
            if let transactionID = plain.transactionID {
                array.append(.orderNumber(transactionID))
            }
            if let fee = plain.fee {
                array.append(.fee(fee))
            }
            array.append(.currency(plain.currency))
        }
        return array
    }
    
    public static func random() -> Self {
        let plain = TransactionPlainObject.random()
        var array: [TransactionInfoType] = [
            .dateAndTime(plain.date.toDate)
        ]
        if let orderNumber = plain.orderNumber {
            array.append(.orderNumber(orderNumber))
        }
        if let cardID = plain.cardID {
            array.append(.toCard(cardID))
        }
        array.append(.currency(plain.currency))
        if let walletNumber = plain.walletNumber {
            array.append(.walletNumber(walletNumber))
        }
        if let txtID = plain.txtID {
            array.append(.transactionTxtId(txtID))
        }
        if let fullName = plain.fullName {
            array.append(.recipientName(fullName))
        }
        if let iban = plain.iban {
            array.append(.recipientIBAN(iban))
        }
        if let transactionID = plain.transactionID {
            array.append(.transaction(transactionID))
        }
        if let cardID = plain.cardID {
            array.append(.recipientID(cardID))
        }
        if let currencyFrom = plain.currencyFrom,
           let currencyTo = plain.currencyTo {
            array.append(.currencyDirection(from: currencyFrom, to: currencyTo))
        }
        if let dpayUserEmail = plain.dpayUserEmail {
            array.append(.dpaySenderUserEmail(dpayUserEmail))
        }
        if let dpayUserEmail = plain.dpayUserEmail {
            array.append(.dpayRecipientUserEmail(dpayUserEmail))
        }
        if let fee = plain.fee {
            array.append(.fee(fee))
        }
        array.append(.status(plain.status))
        return array
    }
}
