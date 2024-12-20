//
//  QRScannerAction.swift
//  CityGuide
//
//  Created by Dmitry Savinov on 25.01.2024.
//

import Foundation

// MARK: - QRScannerAction

public enum QRScannerAction: Equatable {
    
    // MARK: - Cases
    
    /// QR code trigger when it is recognized
    case qrCodeTriggerred(String)
    
    /// An action that calls when qr token obtained
    case qrTokenObtained(String)
    
    /// An action that calls when user taps on the `close` button
    case closeButtonTapped
}
