//
//  DXShortListItemView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 18.08.2024.
//

import SwiftUI
import Kingfisher

// MARK: - DXShortListItemView

public struct DXShortListItemView: View {
    
    // MARK: - Properties
    
    /// The title of the item
    /// This property holds a string value representing the title or name of the item
    public let title: LocalizedStringKey
    
    /// The URL of the image associated with the item
    /// Use this property to store the URL pointing to the image that represents the item
    public let iconImageURL: URL?
    
    /// The publication date
    /// This property is an string value indicating the publication date of items
    public let publicationDateText: String
    
    /// The publication date
    /// This property is an string value indicating the publication date of items
    public let height: CGFloat
    
    // MARK: - Initiaziler
    
    /// Initializes a new instance of the `DXShortListItemView` structure.
    /// - Parameters:
    ///   - title: The title of the item.
    ///   - iconImageURL: The URL of the image associated with the item.
    ///   - publicationDate: The publication date of the item.
    public init(
        title: LocalizedStringKey,
        iconImageURL: URL?,
        publicationDateText: String,
        height: CGFloat = 250
    ) {
        self.title = title
        self.height = height
        self.iconImageURL = iconImageURL
        self.publicationDateText = publicationDateText
    }
    
    // MARK: - View
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack(alignment: .leading, spacing: .mediumPadding) {
                KFImage(iconImageURL)
                    .placeholder { LinearGradient.cgImagePlaceholder }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 160, height: 140)
                    .clipped()
                Text(title)
                    .font(.inter(size: 15, weight: .medium))
                    .lineLimit(3)
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, .smallPadding)
            }
            .padding(.bottom, .smallPadding)
            .frame(width: 160, height: height, alignment: .top)
            .background(Colors.bg3.swiftUIColor)
            .smoothCorners(.small)
            .dxShadow()
            Text(publicationDateText)
                .font(.inter(size: 13, weight: .medium))
                .foregroundColor(Colors.textGray.swiftUIColor)
                .padding(10)
        }
        .frame(width: 160, height: height, alignment: .top)
    }
}

// MARK: - Skeletonable

extension DXShortListItemView: Skeletonable {
    
    // MARK: - Skeletonable
    
    public static var skeletonBody: some View {
        VStack(spacing: .mediumPadding) {
            HorizontalSkeletonElement()
                .dxSkeleton(shape: .rectangle)
                .frame(height: 160)
            VStack(alignment: .leading, spacing: .mediumPadding) {
                HorizontalSkeletonElement()
                    .dxSkeleton()
                    .frame(height: 20)
                Spacer(minLength: 0)
                SkeletonElement()
                    .dxSkeleton(size: CGSize(width: 65, height: 16))
            }
            .padding(.horizontal, .mediumPadding)
        }
        .frame(width: 160, height: 289)
        .padding(.bottom, .mediumPadding)
        .background(Colors.bg3.swiftUIColor)
        .smoothCorners(.small)
        .dxShadow()
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Colors.bg1.swiftUIColor
        VStack(spacing: .mediumPadding) {
            DXShortListItemView(
                title: "Title",
                iconImageURL: .random(),
                publicationDateText: "14 ноября"
            )
            DXShortListItemView(
                title: "Title",
                iconImageURL: URL(string: "https://").unsafelyUnwrapped,
                publicationDateText: "14 ноября"
            )
        }
    }
}

#Preview("skeleton") {
    ZStack {
        Colors.bg1.swiftUIColor
        DXShortListItemView.skeleton()
    }
}
