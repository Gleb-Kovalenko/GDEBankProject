//
//  TransactionListEmptyView.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 24.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit

// MARK: - TransactionListEmptyView

@WithLocalizationUpdater
public struct TransactionListEmptyView: View {
    
    // MARK: - Properties
    
    /// Title text
    public let title: String
    
    /// Titlte font
    public let titleFont: Font
    
    /// Subtitle
    public let subtitle: String
    
    /// Subtitle font
    public let subtitleFont: Font
    
    /// Subtitle color
    public let subtitleColor: Color
    
    // MARK: - Initializers
    
    public init(
        title: String = CoreLocalization.TransactionList.Empty.title,
        titleFont: Font = .inter(size: 20, weight: .semibold),
        subtitle: String = CoreLocalization.TransactionList.Empty.subtitle,
        subtitleFont: Font = .inter(size: 14, weight: .medium),
        subtitleColor: Color = CoreColors.gray2.swiftUIColor
    ) {
        self.title = title
        self.titleFont = titleFont
        self.subtitle = subtitle
        self.subtitleFont = subtitleFont
        self.subtitleColor = subtitleColor
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(titleFont)
                .multilineTextAlignment(.center)
            Text(subtitle)
                .font(subtitleFont)
                .multilineTextAlignment(.center)
                .foregroundStyle(subtitleColor)
        }
    }
}

#Preview {
    TransactionListEmptyView()
}
