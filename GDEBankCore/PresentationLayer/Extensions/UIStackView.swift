//
//  UIStackView.swift
//  GDEBankCore
//
//  Created by Gleb Kovalenko on 30.10.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import UIKit

// MARK: - UIStackView

extension UIStackView {
    
    public func removeAllSubviews() {
        arrangedSubviews.forEach { subview in
            self.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
