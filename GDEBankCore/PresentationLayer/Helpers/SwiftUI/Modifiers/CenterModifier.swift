//
//  CenterModifier.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import SwiftUI

// MARK: - CenterModifier

public struct CenterModifier: ViewModifier {

    public func body(content: Content) -> some View {
        HStack(spacing: 0) {
            Spacer(minLength: 0)
            content
            Spacer(minLength: 0)
        }
    }
}

// MARK: - View

extension View {
    
    /// Centers target view
    public func centered() -> some View {
        modifier(CenterModifier())
    }
}

