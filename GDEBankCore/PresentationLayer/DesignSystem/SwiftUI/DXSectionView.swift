//
//  DXCategoryShortListView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 18.08.2024.
//

import SwiftUI

// MARK: - DXCategoryShortListView

public struct DXSectionView<Content: View, AccessoryContent: View>: View {
    
    // MARK: - Properties
    
    /// Property  representing the title of the view.
    public let title: LocalizedStringKey
    
    /// Indicates that obtained data is empty
    public let isEmptyPlaceholderActive: Bool
    
    /// A closure that holds the content of the view.
    public let content: () -> Content
    
    /// On  tapped action for ViewAllButton
    public let accessoryView: () -> AccessoryContent?
    
    // MARK: - Initiaziler
    
    /// Initializes a new instance of the `DXCategoryShortListView` structure representing an list category.
    /// - Parameters:
    ///   - title: The title to be used in the view's header.
    ///   - isEmptyPlaceholderActive: A flag indicating whether the obtained data is empty and a placeholder should be displayed.
    ///   - content: A closure that holds the content of the view. This content is typically created using the @ViewBuilder attribute and can include views such as images, text, and other
    ///   - accessoryView: A closure that holds the accessory view, such as a "ViewAllButton".
    public init(
        title: LocalizedStringKey,
        isEmptyPlaceholderActive: Bool,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder accessoryView: @escaping () -> AccessoryContent? = { EmptyView() }
    ) {
        self.title = title
        self.isEmptyPlaceholderActive = isEmptyPlaceholderActive
        self.content = content
        self.accessoryView = accessoryView
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack(spacing: .mediumPadding) {
            HStack(spacing: 0) {
                Text(title)
                    .font(.inter(size: 24, weight: .semibold))
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer(minLength: 0)
                accessoryView()
            }
            .padding(.horizontal, .mediumPadding)
            if !isEmptyPlaceholderActive {
                content()
            }
        }
        .padding(.top, .mediumPadding)
        .background(Colors.bg2.swiftUIColor)
        .smoothCorners(.large)
    }
}

// MARK: - Preview

#Preview("Short-List") {
    ZStack {
        Colors.bg1.swiftUIColor
        ScrollView {
            VStack(spacing: .mediumPadding) {
                DXSectionView(
                    title: "News",
                    isEmptyPlaceholderActive: false
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: .smallPadding) {
                            ForEach(0...5, id: \.self) { index in
                                DXShortListItemView(
                                    title: "Title",
                                    iconImageURL: .random(),
                                    publicationDateText: "14 November"
                                )
                            }
                        }
                    }
                } accessoryView: {
                    ViewAllButton(mode: .small) {
                    }
                }
                DXSectionView(
                    title: "News",
                    isEmptyPlaceholderActive: true
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: .smallPadding) {
                            ForEach(0...5, id: \.self) { index in
                                DXShortListItemView(
                                    title: "Title",
                                    iconImageURL: .random(),
                                    publicationDateText: "14 November"
                                )
                            }
                        }
                        .padding(.smallPadding)
                    }
                } accessoryView: {
                    ViewAllButton(mode: .small) {
                    }
                }
                DXSectionView(
                    title: "News",
                    isEmptyPlaceholderActive: false
                ) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: .smallPadding) {
                            ForEach(0...5, id: \.self) { index in
                                DXShortListItemView(
                                    title: "Title",
                                    iconImageURL: .random(),
                                    publicationDateText: "14 November"
                                )
                            }
                        }
                        .padding([.horizontal, .bottom], .smallPadding)
                    }
                }
            }
        }
    }
}
