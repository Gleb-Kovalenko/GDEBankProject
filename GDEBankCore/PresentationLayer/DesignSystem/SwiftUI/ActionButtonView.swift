//
//  ActionButtonView.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 24.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI

// MARK: - ActionButtonView

public struct ActionButtonView: View {
    
    // MARK: - Properties
    
    /// Image name
    public let imageName: String
    
    /// Button title
    public let title: String
    
    /// Button height
    public let height: CGFloat
    
    /// Button action
    public let action: VoidClosure
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameters:
    ///   - imageName: Button image nmae
    ///   - title: Button title
    ///   - height: Button height
    ///   - action: Button action
    public init(
        imageName: String,
        title: String,
        height: CGFloat,
        action: @escaping VoidClosure
    ) {
        self.imageName = imageName
        self.title = title
        self.height = height
        self.action = action
    }
    
    // MARK: - View
    
    public var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                Image(imageName)
                    .scaledImage(with: .fit, size: 24)
                    .padding(.bottom, 4)
                    .padding(.top, 8)
                Text(title)
                    .font(.inter(size: 11, weight: .bold))
                    .foregroundColor(CoreColors.textDefault.swiftUIColor)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 12)
            .frame(height: height)
            .centered()
            .background(CoreColors.gray6.swiftUIColor)
            .smoothCorners(radius: 8)
        }
    }
}
