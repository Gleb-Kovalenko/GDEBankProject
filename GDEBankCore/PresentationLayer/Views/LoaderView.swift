//
//  LoaderView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import SwiftUI

// MARK: - LoaderView

public struct LoaderView: View {
    
    // MARK: - Appearance
    
    public enum Appearance {
        
        // MARK: - Cases
        
        case large
        case medium
        case small
        
        // MARK: - Useful

        public var size: CGFloat {
            switch self {
            case .large:
                return 80
            case .medium:
                return 40
            case .small:
                return 24
            }
        }
        
        public var lineWidth: CGFloat {
            switch self {
            case .large:
                return 6
            case .medium:
                return 4
            case .small:
                return 2
            }
        }
    }
    
    // MARK: - Mode
    
    public enum Mode {
        
        // MARK: - Cases
        
        case `default`
        case withBackground
    }
    
    // MARK: - Properties
    
    /// Loader appearance
    public let appearance: Appearance
    
    /// Loader view mode
    public let mode: Mode
    
    // MARK: - Private
    
    /// Indicates is animation loader
    @State private var isAnimating = false
    
    // MARK: - Initializers
        
    /// Initializes a `LoaderView` with a specified size.
    ///
    /// - Parameters size: The size of the loader view. Defaults to `90` if no value is provided.
    public init(
        appearance: Appearance = .medium,
        mode: Mode = .default
    ) {
        self.appearance = appearance
        self.mode = mode
    }

    // MARK: - View

    public var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(
                    CoreColors.accentColor.swiftUIColor,
                    style: StrokeStyle(
                        lineWidth: appearance.lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
                .scaleEffect(1)
        }
        .frame(width: appearance.size, height: appearance.size)
    }
}
