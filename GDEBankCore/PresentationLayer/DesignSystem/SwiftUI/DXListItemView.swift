//
//  DXListItemView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 18.08.2024.
//

import SwiftUI
import Kingfisher

// MARK: - DXListItemView

public struct DXListItemView<ButtonContent: View>: View {
    
    // MARK: - Properties
    
    /// The title of the item
    /// This property holds a string value representing the title or name of the item
    public let title: LocalizedStringKey
    
    /// The URL of the image associated with the item
    /// Use this property to store the URL pointing to the image that represents the item
    public let imageURL: URL?
    
    /// The publication date
    /// This property is an string value indicating the publication date of items
    public let publicationDateText: String
    
    /// A closure that occurs when onTap
    public let onTap: VoidClosure
    
    /// Representation that holds the content of the view.
    public var favoriteButtonContent: () -> ButtonContent
    
    // MARK: - Initiaziler
    
    /// Initializes a new instance of the `DXListItemView` structure.
    /// - Parameters:
    ///   - title: The title of the item.
    ///   - imageURL: The URL of the image associated with the item.
    ///   - publicationDateText: The publication date of the item.
    ///   - onTap: A closure that occurs when onTap
    public init(
        title: LocalizedStringKey,
        imageURL: URL?,
        publicationDateText: String,
        onTap: @escaping VoidClosure,
        @ViewBuilder favoriteButtonContent: @escaping () -> ButtonContent = { EmptyView() }
    ) {
        self.title = title
        self.imageURL = imageURL
        self.publicationDateText = publicationDateText
        self.onTap = onTap
        self.favoriteButtonContent = favoriteButtonContent
    }
    
    // MARK: - View
    
    public var body: some View {
        Button {
            onTap()
        } label: {
            HStack(alignment: .top, spacing: 0) {
                KFImage(imageURL)
                    .placeholder { Colors.bg4.swiftUIColor }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120)
                    .clipped()
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.inter(size: 17, weight: .regular))
                        .foregroundColor(Colors.textDefault.swiftUIColor)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(publicationDateText)
                        .foregroundColor(Colors.textGray.swiftUIColor)
                        .font(.inter(size: 15, weight: .regular))
                }
                .padding(.vertical, .mediumPadding)
                .padding(.leading, .mediumPadding)
                Spacer()
                favoriteButtonContent()
            }
            .frame(height: 120)
            .background(Colors.bg2.swiftUIColor)
            .smoothCorners(.large)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Skeletonable

extension DXListItemView: Skeletonable {
    
    public static var skeletonBody: some View {
        HStack(alignment: .top, spacing: 0) {
            SkeletonElement()
                .dxSkeleton(
                    size: CGSize(width: 120, height: 120),
                    shape: .rectangle
                )
            VStack(alignment: .leading, spacing: 0) {
                HorizontalSkeletonElement()
                    .dxSkeleton(shape: .rounded(.radius(20)))
                    .frame(height: 20)
                Spacer()
                SkeletonElement()
                    .dxSkeleton(
                        size: CGSize(width: 50, height: 18),
                        shape: .rounded(.radius(18))
                    )
            }
            .padding(.vertical, .mediumPadding)
            .padding(.horizontal, .mediumPadding)
            Spacer(minLength: 0)
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Colors.bg4.swiftUIColor)
                .frame(width: 24, height: 24)
                .padding([.top, .trailing], .mediumPadding)
        }
        .frame(height: 120)
        .background(Colors.bg2.swiftUIColor)
        .smoothCorners(.large)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        Colors.bg1.swiftUIColor
        VStack(spacing: .mediumPadding) {
            DXListItemView(
                title: "Title",
                imageURL: .random(),
                publicationDateText: "14 November",
                onTap: {
                },
                favoriteButtonContent: {
                }
            )
            DXListItemView(
                title: "Title",
                imageURL: URL(string: "https://").unsafelyUnwrapped,
                publicationDateText: "14 November",
                onTap: {
                }
            ) {
            }
            DXListItemView<EmptyView>.skeleton()
        }
    }
}
