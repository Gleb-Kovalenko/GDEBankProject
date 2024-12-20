//
//  DXInformationView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 18.08.2024.
//

import SwiftUI

// MARK: - DXInformationView

public struct DXInformationView<Content: View>: View {
    
    // MARK: - Properties
    
    /// Property representing the title of the view.
    public let title: LocalizedStringKey
    
    /// A closure that holds the content of the view.
    public let content: () -> Content
    
    // MARK: - Initiaziler
    
    /// Initializes the view structure with a given title and content closure.
    /// - Parameters:
    ///   - title: Representing the title of the view.
    ///   - content: A closure uses `@ViewBuilder` to accept a build expression that provides the view's content.
    public init(
        title: LocalizedStringKey,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.content = content
    }
    
    // MARK: - View
    
    public var body: some View {
        DXContainerView {
            VStack(alignment: .leading, spacing: .smallPadding) {
                HStack(spacing: 0) {
                    Text(title)
                        .font(.inter(size: 17, weight: .bold))
                        .lineLimit(1)
                    Spacer()
                }
                content()
            }
        }
    }
}

// MARK: - Preview

#Preview("WorkSchedule") {
    ZStack {
        Colors.bg1.swiftUIColor
        DXInformationView(title: "Hours of operation") {
            HStack(spacing: 4) {
                Text(verbatim: "Open tomorrow ")
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                    .font(.inter(size: 15, weight: .regular))
                 + Text(verbatim: "1:31")
                    .font(.inter(size: 15, weight: .semibold))
                    .foregroundColor(Colors.textDefault.swiftUIColor)
                Spacer(minLength: 0)
                Button {
                } label: {
                    Text(verbatim: "Schedule")
                        .foregroundColor(.accentColor)
                        .font(.inter(size: 15, weight: .semibold))
                }
            }
        }
    }
}
