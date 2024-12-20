//
//  ForceUpdateAction.swift
//  GDEBank
//
//  Created by incetro on 29/05/2022.
//  Copyright © 2022 Incetro Inc. All rights reserved.
//

import Foundation

// MARK: - ForceUpdateAction

/// All available `ForceUpdate` module actions.
///
/// It's a type that represents all of the actions that can happen in `ForceUpdate` feature,
/// such as user actions, notifications, event sources and more.
///
/// We have some actions in the feature. There are the obvious actions,
/// such as tapping some button, holding another button, or changing a slider value.
/// But there are also some slightly non-obvious ones, such as the action of the user dismissing the alert,
/// and the action that occurs when we receive a response from the fact API request.
public enum ForceUpdateAction: Equatable {

    // MARK: - Cases

    /// An action that calls when user taps on the `update` button
    case updateButtonTapped
}
