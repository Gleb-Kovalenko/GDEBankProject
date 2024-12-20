//
//  IconCircleView.swift
//  GDEBankCore
//
//  Created by Andrey Barsukov on 26.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import Foundation

// MARK: - IconCircleView

public struct IconCircleView: View {
    
    // MARK: - Properties
    
    /// The image to be displayed inside the circle.
    public let image: UIImage
    
    /// The background color of the circle.
    public let backgroundColor: Color
    
    /// The color of the icon.
    public let iconColor: Color
    
    /// The size of the circle.
    public let circleSize: CGFloat
    
    /// The size of the icon.
    public let iconSize: CGSize
    
    // MARK: - Initializers
    
    /// Initializes a new instance of `IconCircleView`.
    ///
    /// - Parameters:
    ///   - image: The image to be displayed inside the circle.
    ///   - backgroundColor: The background color of the circle.
    ///   - iconColor: The color of the icon.
    ///   - circleSize: The size of the circle.
    ///   - iconSize: The size of the icon.
    public init(
        image: UIImage,
        backgroundColor: Color,
        iconColor: Color,
        circleSize: CGFloat = 56,
        iconSize: CGSize
    ) {
        self.image = image
        self.backgroundColor = backgroundColor
        self.iconColor = iconColor
        self.circleSize = circleSize
        self.iconSize = iconSize
    }
    
    // MARK: - View
    
    public var body: some View {
        Circle()
            .frame(width: circleSize, height: circleSize)
            .foregroundColor(backgroundColor)
            .overlay {
                Image(uiImage: image)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: iconSize.width, height: iconSize.height)
                    .foregroundColor(iconColor)
            }
    }
}
