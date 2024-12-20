//
//  TransactionStatusView.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit

// MARK: - TransactionStatusView

@WithLocalizationUpdater
public struct TransactionStatusView: View {
    
    // MARK: - Properties
    
    /// Transaction status
    public let status: TransactionStatus
    
    /// Default initializer
    public init(status: TransactionStatus) {
        self.status = status
    }
    
    // MARK: - View
    
    public var body: some View {
        HStack(spacing: 4) {
            Image(status.imageName)
                .dxImage(
                    height: 16,
                    color: status.foregroundColor
                )
            Text(status.name)
                .font(.inter(size: 11, weight: .medium))
                .foregroundStyle(status.foregroundColor)
        }
        .padding(.vertical, 4)
        .padding(.leading, 4)
        .padding(.trailing, 8)
        .background(status.backgroundColor)
        .smoothCorners(radius: 8)
    }
}

#Preview {
    TransactionStatusView(status: .success)
}
