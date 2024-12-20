//
//  TitlePlaceholderView.swift
//  GDEBank
//
//  Created by incetro on 2/4/24.
//

import SwiftUI

// MARK: - TitlePlaceholderView

public struct TitlePlaceholderView: View {

    public var title: String
    
    public var bgColor: Color
    
    public var foregroundColor: Color
    
    public var font: Font
    
    init(
        title: String,
        foregroundColor: Color = .white,
        bgColor: Color,
        font: Font = .inter(size: 27, weight: .bold)
    ) {
        self.title = title
        self.foregroundColor = foregroundColor
        self.bgColor = bgColor
        self.font = font
    }
    
    // MARK: - View
    
    public var body: some View {
        bgColor
            .overlay {
                Text(title)
                    .textCase(.uppercase)
                    .foregroundColor(foregroundColor)
                    .font(font)
            }
    }
}

#Preview {
    TitlePlaceholderView(
        title: "Pharmacy",
        foregroundColor: .white,
        bgColor: Colors.accentOrange.swiftUIColor
    )
}
