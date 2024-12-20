//
//  PayTabAction.swift
//  GDEBank
//
//  Created by Dmitry Savinov on 19.08.2024.
//  Copyright © 2024 Incetro Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

// MARK: - PayTabAction

@CasePathable
public enum PayTabAction {
    
    // MARK: - Cases
    
    /// An action that calls when user taps on the `Tab` button
    case tabButtonTapped(Tabs)
    
    /// An action that calls when user taps on the `Logout` button
    case logoutButtonTapped
    
    // MARK: - Children
    
    /// Child action for `MainTabCoordinator` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `mainTabCoordinator` case means that every action in `MainTabCoordinator` module
    /// will be sent to current module through it
    case mainTabCoordinator(MainTabCoordinatorAction)
}
