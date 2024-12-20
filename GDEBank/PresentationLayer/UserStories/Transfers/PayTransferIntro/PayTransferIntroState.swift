//
//  PayTransferIntroState.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - PayTransferIntroState

@ObservableState
public struct PayTransferIntroState: Equatable {
    
    // MARK: - Properties
    
    /// Module localization
    public var l10n: PayTransferIntroLocalization = .default
}
