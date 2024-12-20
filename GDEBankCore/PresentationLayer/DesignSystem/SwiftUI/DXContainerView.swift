//
//  DXContainerView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 16.08.2024.
//

import SwiftUI

// MARK: - DXContainerView

public struct DXContainerView<Content: View>: View {
    
    // MARK: - Properties
    
    public let content: () -> Content
    
    // MARK: - Initializers
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    // MARK: - View
    
    public var body: some View {
        content()
            .padding(.mediumPadding)
            .background(Colors.bg2.swiftUIColor)
            .smoothCorners(.large)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Colors.bg1.swiftUIColor
        DXContainerView {
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
