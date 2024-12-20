//
//  RoundedCorner.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import SwiftUI

// MARK: - RoundedCorner

private struct RoundedCorner: Shape {

    // MARK: - Properties

    /// Desirable smooth corner radius
    private(set) var radius: CGFloat = .infinity

    /// Rounded corners
    private(set) var corners: UIRectCorner = .allCorners

    // MARK: - Shape

    /// Describes this shape as a path within a rectangular frame of reference.
    ///
    /// - Parameter rect: The frame of reference for describing this shape.
    ///
    /// - Returns: A path that describes this shape.
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - View

public extension View {

    /// Update smooth corners for current view
    /// - Parameters:
    ///   - radius: corner radius value
    ///   - corners: target corners which we want to round
    /// - Returns: modified view instance
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
