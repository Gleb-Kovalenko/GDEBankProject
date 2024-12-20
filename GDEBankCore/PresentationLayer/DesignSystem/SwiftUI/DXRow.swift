//
//  DXRow.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import SwiftUI

// MARK: - DXRow

public struct DXRow<Left, Right> : View where Left : View, Right : View {

    // MARK: - Properties

    public var left: Left
    public var right: Right
    public var hPadding: CGFloat = 16
    public let action: VoidClosure

    // MARK: - Initializers

    /// Creates a label with a custom title and icon.
    public init(
        @ViewBuilder left: () -> Left,
        @ViewBuilder right: () -> Right,
        action: @escaping VoidClosure
    ) {
        self.left = left()
        self.right = right()
        self.action = action
    }

    // MARK: - View

    public var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(Colors.bg2.swiftUIColor)
                HStack(spacing: 0) {
                    left
                    Spacer()
                    right
                }
                .padding(.horizontal, hPadding)
            }
            .frame(height: 60)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
