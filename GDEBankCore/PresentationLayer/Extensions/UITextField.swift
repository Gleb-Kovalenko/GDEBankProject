//
//  UITextField.swift
//  Auth IOS
//
//  Created by incetro on 5/26/21.
//
// 101-ui

import UIKit

// MARK: - UITextField

public extension UITextField {

    /// Add left spacing to a `UITextField` instance
    /// - Parameters:
    ///   - spacing: necessary spacing
    ///   - mode: spacing mode
    func addLeftSpacing(_ spacing: CGFloat, mode: UITextField.ViewMode = .always) {
        leftViewMode = mode
        leftView = UIView(frame: .init(x: 0, y: 0, width: spacing, height: 0))
    }

    /// Add right spacing to a `UITextField` instance
    /// - Parameters:
    ///   - spacing: necessary spacing
    ///   - mode: spacing mode
    func addRightSpacing(_ spacing: CGFloat, mode: UITextField.ViewMode = .always) {
        rightViewMode = mode
        rightView = UIView(frame: .init(x: 0, y: 0, width: spacing, height: 0))
    }
}
