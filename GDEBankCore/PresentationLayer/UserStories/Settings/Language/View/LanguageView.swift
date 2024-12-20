//
//  LanguageView.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 5.08.24.
//

import ComposableArchitecture
import SwiftUI
import SwiftMacrosKit

// MARK: - LanguageView

/// A visual representation of `Language` module.
/// Here we define the view that displays the feature.
/// It holds onto a `Store<LanguageState, LanguageAction>` so that it can observe
/// all changes to the state and re-render, and we can send all user actions
/// to the store so that state changes.
@WithLocalizationUpdater
public struct LanguageView: View {
    
    // MARK: - Properties
    
    /// `Language` module `Store` instance
    public let store: StoreOf<LanguageReducer>
    
    /// The appearance settings for the view.
    public let appearance: LanguageViewAppearance
    
    ///App locale
    @Environment(\.locale) private var locale
    
    // MARK: - Initializers
    
    /// Default initializer
    /// - Parameters:
    ///   - store: The `StoreOf<LanguageReducer>` instance.
    ///   - appearance: The appearance settings for the view. Defaults to `.default`.
    public init(
        store: StoreOf<LanguageReducer>,
        appearance: LanguageViewAppearance = .default
    ) {
        self.store = store
        self.appearance = appearance
    }
    
    /// Default initializer
    /// - Parameters:
    ///   - store: The `StoreOf<LanguageReducer>` instance.
    public init(
        store: StoreOf<LanguageReducer>
    ) {
        self.store = store
        self.appearance = .default
    }
    
    // MARK: - View
    
    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                appearance.backgroundColor
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(store.languages, id: \.self) { language in
                            HStack(spacing: 0) {
                                Text(language.title)
                                    .font(appearance.titleFont)
                                    .foregroundColor(appearance.titleColor)
                                Spacer()
                                WithPerceptionTracking {
                                    if store.currentLanguage == language {
                                        checkmarkImage
                                    }
                                }
                            }
                            .frame(height: 64)
                            .padding(.horizontal, 20)
                            .background(appearance.backgroundColor)
                            .onTapGesture {
                                store.send(.setLanguage(language))
                            }
                            Divider()
                                .background(appearance.dividerColor)
                                .padding(.horizontal, 20)
                        }
                    }
                }
                .environment(\.locale, .getCustomLocale(store.currentLanguage.rawValue))
                .id(store.currentLanguage.id)
            }
        }
    }
    
    private var checkmarkImage: some View {
        appearance
            .checkmarkImage
            .resizable()
            .renderingMode(.template)
            .foregroundColor(appearance.checkmarkColor)
            .frame(width: 20, height: 20)
    }
}
