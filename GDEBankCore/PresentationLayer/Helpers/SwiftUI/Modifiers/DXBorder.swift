//
//  DXBorder.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 25.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - View

extension View {
    
    public func dxBorder(
        color: Color = CoreColors.gray2.swiftUIColor,
        width: CGFloat = 1,
        radius: CGFloat = 8
    ) -> some View {
        modifier(
            DXBorder(
                color: color,
                width: width,
                radius: radius
            )
        )
    }
}

// MARK: - SmoothCorners

/// Modifier that apply smooth corner radius to rectangle View
public struct DXBorder: ViewModifier {
    
    // MARK: - Properties
    
    /// Border color
    public let color: Color
    
    /// Border width
    public let width: CGFloat
    
    /// Border radius
    public let radius: CGFloat
    
    // MARK: - ViewModifier
    
    public func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(lineWidth: width)
                    .foregroundStyle(color)
            )
    }
}
