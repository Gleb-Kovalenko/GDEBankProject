//
//  PayTransferIntroAction.swift
//  TCATemplate
//
//  Created by Dmitry Savinov on 19.10.2023.
//  Copyright © 2023 Incetro Inc. All rights reserved.
//

import ComposableArchitecture

// MARK: - PayTransferIntroAction

@CasePathable
public enum PayTransferIntroAction: Equatable {
    
    // MARK: - Cases
    
    /// An action that calls when user taps on the `Scan` button
    case scanButtonTapped
}
