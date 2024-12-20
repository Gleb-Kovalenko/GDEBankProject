//
//  PayTransfer.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import GDEBankCore
import Foundation

// MARK: - PayTransfer

@Reducer
public struct PayTransfer {

    // MARK: - Aliases

    public typealias State  = PayTransferState
    public typealias Action = PayTransferAction
    
    // MARK: - Properties
    
    /// `Pay` service instance
    private let payService: GDEBankService
    
    // MARK: - Initializers
    
    /// Default initializer
    public init(payService: GDEBankService) {
        self.payService = payService
    }
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        Reduce {state, action in
            switch action {
            case let .setCurrency(currency):
                state.currency = currency
            case let .setAmountText(text):
                guard text != state.amountText else {
                    return .none
                }
                state.isInsufficientFundsError = false
                guard !text.isEmpty else {
                    state.amountText = ""
                    return .none
                }
                guard let amount = Double(text) else {
                    return .none
                }
                state.amountText = amount.formatCurrency(
                    state.currency,
                    withCurrencySymbol: false
                )
            case .transferButtonTapped:
                guard let amount = Double(state.amountText) else {
                    return .none
                }
                state.isRemotingOperation = true
                return .run { [qrToken = state.qrToken, currency = state.currency] send in
                    let status = try await payService.processTransfer(
                        qrToken: qrToken,
                        amount: amount,
                        currency: currency
                    )
                    await send(.transferCompleted(.success(status)))
                } catch: { error, send in
                    await send(.transferCompleted(.failure(error as NSError)))
                }
            case .transferCompleted(.success):
                state.isRemotingOperation = false
                return .send(.transferCompletedSuccesfully)
            case .transferCompleted(.failure(let error)):
                // TODO: - Fetch isInsufficientFundsError
                state.isRemotingOperation = false
                state.alert = .show(error: error)
            default:
                break
            }
            return .none
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
