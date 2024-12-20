//
//  DXUITextField.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 23.07.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import UIKit
import Layout

// MARK: - DXCodeField

public class DXCodeField: ChainableTextField {
    
    // MARK: - Useful
    
    public var appearance: Appearance = .default {
        didSet {
            style(with: appearance)
        }
    }
    
    public var uiState: UIState = .normal {
        didSet {
            style(with: appearance)
        }
    }
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style(with: appearance)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        style(with: appearance)
    }
    
    // MARK: - Setup
    
    private func setup() {
        keyboardType = .numberPad
        textAlignment = .center
        prepareForAutolayout()
        self
            .width(LayoutConstants.width)
            .height(LayoutConstants.height)
    }
}

// MARK: - UITextInput

extension DXCodeField {
    
    override public func caretRect(for position: UITextPosition) -> CGRect {
        super.caretRect(for: position).offset(x: -LayoutConstants.corretOffset)
    }
}

// MARK: - Style
    
extension DXCodeField: Stylable {
    
    public func style(with appearance: Appearance) {
        styleTextField(with: appearance)
        stylePlaceholder(with: appearance)
    }
    
    
    private func styleTextField(with appearance: Appearance) {
        switch uiState {
        case .normal:
            layer.borderColor = appearance.frameColor.cgColor
            textColor = appearance.textColor
            tintColor = appearance.textColor
        case .error:
            layer.borderColor = appearance.errorColor.cgColor
            textColor = appearance.errorColor
            tintColor = appearance.errorColor
        }
        layer.borderWidth = appearance.borderWidth
        layer.cornerRadius = appearance.cornerRadius
        font = appearance.textFont
    }
    
    private func stylePlaceholder(with appearance: Appearance) {
        attributedPlaceholder = NSAttributedString(
            string: "_",
            attributes: [
                NSAttributedString.Key.baselineOffset: -LayoutConstants.placeholderBaselineOffset,
                NSAttributedString.Key.font: appearance.placeholderFont
            ]
        )
    }
    
    // MARK: - UIView
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.style(with: appearance)
    }
}

// MARK: - Appearance

public extension DXCodeField {
    
    struct Appearance: Default {
    
        // MARK: - Colors
        
        public let frameColor: UIColor
        public let textColor: UIColor
        public let placeholderColor: UIColor
        public let errorColor: UIColor
        
        // MARK: - Fonts
        
        public let textFont: UIFont
        public let placeholderFont: UIFont
        
        // MARK: - Dimensions
        
        public let textFieldHeight: CGFloat
        public let borderWidth: CGFloat
        public let cornerRadius: CGFloat
        
        // MARK: - Initailizers
        
        public init(
            frameColor: UIColor = GDEBankCore.Colors.gray2.color,
            textColor: UIColor = GDEBankCore.Colors.textDefault.color,
            placeholderColor: UIColor = GDEBankCore.Colors.gray4.color,
            errorColor: UIColor = GDEBankCore.Colors.alert1.color,
            textFont: UIFont = .inter(size: 16, weight: .medium),
            placeholderFont: UIFont = .inter(size: 16, weight: .medium),
            textFieldHeight: CGFloat = LayoutConstants.height,
            borderWidth: CGFloat = LayoutConstants.borderWidth,
            cornerRadius: CGFloat = LayoutConstants.cornerRadius
        ) {
            self.frameColor = frameColor
            self.textColor = textColor
            self.placeholderColor = placeholderColor
            self.errorColor = errorColor
            self.textFont = textFont
            self.placeholderFont = placeholderFont
            self.textFieldHeight = textFieldHeight
            self.borderWidth = borderWidth
            self.cornerRadius = cornerRadius
        }
        
        // MARK: - Default
        
        public static let `default` = Appearance()
    }
}

// MARK: - LayoutConstants

extension DXCodeField {
    
    public enum LayoutConstants {
        public static let height: CGFloat = 50
        public static let width: CGFloat = 40
        public static let borderWidth: CGFloat = 1
        public static let cornerRadius: CGFloat = 8
        public static let corretOffset: CGFloat = 2
        public static let placeholderBaselineOffset: CGFloat = 2
    }
}
