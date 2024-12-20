//
//  QRScannerState.swift
//  CityGuide
//
//  Created by Dmitry Savinov on 25.01.2024.
//

import Foundation

// MARK: - QRScannerState

public struct QRScannerState: Equatable {
    
    // MARK: - Properties
    
    /// Last scanned string from QR code
    public var lastQRCode: String?
    
    /// Error text value
    public var errorText: String?
}

// MARK: - Initializers

extension QRScannerState {
    
    public init(forPublicInit: String? = nil) {
        
    }
}
