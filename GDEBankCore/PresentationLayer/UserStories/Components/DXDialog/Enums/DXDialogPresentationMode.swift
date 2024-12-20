//
//  DXDialogPresentationMode.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 01.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - DXDialogPresentationMode

public enum DXDialogPresentationMode {
    
    // MARK: - Cases
    
    case fullScreenCover
    case popup
    
    // MARK: - Useful
    
    public var appereance: DXDialogViewAppearance {
        switch self {
        case .fullScreenCover:
            return .fullScreenCover
        case .popup:
            return .popup
        }
    }
    
    // MARK: - OuterPaddings
    
    public var horizontalPaddings: CGFloat {
        switch self {
        case .fullScreenCover:
            return 0
        case .popup:
            return 20
        }
    }
    
    public var topPadding: CGFloat {
        switch self {
        case .fullScreenCover:
            return 24
        case .popup:
            return 0
        }
    }
}
