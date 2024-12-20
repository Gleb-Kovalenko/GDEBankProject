//
//  UIFont.swift
//  GDEBankCore
//
//  Created by Dmitry Savinov on 09.08.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import UIKit

// MARK: - UIFont

extension UIFont {
    
    public var monospacedDigitFont: UIFont {
        let newFontDescriptor = fontDescriptor.monospacedDigitFontDescriptor
        return UIFont(descriptor: newFontDescriptor, size: 0)
    }
    
    public var monospacedTextFont: UIFont {
        let newFontDescriptor = fontDescriptor.monospacedTextFontDescriptor
        return UIFont(descriptor: newFontDescriptor, size: 0)
    }
}

// MARK: - UIFontDescriptor

private extension UIFontDescriptor {
    
    var monospacedDigitFontDescriptor: UIFontDescriptor {
        let fontDescriptorFeatureSettings = [[
            UIFontDescriptor.FeatureKey.type: kNumberSpacingType,
            UIFontDescriptor.FeatureKey.selector: kMonospacedNumbersSelector
        ]]
        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
        let fontDescriptor = self.addingAttributes(fontDescriptorAttributes)
        return fontDescriptor
    }
    
    var monospacedTextFontDescriptor: UIFontDescriptor {
        let fontDescriptorFeatureSettings = [[
            UIFontDescriptor.FeatureKey.type: kTextSpacingType,
            UIFontDescriptor.FeatureKey.selector: kMonospacedTextSelector
        ]]
        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
        let fontDescriptor = self.addingAttributes(fontDescriptorAttributes)
        return fontDescriptor
    }
}
