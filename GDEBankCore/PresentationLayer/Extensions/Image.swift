//
//  Image.swift
//  GDEBank
//
//  Created by incetro on 12/10/23.
//

import SwiftUI

// MARK: - Image

extension Image {
    
    public static func system(_ name: String) -> Image {
        Image(systemName: name)
    }
    
    public func scaledImage(with contentMode: ContentMode, size: CGFloat, aligment: Alignment = .center) -> some View {
        switch contentMode {
        case .fit:
            self
                .resizable()
                .scaledToFit()
                .frame(size: size, aligment: aligment)
                .eraseToAnyView()
        case .fill:
            self
                .resizable()
                .scaledToFill()
                .frame(size: size, aligment: aligment)
                .eraseToAnyView()
        }
    }
    
    public func scaledImage(with contentMode: ContentMode, width: CGFloat? = nil, height: CGFloat? = nil, aligment: Alignment = .center) -> some View {
        switch contentMode {
        case .fit:
            self
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height, alignment: aligment)
                .eraseToAnyView()
        case .fill:
            self
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height, alignment: aligment)
                .eraseToAnyView()
        }
    }
    
    public func dxImage(
        contentMode: ContentMode = .fit,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        renderingMode: Image.TemplateRenderingMode = .template,
        color: Color = Colors.gray1.swiftUIColor
    ) -> some View {
        self
            .renderingMode(renderingMode)
            .scaledImage(with: contentMode, width: width, height: height)
            .foregroundStyle(color)
    }
    
    public func dxImage(
        contentMode: ContentMode = .fit,
        size: CGFloat? = nil,
        renderingMode: Image.TemplateRenderingMode = .template,
        color: Color = Colors.gray1.swiftUIColor
    ) -> some View {
        self
            .renderingMode(renderingMode)
            .scaledImage(with: contentMode, width: size, height: size)
            .foregroundStyle(color)
    }
}
