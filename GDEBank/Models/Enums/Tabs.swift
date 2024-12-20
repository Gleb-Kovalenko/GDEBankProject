//
//  Tabs.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 14.08.2024.
//

import SwiftUI

// MARK: - Tabs

public enum Tabs: Equatable {
    
    // MARK: - Cases
    
    case main
    case exit
    
    // MARK: - Useful
    
    var title: String {
        switch self {
        case .main:
            L10n.Tabs.main
        case .exit:
            L10n.Tabs.exit
        }
    }
    
    var imageResource: ImageResource {
        switch self {
        case .main:
            ImageResource.home
        case .exit:
            ImageResource.exit
        }
    }
}
