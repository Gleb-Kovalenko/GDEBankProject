//
//  WithPulseLogging.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 29.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import PulseUI

// MARK: - WithPulseLoggingModifer

public struct WithPulseLoggingModifer: ViewModifier {
    
    // MARK: - Properties
    
    /// Indicates is pulse active
    @State private var isActive = false
    
    // MARK: - ViewModifier
    
    public func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                Button {
                    isActive = true
                } label: {
                    Color.clear
                }
                .frame(width: 60, height: 40)
            }
            .sheet(isPresented: $isActive) {
                NavigationStack {
                    ConsoleView()
                }
            }
    }
}

// MARK: - View + LoadingStateModifier

extension View {
    
    public func withPulseLogging() -> some View {
        self.modifier(WithPulseLoggingModifer())
    }
}
