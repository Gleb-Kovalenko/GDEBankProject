//
//  MainView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import GDEBankCore
import SwiftMacrosKit
import TCANetworkReducers

// MARK: - MainView

@WithLocalizationUpdater
public struct MainView: View {
    
    // MARK: - Properties

    /// The store powering the `Main` reducer.
    public let store: StoreOf<Main>
    
    /// Appearance settings for `MainView`.
    public let appearance: MainViewAppearance

    // MARK: - Initializers
    
    /// Initializes the `MainView` with a store, view state, and optional appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store powering the `Main` reducer.
    ///   - appearance: The appearance settings for the view. Defaults to `.default`.
    public init(
        store: StoreOf<Main>,
        appearance: MainViewAppearance = .default
    ) {
        self.store = store
        self.appearance = appearance
    }
    
    /// Initializes the `MainView` with a store, view state, and optional appearance settings.
    ///
    /// - Parameters:
    ///   - store: The store powering the `Main` reducer.
    public init(store: StoreOf<Main>) {
        self.store = store
        self.appearance = .default
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 24) {
                if store.isRemotingOperation {
                    LoaderView()
                } else {
                    balanceView
                    availableAccountsView
                        .padding(.horizontal, -Constants.horizontalPaddings)
                    operationsButtonsRowView
                    ScrollView(showsIndicators: false) {
                        transactionListView
                            .padding(.bottom, 24)
                    }
                    .refreshable {
                        store.send(.reloadButtonTapped)
                    }
                }
            }
            .padding(.horizontal, Constants.horizontalPaddings)
            .padding(.top, 24)
            .navigationTitle(store.l10n.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .alert(store: store.scope(state: \.$alert, action: \.alert))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    toolbarTrailingView
                }
            }
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
    
    private var balanceView: some View {
        Group {
            if let currency = store.currency,
               let balance = store.currencyBalance {
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        CircledImage(
                            imageName: CoreAssets.wallet.name,
                            imageSize: 18,
                            circleSize: 40,
                            circleColor: CoreColors.gray6.swiftUIColor.light,
                            imageColor: CoreColors.gray1.swiftUIColor.light
                        )
                        VStack(alignment: .leading, spacing: 0) {
                            Text(store.l10n.totalBalance)
                                .font(appearance.totalBalanceFont)
                            Text(balance.formatCurrency(currency))
                                .font(appearance.balanceFont)
                        }
                        .foregroundColor(.white)
                    }
                    Spacer(minLength: 0)
                }
                .padding(16)
                .background(LinearGradient.gdeBankColorsGradient)
                .smoothCorners(radius: 8)
            }
        }
    }
    
    private var availableAccountsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(store.accounts, id: \.id) { account in
                    DXButton(
                        text: account.id.shortName,
                        style: .control(fill: store.currency == account.id),
                        height: 29,
                        font: .inter(size: 11, weight: .medium)
                    ) {
                        store.send(.setCurrency(account.id))
                    }
                }
            }
            .padding(.horizontal, Constants.horizontalPaddings)
        }
    }
    
    private var operationsButtonsRowView: some View {
        HStack(spacing: 8) {
            DXButton(
                text: store.l10n.transferButtonTitle,
                shouldExpand: true
            ) {
                store.send(.transferButtonTapped)
            }
            DXButton(
                text: store.l10n.receiveButtonTitle,
                style: .outline,
                shouldExpand: true
            ) {
                store.send(.receiveButtonTapped)
            }
        }
    }
    
    private var transactionListView: some View {
        LazyVStack(spacing: Constants.itemsSpacing) {
            Text(store.l10n.transferHistoryTitle)
                .font(appearance.transferHistoryTitleFont)
                .padding(.top, 8)
                .padding(.bottom, 10)
                .pin(.left)
            TransactionListView(
                store: store.scope(
                    state: \.transactionList,
                    action: \.transactionList
                )
            )
            IfLetStore(
                store.scope(
                state: \.reloadableMain?.pagination,
                action: \.reloadableMain
                )
            ) { store in
                PaginationView(
                    store: store,
                    loader: {
                        LoaderView(appearance: .small)
                    }
                )
            }
        }
    }
    
    // MARK: - Subviews
    
    private var toolbarTrailingView: some View {
        LanguageMenuView(
            store: store.scope(
                state: \.languageMenu,
                action: \.languageMenu
            )
        )
    }
}

// MARK: - Constants

extension MainView {
    
    enum Constants {
        static let horizontalPaddings: CGFloat = 20
        static let itemsSpacing: CGFloat = 16
    }
}
