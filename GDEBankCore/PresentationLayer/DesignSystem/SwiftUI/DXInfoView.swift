//
//  DXInfoView.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 26.11.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import SwiftMacrosKit

// MARK: - DXInfoView

/// A view component displaying informational text with optional styling and validation support.
public struct DXInfoView: View {
    
    // MARK: - Properties
    
    /// The text to display in the view.
    /// This text is shown alongside an icon and adapts its style based on the state.
    private let text: String
    
    /// The state of the view, determining its appearance and validation.
    private let state: UIState
    
    /// The appearance configuration for the view, allowing customization of fonts, colors, and layout.
    private let appearance: Appearance
    
    // MARK: - Initializers
    
    /// Creates a new `DXInfoView` instance.
    ///
    /// - Parameters:
    ///   - text: The informational text to display.
    ///   - state: The state of the view, indicating its current visual and functional condition.
    ///   - appearance: The appearance configuration for customizing the view's style. Defaults to `.default`.
    public init(
        text: String,
        state: UIState,
        appearance: Appearance = .default
    ) {
        self.text = text
        self.state = state
        self.appearance = appearance
    }
    
    // MARK: - Computed Properties
    
    /// Indicates whether the current state is valid.
    ///
    /// A state of `.normal` is considered valid; any other state is invalid.
    private var isValid: Bool {
        state == .normal
    }
    
    /// The color of the text, adapting to the validity of the state.
    ///
    /// If the state is valid, the `subtitleColor` is used; otherwise, the `errorColor` is applied.
    private var currentTextColor: Color {
        isValid ? appearance.subtitleColor : appearance.errorColor
    }
    
    // MARK: - View
    
    /// The content and layout of the `DXInfoView`.
    ///
    /// - Displays an icon and the provided text, styled and colored based on the state and appearance configuration.
    public var body: some View {
        HStack(spacing: 4) {
            CoreAssets.alertCircle.swiftUIImage
                .dxImage(size: 16, color: currentTextColor)
            Text(text)
                .font(.inter(size: 12, weight: .medium))
                .lineLimit(2)
            Spacer(minLength: 0)
        }
        .foregroundStyle(currentTextColor)
    }
    
    // MARK: - Appearance
    
    /// A structure defining the customizable appearance of the `DXInfoView`.
    @AutoInit
    public struct Appearance {
        
        // MARK: - Properties
        
        /// The font used for the subtitle text.
        public let subtitleFont: Font
        
        /// The default color for the subtitle text.
        public let subtitleColor: Color
        
        /// The color used for error states.
        public let errorColor: Color
        
        // MARK: - Variations
        
        /// The default appearance configuration for `DXInfoView`.
        ///
        /// - `subtitleFont`: `.inter(size: 12, weight: .medium)`
        /// - `subtitleColor`: `CoreColors.gray2.swiftUIColor`
        /// - `errorColor`: `CoreColors.alert1.swiftUIColor`
        public static var `default`: DXInfoView.Appearance {
            Appearance(
                subtitleFont: .inter(size: 12, weight: .medium),
                subtitleColor: CoreColors.gray2.swiftUIColor,
                errorColor: CoreColors.alert1.swiftUIColor
            )
        }
    }
}
