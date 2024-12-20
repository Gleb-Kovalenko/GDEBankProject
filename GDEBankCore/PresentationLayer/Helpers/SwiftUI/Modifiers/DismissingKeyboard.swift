//
//  DismissingKeyboard.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 21.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - DismissingKeyboard

/// The `DismissingKeyboard` struct is a view modifier that dismisses the keyboard
/// when the user taps anywhere on the screen outside of a text input field.
public struct DismissingKeyboard: ViewModifier {
    
    /// Modifies the content view by adding a tap gesture that dismisses the keyboard.
    /// - Parameter content: The view content to which the modifier is applied.
    /// - Returns: The modified view with the tap gesture added.
    public func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.currentWindow?.endEditing(true)
            }
    }
}

// MARK: - View + DismissingKeyboard

extension View {
    
    /// A convenience method that applies the `DismissingKeyboard` modifier to the view.
    /// This allows the keyboard to be dismissed when the user taps anywhere on the screen.
    /// - Returns: The modified view that dismisses the keyboard on tap.
    public func dismissKeyboardOnTap() -> some View {
        self.modifier(DismissingKeyboard())
    }
}
