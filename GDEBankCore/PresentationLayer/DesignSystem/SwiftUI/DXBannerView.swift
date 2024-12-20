//
//  DXBannerView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.01.24.
//

import Foundation
import SwiftUI

// MARK: - DXBannerView

public struct DXBannerView: View {
    
    // MARK: - Properties
    
    @State private var imageOffset: CGFloat = -20
    
    /// The localized string key for the title of the banner.
    private let title: LocalizedStringKey
    
    /// The localized string key for the subtitle of the banner.
    private let subtitle: LocalizedStringKey
    
    /// An action, that is executed, when user taps button
    private let onTapAction: () -> ()
    
    /// View's background image
    public var image: Image
    
    /// View's height
    @State private var height: CGFloat
    
    // MARK: - Initializers
    
    public init(
        title: LocalizedStringKey,
        subtitle: LocalizedStringKey,
        image: Image,
        height: CGFloat,
        onTapAction: @escaping () -> ()
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.height = height
        self.onTapAction = onTapAction
    }
    
    // MARK: - View
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            image
                .resizable()
                .scaledToFill()
                .frame(width: Constants.imageWidth, height: height, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .black.opacity(0.77), location: 0.00),
                            Gradient.Stop(color: .clear, location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0, y: 0.5),
                        endPoint: UnitPoint(x: 1, y: 0.5)
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.inter(size: 20, weight: .semibold))
                Text(subtitle)
                    .font(.inter(size: 15, weight: .regular))
            }
            .foregroundColor(Colors.textWhite.swiftUIColor)
            .padding(.horizontal, .largePadding)
            .padding(.vertical, 23)
        }
        .onTapGesture {
            onTapAction()
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let imageWidth = UIScreen.main.bounds.width - 6 * 2
}
