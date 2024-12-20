//
//  OnLoginedAppearModifier.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 12.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - OnLoginedAppearModifier

public struct OnLoginedAppearModifier: ViewModifier {
    
    // MARK: - Properties
    
    /// On Appear closure
    public let onAppear: () -> Void
    
    /// Log in observer
    @ObservedObject private var logInObserver = LogInObserver.shared
    
    // MARK: - Initializers
    
    public init(onAppear: @escaping () -> Void) {
        self.onAppear = onAppear
        self.logInObserver = logInObserver
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                if logInObserver.isLogined != false {
                    onAppear()
                }
            }
    }
}

// MARK: - View

extension View {
    public func onLoginedAppear(perform action: @escaping () -> Void) -> some View {
        self.modifier(OnLoginedAppearModifier(onAppear: action))
    }
}
