//
//  SwiftUIRepresentable.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 8.08.24.
//

import SwiftUI

// MARK: - SwiftUIRepresentable

public protocol SwiftUIRepresentable {
}

// MARK: - UIView

extension SwiftUIRepresentable where Self: UIView {

    public func swiftUI(
        make: ((Self) -> Void)? = nil,
        update: ((Self) -> Void)? = nil
    ) -> UIViewRepresented<Self> {
        make?(self)
        return UIViewRepresented(
            makeUIView: { _ in self },
            updateUIView: { view, context in update?(view) }
        )
    }
}

extension UIView: SwiftUIRepresentable {
}

// MARK: - UIViewController

extension SwiftUIRepresentable where Self: UIViewController {

    public func swiftUI(
        make: ((Self) -> Void)? = nil,
        update: ((Self) -> Void)? = nil
    ) -> UIViewControllerRepresented<Self> {
        make?(self)
        return UIViewControllerRepresented(
            makeUIView: { _ in self },
            updateUIView: { view, context in update?(view) }
        )
    }
}

extension UIViewController: SwiftUIRepresentable {
}
