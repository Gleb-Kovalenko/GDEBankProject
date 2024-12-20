//
//  Main.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation
import GDEBankCore
import TCANetworkReducers

// MARK: - Main

@Reducer
public struct Main: Reducer {
    
    // MARK: - Aliases

    public typealias State  = MainState
    public typealias Action = MainAction
    
    // MARK: - Properties
    
    /// `GDEBank` service instance
    private let gdeBankService: GDEBankService
    
    /// `Localizer` instace
    private let localizer: Localizer
    
    // MARK: - Initializers

    /// Initializes the `Main` reducer with required services and user defaults.
    ///
    /// - Parameters:
    ///   - gdeBankService: `GDEBank` service instance
    ///   - localizer: localizer instance
    public init(
        gdeBankService: GDEBankService,
        localizer: Localizer
    ) {
        self.gdeBankService = gdeBankService
        self.localizer = localizer
    }
    
    // MARK: - Feature
    
    public var body: some Reducer<MainState, MainAction> {
        Scope(state: \.transactionList, action: \.transactionList) {
            TransactionList()
        }
        Scope(state: \.languageMenu, action: \.languageMenu) {
            LanguageMenu(localizer: localizer)
        }
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isRemotingOperation = true
                return .run { send in
                    let profile = try await gdeBankService.obtainProfile()
                    await send(.payProfileObtained(.success(profile)))
                } catch: { error, send in
                    await send(.payProfileObtained(.failure(error as NSError)))
                }
            case .reloadButtonTapped:
                guard let currency = state.currency else {
                    return .none
                }
                state.reloadableMain = DXIDPaginationState(id: currency, pageSize: AppConstants.Network.Pagination.transactionsPageSize)
                return .concatenate(
                    .send(.transactionList(.reset)),
                    .send(.reloadableMain(.reset))
                )
            case .payProfileObtained(.success(let data)):
                state.accounts = data.balances
                state.isRemotingOperation = false
                guard let account = state.accounts.first else {
                    return .none
                }
                state.currency = account.id
                state.currencyBalance = account.balance
                state.reloadableMain = DXIDPaginationState(id: account.id, pageSize: AppConstants.Network.Pagination.transactionsPageSize)
                return .send(.reloadableMain(.reset))
            case .reloadableMain(.response(.success(let data))):
                state.transactions = data.array
                state.isReloadingInProgress = false
                return .send(
                    .transactionList(
                        .dataObtained(
                            data.array,
                            merge: true
                        )
                    )
                )
            case .setCurrency(let currency):
                guard let account = state.accounts.first(where: { $0.id == currency }) else {
                    return .none
                }
                state.currency = currency
                state.currencyBalance = account.balance
                state.reloadableMain = DXIDPaginationState(id: currency, pageSize: AppConstants.Network.Pagination.transactionsPageSize)
                return .concatenate(
                    .send(.transactionList(.reset)),
                    .send(.reloadableMain(.reset))
                )
            case .payProfileObtained(.failure(let error)), .reloadableMain(.response(.failure(let error))):
                state.isRemotingOperation = false
                state.isReloadingInProgress = false
                state.alert = .show(error: error)
            default:
                break
            }
            return .none
        }
        .ifLet(\.$alert, action: \.alert)
        .ifLet(\.reloadableMain, action: \.reloadableMain) {
            IDPaginationReducer.run { id, page, pageSize in
                try await gdeBankService.obtainProfileTransactions(
                    currency: id,
                    page: page,
                    pageSize: pageSize
                )
            }
        }
    }
}
