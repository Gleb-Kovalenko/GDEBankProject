//
//  DXFavoritesButton.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 18.08.2024.
//

import SwiftUI

// MARK: - DXFavoritesButton

public struct DXFavoriteButton: View {
    
    // MARK: - Properies
    
    /// A Boolean value indicating whether the item is marked as a favorite.
    @Binding public var isFavorite: Bool
    
    // MARK: - Initializer
    
    /// /// Initializes a new instance of the `DXFavoritesButton` structure representing a favorites indicator.
    /// - Parameter isFavorites: Property indicating whether the item is marked as a favorite.
    public init(isFavorite: Binding<Bool>) {
        self._isFavorite = isFavorite
    }
    
    // MARK: - View
    
    public var body: some View {
        Button {
            isFavorite.toggle()
        } label: {
            Image(systemName: "heart\(isFavorite ? ".fill" : "")")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.accentColor)
                .frame(width: 24, height: 24)
        }
        .padding([.top, .trailing], .mediumPadding)
    }
}

// MARK: - Preview

private struct DXFavoriteButton_Previews: PreviewProvider {
    @State static var isFavorite = false
    static var previews: some View {
        DXFavoriteButton(isFavorite: $isFavorite)
    }
}
