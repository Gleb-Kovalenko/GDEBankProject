//
//  QRScanner.swift
//  CityGuide
//
//  Created by Dmitry Savinov on 25.01.2024.
//

import Foundation
import ComposableArchitecture

// MARK: - QRScanner

@Reducer
public struct QRScanner {
    
    // MARK: - Aliases
    
    public typealias State  = QRScannerState
    public typealias Action = QRScannerAction
    
    // MARK: - Initializers
    
    public init() {
        
    }
    
    // MARK: - Reducer
    
    public var body: some Reducer<QRScannerState, QRScannerAction> {
        Reduce { state, action in
            switch action {
            case .qrCodeTriggerred(let string):
                guard state.lastQRCode != string else { return .none }
                state.lastQRCode = string
                state.errorText = nil
                return .send(.qrTokenObtained(string))
            default:
                break
            }
            return .none
        }
    }
}
