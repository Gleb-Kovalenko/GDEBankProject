//
//  RatingAction.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 21.08.2024.
//

import Foundation

// MARK: - RatingAction

/// All available `Rating` module actions.
///
/// It's a type that represents all of the actions that can happen in `Rating` feature,
/// such as user actions, notifications, event sources and more.
///
/// We have some actions in the feature. There are the obvious actions,
/// such as tapping some button, holding another button, or changing a slider value.
/// But there are also some slightly non-obvious ones, such as the action of the user dismissing the alert,
/// and the action that occurs when we receive a response from the fact API request.
public enum RatingAction: Equatable {
    
    // MARK: - Cases
    
    /// An action that calls when need to set new rating value
    case ratingTapped(Int)
    
    /// An action that calls when gesture on ended 
    case ratingSetterOnEnded
}
