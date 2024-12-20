//
//  LanguageMenuAction.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - LanguageMenuAction

@CasePathable
public enum LanguageMenuAction: Equatable {
    
    // MARK: - Cases
    
    /// Sets the language preference for the registration process.
    /// - Parameter language: The language selected by the user.
    case setLanguage(AppLanguage)
}
