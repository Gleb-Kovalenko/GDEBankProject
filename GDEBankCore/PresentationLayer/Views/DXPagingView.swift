//
//  PagingView.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 18.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import SwiftUI
import CollectionViewPagingLayout
import ComposableArchitecture

/// A customizable paging view that displays items in a horizontally scrollable, paginated format.
///
/// `DXPagingView` allows for paging through a collection of data items, providing customizable spacing, padding, and scaling options for each item.
///
/// - Generic Parameters:
///   - `ValueType`: The type of data each page represents. This type must conform to `Identifiable`.
///   - `PageContent`: The view to be rendered for each page.
public struct DXPagingView<ValueType: Identifiable, PageContent: View>: View {
    
    // MARK: - Properties
    
    /// The data to be displayed in the paging view.
    public let data: [ValueType]
    
    /// An optional binding to the selected item's ID.
    public var selection: Binding<ValueType.ID>?
    
    /// The spacing between each item in the paging view.
    public let spacing: CGFloat
    
    /// The leading padding of the paging view.
    public let leadingPadding: CGFloat
    
    /// The height of the paging view. If `nil`, the height will be determined automatically.
    public let height: CGFloat?
    
    /// A closure that returns the content for each page, given a data item.
    public let content: (ValueType) -> PageContent
    
    // MARK: - Private
    
    /// Dynamically calculated width of the content
    @State private var itemWidth: CGFloat?
    
    /// Options for configuring the scaling and translation behavior of the paging view.
    private let options = ScaleTransformViewOptions(
        minScale: 1,
        maxScale: 1,
        scaleRatio: 0,
        translationRatio: .init(x: 1, y: 0),
        minTranslationRatio: nil,
        maxTranslationRatio: nil,
        keepVerticalSpacingEqual: true,
        keepHorizontalSpacingEqual: false,
        scaleCurve: .linear,
        translationCurve: .linear,
        shadowEnabled: false
    )
    
    // MARK: - Initializers
    
    /// Initializes a `DXPagingView` with the given data, selection, spacing, padding, and dimensions.
    ///
    /// - Parameters:
    ///   - data: The data to be displayed in the paging view.
    ///   - selection: An optional binding to track the currently selected item's ID.
    ///   - spacing: The spacing between each item in the paging view.
    ///   - leadingPadding: The leading padding of the paging view. Defaults to `0`.
    ///   - height: The height of the paging view. If `nil`, it will be determined automatically based on content.
    ///   - content: A closure that returns the view for each page given an item of type `ValueType`.
    public init(
        _ data: [ValueType],
        selection: Binding<ValueType.ID>? = nil,
        spacing: CGFloat,
        leadingPadding: CGFloat = 0,
        height: CGFloat? = nil,
        @ViewBuilder content: @escaping (ValueType) -> PageContent
    ) {
        self.data = data
        self.selection = selection
        self.spacing = spacing
        self.leadingPadding = leadingPadding
        self.height = height
        self.content = content
    }
    
    // MARK: - View
    
    /// The body of the `DXPagingView`, responsible for laying out the content and applying the provided configuration.
    ///
    /// - Returns: A view that represents the paginated content with customizable spacing, padding, and scaling options.
    public var body: some View {
        Group {
            WithPerceptionTracking {
                if let itemWidth = itemWidth {
                    contentView(itemWidth: itemWidth)
                } else {
                    measureItemWidth()
                }
            }
        }
    }
    
    // MARK: - Private Views
    
    /// The content view after the item width has been calculated.
    ///
    /// - Parameter itemWidth: The width of each item.
    /// - Returns: The view containing the paginated content.
    private func contentView(itemWidth: CGFloat) -> some View {
        WithPerceptionTracking {
            ScalePageView(
                data,
                selection: .init(
                    get: {
                        selection?.wrappedValue
                    },
                    set: { value in
                        guard let value else { return }
                        selection?.wrappedValue = value
                    }
                )
            ) { item in
                content(item)
                    .frame(
                        width: Constants.pagerWidth - leadingPadding * 2,
                        height: height,
                        alignment: .leading
                    )
            }
            .pagePadding(
                horizontal: .absolute(
                    Constants.pagerHorizontalSpacing(
                        itemWidth: itemWidth,
                        spacing: spacing
                    )
                )
            )
            .options(options)
            .frame(height: height)
        }
    }
    
    /// A view that measures the width of the first item and stores it in `itemWidth`.
    ///
    /// - Returns: A view with a `GeometryReader` for measuring the content width.
    private func measureItemWidth() -> some View {
        Group {
            WithPerceptionTracking {
                if let item = data.first {
                    GeometryReader { geometry in
                        content(item)
                            .background(
                                GeometryReader { innerGeometry in
                                    Color.clear
                                        .onAppear {
                                            itemWidth = innerGeometry.size.width
                                        }
                                }
                            )
                    }
                } else {
                    EmptyView()
                }
            }
        }
    }
}

// MARK: - Constants

extension DXPagingView {
    
    /// A collection of constants used for calculating paging view layout properties.
    enum Constants {
        
        /// The full width of the pager, based on the device screen width.
        static var pagerWidth: CGFloat {
            UIScreen.main.bounds.width
        }
        
        /// Calculates the horizontal spacing between pages.
        ///
        /// - Parameters:
        ///   - itemWidth: The width of each item in the paging view.
        ///   - spacing: The spacing between items.
        /// - Returns: The calculated horizontal spacing between pages.
        static func pagerHorizontalSpacing(itemWidth: CGFloat, spacing: CGFloat) -> CGFloat {
            (pagerWidth - itemWidth - spacing) / 2
        }
    }
}

