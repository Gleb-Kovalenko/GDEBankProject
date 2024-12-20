//
//  PayTransferIntroLocalization.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftMacrosKit

// MARK: - PayTransferIntroLocalization

/// The `PayTransferIntroLocalization` struct defines the localization settings for the transfer intro screen.
@DynamicStringWrapper
public struct PayTransferIntroLocalization {
    
    /// Navigation title
    public let navigationTitle: String
    
    /// Title text
    public let title: String
    
    /// Subtitle
    public let subtitle: String
    
    /// Scan button title
    public let scanButtonTitle: String
}

// MARK: - Variations

extension PayTransferIntroLocalization {
    
    public static var `default`: PayTransferIntroLocalization {
        PayTransferIntroLocalization(
            navigationTitle: L10n.Main.navigationTitle,
            title: L10n.PayTransferIntro.title,
            subtitle: L10n.PayTransferIntro.subtitle,
            scanButtonTitle: L10n.PayTransferIntro.scanButtonTitle
        )
    }
}
