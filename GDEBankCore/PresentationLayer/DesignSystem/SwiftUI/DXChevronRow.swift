//
//  DXChevronRow.swift
//  GDEBank
//
//  Created by incetro on 12/10/23.
//

import SwiftUI

// MARK: - DXChevronRow

public struct DXChevronRow: View {

    public let title: LocalizedStringKey
    public var detail: LocalizedStringKey? = nil
    public var additional: String? = nil
    public let image: Image
    public var imageColor: Color = .accentColor
    public var notificationsCount: Int? = nil
    public var height: CGFloat = 60
    public let action: VoidClosure
    
    // MARK: - Initializers
    
    public init(
        title: LocalizedStringKey,
        detail: LocalizedStringKey? = nil,
        additional: String? = nil,
        image: Image,
        imageColor: Color = .accentColor,
        notificationsCount: Int? = nil,
        height: CGFloat = 60,
        action: @escaping VoidClosure
    ) {
        self.title = title
        self.detail = detail
        self.additional = additional
        self.image = image
        self.imageColor = imageColor
        self.notificationsCount = notificationsCount
        self.height = height
        self.action = action
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(Colors.bg2.swiftUIColor)
            Button() {
                action()
            } label: {
                DXImageRow(
                    icon: {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(imageColor)
                    },
                    title: {
                        Text(title)
                            .foregroundColor(Colors.textDefault.swiftUIColor)
                            .fontWeight(.semibold)
                    },
                    detail: {
                        detail.map { key in
                            Text(key)
                        }
                    },
                    additional: {
                        Text(additional)
                    },
                    withChevron: true,
                    notificationsCount: notificationsCount
                )
            }
        }
        .frame(height: height)
    }
}

#Preview {
    ZStack {
        Color.black
        VStack(alignment: .center, spacing: 0) {
            DXChevronRow(
                title: "Continue",
                detail: "News",
                additional: "Additional",
                image: .system("globe"),
                action: {}
            )
            Color.red.frame(height: 16)
            DXChevronRow(
                title: "Continue",
                image: .system("globe"),
                action: {}
            )
            Color.red.frame(height: 16)
            DXChevronRow(
                title: "Continue",
                additional: "Additional",
                image: .system("globe"),
                action: {}
            )
            Color.red.frame(height: 16)
            DXChevronRow(
                title: "Continue",
                detail: "News",
                image: .system("globe"),
                action: {}
            )
        }
    }
}
