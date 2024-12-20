//
//  MainTabCoordinatorView.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 24.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import GDEBankCore
import SwiftMacrosKit

// MARK: - MainTabCoordinatorView

@WithLocalizationUpdater
public struct MainTabCoordinatorView: View {
    
    // MARK: - Properties
    
    /// The store powering the `MainTabCoordinator` reducer
    @Perception.Bindable var store: StoreOf<MainTabCoordinator>
    
    // MARK: - Initializers

    /// Initializes a new instance of `MainTabCoordinatorView` with the provided store.
    ///
    /// - Parameter store: The `StoreOf<MainTabCoordinator>` that powers the `MainTabCoordinator` reducer.
    public init(store: StoreOf<MainTabCoordinator>) {
        self.store = store
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                MainView(
                    store: store.scope(
                        state: \.main,
                        action: \.main
                    )
                )
            } destination: { store in
                WithPerceptionTracking {
                    switch store.case {
                    case let .main(store):
                        MainView(store: store)
                    case let .qrReceiving(store):
                        PayQRReceivingView(store: store)
                    case let .transferIntro(store):
                        PayTransferIntroView(store: store)
                    case let .payTransfer(store):
                        PayTransferView(store: store)
                    case .dxDialog, .dxDialogFullScreen, .scanner:
                        EmptyView()
                    }
                }
            }
            .loadingState(isActive: store.isRemotingOperation)
            .alert(store: store.scope(state: \.$alert, action: \.alert))
            .dxPopupDialog(
                store: $store.scope(
                    state: \.modalDestination?.dxDialog,
                    action: \.modalDestination.dxDialog
                )
            )
            .dxFullScreenDialog(
                store: $store.scope(
                    state: \.modalDestination?.dxDialogFullScreen,
                    action: \.modalDestination.dxDialogFullScreen
                )
            )
            .fullScreenCover(
                item: $store.scope(
                    state: \.modalDestination?.scanner,
                    action: \.modalDestination.scanner
                )
            ) { scannerStore in
                QRScannerViewController(store: scannerStore)
                    .swiftUI()
                    .ignoresSafeArea()
                    .withPulseLogging()
                    .alert(store: store.scope(state: \.$qrAlert, action: \.qrAlert))
            }
        }
    }
}

