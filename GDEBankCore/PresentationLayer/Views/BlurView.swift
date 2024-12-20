//
//  BlurView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import Foundation
import SwiftUI

// MARK: - BlurView

/// A SwiftUI view that provides a customizable blur effect using `UIViewRepresentable`.
///
/// This struct wraps a `UIView` with a blur effect, allowing customization of the blur style
/// and intensity based on the current color scheme or a custom configuration.
///
/// - Note: The blur effect is implemented using `UIVisualEffectView`, which means it is only
/// available on iOS. The view supports both automatic and custom blur configurations.
public struct BlurView: UIViewRepresentable {
    
    // MARK: - BlurType
    
    /// An enumeration that defines the types of blur effects that can be applied.
    ///
    /// - automatic: Automatically selects a blur style and background color based on the current
    ///   color scheme (dark or light). The intensity is specified as a `CGFloat` value.
    /// - custom: Allows specifying a custom `UIBlurEffect.Style` and a custom background color.
    public enum BlurType {
        
        // MARK: - Cases
        
        case automatic(intensity: CGFloat)
        case custom(style: UIBlurEffect.Style, backgroundColor: UIColor)
    }
    
    // MARK: - Properties
    
    /// The current color scheme of the environment (light or dark).
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    /// The type of blur effect to be applied.
    public let type: BlurType
    
    // MARK: - Initializers
    
    /// Initializes a new `BlurView` with the specified blur type.
    ///
    /// - Parameter type: The type of blur effect to apply.
    public init(_ type: BlurType) {
        self.type = type
    }
    
    // MARK: - UIViewRepresentable
    
    /// Creates the underlying `UIView` for the blur effect.
    ///
    /// - Parameter context: The context for coordinating with the system.
    /// - Returns: A `UIView` instance with the blur effect applied.
    public func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        updateBlur(forView: view)
        return view
    }
    
    /// Updates the `UIView` when the SwiftUI state changes.
    ///
    /// - Parameters:
    ///   - uiView: The `UIView` instance to update.
    ///   - context: The context for coordinating with the system.
    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        updateBlur(forView: uiView)
    }
    
    // MARK: - Private
    
    /// Configures the blur effect for the specified `UIView` based on the current blur type.
    ///
    /// This method removes any existing subviews, applies the appropriate blur effect, and
    /// sets the background color according to the blur type (either automatic or custom).
    ///
    /// - Parameter view: The `UIView` to which the blur effect should be applied.
    private func updateBlur(forView view: UIView) {
        
        view.subviews.forEach {
            $0.removeFromSuperview()
        }
        view.backgroundColor = .clear
        
        let blurStyle: UIBlurEffect.Style
        let blurBackgroundColor: UIColor
        
        switch type {
        case .automatic(let intensity):
            blurStyle = colorScheme == .dark ? .dark : .light
            blurBackgroundColor = colorScheme == .dark
                ? .black.withAlphaComponent(intensity)
                : .white.withAlphaComponent(intensity)
        case .custom(let style, let backgroundColor):
            blurStyle = style
            blurBackgroundColor = backgroundColor
        }
        
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        if blurView.subviews.count > 1 {
            blurView.subviews[1].backgroundColor = blurBackgroundColor
        }
    }
}
