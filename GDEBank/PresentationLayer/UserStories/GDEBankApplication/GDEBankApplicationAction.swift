//
//  GDEBankApplicationAction.swift
//  GDEBank
//
//  Created by Gleb Kovalenko on 11.09.2024.
//  Copyright © 2024 Incetro. All rights reserved.
//

import ComposableArchitecture
import GDEBankCore
import Foundation

// MARK: - GDEBankApplicationAction

@CasePathable
public enum GDEBankApplicationAction {
    
    // MARK: - Cases
    
    /// General action that calls when view appears
    case onAppear
    
    /// An action that calls when need to show login
    case showLogin
    
    /// An action that calls when need to make logout
    case makeLogout
    
    /// An action that calls when url scheme opening obtained
    case urlSchemeOpeningObtained(URL)

    // MARK: - Children
    
    /// Child action for `PayLogin` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `payLogin` case means that every action in `PayLogin` module
    /// will be sent to current module through it
    case payLogin(PayLoginAction)
    
    /// Child action for `PayTab` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `main` case means that every action in `PayTab` module
    /// will be sent to current module through it
    case payTab(PayTabAction)
    
    /// Child action for `Alert` module.
    ///
    /// It's necessary as we use `Scope` reducer in current module's reducer.
    /// In short, the `alert` case means that every action in `Alert` module
    /// will be sent to current module through it
    case alert(PresentationAction<DXAlertAction>)
    
    /// Application path stack action
    case path(StackActionOf<GDEBankApplication.Path>)
    
    /// Modal destination action
    case modalDestination(PresentationAction<GDEBankApplication.Path.Action>)
    
    // MARK: - Service
    
    /// An action that calls when tokens session activated
    case sessionActivated(Result<Bool, NSError>)
}
