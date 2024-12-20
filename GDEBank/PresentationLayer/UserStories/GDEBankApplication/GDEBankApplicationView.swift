//
//  GDEBankApplicationView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 11.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import GDEBankCore

// MARK: - GDEBankApplicationView

public struct GDEBankApplicationView: View {

    // MARK: - Properties
    
    /// The store powering the `GDEBankApplication` reducer
    @Perception.Bindable public var store: StoreOf<GDEBankApplication>
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            Group {
                if store.isUserAuthorized {
                    PayTabView(
                        store: store.scope(
                            state: \.payTab,
                            action: \.payTab
                        )
                    )
                } else {
                    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                        PayLoginView(
                            store: store.scope(
                                state: \.payLogin,
                                action: \.payLogin
                            )
                        )
                    } destination: { store in
                        WithPerceptionTracking {
                            switch store.case {
                            case let .payLogin(store):
                                PayLoginView(store: store)
                            case .dxDialog:
                                EmptyView()
                            }
                        }
                    }
                }
            }
            .alert(store: store.scope(state: \.$alert, action: \.alert))
            .loadingState(isActive: store.isRemoteOperation)
            .background(CoreColors.defaultPrimary.swiftUIColor.ignoresSafeArea())
            .environment(\.colorScheme, store.useDarkTheme ? .dark : .light)
            .dxPopupDialog(
                store: $store.scope(
                    state: \.modalDestination?.dxDialog,
                    action: \.modalDestination.dxDialog
                )
            )
            .onAppear {
                store.send(.onAppear)
            }
            .onOpenURL { url in
                store.send(.urlSchemeOpeningObtained(url))
            }
            .withPulseLogging()
        }
    }
}
