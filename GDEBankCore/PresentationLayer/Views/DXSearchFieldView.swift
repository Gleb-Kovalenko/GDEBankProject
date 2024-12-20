//
//  DXSearchFieldView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 14.08.2024.
//

import SwiftUI

// MARK: - DXSearchFieldView

public struct DXSearchFieldView: View {
    
    // MARK: - Properties
    
    /// TextField binding text
    @Binding var text: String
    
    // MARK: - View
    
    public var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "magnifyingglass")
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(Colors.textGray.swiftUIColor)
            ZStack(alignment: .leading) {
                Text("Search")
                    .font(.inter(size: 17, weight: .regular))
                    .foregroundColor(Colors.textGray.swiftUIColor)
                    .isOpaque(text.isEmpty)
                TextField("", text: $text)
            }
            Spacer(minLength: 0)
        }
        .padding(8)
        .background(Colors.searchField.swiftUIColor)
        .smoothCorners(radius: 18)
    }
}

#Preview {
    ZStack {
        Colors.bg1.swiftUIColor
        DXSearchFieldView(text: .constant(""))
            .padding()
    }
}
