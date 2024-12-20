//
//  MainTabCoordinator.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 24.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture
import Foundation
import GDEBankCore
import Swinject
import UIKit

@Reducer
public struct MainTabCoordinator {
    
    // MARK: - Aliases

    public typealias State  = MainTabCoordinatorState
    public typealias Action = MainTabCoordinatorAction
    
    // MARK: - Properties
    
    /// Assembly container
    private static var container: Container {
        AssembliesHolder.container
    }
    
    /// `Pay` service instance
    private let payService: GDEBankService
    
    // MARK: - Initializers
    
    /// Default initializer
    public init() {
        payService = MainTabCoordinator.container.resolve()
    }
    
    // MARK: - Path
    
    @Reducer(state: .equatable)
    public enum Path {
        
        // MARK: - Cases
        
        case main(Main)
        case qrReceiving(PayQRReceiving)
        
        // MARK: - Transfer
        
        case transferIntro(PayTransferIntro)
        case scanner(QRScanner)
        case payTransfer(PayTransfer)
        
        // MARK: - Dialog
        
        case dxDialog(DXDialog)
        case dxDialogFullScreen(DXDialog)
        
        // MARK: - ReducerBuilder
        
        public static var body: some ReducerOf<Self> {
            Scope(state: \.main, action: \.main) {
                Main(
                    gdeBankService: container.resolve(),
                    localizer: container.resolve()
                )
            }
            Scope(state: \.payTransfer, action: \.payTransfer) {
                PayTransfer(payService: container.resolve())
            }
            Scope(state: \.scanner, action: \.scanner) {
                QRScanner()
            }
            Scope(state: \.transferIntro, action: \.transferIntro) {
                PayTransferIntro()
            }
            Scope(state: \.qrReceiving, action: \.qrReceiving) {
                PayQRReceiving(
                    payService: container.resolve(),
                    fileManager: container.resolve()
                )
            }
            Scope(state: \.dxDialogFullScreen, action: \.dxDialogFullScreen) {
                DXDialog()
            }
            Scope(state: \.dxDialog, action: \.dxDialog) {
                DXDialog()
            }
        }
    }
    
    // MARK: - Reducer
    
    public var body: some Reducer<MainTabCoordinatorState, MainTabCoordinatorAction> {
        Scope(state: \.main, action: \.main) {
            Main(
                gdeBankService: MainTabCoordinator.container.resolve(),
                localizer: MainTabCoordinator.container.resolve()
            )
        }
        Reduce { state, action in
            switch action {
                
            // MARK: - Main
                
            case .main(let action),
                    .path(.element(_, .main(let action))):
                return processMain(action: action, state: &state)
                
            // MARK: - TransferIntro
                
            case .path(.element(_, action: .transferIntro(.scanButtonTapped))):
                state.modalDestination = .scanner(QRScannerState())
                
            // MARK: - QRScanner
                
            case .path(.element(_, action: .scanner(let scannerAction))),
                .modalDestination(.presented(.scanner(let scannerAction))):
                return processQRScanner(action: scannerAction, state: &state)
                
            // MARK: - PayTransfer
                
            case .path(.element(_, action: .payTransfer(.transferCompletedSuccesfully))):
                state.modalDestination = .dxDialogFullScreen(.successfulTransferWithoutCheck)
                
            // MARK: - DXDialog
                
            case .modalDestination(.presented(.dxDialog(let dxDialogAction))),
                 .modalDestination(.presented(.dxDialogFullScreen(let dxDialogAction))):
                return processDXDialog(action: dxDialogAction, state: &state)
                
            // MARK: - Service
                
            case let .qrTokenObtained(token, .success(transferInfo)):
                state.isRemotingOperation = false
                state.modalDestination = nil
                state.path.append(
                    .payTransfer(
                        PayTransferState(
                            qrToken: token,
                            transferInfo: transferInfo
                        )
                    )
                )
            case .qrTokenObtained(_, .failure(let error)):
                state.isRemotingOperation = false
                state.qrAlert = .show(error: error)
            default:
                break
            }
            return .none
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$alert, action: \.alert)
        .ifLet(\.$qrAlert, action: \.qrAlert)
        .ifLet(\.$modalDestination, action: \.modalDestination) {
            MainTabCoordinator.Path.body
        }
    }
    
    // MARK: Main
    
    private func processMain(
        action: MainAction,
        state: inout MainTabCoordinatorState
    ) -> Effect<MainTabCoordinatorAction> {
        switch action {
        case .receiveButtonTapped:
            guard let currentCurrency = state.main.accounts.first(where: { $0.currencyType == state.main.currency }) else {
                return .none
            }
            state.path.append(
                .qrReceiving(
                    PayQRReceivingState(
                        defaultCurrency: currentCurrency,
                        currencies: state.main.accounts
                    )
                )
            )
        case .transferButtonTapped:
            state.path.append(
                .transferIntro(
                    PayTransferIntroState()
                )
            )
        default:
            break
        }
        return .none
    }
    
    private func processDXDialog(
        action: DXDialogAction,
        state: inout MainTabCoordinatorState
    ) -> Effect<MainTabCoordinatorAction> {
        switch action {
        case .toMainButtonTapped:
            state.modalDestination = nil
            state.path.removeAll()
        case .getReceiptButtonTapped:
            // TODO: - Add logic
            return .none
        default:
            break
        }
        return .none
    }
    
    private func processQRScanner(
        action: QRScannerAction,
        state: inout MainTabCoordinatorState
    ) -> Effect<MainTabCoordinatorAction> {
        switch action {
        case .closeButtonTapped:
            state.modalDestination = nil
        case .qrTokenObtained(let qrToken):
            guard !state.isRemotingOperation else {
                return .none
            }
            state.isRemotingOperation = true
            return .run { send in
                let transferInfo = try await payService.obtainTransferInfo(qrToken: qrToken)
                await send(.qrTokenObtained(token: qrToken, .success(transferInfo)))
            } catch: { error, send in
                await send(.qrTokenObtained(token: qrToken, .failure(error as NSError)))
            }
        default:
            break
        }
        return .none
    }
}
