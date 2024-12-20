//
//  LanguageMenu.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - LanguageMenu

@Reducer
public struct LanguageMenu {

    // MARK: - Aliases

    public typealias State  = LanguageMenuState
    public typealias Action = LanguageMenuAction
    
    // MARK: - Properties
    
    /// `Localizer` implementation
    private let localizer: Localizer
    
    // MARK: - Initializers
    
    /// Default initializer
    public init(localizer: Localizer) {
        self.localizer = localizer
    }
    
    // MARK: - Feature
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .setLanguage(let language):
                state.currentLanguage = language
                localizer.setCurrrentLanguage(language)
            }
            return .none
        }
    }
}
