//
//  GradientViewProvider.swift
//  GDEBank
//
//  Created by incetro on 27/11/2019.
//  Copyright © 2019 Incetro Inc. All rights reserved.
//

import UIKit

// MARK: - GradientViewProvider

public protocol GradientViewProvider {
    associatedtype GradientViewType
}

public extension GradientViewProvider where Self: UIView {
    var gradientLayer: GradientViewType? {
        layer as? GradientViewType
    }
}

extension UIView: GradientViewProvider {
    public typealias GradientViewType = GradientLayer
}
