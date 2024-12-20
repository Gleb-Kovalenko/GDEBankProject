//
//  LanguageMenuState.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - LanguageMenuState

@ObservableState
public struct LanguageMenuState: Equatable {
    
    // MARK: - Properties
    
    @Shared(.appLanguage)
    public var currentLanguage = AppLanguage.default
}

// MARK: - Initializers

extension LanguageMenuState {
    
    public init(forPublicInit: String? = nil) {
    }
}
