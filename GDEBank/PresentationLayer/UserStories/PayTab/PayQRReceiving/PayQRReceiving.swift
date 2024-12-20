//
//  PayQRReceiving.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation
import GDEBankCore

// MARK: - PayQRReceiving

@Reducer
public struct PayQRReceiving {

    // MARK: - Aliases

    public typealias State  = PayQRReceivingState
    public typealias Action = PayQRReceivingAction
    
    /// `Pay` service instance
    private let payService: GDEBankService
    
    /// `FileManager` instance
    private let fileManager: FileManager
    
    // MARK: - Initializers
    
    public init(
        payService: GDEBankService,
        fileManager: FileManager
    ) {
        self.payService = payService
        self.fileManager = fileManager
    }
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        Reduce {
            state,
            action in
            switch action {
            case .onAppear:
                return obtainQrURL(type: state.selectedTab, state: &state)
            case let .tabTapped(type):
                state.selectedTab = type
                return obtainQrURL(type: type, state: &state)
            case let .currencySelected(currency):
                guard currency != state.selectedCurrency else {
                    return .none
                }
                state.selectedCurrency = currency
                state.dynamicQrURL = nil
                state.dynamicQrSumText = ""
            case let .setSumText(text):
                guard text != state.dynamicQrSumText else {
                    return .none
                }
                guard !text.isEmpty else {
                    state.dynamicQrSumText = ""
                    state.dynamicQrURL = nil
                    return .none
                }
                guard let amount = Double(text) else {
                    return .none
                }
                state.isGenerateQRAvailable = true
                state.dynamicQrURL = nil
                state.dynamicQrSumText = amount.formatCurrency(
                    state.selectedCurrency.currencyType,
                    withCurrencySymbol: false
                )
            case .generateQrButtonTapped:
                state.isGenerateQRAvailable = false
                return obtainQrURL(type: .dynamic, state: &state)
            case let .qrCodeObtained(type, result: .success(url)):
                switch type {
                case .static:
                    state.staticQrURL = url
                case .dynamic:
                    state.isGenerateQRAvailable = true
                    state.dynamicQrURL = url
                }
            case let .shareButtonTapped(type):
                return downloadQR(type: type, state: &state)
            case .qrCodeDownloaded(_, result: .success(let url)):
                state.shareSheet = ShareSheetState(activityItem: url)
            case .shareSheetDismiss:
                if let url = state.shareSheet?.activityItems.first as? URL {
                    try? fileManager.removeItem(at: url)
                }
                state.shareSheet = nil
            case .qrCodeObtained(_, result: .failure(let error)),
                 .qrCodeDownloaded(_, result: .failure(let error)):
                state.alert = .show(error: error)
            default:
                break
            }
            return .none
        }
        .ifLet(\.$alert, action: \.alert)
    }
    
    // MARK: - Properties
    
    private func obtainQrURL(
        type: PayQRReceivingState.QRType,
        state: inout PayQRReceivingState
    ) -> Effect<PayQRReceivingAction> {
        guard type == .static && state.staticQrURL == nil ||
              type == .dynamic && state.dynamicQrURL == nil && Double(state.dynamicQrSumText) != nil else {
            return .none
        }
        return .run {
            [
                currencyType = state.selectedCurrency.currencyType,
                amountText = state.dynamicQrSumText
            ] send in
            let qrURL: URL
            switch type {
            case .static:
                qrURL = try await payService.obtainStaticQRCode()
            case .dynamic:
                qrURL = try await payService.generateDynamicQRCode(
                    wallet: currencyType,
                    amount: Double(amountText) ?? 0
                )
            }
            await send(.qrCodeObtained(qrType: type, result: .success(qrURL)))
        } catch: { error, send in
            await send(.qrCodeObtained(qrType: type, result: .failure(error as NSError)))
        }
    }
    
    // MARK: - Properties
    
    private func downloadQR(
        type: PayQRReceivingState.QRType,
        state: inout PayQRReceivingState
    ) -> Effect<PayQRReceivingAction> {
        let qrURL: URL?
        switch type {
        case .static:
            qrURL = state.staticQrURL
        case .dynamic:
            qrURL = state.dynamicQrURL
        }
        guard let qrURL else {
            return .none
        }
        return .run(
            operation: { send in
                try payService.downloadFile(
                    url: qrURL
                ) { result in
                    Task {
                        switch result {
                        case .success(let localFileUrl):
                            await send(.qrCodeDownloaded(qrType: type, result: .success(localFileUrl)))
                        case .failure(let error):
                            await send(.qrCodeDownloaded(qrType: type, result: .failure(error as NSError)))
                        }
                    }
                }
            },
            catch: { error, send in
                await send(.qrCodeDownloaded(qrType: type, result: .failure(error as NSError)))
            }
        )
    }
}
