//
//  DXPageControl.swift
//  Onboarding
//
//  Created by incetro on 11/27/23.
//

import SwiftUI
import ComposableArchitecture

// MARK: - DXPageControl

public struct DXPageControl: View {
    
    // MARK: - Properties

    /// The currently selected page index.
    public var selectedPage: Int

    /// The total number of pages to display.
    public var pages: Int

    /// The diameter of the unselected page indicators (circles).
    public var circleDiameter: CGFloat

    /// The width of the indicator for the selected page.
    public var selectedWidth: CGFloat

    /// The spacing between the page indicators.
    public var spacing: CGFloat
    
    /// The corner radius for the selected page indicator.
    public var radius: CGFloat

    // MARK: - Initializers

    /// Initializes the page indicator with the provided settings.
    ///
    /// - Parameters:
    ///   - selectedPage: The index of the currently selected page.
    ///   - pages: The total number of pages to be displayed.
    ///   - circleDiameter: The diameter of the circles for unselected pages.
    ///   - selectedWidth: The width of the indicator for the selected page.
    ///   - spacing: The spacing between each page indicator.
    ///   - radius: The corner radius of the selected page indicator.
    public init(
        selectedPage: Int,
        pages: Int,
        circleDiameter: CGFloat = 6,
        selectedWidth: CGFloat = 12,
        spacing: CGFloat = 4,
        radius: CGFloat = 9
    ) {
        self.selectedPage = selectedPage
        self.pages = pages
        self.circleDiameter = circleDiameter
        self.selectedWidth = selectedWidth
        self.spacing = spacing
        self.radius = radius
    }
    
    // MARK: - Initializers

    /// Initializes the page indicator with the provided settings.
    ///
    /// - Parameters:
    ///   - selectedItem: ID of selected item in array
    ///   - pages: Pages to be displayed.
    ///   - circleDiameter: The diameter of the circles for unselected pages.
    ///   - selectedWidth: The width of the indicator for the selected page.
    ///   - spacing: The spacing between each page indicator.
    ///   - radius: The corner radius of the selected page indicator.
    public init<Data: Identifiable>(
        selectedItem: Data.ID,
        pages: [Data],
        circleDiameter: CGFloat = 6,
        selectedWidth: CGFloat = 12,
        spacing: CGFloat = 4,
        radius: CGFloat = 9
    ) {
        self.selectedPage = pages.firstIndex(where: { $0.id == selectedItem }) ?? 0
        self.pages = pages.count
        self.circleDiameter = circleDiameter
        self.selectedWidth = selectedWidth
        self.spacing = spacing
        self.radius = radius
    }
    
    /// Initializes the page indicator with the provided settings.
    ///
    /// - Parameters:
    ///   - selectedItem: ID of selected item in array
    ///   - pages: Identified array of pages to be displayed.
    ///   - circleDiameter: The diameter of the circles for unselected pages.
    ///   - selectedWidth: The width of the indicator for the selected page.
    ///   - spacing: The spacing between each page indicator.
    ///   - radius: The corner radius of the selected page indicator.
    public init<Data: Identifiable>(
        selectedItem: Data.ID,
        pages: IdentifiedArrayOf<Data>,
        circleDiameter: CGFloat = 6,
        selectedWidth: CGFloat = 12,
        spacing: CGFloat = 4,
        radius: CGFloat = 9
    ) {
        self.selectedPage = pages.index(id: selectedItem) ?? 0
        self.pages = pages.count
        self.circleDiameter = circleDiameter
        self.selectedWidth = selectedWidth
        self.spacing = spacing
        self.radius = radius
    }
    
    // MARK: - View
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<pages, id: \.self) { index in
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .foregroundColor(CoreColors.gray4.swiftUIColor)
                    .frame(width: index == selectedPage ? selectedWidth : circleDiameter, height: circleDiameter)
                    .animation(.easeInOut(duration: 0.2), value: selectedPage)
            }
        }
    }
}
