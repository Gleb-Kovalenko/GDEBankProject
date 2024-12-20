//
//  CircledImage.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 23.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import Kingfisher

// MARK: - CircledImage

public struct CircledImage: View {
    
    // MARK: - Properties
    
    /// Image name to circle
    public let imageName: String?
    
    /// Image url
    public let imageURL: URL?
    
    /// Image size
    public let imageSize: CGFloat
    
    /// Background imageSize
    public let circleSize: CGFloat
    
    /// Circle color
    public let circleColor: Color
    
    /// Image color
    public let imageColor: Color
    
    // MARK: - Initializers
    
    /// Initializes a new `CircledImage` view with the specified properties.
    /// - Parameters:
    ///   - imageName: The name of the image to be displayed within the circle.
    ///   - imageSize: The size of the image within the circle. The default value is 20.
    ///   - circleSize: The size of the circular background. The default value is 40.
    ///   - circleColor: The color of the circle surrounding the image. The default value is `Colors.gray6.swiftUIColor`.
    ///   - imageColor: The color to apply to the image. The default value is `Colors.gray1.swiftUIColor`.
    public init(
        imageName: String,
        imageSize: CGFloat = 20,
        circleSize: CGFloat = 40,
        circleColor: Color = Colors.gray6.swiftUIColor,
        imageColor: Color = Colors.gray1.swiftUIColor
    ) {
        self.imageName = imageName
        self.imageURL = nil
        self.imageSize = imageSize
        self.circleSize = circleSize
        self.circleColor = circleColor
        self.imageColor = imageColor
    }
    
    /// Initializes a new `CircledImage` view with the specified properties.
    /// - Parameters:
    ///   - imageURL: image URL
    ///   - imageSize: The size of the image within the circle. The default value is 20.
    ///   - circleSize: The size of the circular background. The default value is 40.
    ///   - circleColor: The color of the circle surrounding the image. The default value is `Colors.gray6.swiftUIColor`.
    ///   - imageColor: The color to apply to the image. The default value is `Colors.gray1.swiftUIColor`.
    public init(
        imageURL: URL?,
        imageSize: CGFloat = 20,
        circleSize: CGFloat = 40,
        circleColor: Color = Colors.gray6.swiftUIColor,
        imageColor: Color = Colors.gray1.swiftUIColor
    ) {
        self.imageName = nil
        self.imageURL = imageURL
        self.imageSize = imageSize
        self.circleSize = circleSize
        self.circleColor = circleColor
        self.imageColor = imageColor
    }

    // MARK: - View
    
    public var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(size: circleSize)
            if let imageName {
                Image(imageName)
                    .dxImage(
                        width: imageSize,
                        color: imageColor
                    )
            } else {
                KFImage(imageURL)
                    .loadDiskFileSynchronously()
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(size: imageSize)
                    .foregroundStyle(imageColor)
            }
        }
    }
}

#Preview {
    ZStack {
        CircledImage(imageName: Assets.inboxIn.name)
    }
}
