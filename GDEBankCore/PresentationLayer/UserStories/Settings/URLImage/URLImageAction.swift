//
//  URLImageAction.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 6.08.24.
//

import Foundation
import ComposableArchitecture

// MARK: - URLImageAction

/// All available `URLImage` module actions.
///
/// It's a type that represents all of the actions that can happen in `URLImage` feature,
/// such as user actions, notifications, event sources and more.
///
/// We have some actions in the feature. There are the obvious actions,
/// such as tapping some button, holding another button, or changing a slider value.
/// But there are also some slightly non-obvious ones, such as the action of the user dismissing the alert,
/// and the action that occurs when we receive a response from the fact API request.
public enum URLImageAction: Equatable {

    // MARK: - Cases

    /// General action that calls when view appears
    case onAppear
    
    /// Calls when image has been obtained
    case imageDataObtained
}
