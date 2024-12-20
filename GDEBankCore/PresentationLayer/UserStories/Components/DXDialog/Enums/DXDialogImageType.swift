//
//  DXDialogImageType.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 01.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - DXDialogImageType

public enum DXDialogImageType: Equatable {
    
    // MARK: - Cases
    
    case success
    case warning
    case error
    
    // MARK: - Useful
    
    public var imageName: String {
        switch self {
        case .success:
            CoreAssets.checkCircle.name
        case .warning:
            CoreAssets.alertCircle.name
        case .error:
            CoreAssets.alertCircle.name
        }
    }
    
    public var imageColor: Color {
        switch self {
        case .success, .warning, .error:
            return .white
        }
    }
    
    public var outerCircleColor: Color {
        switch self {
        case .success:
            CoreColors.success2.swiftUIColor
        case .warning:
            CoreColors.warning2.swiftUIColor
        case .error:
            CoreColors.alert2.swiftUIColor
        }
    }
}
