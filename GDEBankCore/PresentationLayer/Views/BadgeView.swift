//
//  BadgeView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import SwiftUI

// MARK: - BadgeView

public struct BadgeView: View {

    // MARK: - Properties

    public let notificationsCount: Int

    // MARK: - View

    public var body: some View {
        ZStack {
            Circle()
                .fill(Color.red)
                .frame(width: 18, height: 18)
            Text(String(notificationsCount))
                .font(.inter(size: 13, weight: .regular))
                .foregroundColor(.white)
        }
    }
}

// MARK: - BadgeModifier

public struct BadgeModifier: ViewModifier {

    // MARK: - Properties

    public let notificationsCount: Int

    public let corner: UIRectCorner

    // MARK: - ViewModifier

    public func body(content: Content) -> some View {
        switch corner {
        case .topLeft:
            content
                .overlay(
                    VStack {
                        HStack {
                            BadgeView(notificationsCount: notificationsCount)
                                .offset(x: -LayoutConstants.insetX, y: -LayoutConstants.insetY)
                            Spacer()
                        }
                        Spacer()
                    }
                )
        case .bottomLeft:
            content
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            BadgeView(notificationsCount: notificationsCount)
                                .offset(x: -LayoutConstants.insetX, y: LayoutConstants.insetY)
                            Spacer()
                        }
                    }
                )
        case .bottomRight:
            content
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            BadgeView(notificationsCount: notificationsCount)
                                .offset(x: LayoutConstants.insetX, y: LayoutConstants.insetY)
                        }
                    }
                )
        default:
            content
                .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            BadgeView(notificationsCount: notificationsCount)
                                .offset(x: LayoutConstants.insetX, y: -LayoutConstants.insetY)
                        }
                        Spacer()
                    }
                )
        }
    }
}

// MARK: Useful

extension View {

    public func addBadge(_ notificationsCount: Int, corner: UIRectCorner) -> some View {
        modifier(BadgeModifier(notificationsCount: notificationsCount, corner: corner))
    }
}

// MARK: - LayoutConstants

private struct LayoutConstants {
    static let insetX: CGFloat = 8
    static let insetY: CGFloat = 11
}
