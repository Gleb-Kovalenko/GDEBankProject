//
//  LanguageMenuView.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SwiftMacrosKit

// MARK: - LanguageMenuView

@WithLocalizationUpdater
public struct LanguageMenuView: View {
    
    // MARK: - Properties

    /// The store powering the `LanguageMenu` reducer
    public let store: StoreOf<LanguageMenu>
    
    /// The appearance settings for the Language Menu view.
    public let appearance: LanguageMenuViewAppearance
    
    // MARK: - Initializers
    
    /// Initializes a new instance of the `LanguageMenuView`.
    /// - Parameters:
    ///   - store: The store powering the `LanguageMenu` reducer.
    ///   - appearance: The appearance settings for the view.
    public init(
        store: StoreOf<LanguageMenu>,
        appearance: LanguageMenuViewAppearance = .default
    ) {
        self.store = store
        self.appearance = appearance
    }
    
    /// Initializes a new instance of the `LanguageMenuView`.
    /// - Parameters:
    ///   - store: The store powering the `LanguageMenu` reducer.
    public init(
        store: StoreOf<LanguageMenu>
    ) {
        self.store = store
        self.appearance = .default
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            Menu {
                ForEach(AppLanguage.allCases) { language in
                    Button {
                        store.send(.setLanguage(language))
                    } label: {
                        HStack(spacing: 4) {
                            Image(language.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 16)
                            Text(language.languageName)
                                .font(appearance.languageButtonFont)
                        }
                    }
                }
            } label: {
                HStack(alignment: .top, spacing: 6) {
                    Image(store.currentLanguage.locale.languageCode)
                        .scaledImage(with: .fit, size: 16)
                    Assets.chevronDown.swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    LanguageMenuView(
        store: Store(
            initialState: LanguageMenuState(),
            reducer: {
                LanguageMenu(
                    localizer: LocalizerImplementation(
                        defaults: .standard,
                        localizationStores: []
                    )
                )
            }
        )
    )
}
