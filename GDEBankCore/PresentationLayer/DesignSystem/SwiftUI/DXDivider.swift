//
//  DXDivider.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 08.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - DXDivider

public struct DXDivider: View {
    
    // MARK: - Initializers
    
    public init() {}
    
    // MARK: - View
    
    public var body: some View {
        Rectangle()
            .fill(CoreColors.gray4.swiftUIColor)
            .frame(height: 1)
    }
}

// MARK: - Preview

#Preview {
    DXDivider()
}
