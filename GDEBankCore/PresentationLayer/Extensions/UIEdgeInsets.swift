//
//  UIEdgeInsets.swift
//  GDEBank
//
//  Created by incetro on 5/10/21.
//

import UIKit

// MARK: - UIEdgeInsets

public extension UIEdgeInsets {

    func bottom(_ bottom: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func top(_ top: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func left(_ left: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func right(_ right: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func horizontal(_ horizontal: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: horizontal, bottom: bottom, right: horizontal)
    }

    static func equal(inset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    static func bottom(_ bottom: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets.zero.bottom(bottom)
    }

    static func top(_ top: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets.zero.top(top)
    }

    static func left(_ left: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets.zero.left(left)
    }

    static func right(_ right: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets.zero.right(right)
    }

    static func horizontal(_ horizontal: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets.zero.left(horizontal).right(horizontal)
    }

    var horizontalInset: CGFloat {
        left + right
    }

    var verticalInset: CGFloat {
        top + bottom
    }
}
