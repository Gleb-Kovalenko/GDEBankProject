//
//  DXRowContainer.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 16.08.2024.
//

import SwiftUI

// MARK: - DXRowContainer

public struct DXRowContainer<Content: View>: View {
    
    // MARK: - Properties

    public let hPadding: CGFloat
    public let content: () -> Content
    
    // MARK: - Initializers
    
    public init(
        hPadding: CGFloat = 16,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.hPadding = hPadding
        self.content = content
    }
    
    // MARK: - View
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundStyle(Colors.bg2.swiftUIColor)
            content()
                .padding(.horizontal, hPadding)
        }
        .frame(height: 60)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Colors.bg1.swiftUIColor
        DXRowContainer {
            VStack {
                HStack {
                    Text("Continue")
                    Spacer()
                }
            }
        }
        .padding(.mediumPadding)
    }
}
