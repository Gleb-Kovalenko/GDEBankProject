//
//  StylableUIView.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 05.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import UIKit

// MARK: - StylableUIView

open class StylableUIView<Appearance: Default>: UIView, Stylable {
    
    // MARK: - Properties
    
    public var appearance: Appearance = .default {
        didSet {
            style(with: appearance)
        }
    }
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        style(with: appearance)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        style(with: appearance)
    }
    
    // MARK: - Stylable
    
    open func style(with appearance: Appearance) {
        fatalError("should be ovveriden in children")
    }
    
    // MARK: - UIView
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.style(with: appearance)
    }
}
