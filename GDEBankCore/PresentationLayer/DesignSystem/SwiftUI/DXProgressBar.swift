//
//  DXProgressBar.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 10.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - DXProgressBar

/// `DXProgressBar` is a customizable progress bar component that uses `SwiftUI`.
/// It displays the current progress as a filled portion of a bar, with a rounded rectangle shape.
public struct DXProgressBar: View {
    
    // MARK: - Properties
    
    /// The current progress value represented as a percentage (0.0 to 1.0).
    /// `0.0` represents 0% progress, and `1.0` represents 100% progress.
    private var value: Double
    
    /// The shape of the progress bar, defined as a rounded rectangle with a corner radius of 16.
    private let shape = RoundedRectangle(cornerRadius: 16)
    
    // MARK: - Initializers
    
    /// Initializes a new `DXProgressBar` with the specified progress value.
    /// - Parameter value: The progress value ranging from 0.0 (0%) to 1.0 (100%).
    public init(value: Double) {
        self.value = value
    }
    
    // MARK: - View
    
    /// The body of the progress bar view. 
    /// It draws the progress bar with the filled portion representing the current progress.
    public var body: some View {
        shape
            .fill(Colors.defaultPrimary.swiftUIColor)
            .overlay(alignment: .leading) {
                GeometryReader { proxy in
                    shape.fill(Colors.control1.swiftUIColor)
                        .frame(width: proxy.size.width * value)
                }
            }
            .frame(height: Constants.height)
            .padding(.horizontal, Constants.borderSize.width)
            .padding(.vertical, Constants.borderSize.height)
            .background(shape.fill(Colors.gray5.swiftUIColor))
    }
}

// MARK: - Constants

/// Extension to define layout constants for the `DXProgressBar`.
extension DXProgressBar {
    
    public enum Constants {
        
        /// The height of the progress bar.
        public static let height: CGFloat = 8
        
        /// The padding around the progress bar in both width and height.
        public static let borderSize = CGSize(width: 2, height: 2)
    }
}

// MARK: - Preview

#Preview {
    DXProgressBar(value: 0.77)
}
