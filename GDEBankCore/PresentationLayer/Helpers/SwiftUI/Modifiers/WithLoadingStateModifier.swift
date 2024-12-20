//
//  LoadingStateModifier.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 24.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - LoadingStateModifier

public struct LoadingStateModifier: ViewModifier {
    
    // MARK: - Properties
    
    /// Value that indicates is need to show loading state
    public let isActive: Bool
    
    // MARK: - ViewModifier
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            ZStack {
//                CoreColors.textDefault.swiftUIColor
//                    .opacity(0.1)
                LoaderView()
            }
            .ignoresSafeArea(.all)
            .isOpaque(isActive)
            .animation(.easeIn(duration: 0.16), value: isActive)
        }
    }
}

// MARK: - View + LoadingStateModifier

extension View {
    
    public func loadingState(isActive: Bool) -> some View {
        self.modifier(LoadingStateModifier(isActive: isActive))
    }
}

