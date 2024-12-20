//
//  Color.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 15.08.2024.
//

import SwiftUI

// MARK: - Color

extension Color {
    
    /// Creates an Color from HEX String in "#363636" format
    ///
    /// - Parameter hexString: HEX String in "#363636" format
    public static func hex(_ hexString: String) -> Color {
        Color(uiColor: UIColor(hexString: hexString))
    }
    
    public init(rgba red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(.sRGB, red: red / 255, green: green / 255, blue: blue / 255, opacity: alpha)
    }
    
    /// Light version of color
    public var light: Self {
        let uiColor = UIColor(self)
        return Color(uiColor.light)
    }

    /// Dark version of color
    public var dark: Self {
        let uiColor = UIColor(self)
        return Color(uiColor.dark)
    }
}

extension String {
    
    public func hexColor() -> Color {
        Color(uiColor: UIColor(hexString: self))
    }
}
