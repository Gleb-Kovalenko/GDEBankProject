//
//  MainTabCoordinatorAction.swift
//  GDEBankWallet
//
//  Created by Gleb Kovalenko on 24.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture
import Foundation
import GDEBankCore

// MARK: - MainTabCoordinatorAction

@CasePathable
public enum MainTabCoordinatorAction {
    
    // MARK: - Children
    
    /// Child action for `Main` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `main` case means that every action in `Main` module
    /// will be sent to current module through it
    case main(MainAction)
    
    /// Modal module destination
    case modalDestination(PresentationAction<MainTabCoordinator.Path.Action>)
    
    /// Application path stack action
    case path(StackActionOf<MainTabCoordinator.Path>)
    
    /// Child action for `Alert` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `alert` case means that every action in `Alert` module
    /// will be sent to current module through it
    case alert(PresentationAction<DXAlertAction>)
    
    /// Child action for `Alert` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `alert` case means that every action in `Alert` module
    /// will be sent to current module through it
    case qrAlert(PresentationAction<DXAlertAction>)
    
    // MARK: - Service
    
    /// An action that calls when qr token obtained
    case qrTokenObtained(token: String, Result<TransferInfoPlainObject, NSError>)
}
