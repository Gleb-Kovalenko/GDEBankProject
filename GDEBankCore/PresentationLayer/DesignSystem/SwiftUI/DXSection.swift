//
//  DXSection.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import Foundation
import SwiftUI

// MARK: - DXSection

public struct DXSection<Title, Content> : View where Title : View, Content : View {

    // MARK: - Properties

    /// Title of section
    public var title: Title?

    /// Subtitle of section
    public var subtitle: Title?

    /// Footer of section
    public var footer: Title?

    /// Target content that shoud be inside view
    public var content: Content

    // MARK: - Initializers

    /// Creates a label with a custom title and icon.
    public init(
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder title: @escaping () -> Title? = { nil },
        @ViewBuilder subtitle: @escaping () -> Title? = { nil },
        @ViewBuilder footer: @escaping () -> Title? = { nil }
    ) {
        self.title = title()
        self.subtitle = subtitle()
        self.content = content()
        self.footer = footer()
    }

    // MARK: - View

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let title {
                title
                    .font(.inter(size: 22, weight: .semibold))
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                    .padding(.bottom, 8)
                    .padding(.horizontal, 5)
                    .fixedSize(horizontal: false, vertical: true)
            }
            if let subtitle {
                subtitle
                    .font(.inter(size: 12, weight: .regular))
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                    .padding(.bottom, 13)
                    .padding(.horizontal, 5)
                    .fixedSize(horizontal: false, vertical: true)
            }
            ZStack {
                RoundedRectangle(cornerRadius: 13, style: .continuous)
                    .foregroundColor(Colors.bg2.swiftUIColor)
                content
            }
            if let footer {
                footer
                    .font(.inter(size: 12, weight: .regular))
                    .foregroundColor(.red)
                    .padding(.top, 6)
                    .padding(.leading, 5)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Only content

extension DXSection where Title == EmptyView, Content : View {

    /// Creates a section with the provided section content.
    /// - Parameters:
    ///   - content: The section's content.
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
}
