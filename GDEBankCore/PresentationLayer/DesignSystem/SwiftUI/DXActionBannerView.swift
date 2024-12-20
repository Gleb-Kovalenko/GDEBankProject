//
//  DXBannerView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 03.08.2024.
//

import SwiftUI
import Kingfisher

// MARK: - DXActionBannerView

public struct DXActionBannerView<Content: View, AccessoryView: View>: View {
    
    // MARK: - Properties
    
    public let contentPadding: CGFloat = 10
    public var cornerRadius: CGFloat { contentPadding + 8 }
    
    /// The localized string key for the title of the banner.
    public let title: LocalizedStringKey
    
    /// The type of image to be displayed in the banner.
    public let imageType: DXImageType
    
    /// A properties that returns the content view of the banner.
    public let content: () -> Content
    
    /// A properties that returns the accessory view of the banner.
    public let accessoryView: () -> AccessoryView
    
    // MARK: - Initilizer
    
    /// Initializes a new `DXBannerView` instance.
    /// - Parameters:
    ///   - title: The localized string key for the title of the banner.
    ///   - imageType: The type of image to be displayed in the banner.
    ///   - content: A properties that returns the content view of the banner.
    ///   - accessoryView: A properties that returns the accessory view of the banner.
    public init(
        title: LocalizedStringKey,
        imageType: DXImageType,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder accessoryView: @escaping () -> AccessoryView
    ) {
        self.title = title
        self.imageType = imageType
        self.content = content
        self.accessoryView = accessoryView
    }

    // MARK: - View
    
    public var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 18) {
                Text(title)
                    .font(.inter(size: 24, weight: .bold))
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                    .padding(.horizontal, .largePadding)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 6)
                VStack(alignment: .leading, spacing: 18) {
                    content()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)
                accessoryView()
            }
            .frame(maxWidth: .infinity)
            .padding(contentPadding)
        }
        .background(
            ZStack {
                switch imageType {
                case .imageURL(let imageURL):
                    KFImage(imageURL)
                        .resizable()
                        .placeholder { LinearGradient.cgImagePlaceholder }
                        .scaledToFill()
                        .smoothCorners(radius: cornerRadius)
                        .clipped()
                case .assetsImage(let imageString):
                    Image(imageString)
                        .bannerModifier()
                case .systemImage(let systemImage):
                    Image(systemName: systemImage)
                        .bannerModifier()
                }
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .black.opacity(0.16), location: 0.00),
                        Gradient.Stop(color: .black.opacity(0.81), location: 1.00),
                        Gradient.Stop(color: .black.opacity(0.62), location: 1.00)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .smoothCorners(radius: cornerRadius)
            }
        )
        .smoothCorners(radius: cornerRadius)
    }
}

// MARK: - Preview

#Preview {
    DXActionBannerView(
        title: "Log in to get more",
        imageType: .assetsImage("datingscout")
    ) {
        Label {
            Text("Get discounts from 15%")
                .font(.inter(size: 17, weight: .regular))
                .foregroundColor(Colors.textWhite.swiftUIColor)
        } icon: {
            Image(systemName: "percent")
                .foregroundColor(.white)
                .font(Font.inter(size: 15, weight: .bold))
        }
        Label {
            Text("Share your reviews")
                .font(.inter(size: 17, weight: .regular))
                .foregroundColor(Colors.textWhite.swiftUIColor)
        } icon: {
            Image(systemName: "star.fill")
                .foregroundColor(.white)
                .font(Font.inter(size: 15, weight: .bold))
        }
        Label {
            Text(verbatim: "Keep important things in your favorites ")
                .font(.inter(size: 17, weight: .regular))
                .foregroundColor(Colors.textWhite.swiftUIColor)
        } icon: {
            Image(systemName: "heart.fill")
                .foregroundColor(.white)
                .font(Font.inter(size: 15, weight: .bold))
        }
    } accessoryView: {
        DXButton(text: "Log in") {
        }
    }
}
