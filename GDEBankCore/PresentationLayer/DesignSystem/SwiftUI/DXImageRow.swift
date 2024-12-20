//
//  DXImageRow.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import SwiftUI

// MARK: - DXImageRow

public struct DXImageRow<Title, Icon> : View where Title : View, Icon : View {

    // MARK: - Properties

    public let icon: Icon?
    public var title: Title
    public var detail: Title?
    public var additional: Title?
    public let notificationsCount: Int?
    public var spacing: CGFloat = 0
    public var withChevron: Bool
    public var hPadding: CGFloat = 16

    // MARK: - Initializers

    /// Creates a label with a custom title and icon.
    public init(
        @ViewBuilder icon: @escaping () -> Icon? = { nil },
        @ViewBuilder title: () -> Title,
        @ViewBuilder detail: @escaping () -> Title? = { nil },
        @ViewBuilder additional: @escaping () -> Title? = { nil },
        withChevron: Bool = true,
        notificationsCount: Int? = nil
    ) {
        self.icon = icon()
        self.title = title()
        self.detail = detail()
        self.additional = additional()
        self.withChevron = withChevron
        self.notificationsCount = notificationsCount
    }

    // MARK: - View

    public var body: some View {
        HStack(spacing: 0) {
            icon
                .padding(.leading, hPadding)
            VStack(alignment: .leading, spacing: spacing) {
                title
                    .font(.inter(size: 17, weight: .regular))
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                detail
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.inter(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading, hPadding)
            Spacer()
            if let notificationsCount {
                BadgeView(notificationsCount: notificationsCount)
            } else {
                additional
                    .font(.inter(size: 17, weight: .regular))
                    .foregroundColor(.gray)
            }
            if withChevron {
                Image(systemName: "chevron.right")
                    .font(.inter(size: 13, weight: .regular))
                    .foregroundColor(.gray)
                    .padding(.trailing, hPadding)
                    .padding(.leading, 8)
            }
        }
        .frame(height: 40)
    }
}

#Preview {
    ZStack {
        Color.black
        VStack(alignment: .center, spacing: 8) {
            DXChevronRow(
                title: "Continue",
                detail: "News",
                additional: "Additional",
                image: .system("globe"),
                action: {}
            )
            DXChevronRow(
                title: "Continue",
                image: .system("globe"),
                action: {}
            )
            DXChevronRow(
                title: "Continue",
                additional: "Additional",
                image: .system("globe"),
                action: {}
            )
            DXChevronRow(
                title: "Continue",
                detail: "News",
                image: .system("globe"),
                action: {}
            )
        }
    }
}
