//
//  UIConstants.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 16.08.2024.
//

import Foundation
import SwiftUI

// MARK: - UIConstants

public enum UIConstants {
    
    // MARK: - Padding
    
    public enum Padding {
        public static let small: CGFloat = 8
        public static let medium: CGFloat = 16
        public static let large: CGFloat = 23
    }
    
    // MARK: - CornerRadius
    
    public enum CornerRadius: CGFloat {

        // MARK: - Cases
        
        case small = 8
        case large = 26
    }
}

// MARK: - CGFloat+UIConstants

extension CGFloat {
    
    public static let smallPadding = UIConstants.Padding.small
    public static let mediumPadding = UIConstants.Padding.medium
    public static let largePadding = UIConstants.Padding.large
}

// MARK: - SmoothCorners+UIConstants

extension SmoothCorners {
    
    public init(_ cornerRadius: UIConstants.CornerRadius) {
        self.radius = cornerRadius.rawValue
    }
}

// MARK: - View

extension View {
    
    public func smoothCorners(_ cornerRadius: UIConstants.CornerRadius) -> some View {
        modifier(SmoothCorners(cornerRadius))
    }
}

// MARK: - Image

extension Image {
    
    public func bannerModifier() -> some View {
        self
            .resizable()
            .scaledToFill()
            .smoothCorners(.large)
    }
}
